#!/usr/bin/env bash

__SOURCE__="${BASH_SOURCE[0]}"
while [[ -h "${__SOURCE__}" ]]; do
    __SOURCE__="$(find "${__SOURCE__}" -type l -ls | sed -n 's@^.* -> \(.*\)@\1@p')"
done
__DIR__="$(cd -P "$(dirname "${__SOURCE__}")" && pwd)"


## Provides to_array -t '<array_reference>' -i '<string>'
source "${__DIR__}/modules/to-array/to-array.sh"


__usage__() {
    cat <<EOF
Converts list of arguments to array(s) and prints results
EOF
}


_arguments=( "${@}" )
for _index in "${!_arguments[@]}"; do
    _argument="${_arguments[${_index}]}"
    case "${_argument}" in
        -h|--help)
            __usage__
            exit 0
        ;;
        *)
            target=()
            to_array -t 'target' -i "${_argument}" --strip-quotes
            printf '_argument[%i] -> ( %s )\n' "${_index}" "${target[*]@Q}"
        ;;
    esac
done


