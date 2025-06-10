#!/bin/bash

EXTENSIONS_FILE="extensions.txt"

if [ ! -f "$EXTENSIONS_FILE" ]; then
    echo "[ERR] Extensions file not found"
    exit 1
fi

echo "[STEP] Installing extensions:"

while read -r line; do
    if [[ -n "$line" && ! "$line" =~ ^# ]]; then
        echo "[INSTALL] Installing: $line"
        code --install-extension "$line" --force
    fi
done < "$EXTENSIONS_FILE"

if [ -f "./settings.json" ]; then
    echo "[COPY] Copying settings.json"
    VSCODE_SETTINGS_DIR="$HOME/.config/Code/User"
    mkdir -p "$VSCODE_SETTINGS_DIR"  # Создаем директорию, если её нет
    cp "./settings.json" "$VSCODE_SETTINGS_DIR/settings.json"
fi

echo "[FINISH] Done!"