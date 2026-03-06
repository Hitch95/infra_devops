# Infrastructure DevOps - TP Terraform

Projet d'infrastructure as Code utilisant **Terraform** avec **Docker** pour déployer une application Node.js avec PostgreSQL localement (gratuit).

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                   infra-devops-network                       │
│                                                              │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐   │
│  │   Postgres  │    │    API       │    │   Adminer    │   │
│  │  :5432      │◄──►│  :3000       │    │   :8080     │   │
│  └─────────────┘    └─────────────┘    └─────────────┘   │
│                           │                                  │
└───────────────────────────┼──────────────────────────────────┘
                            │
                     ┌──────┴──────┐
                     │  Host OS    │
                     │ :3003 :8080 │
                     └─────────────┘
```

## Prérequis

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installé et lancé
- Terraform disponible dans le PATH ou chemin personnalisé

## Structure des fichiers

```
infra-devops/
├── app/                     # Application Node.js
│   ├── Dockerfile           # Image Docker de l'API
│   ├── package.json         # Dépendances Node.js
│   └── server.js            # Serveur Express
│
├── terraform/                # Configuration Terraform
│   ├── versions.tf          # Version Terraform et providers
│   ├── variables.tf         # Variables configurables
│   ├── main.tf              # Ressources Docker
│   └── outputs.tf           # Sorties après déploiement
│
└── README.md                # Ce fichier
```

## Variables configurables

Modifier `terraform/variables.tf` :

| Variable | Description | Défaut |
|----------|-------------|--------|
| `project_name` | Nom du projet | `infra-devops` |
| `app_env` | Environnement | `dev` |
| `api_port` | Port de l'API | `3003` |
| `adminer_port` | Port Adminer | `8080` |
| `db_user` | User PostgreSQL | `admin` |
| `db_password` | Mot de passe BDD | `admin123` |
| `db_name` | Nom de la BDD | `appdb` |

## Commandes

### Initialisation

```bash
cd terraform
C:\Users\bmoufidi\tools\terraform\terraform### Déploiement.exe init
```



```bash
C:\Users\bmoufidi\tools\terraform\terraform.exe apply
```

Confirmer avec `yes`.

### Vérification

```bash
C:\Users\bmoinfo\tools\terraform\terraform.exe output
```

### Destruction

```bash
C:\Users bmoufidi\tools\terraform\terraform.exe destroy
```

## Services déployés

| Service | URL | Description |
|---------|-----|-------------|
| API | http://localhost:3003 | Application Node.js |
| Health | http://localhost:3003/health | Endpoint de santé |
| Adminer | http://localhost:8080 | Interface pgAdmin |

## Endpoints API

- `GET /health` → `{"status":"ok"}`
- `GET /` → Message avec APP_ENV

## Variables d'environnement de l'API

- `PORT=3000`
- `APP_ENV=dev`
- `DATABASE_URL=postgres://admin:admin123@postgres:5432/appdb`

## Tests

```bash
# Test health
curl http://localhost:3003/health

# Test home
curl http://localhost:3003/
```

## Connexion à la base de données

Via Adminer (http://localhost:8080) :
- Serveur : `postgres`
- Utilisateur : `admin`
- Mot de passe : `admin123`
- Base de données : `appdb`

## Dépannage

### Erreur "port already allocated"
Modifier `api_port` dans `variables.tf` et réappliquer.

### Docker non disponible
Vérifier que Docker Desktop est lancé.

### Erreur de permissions
Lancer le terminal en tant qu'administrateur si nécessaire.
