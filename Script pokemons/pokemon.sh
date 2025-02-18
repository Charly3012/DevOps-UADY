#!/bin/bash

POKEMON_NAME="$1"

if [ -z "$POKEMON_NAME" ]; then
    echo "Error: Debes proporcionar un nombre de Pokémon."
    exit 1
fi

API_URL="https://pokeapi.co/api/v2/pokemon/$POKEMON_NAME"
RESPONSE=$(curl -s "$API_URL")

NAME=$(echo "$RESPONSE" | jq -r '.name // empty')
ID=$(echo "$RESPONSE" | jq '.id // empty')
WEIGHT=$(echo "$RESPONSE" | jq '.weight // empty')
HEIGHT=$(echo "$RESPONSE" | jq '.height // empty')
ORDER=$(echo "$RESPONSE" | jq '.order // empty')

if [ -z "$NAME" ]; then
    echo "Error: Pokémon '$POKEMON_NAME' no encontrado."
    exit 1
fi

echo "${NAME^} - Numero de pokemon: $ID"
echo "ID = $ID"
echo "Weight = $WEIGHT"
echo "Height = $HEIGHT"
echo "Order = $ORDER"

# Por si no existe
if [ ! -f pokemones.csv ]; then
    echo "ID,Name,Weight,Height,Order" > pokemones.csv
fi

echo "$ID,$NAME,$WEIGHT,$HEIGHT,$ORDER" >> pokemones.csv
