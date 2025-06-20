#!/bin/bash

# Always resolve GITVISTA_HOME if needed
GITVISTA_HOME="${GITVISTA_HOME:-$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")/.." && pwd)}"


load_api_key() {
    if [ -f .env ]; then
        export $(grep -v '^#' .env | xargs)
    fi
}