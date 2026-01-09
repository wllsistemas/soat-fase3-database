# SOAT FASE 03 - Database

_Tech challenge_ da pós tech em arquitetura de software - FIAP Fase 3

# Alunos

- Felipe
    - RM: `365154`
    - discord: `felipeoli7eira`
    - LinkedIn: [@felipeoli7eira](https://www.linkedin.com/in/felipeoli7eira)
- Nicolas
    - RM: `365746`
    - discord: `nic_hcm`
    - LinkedIn: [@Nicolas Martins](https://www.linkedin.com/in/nicolas-henrique/)
- William
    - RM: `365973`
    - discord: `wllsistemas`
    - LinkedIn: [@William Francisco Leite](https://www.linkedin.com/in/william-francisco-leite-9b3ba9269/?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app)

# Material
- [Vídeo de apresentação](https://www.youtube.com/watch?v=POC_FaWt39E)
- [Documento de entrega - PDF](https://drive.google.com/file/d/1Xl_8YgZHRIELfM3yCWjbswp4tD7Gxoin/view?usp=drive_link)

# Sobre o projeto
Este projeto foi desenvolvido com [Laravel](https://laravel.com), [nginx](https://nginx.org) e [postgresql](https://www.postgresql.org) e por volta dessas 3 tecnologias, está o [docker](https://www.docker.com)/[docker compose](https://docs.docker.com/compose) e toda uma arquitetura com kubernetes, utilizando terraform para provisionamento de rescursos na AWS.

# Documentação

## 🚀 Pipeline GitHub Actions

#### 1. Aprovação de um PR para merge com a `main`
No branch `main` são efetuados merges mediante aprovação dos PRs.

#### 2. Execução da Pipeline CI
Ao executar o merge, é disparada a pipeline `database.yaml` que executa:
- Provisionamento do Persistent Volume Claim PVC
- Provisionamento do POD com imagem PostgresQL
- Provisionamento do Serviço ClusterIP
- Persiste o estado do terraform no bucket S3

## 🚀 State Terraform no Bucket S3
Para persistência do estado dos recursos provisionados via terraform, é utilizado um repositório Bucket S3 na AWS, onde os arquivos de persistência foram separados por repositório (infra, database e application).

## 🚀 Imagem PostgreSQL
O serviço SGBD do **🚀PostgreSQL** é baixado e instalado no container a partir de uma imagem no DockerHub **postgres:17.5**, apenas com acesso interno dentro do cluster pela porta **5432**.

## 🚀 Persistent Volume Claim PVC
Para pesistências dos dados do PostgreSQL é necessário:
- StorageClass “gp3” no cluster (usando AWS EBS CSI Driver)
- PersistentVolumeClaim (PVC) que pede 1Gi dessa StorageClass

Sem isso, um PostgreSQL rodando em Pod/Deployment/StatefulSet perde os dados quando o Pod é recriado.

A **StorageClass** define como o Kubernetes vai criar volumes dinamicamente quando alguém pedir um PVC.

O **PVC** é o "pedido" de volume, nesse caso está pedindo 1Gi para ser montado no Pod do PostgreSQL.

## 🚀 Service
Cria um Service do Kubernetes chamado postgres do tipo ClusterIP, que expõe a porta 5432 apenas dentro do cluster e encaminha o tráfego para os Pods do PostgreSQL que tenham o label correspondente no selector.

