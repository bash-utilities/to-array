# To Array
[heading__top]:
  #to-array
  "&#x2B06; Bash array from string with quote parsing"


Bash array from string with quote parsing


## [![Byte size of To Array][badge__main__to_array__source_code]][to_array__main__source_code] [![Open Issues][badge__issues__to_array]][issues__to_array] [![Open Pull Requests][badge__pull_requests__to_array]][pull_requests__to_array] [![Latest commits][badge__commits__to_array__main]][commits__to_array__main]  [![Build Status][badge_travis_ci]][build_travis_ci]



---


- [:arrow_up: Top of Document][heading__top]

- [:building_construction: Requirements][heading__requirements]

- [:zap: Quick Start][heading__quick_start]

  - [:memo: Edit Your ReadMe File][heading__your_readme_file]
  - [:floppy_disk: Commit and Push][heading__commit_and_push]

- [&#x1F9F0; Usage][heading__usage]

- [&#x1F5D2; Notes][heading__notes]

- [:chart_with_upwards_trend: Contributing][heading__contributing]

  - [:trident: Forking][heading__forking]
  - [:currency_exchange: Sponsor][heading__sponsor]

- [:card_index: Attribution][heading__attribution]

- [:balance_scale: Licensing][heading__license]


---



## Requirements
[heading__requirements]:
  #requirements
  "&#x1F3D7; Prerequisites and/or dependencies that this project needs to function properly"


This project is written and tested for devices with Bash version `4.4` (or greater)


______


## Quick Start
[heading__quick_start]:
  #quick-start
  "&#9889; Perhaps as easy as one, 2.0,..."


This repository encourages the use of Git Submodules to track dependencies


**Bash Variables**


```Bash
_module_name='to-array'
_module_https_url="https://github.com/bash-utilities/to-array.git"
_module_base_dir='modules'
_module_path="${_module_base_dir}/${_module_name}"
```


**Bash Submodule Commands**


```Bash
cd "<your-git-project-path>"

git checkout gh-pages

mkdir -vp "${_module_base_dir}"

git submodule add -b main\
                  --name "${_module_name}"\
                  "${_module_https_url}"\
                  "${_module_path}"
```


---


### Your ReadMe File
[heading__your_readme_file]:
  #your-readme-file
  "&#x1F4DD; Suggested additions for your ReadMe.md file so everyone has a good time with submodules"


Suggested additions for your _`ReadMe.md`_ file so everyone has a good time with submodules


```MarkDown
Clone with the following to avoid incomplete downloads


    git clone --recurse-submodules <url-for-your-project>


Update/upgrade submodules via


    git submodule update --init --merge --recursive
```


---


### Commit and Push
[heading__commit_and_push]:
  #commit-and-push
  "&#x1F4BE; It may be just this easy..."


```Bash
git add .gitmodules
git add "${_module_path}"


## Add any changed files too


git commit -F- <<'EOF'
:heavy_plus_sign: Adds `bash-utilities/to-array#1` submodule



**Additions**


- `.gitmodules`, tracks submodules AKA Git within Git _fanciness_

- `README.md`, updates installation and updating guidance

- `modules/to-array`, submodule provides Bash function that splits string to array
EOF


git push origin gh-pages
```


**:tada: Excellent :tada:** your project is now ready to begin unitizing code from this repository!


______


## Usage
[heading__usage]:
  #usage
  "&#x1F9F0; How to utilize this repository"


Write a script that sources and utilizes `to_array` function...


**`example.sh`**


```Bash
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
```


Provide executable permissions and run `example.sh` script...


```Bash
chmod u+x example.sh

./example.sh '"spam flavored" ham "in a can"'
#> _argument[0] -> ( 'spam flavored' 'ham' 'in a can' )
```


______


## Notes
[heading__notes]:
  #notes
  "&#x1F5D2; Additional things to keep in mind when developing"


This repository may not be feature complete and/or fully functional, Pull Requests that add features or fix bugs are certainly welcomed.


---


To list available parameters use `--help` option...


```Bash
cd "<your-git-project-path>"

modules/to-array/to-array.sh --help
```


______


## Contributing
[heading__contributing]:
  #contributing
  "&#x1F4C8; Options for contributing to to-array and bash-utilities"


Options for contributing to to-array and bash-utilities


---


### Forking
[heading__forking]:
  #forking
  "&#x1F531; Tips for forking to-array"


Start making a [Fork][to_array__fork_it] of this repository to an account that you have write permissions for.


- Add remote for fork URL. The URL syntax is _`git@github.com:<NAME>/<REPO>.git`_...


```Bash
cd ~/git/hub/bash-utilities/to-array

git remote add fork git@github.com:<NAME>/to-array.git
```


- Commit your changes and push to your fork, eg. to fix an issue...


```Bash
cd ~/git/hub/bash-utilities/to-array


git commit -F- <<'EOF'
:bug: Fixes #42 Issue


**Edits**


- `<SCRIPT-NAME>` script, fixes some bug reported in issue
EOF


git push fork main
```


> Note, the `-u` option may be used to set `fork` as the default remote, eg. _`git push -u fork main`_ however, this will also default the `fork` remote for pulling from too! Meaning that pulling updates from `origin` must be done explicitly, eg. _`git pull origin main`_


- Then on GitHub submit a Pull Request through the Web-UI, the URL syntax is _`https://github.com/<NAME>/<REPO>/pull/new/<BRANCH>`_


> Note; to decrease the chances of your Pull Request needing modifications before being accepted, please check the [dot-github](https://github.com/bash-utilities/.github) repository for detailed contributing guidelines.


---


### Sponsor
  [heading__sponsor]:
  #sponsor
  "&#x1F4B1; Methods for financially supporting bash-utilities that maintains to-array"


Thanks for even considering it!


Via Liberapay you may <sub>[![sponsor__shields_io__liberapay]][sponsor__link__liberapay]</sub> on a repeating basis.


Regardless of if you're able to financially support projects such as to-array that bash-utilities maintains, please consider sharing projects that are useful with others, because one of the goals of maintaining Open Source repositories is to provide value to the community.


______


## Attribution
[heading__attribution]:
  #attribution
  "&#x1F4C7; Resources that where helpful in building this project so far."


- [GitHub -- `github-utilities/make-readme`](https://github.com/github-utilities/make-readme)


______


## License
[heading__license]:
  #license
  "&#x2696; Legal side of Open Source"


```
Bash array from string with quote parsing
Copyright (C) 2020 S0AndS0

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published
by the Free Software Foundation, version 3 of the License.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
```


For further details review full length version of [AGPL-3.0][branch__current__license] License.



[branch__current__license]:
  /LICENSE
  "&#x2696; Full length version of AGPL-3.0 License"


[badge__commits__to_array__main]:
  https://img.shields.io/github/last-commit/bash-utilities/to-array/main.svg

[commits__to_array__main]:
  https://github.com/bash-utilities/to-array/commits/main
  "&#x1F4DD; History of changes on this branch"


[to_array__community]:
  https://github.com/bash-utilities/to-array/community
  "&#x1F331; Dedicated to functioning code"


[issues__to_array]:
  https://github.com/bash-utilities/to-array/issues
  "&#x2622; Search for and _bump_ existing issues or open new issues for project maintainer to address."

[to_array__fork_it]:
  https://github.com/bash-utilities/to-array/
  "&#x1F531; Fork it!"

[pull_requests__to_array]:
  https://github.com/bash-utilities/to-array/pulls
  "&#x1F3D7; Pull Request friendly, though please check the Community guidelines"

[to_array__main__source_code]:
  https://github.com/bash-utilities/to-array/
  "&#x2328; Project source!"

[badge__issues__to_array]:
  https://img.shields.io/github/issues/bash-utilities/to-array.svg

[badge__pull_requests__to_array]:
  https://img.shields.io/github/issues-pr/bash-utilities/to-array.svg

[badge__main__to_array__source_code]:
  https://img.shields.io/github/repo-size/bash-utilities/to-array


[sponsor__shields_io__liberapay]:
  https://img.shields.io/static/v1?logo=liberapay&label=Sponsor&message=bash-utilities

[sponsor__link__liberapay]:
  https://liberapay.com/bash-utilities
  "&#x1F4B1; Sponsor developments and projects that bash-utilities maintains via Liberapay"


[badge_travis_ci]:
  https://travis-ci.com/bash-utilities/to-array.svg?branch=main

[build_travis_ci]:
  https://travis-ci.com/bash-utilities/to-array

