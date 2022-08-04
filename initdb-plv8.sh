#!/bin/bash

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Create the plv8 extension
"${psql[@]}" --dbname="$POSTGRES_DB" <<- 'EOSQL'
CREATE EXTENSION IF NOT EXISTS plv8;
EOSQL