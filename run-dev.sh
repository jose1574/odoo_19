#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PYTHON="$ROOT_DIR/.venv/bin/python"
CONFIG="$ROOT_DIR/odoo-server.conf"

if [[ ! -x "$PYTHON" ]]; then
    echo "No se encontró el entorno virtual en $ROOT_DIR/.venv" >&2
    exit 1
fi

if systemctl is-active --quiet odoo.service; then
    echo "El servicio de producción está activo en el puerto 8069." >&2
    echo "Deténlo primero con: sudo systemctl stop odoo.service" >&2
    exit 1
fi

cd "$ROOT_DIR"
exec "$PYTHON" "$ROOT_DIR/odoo-bin" \
    -c "$CONFIG" \
    --dev=all \
    --logfile=- \
    "$@"