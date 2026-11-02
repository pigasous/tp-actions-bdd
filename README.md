# TP GitHub Actions et bases de données : Exercice 1

## Exercice 1 : PostgreSQL sur le runner et migrations

Les runners `ubuntu-latest` contiennent PostgreSQL, mais le service est **arrêté** par défaut.

**Énoncé :** créer `.github/workflows/db-check.yml`, déclenché à chaque `push`, avec un job `migrations` qui :

1. démarre PostgreSQL avec `sudo systemctl start postgresql.service`, puis attend qu'il accepte des connexions (`pg_isready`, avec une boucle de 15 essais maximum) ;
2. définit le mot de passe `postgres` de l'utilisateur `postgres` et crée la base `tp` (`sudo -u postgres psql` et `sudo -u postgres createdb`) ;
3. applique les migrations avec `db/apply.sh` ;
4. affiche la structure de la table avec la commande `\d students` de `psql`.

Les paramètres de connexion seront passés par des variables d'environnement définies au niveau du workflow :

| Variable | Valeur |
|---|---|
| `DB_HOST` | `localhost` |
| `DB_PORT` | `5432` |
| `DB_NAME` | `tp` |
| `DB_USER` | `postgres` |
| `DB_PASSWORD` | `postgres` |

## Fichiers fournis

- `db/migrations/001_create_students.sql` : crée la table `students`
- `db/migrations/002_add_grade_constraints.sql` : ajoute la contrainte sur la note et un index
- `db/apply.sh` : applique les migrations dans l'ordre alphabétique (lit les variables `DB_*`)

## Envoyer le dossier sur GitHub

1. Créer un dépôt vide `tp-actions-bdd` sur github.com (sans README).
2. Depuis ce dossier :

```bash
git init -b main
git add .
git commit -m "Exercice 1"
git remote add origin https://github.com/VOTRE-COMPTE/tp-actions-bdd.git
git push -u origin main
```

3. Ouvrir l'onglet **Actions** du dépôt et suivre l'exécution du workflow.

## À observer

Le runner est une machine virtuelle neuve à chaque exécution, détruite à la fin du job. La base `tp` est donc recréée à chaque fois.
