#!/usr/bin/env bash

# switch-to-kvm.sh — отключает VirtualBox, включает KVM + libvirtd
set -e

# Цвета
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m'

error() { echo -e "${RED}[ОШИБКА]${NC} $1"; }
success() { echo -e "${GREEN}[УСПЕХ]${NC} $1"; }
info() { echo -e "${CYAN}[ИНФО]${NC} $1"; }
warn() { echo -e "${YELLOW}[ПРЕДУПРЕЖДЕНИЕ]${NC} $1"; }

is_module_loaded() { /usr/bin/lsmod | /usr/bin/grep -q "^$1 "; }

info "Останавливаем службу VirtualBox..."
/usr/bin/systemctl stop vboxdrv.service 2>/dev/null || true

info "Выгружаем все модули VirtualBox..."
# Сначала зависимые модули, потом основной
for MOD in vboxpci vboxnetadp vboxnetflt vboxdrv; do
    if is_module_loaded "$MOD"; then
        info "Выгружаем $MOD..."
        if ! /usr/sbin/modprobe -r "$MOD" 2>/dev/null; then
            warn "Обычная выгрузка не удалась, пробуем принудительно..."
            /usr/sbin/rmmod -f "$MOD" 2>/dev/null || warn "Не удалось выгрузить $MOD"
        fi
    fi
done

# Проверяем, остались ли модули VirtualBox
if is_module_loaded vbox; then
    error "Не удалось выгрузить модули VirtualBox: $(/usr/bin/lsmod | /usr/bin/grep vbox | /usr/bin/awk '{print $1}')"
    error "Возможно, запущены виртуальные машины VirtualBox. Остановите их."
    exit 1
else
    success "Все модули VirtualBox выгружены."
fi

info "Загружаем модули KVM..."
/usr/sbin/modprobe kvm

# Определяем тип процессора
if /usr/bin/grep -q "Intel" /proc/cpuinfo; then
    info "Обнаружен Intel, загружаем kvm_intel..."
    /usr/sbin/modprobe kvm_intel
elif /usr/bin/grep -q "AMD" /proc/cpuinfo; then
    info "Обнаружен AMD, загружаем kvm_amd..."
    /usr/sbin/modprobe kvm_amd
else
    warn "Не удалось определить тип процессора. Пробуем kvm_intel..."
    /usr/sbin/modprobe kvm_intel 2>/dev/null || /usr/sbin/modprobe kvm_amd
fi

# Проверяем загрузку
if is_module_loaded kvm_intel || is_module_loaded kvm_amd; then
    success "Модули KVM загружены успешно."
else
    error "Не удалось загрузить модули KVM. Проверьте, включена ли виртуализация в BIOS."
    exit 1
fi

info "Включаем и запускаем libvirtd..."
/usr/bin/systemctl enable --now libvirtd
/usr/bin/systemctl enable --now libvirtd.socket 2>/dev/null || true

info "Отключаем автозапуск vboxdrv..."
/usr/bin/systemctl disable --now vboxdrv.service 2>/dev/null || true

success "Готово! Теперь активен KVM + libvirt."