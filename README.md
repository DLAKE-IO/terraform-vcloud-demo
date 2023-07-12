# Demo vCloud

Voici comment déployer votre infrastructure sur le cloud D-Lake à l'aide de Terraform.

Cet exemple suppose le points suivants :

1. Terraform est installé sur votre poste : https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
2. Vous disposez d'un utilisateur configuré avec des droits adaptés sur votre VDC
3. Vous disposez d'un réseau configuré pour joindre Internet
4. Vous disposez d'une Edge Gateway avec le load balancing activé
5. Vous disposez d'un vApp template

Ce projet permet de déployer 3 serveurs web derrière un Load Balancer avec une page « hello world ».

## TLDR

On initialise le projet pour le premier run. Cela installe notamment le provider vcd.

```
terraform init
```

On crée un plan d'éxecution. Terraform va comparer l'existant à notre code et crée un plan d'éxecution « plan ».

```
terraform plan -out plan
```

On lance le provisionnement à partir de ce plan.

```
terraform apply plan
```
