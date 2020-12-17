#!/usr/bin/env bash


set -Ee -o functrace


## Find true directory this script resides in
__SOURCE__="${BASH_SOURCE[0]}"
while [[ -h "${__SOURCE__}" ]]; do
    __SOURCE__="$(find "${__SOURCE__}" -type l -ls | sed -n 's@^.* -> \(.*\)@\1@p')"
done
__DIR__="$(cd -P "$(dirname "${__SOURCE__}")" && pwd)"
__PARENT_DIR__=$(dirname "${__DIR__}")


# shellcheck source=to-array.sh
source "${__PARENT_DIR__}/to-array.sh"


## Provides verify_equality '<target_ref>' '<expected_ref>'
# shellcheck source=.travis-ci/lib/verify-equality.sh
source "${__DIR__}/lib/verify-equality.sh"

## Provides print_error '<message_ref>'
# shellcheck source=.travis-ci/lib/print-error.sh
source "${__DIR__}/lib/print-error.sh"

## Provides print_array '<array_ref>' '<padding_ammount>'
##          pad_string '<padding_ammount>' '<character>'
# shellcheck source=.travis-ci/lib/print-array.sh
source "${__DIR__}/lib/print-array.sh"


# shellcheck source=.travis-ci/features/double-quotes.sh
source "${__DIR__}/features/double-quotes.sh"

# shellcheck source=.travis-ci/features/single-quotes.sh
source "${__DIR__}/features/single-quotes.sh"

# shellcheck source=.travis-ci/features/mixed-quotes.sh
source "${__DIR__}/features/mixed-quotes.sh"

# shellcheck source=.travis-ci/features/no-quotes.sh
source "${__DIR__}/features/no-quotes.sh"


# # shellcheck source=.travis-ci/errors/number.sh
# source "${__DIR__}/errors/number.sh"


##
#
test_function() {
    local _function_name="${1:?No function_name name provided}"
    local -a _function_arguments=( "${@}" )
    unset "_function_arguments[0]"
    "${_function_name}" "${_function_arguments[@]}" || {
        local _status="${?}"
        printf 'Failed -> %s\n' "${_function_name}"
        return "${_status}"
    }
}


test_function double_quotes
test_function mixed_quotes
test_function no_quotes
test_function single_quotes

