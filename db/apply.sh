#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
export PGPASSWORD="${DB_PASSWORD}"

for f in "$DIR"/migrations/*.sql; do
  echo ">> Migration : $f"
  psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" \
       -v ON_ERROR_STOP=1 -f "$f"
done
