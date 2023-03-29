#!/bin/sh

echo "Setup running"
if [ ! -f ./.env ]; then
    echo "Copying .env file..."
    cp ./.env.dist ./.env
fi

source ./.env

echo "Setup done"