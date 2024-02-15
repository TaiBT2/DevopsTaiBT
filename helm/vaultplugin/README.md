<!-- 1. Build and deploy vault-plugin to vault-server

docker run --rm -it -u 0:0 -w /opt/build \
 -v /synodus/projects/devops/helmTemplates/b22dadtubac-be-vaultplugin:/opt/build/plugins/:rw,z repo.edsolabs.com/b22dadtubac/develop-gcp/b22dadtubac-be-vaultpluginbuild:0.0.0 /bin/sh 

-->
1. Build docker container image base for Builder

Dockerfile:
    FROM golang:1.19 as build

    RUN apt-get update

    RUN apt-get install -y lsb-release gpg software-properties-common \
        build-essential \
        cmake libc++-dev libc++abi-dev libboost-all-dev

    RUN wget https://apt.llvm.org/llvm.sh \
        && chmod +x llvm.sh \
        && ./llvm.sh 14 \
        && rm -f llvm.sh*

    ENV CC=/usr/bin/clang-14
    ENV CXX=/usr/bin/clang++-14


DOCKER_BUILDKIT=1 docker build --no-cache -t repo.edsolabs.com/b22dadtubac/develop-gcp/b22dadtubac-be-vaultbuilder-base:latest .


2. Build plugin in docker container from base image

Dockerfile:
    FROM repo.edsolabs.com/b22dadtubac/develop-gcp/b22dadtubac-be-vaultbuilder-base:latest

    ARG PLUGIN_NAME=vault-banca-plugin

    WORKDIR /opt/build
    COPY . .
    RUN go mod download && go build -o plugins/${PLUGIN_NAME} cmd/${PLUGIN_NAME}/main.go

DOCKER_BUILDKIT=1 docker build --no-cache -t b22dadtubac-be-vault:1.12.2-builder-tmp .


3. Run container to mount bind volume and copy plugin file from container to host

docker-compose.yml:
    version: '1.12.2'
    services:
    banca-vault-builder-tmp:
        build: 
            context: .
            dockerfile: Dockerfile.builder
        image: b22dadtubac-be-vault:1.12.2-builder-tmp
        container_name: b22dadtubac-be-vault-builder-tmp
        volumes:
            - ./deployment/plugins:/app:rw
        command: cp /opt/build/plugins/vault-banca-plugin /app/


4. Build Vault server container image

docker-compose.yml:
    version: '1.12.2'
    services:
        banca-vault:
            image: repo.edsolabs.com/b22dadtubac/develop-gcp/b22dadtubac-be-vaultserver:latest
            container_name: b22dadtubac-be-vault
            volumes:
                - ./config:/vault/config:rw
                - ./plugins:/vault/plugins:rw
                - ./logs:/vault/logs:rw
            healthcheck:
                test: ["CMD", 'sh', '-c', 'echo -e "Checking for the availability of Vault server deployment"; while ! nc -z "banca-vault" 8200; do sleep 1; printf "-"; done; echo -e " >> Vault server has started";' ]
                timeout: 10s
                retries: 10
            ports:
                - 8200:8200
            environment:
                VAULT_ADDR: "http://127.0.0.1:8200"
            cap_add:
                - IPC_LOCK
            entrypoint: vault server -config=/vault/config/config.hcl
            #entrypoint: vault server -dev -dev-plugin-dir=/vault/plugins

docker compose 

5. Deploy when Vault service already run Up

kubectl cp deployment/plugins/vault-banca-plugin banca-dev/b22dadtubac-be-vaultserver-dev-0:/vault/data/plugins/vault-banca-plugin -n banca-dev

kubectl exec -it b22dadtubac-be-vaultserver-dev-0 /bin/bash -n banca-dev


Enter into shell:  

# Initially registering with Vault secret path
export VAULT_ADDR=http://127.0.0.1:8200 && export VAULT_TOKEN=hvs.KgHWi1JhF6dHle7ESVlufzjb && cd /vault/data/plugins && SHA256=$(sha256sum vault-banca-plugin | cut -d ' ' -f1) && vault plugin register -sha256=$SHA256 secret vault-banca-plugin && vault secrets enable -path=banca-secrets vault-banca-plugin && vault plugin reload -plugin vault-banca-plugin

# Sequentially registering  without Vault secret path
export VAULT_ADDR=http://127.0.0.1:8200 && export VAULT_TOKEN=hvs.KgHWi1JhF6dHle7ESVlufzjb && cd /vault/data/plugins && SHA256=$(sha256sum vault-banca-plugin | cut -d ' ' -f1) && vault plugin register -sha256=$SHA256 secret vault-banca-plugin && vault plugin reload -plugin vault-banca-plugin

Enter into shell when done: exit 