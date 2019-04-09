#!/usr/bin/env bash

main() {
    local cilium_started

    cilium_started=true
    echo "As Cilium is running in visibility-mode we can't wait for it to start"
    echo "as it might be waiting for cni0 to be created."

    if [ "$cilium_started" = true ] ; then
        echo 'Cilium successfully started!'
    else
        >&2 echo 'Timeout waiting for Cilium to start...'
        journalctl -u cilium.service --since $(systemctl show -p ActiveEnterTimestamp cilium.service | awk '{print $2 $3}')
        >&2 echo 'Cilium failed to start'
        exit 1
    fi
}

main "$@"
