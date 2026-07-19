#
# https://github.com/dircmd/dircmd
#
export DIRCMD_VERSION="3.0.0"

# Detect Shell Type
unset SHELL_TYPE
if [[ -n "${BASH_VERSION}" ]]; then
  export SHELL_TYPE="bash"
fi
if [[ -n "${ZSH_VERSION}" ]]; then
  export SHELL_TYPE="zsh"
fi
if [[ -z "${SHELL_TYPE}" ]]; then
  return 0
fi

_dircmd_search_tree() {

  local _start_dir="${1}"
  local _end_dir="${2}"
  local _reverse_list="${3:-0}"
  local _search_list=()

  while ! echo "${_start_dir}" | grep -qE "^${_end_dir}$"; do
    if [[ -d "${_start_dir}/.dircmd" ]]; then
      _search_list+=("${_start_dir}/.dircmd")
    fi
    _start_dir="$(dirname "${_start_dir}")"
  done

  if [[ ${_reverse_list} -eq 0 ]]; then
    local _squence=$(seq --separator=" " 0 "${#_search_list[@]}")
    local _mode="exit"
  else
    local _squence=$(seq --separator=" " 0 "${#_search_list[@]}" | rev)
    local _mode="entry"
  fi

  for i in ${_squence}; do
    for ES in $(ls ${_search_list[${i}]}/*${_mode} 2>/dev/null); do
      source "${ES}" </dev/null
    done
  done
}

_dircmd_hook() {
  if [[ -z "${DIRCMD_OLDPWD}" ]] || echo "${DIRCMD_OLDPWD}" | grep -qE "^${PWD}$"; then
    true
  else
    if echo "${OLDPWD}" | grep -qE "^${PWD}"; then
      _dircmd_search_tree "${OLDPWD}" "${PWD}" 0
    elif echo "${PWD}" | grep -qE "^${OLDPWD}"; then
      _dircmd_search_tree "${PWD}" "${OLDPWD}" 1
    else
      _dircmd_search_tree "${OLDPWD}" "/" 0
      _dircmd_search_tree "${PWD}" "/" 1
    fi
  fi
  export DIRCMD_OLDPWD="${PWD}"
}

_dircmd_save() {
  VAR_NAME="${DIRCMD_HASH}_${1}"
  VAR_DATA="${!1}"
  DIRCMD_STORAGE[${VAR_NAME}]="${VAR_DATA}"
}

_dircmd_restore() {
  VAR_NAME="${DIRCMD_HASH}_${1}"
  VAR_DATA="${DIRCMD_STORAGE[${VAR_NAME}]}"
  if [[ -n "${VAR_DATA}" ]]; then
    unset ${1}
    export ${1}="${VAR_DATA}"
  fi
}

if ((BASH_VERSINFO[0] > 5 || BASH_VERSINFO[0] == 5 && BASH_VERSINFO[1] >= 1)); then
  PROMPT_COMMAND=${PROMPT_COMMAND-}
  PROMPT_COMMAND+=("_dircmd_hook")
else
  PROMPT_COMMAND="_dircmd_hook; ${PROMPT_COMMAND}"
fi

prmptcmd() {
  eval "${PROMPT_COMMAND}"
}
precmd_functions=(prmptcmd)
