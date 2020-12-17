#!/usr/bin/env bash


single_quotes() {
    printf '# Started -> %s\n' "${FUNCNAME[0]}"

    local string_one="'spam flavored' 'ham in' 'a can'"
    local -a test_one

    local -a expected_list=(
        "'spam flavored'"
        "'ham in'"
        "'a can'"
    )

    to_array --input "${string_one}" --target 'test_one'
    verify_equality --target test_one --expected expected_list || {
        local _status="${?}"
        print_array test_one
        print_array expected_list
        return "${_status}"
    }

    local string_two="'spam flavored' 'ham in' 'a can'"
    local -a test_two

    local -a expected_two=(
        'spam flavored'
        'ham in'
        'a can'
    )

    to_array --input "${string_two}" --target 'test_two' --strip-single-quotes
    verify_equality --target test_two --expected expected_two || {
        local _status="${?}"
        print_array test_two
        print_array expected_two
        return "${_status}"
    }

    printf '# Finished -> %s\n' "${FUNCNAME[0]}"
}

