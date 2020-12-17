#!/usr/bin/env bash


__to_array__version__='0.0.1'


##
# Removes leading characters from variable reference
# @parameter {Reference}       $1 _reference
# @parameter {number | string} $2 _character
# @example
#   string="''foo bar'''"
#   to_array__strip_leading_character 'string' "'"
#
#   echo "${string}"
#   #> foo bar'''
# @author S0AndS0
# @license AGPL-3.0
to_array__strip_leading_character() {
    local -n _reference="${1}"
    local _character="${2}"

    while [[ "${_reference}" =~ ^${_character}[[:print:]]* ]]; do
        _reference="${_reference:1}"
    done
}


##
# Removes trailing characters from variable reference
# @parameter {Reference}       $1 _reference
# @parameter {number | string} $2 _character
# @example
#   string="''foo bar'''"
#   to_array__strip_trailing_character 'string' "'"
#
#   echo "${string}"
#   #> ''foo bar
# @author S0AndS0
# @license AGPL-3.0
to_array__strip_trailing_character() {
    local -n _reference="${1}"
    local _character="${2}"

    while [[ "${_reference}" =~ [[:print:]]${_character}$ ]]; do
        _reference="${_reference::-1}"
    done
}


##
# Appends to variable reference a value with optional separator
# @parameter {StringReference} $1 _string_reference
# @parameter {number | string} $2 _value
# @parameter {number | string} $3 _separator
# @example
#   string=""
#
#   to_array__append_to_string string "one" ', '
#   to_array__append_to_string string "two" ', '
#   to_array__append_to_string string "three" ', '
#
#   printf 'string -> %s\n' "${string}"
#   #> string -> one, two, three
# @author S0AndS0
# @license AGPL-3.0
to_array__append_to_string() {
    local -n _string_reference="${1}"
    local _value="${2}"
    local _separator="${3}"

    if (( ${#_string_reference} )); then
        _string_reference+="${_separator}${_value}"
    else
        _string_reference="${_value}"
    fi
}


##
# Appends value to array reference
# @parameter {ArrayReference}  $1 _array_reference
# @parameter {number | string} $2 _value
# @example
#   array=( zero one )
#
#   to_array__append_to_array 'array' 'two and one half'
#
#   printf 'array[*] -> ( %s )\n' "${array[*]@Q}"
#   #> array[*] -> ( 'zero' 'one' 'two and one half' )
# @author S0AndS0
# @license AGPL-3.0
to_array__append_to_array() {
    local -n _array_reference="${1}"
    local _value="${2}"
    local -a _array_reference__index_list=( "${!_array_reference[@]}" )

    local _array_reference__index_last=0
    if (( ${#_array_reference__index_list[@]} )); then
        _array_reference__index_last="$(( ${_array_reference__index_list[-1]} + 1))"
    fi

    _array_reference[${_array_reference__index_last}]="${_value}"
}


##
# Prints to STDERR the calling function prefixed to passed message lines
# @parameter {number[] | string[]} $@
# @example
#   fn_caller() {
#     to_array__debug 'Ground control to major Tom' 'come in major Tom'
#   }
#
#   fn_caller
#
#   #> fn_caller: Ground control to major Tom
#   #>            come in major Tom
to_array__debug() {
    local -a _message_lines=( "${@}" )
    local _calling_function="${FUNCNAME[1]}"
    local _message_lines__first="${_message_lines[0]}"
    local -a _message_lines__remaining=( "${_message_lines[@]:1}" )

    (( ${#_message_lines__first} )) && {
        printf >&2 '%s: %s\n' "${_calling_function}" "${_message_lines__first}"
    }

    (( ${#_message_lines__remaining[@]} )) && {
        local _padding_limit="$(( ${#_calling_function} + 2 ))"
        local _padding=''
        local i
        for i in $(seq 1 "${_padding_limit}"); do
            _padding+=' '
        done
        printf >&2 '%s%s\n' "${_padding}" "${_message_lines__remaining[@]}"
    }
}


##
# Assigns array reference with string as an array
# @example
#   target=()
#
#   to_array --strip-quotes -t target -i 'spam "flavored ham" in a can'
#
#   printf 'target[*] -> ( %s )\n' "${target[*]@Q}"
#   #> target[*] -> ( 'spam' 'flavored ham' 'in' 'a' 'can' )
# @author S0AndS0
# @license AGPL-3.0
to_array() {
    ##
    # Initialize locally scoped variables
    local _help=0
    local _verbose=0
    local _strip__double_quotes=0
    local _strip__single_quotes=0
    local _strip__quotes=0
    local _element__separator=' '
    local _target_reference_name
    local _input
    local _version

    ##
    # Parse parameters
    local -a _arguments=( "${@:?No arguments provided to ${FUNCNAME[0]}}" )
    local i
    for i in "${!_arguments[@]}"; do
        case "${_arguments[${i}]}" in
            --target|-t)
                (( i++ )) || { true; }
                local -n _target_reference="${_arguments[${i}]}"
                _target_reference_name="${_arguments[${i}]}"
            ;;
            --input|-i)
                (( i++ )) || { true; }
                _input="${_arguments[${i}]}"
            ;;
            --separator|-s)
                (( i++ )) || { true; }
                _element__separator="${_arguments[${i}]}"
            ;;
            --strip-double-quotes)
                _strip__double_quotes=1
            ;;
            --strip-single-quotes)
                _strip__single_quotes=1
            ;;
            --strip-quotes)
                _strip__quotes=1
            ;;
            --verbose|-v)
                (( _verbose++ )) || { true; }
            ;;
            --version|-V)
                _version=1
            ;;
            --help|-h)
                _help=1
            ;;
        esac
    done

    ##
    # Populate usage variable with parsed parameters
    local __usage__
    read -rd '' __usage__ <<EOF
Appends to array reference with parsed string elements


## Parameters

-t    --target    <ArrayReferance>        ${_target_reference_name:-array_name}

    {Required} - Target array reference to append element(s) to


-i    --input          <number | string>

    {Required} - String to convert to array


-s   --separator       <number | string>  ${_element__separator@Q}

    {Optional} - Character inserted between elements


--strip-double-quotes  <Boolean>          ${_strip__double_quotes:-0}

    {Optional} - If true, then strip double quotes during conversion


--strip-single-quotes  <Boolean>          ${_strip__single_quotes:-0}

    {Optional} - If true, then strip single quotes during conversion


--strip-quotes        <Boolean>           ${_strip__quotes:-0}

    {Optional} - If true, then strip double, and single, quotes during conversion


-v    --verbose       <Counter | Boolean> ${_verbose:-0}

    {Optional} - Prints parsed options and results if flag is present


-h    --help          <Boolean>           ${_help:-0}

    {Optional} - Prints this message if flag is present


## Example

    target=()

    to_array -t target -i 'spam "flavored ham" in a can'

    printf 'target[*] -> ( %s )\\n' "\${target[*]@Q}"
    #> target[*] -> ( 'spam' '"flavored ham"' 'in' 'a' 'can' )
EOF


    ##
    # Detect premature exit states
    if (( _version )); then
        printf '%s\n' "${__to_array__version__}"
        return 0
    fi

    if (( _help )); then
        printf '%s\n' "${__usage__}"
        return 0
    fi

    local -a _element__words
    IFS=' ' read -ra _element__words <<<"${_input}"
    local _element__word
    local _within__single_quotes
    local _within__double_quotes
    local _element__accumulator
    for _element__word in "${_element__words[@]}"; do
        if (( _within__double_quotes )); then
            if [[ "${_element__word}" =~ '"'$ ]]; then
                to_array__append_to_string '_element__accumulator' "${_element__word}" "${_element__separator}"
                if (( _strip__double_quotes )); then
                    to_array__strip_leading_character '_element__accumulator' '"'
                    to_array__strip_trailing_character '_element__accumulator' '"'
                    (( _verbose )) && {
                        to_array__debug 'Stripping double-quotes'
                    }
                elif (( _strip__quotes )); then
                    to_array__strip_leading_character '_element__accumulator' "(\"|')"
                    to_array__strip_trailing_character '_element__accumulator' "(\"|')"
                    (( _verbose )) && {
                        to_array__debug 'Stripping double and/or single quotes'
                    }
                fi

                to_array__append_to_array '_target_reference' "${_element__accumulator}"
                _element__accumulator=''
                _within__double_quotes=0

                (( _verbose )) && {
                    to_array__debug 'Finished double-quote block'
                }
            else
                to_array__append_to_string '_element__accumulator' "${_element__word}" "${_element__separator}"
            fi
        elif (( _within__single_quotes )); then
            if [[ "${_element__word}" =~ "'"$ ]]; then
                to_array__append_to_string '_element__accumulator' "${_element__word}" "${_element__separator}"
                if (( _strip__single_quotes )); then
                    to_array__strip_leading_character '_element__accumulator' "'"
                    to_array__strip_trailing_character '_element__accumulator' "'"
                    (( _verbose )) && {
                        to_array__debug 'Stripping single quotes'
                    }
                elif (( _strip__quotes )); then
                    to_array__strip_leading_character '_element__accumulator' "(\"|')"
                    to_array__strip_trailing_character '_element__accumulator' "(\"|')"
                    (( _verbose )) && {
                        to_array__debug 'Stripping double and/or single quotes'
                    }
                fi

                to_array__append_to_array '_target_reference' "${_element__accumulator}"
                _element__accumulator=''
                _within__single_quotes=0

                (( _verbose )) && {
                    to_array__debug 'Finished single-quote block'
                }
            else
                to_array__append_to_string '_element__accumulator' "${_element__word}" "${_element__separator}"
            fi
        else
            if [[ "${_element__word}" =~ ^'"' ]]; then
                (( _verbose )) && {
                    to_array__debug 'Started double-quote block'
                }

                _within__double_quotes=1
                _element__accumulator="${_element__word}"
            elif [[ "${_element__word}" =~ ^"'" ]]; then
                (( _verbose )) && {
                    to_array__debug 'Started single-quote block'
                }

                _within__single_quotes=1
                _element__accumulator="${_element__word}"
            else
                to_array__append_to_array '_target_reference' "${_element__word}"
                _element__accumulator=''
            fi
        fi
    done

    (( _verbose )) && {
        to_array__debug "${_target_reference_name}[*] -> ( ${_target_reference[*]@Q} )"
    }
}


##
# Enable help and version options if run as a script
case "$@" in
    -h|--help)
        to_array -h
    ;;
    -V|--version)
        to_array -V
    ;;
esac

