#!/bin/bash
while read -rsn1 ui; do
    case "$ui" in
    $'\x1b')    # Handle ESC sequence.
        # Flush read. We account for sequences for Fx keys as
        # well. 6 should suffice far more then enough.
        read -rsn1 -t 0.1 tmp
        if [[ "$tmp" == "[" ]]; then
            read -rsn1 -t 0.1 tmp
            case "$tmp" in
            "A") printf "Up\n";;
            "B") printf "Down\n";;
            "C") printf "Right\n";;
            "D") printf "Left\n";;
            esac
        fi
        # Flush "stdin" with 0.1  sec timeout.
        read -rsn5 -t 0.1
        ;;
    # Other one byte (char) cases. Here only quit.
    q) break;;
    esac
done
