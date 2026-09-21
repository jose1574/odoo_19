#!/usr/bin/env bash
set -euo pipefail

ACTION="${1:-restart}"

case "$ACTION" in
    start|stop|restart|status)
        sudo systemctl "$ACTION" odoo.service
        ;;
    logs)
        sudo journalctl -u odoo.service -f
        ;;
    *)
        echo "Uso: $0 {start|stop|restart|status|logs}" >&2
        exit 2
        ;;
esac