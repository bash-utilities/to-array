#!/usr/bin/env bash


no_quotes() {
    printf '# Started -> %s\n' "${FUNCNAME[0]}"

    local string_one="spam flavored ham in a can"
    local -a test_one

    local -a expected_list=(
        'spam'
        'flavored'
        'ham'
        'in'
        'a'
        'can'
    )

    to_array --input "${string_one}" --target 'test_one'
    verify_equality --target test_one --expected expected_list || {
        local _status="${?}"
        print_array test_one
        print_array expected_list
        return "${_status}"
    }

    printf '# Finished -> %s\n' "${FUNCNAME[0]}"
}

