ARG CODE_SERVER_VERSION

FROM codercom/code-server:$CODE_SERVER_VERSION

USER root

RUN curl -O https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb \
    && echo deb http://deb.debian.org/debian bookworm-backports main | tee /etc/apt/sources.list.d/bookworm-backports.list \
    && apt-get update \
    && apt-get install -y apt-transport-https libgdiplus libc6-dev \
    && apt-get update \
    && apt-get install -y dotnet-sdk-9.0 \
    && apt-get install -y -t bookworm-backports git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER 1000

ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
