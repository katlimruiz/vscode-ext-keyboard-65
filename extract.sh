# This script will extract all keys that are related to Function Keys

cat defaults-2024-02.json |\
    # extract the keybindings involving F1-12 keys
    jq '[ .[] | select(.key | test("\\+?f[0-9][0-9]?$", "ix")) ] |  sort_by(.key)' |\
    # add the key prefix
    sed 's/"key": "/"key": "cmd+escape /i' |\
    # replace F1-9 by numeral keys
    sed -E 's/( |\+)f([1-9])"/\1\2"/i' |\
    # replace F10 by 0
    sed -E 's/( |\+)f10"/\10"/i' |\
    # replace F11 by -
    sed -E 's/( |\+)f11"/\1-"/i' |\
    # replace F12 by -
    sed -E 's/( |\+)f12"/\1="/i'>extracted.json
