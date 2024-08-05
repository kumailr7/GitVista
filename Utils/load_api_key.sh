#!/bin/bash

load_api_key() {
    if [ -f .env ]; then
        export $(grep -v '^#' .env | xargs)
    fi
}