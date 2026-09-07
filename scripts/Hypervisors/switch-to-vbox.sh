#!/usr/bin/env bash

# switch-to-vbox.sh — отключает KVM, включает VirtualBox

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

info "Останавливаем работающие виртуальные машины KVM..."
/usr/bin/systemctl stop libvirtd 2>/dev/null || true
/usr/bin/systemctl stop libvirtd.socket 2>/dev/null || true

info "Выгружаем модули KVM..."
# Сначала выгружаем аппаратные модули, затем общий kvm, затем irqbypass
for MOD in kvm_intel kvm_amd kvm irqbypass; do
    if is_module_loaded "$MOD"; then
        info "Выгружаем $MOD..."
        if ! /usr/sbin/modprobe -r "$MOD" 2>/dev/null; then
            warn "Обычная выгрузка не удалась, пробуем принудительно..."
            /usr/sbin/rmmod -f "$MOD" 2>/dev/null || warn "Не удалось выгрузить $MOD"
        fi
    fi
done

# Проверяем, остались ли модули kvm
if is_module_loaded kvm; then
    error "Не удалось выгрузить модули KVM. Возможно, они используются."
    error "Попробуйте перезагрузить систему или остановить все ВМ KVM."
    exit 1
else
    success "Модули KVM выгружены."
fi

info "Загружаем модуль VirtualBox..."
/usr/sbin/modprobe vboxdrv

if is_module_loaded vboxdrv; then
    success "Модуль vboxdrv загружен успешно."
else
    error "Не удалось загрузить модуль vboxdrv. Проверьте установку VirtualBox."
    exit 1
fi

info "Включаем и запускаем службу VirtualBox..."
/usr/bin/systemctl enable --now vboxdrv.service

info "Отключаем автозапуск libvirtd..."
/usr/bin/systemctl disable --now libvirtd 2>/dev/null || true
/usr/bin/systemctl disable --now libvirtd.socket 2>/dev/null || true

success "Готово! Теперь активен VirtualBox."