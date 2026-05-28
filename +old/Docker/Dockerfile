### docker build -t linux_zayac:0.0.1 .
### docker run -d --name linux_zayac --hostname linux_zayac linux_zayac:0.0.1 tail -f /dev/null
### docker exec -it linux_zayac /bin/bash

# Базовый образ и переменные окружения
FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Moscow
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
ENV force_color_prompt=yes

# Метаданные образа
LABEL maintainer="alexeyzayac@icloud.com"
LABEL description="DevOps machine: networking tools + automation ready"
LABEL version="1.0"

# Удаляем предустановленного пользователя ubuntu
RUN if id ubuntu >/dev/null 2>&1; then \
        userdel -r ubuntu || true; \
    fi

# Установка sudo
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* /var/tmp/*   

# Пакеты для цветного вывода
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        coreutils \
        ncurses-bin \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* /var/tmp/*   

# Основные сетевые и системные утилиты
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        curl \
        ca-certificates \
        lsb-release \
        apt-transport-https \
        locales \
        procps \
        htop \
        mc \
        gnupg \
        software-properties-common \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* /var/tmp/*  

# Генерация локали
RUN locale-gen en_US.UTF-8

# Сетевые диагностические инструменты
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        net-tools \
        iproute2 \
        dnsutils \
        traceroute \
        netcat-openbsd \
        iputils-ping \
        iptables \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* /var/tmp/*   

# Работа с файлами и текстом
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        file \
        less \
        tree \
        jq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* /var/tmp/*   

# Архивация
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gzip \
        zip \
        unzip \
        tar \
        rsync \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* /var/tmp/*

# Дополнительные оболочки и редакторы
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bash-completion \
        nano \
        vim \
        tmux \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* /var/tmp/*

# DevOps-инструменты 
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        openssh-client \
        python3 \
        python3-pip \
        sshpass \
        ansible \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* /var/tmp/*

# Кастомный .bashrc
COPY .bashrc /root/.bashrc
COPY .bashrc /etc/skel/.bashrc

# Создание непривилегированного пользователя
RUN mkdir -p /etc/sudoers.d && chmod 0755 /etc/sudoers.d
RUN useradd -m -s /bin/bash localadmin && \
    echo "localadmin ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/localadmin && \
    chmod 0440 /etc/sudoers.d/localadmin

# Возврат DEBIAN_FRONTEND
ENV DEBIAN_FRONTEND=readline

# Переключение на непривилегированного пользователя
USER localadmin
WORKDIR /home/localadmin

# Команда по умолчанию
CMD ["/bin/bash"]