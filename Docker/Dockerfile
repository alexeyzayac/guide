### 
### docker run -d --name My_Ubuntu my_ubuntu:0.0.1 tail -f /dev/null
### docker exec -it My_Ubuntu /bin/bash
### 

FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Безопасность и права
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        sudo \
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
        procps \
        htop \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* /var/tmp/*        

# Работа с сетью и диагностика
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        net-tools \
        iproute2 \
        dnsutils \
        traceroute \
        netcat-openbsd \
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
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* /var/tmp/*

# Дополнительные оболочки и редакторы
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bash-completion \
        nano \
        vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* /var/tmp/*

ENV DEBIAN_FRONTEND=readline

CMD ["/bin/bash"]
