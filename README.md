# Azure Cloud-Native Infrastructure with Terraform & AKS

Ce projet démontre le provisionnement complet d'une infrastructure **Infrastructure as Code (IaC)** sur Azure, le stockage d'images conteneurisées et l'orchestration via Kubernetes.

## Architecture du Projet

L'infrastructure est entièrement pilotée par **Terraform** et comprend :
* **Azure Kubernetes Service (AKS)** : Cluster managé pour l'orchestration des conteneurs.
* **Azure Container Registry (ACR)** : Registre privé pour stocker les images Docker.
* **Azure Virtual Network** : Configuration réseau sécurisée pour le cluster.

## Stack Technique

* **IaC** : Terraform
* **Conteneurisation** : Docker
* **Orchestration** : Kubernetes (kubectl)
* **Cloud** : Microsoft Azure (Azure CLI)
* **Runtime** : Python / Flask (API de démonstration)

## Déploiement Rapide

### 1. Provisionnement de l'infrastructure
```bash
cd terraform
terraform init
terraform apply -auto-approve