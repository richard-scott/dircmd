#
# https://github.com/dircmd/dircmd
#
#export DIRCMD_DEBUG=1
export DIRCMD_VERSION="2.0.2"
if echo "${SHELL}" | grep -E -q "/bash$"; then
  export DIRCMD_PATH="${BASH_SOURCE[0]}"
fi

if ! declare -p DIRCMD_STORAGE >/dev/null 2>&1; then
  if uname -s | grep -i -q 'darwin'; then
    declare -a DIRCMD_STORAGE
  else
    declare -A DIRCMD_STORAGE
  fi
fi

_dircmd_get_hash() {
  echo "DIRCMD_$(echo ${PWD} | sha1sum | awk '{print $1}')"
}

_dircmd_source() {
  if [[ -e .dircmd ]]; then
    if [[ $(find .dircmd -type f 2>/dev/null | wc -l) -gt 0 ]]; then
      for ES in .dircmd/*${1}; do
        if [[ -n "${DIRCMD_DEBUG}" ]]; then
          echo "Sourcing: ${PWD}/${ES}"
        fi
        export DIRCMD_HASH="$(_dircmd_get_hash)"
        source "${ES}" </dev/null
      done
    fi
  fi
}

_dircmd_hook() {
  local previous_exit_status=$?
  exec 6<&0
  local HASH="$(_dircmd_get_hash)"

  local CHECKSUM="$(sha1sum ${BASH_SOURCE[0]} | awk '{print $1}')"
  if [[ -z "${DIRCMD_CHECKSUM}" ]]; then
    export DIRCMD_CHECKSUM="$(echo ${CHECKSUM})"
  fi
  if [[ -n "${DIRCMD_CHECKSUM}" ]]; then
    if [[ ${CHECKSUM} != ${DIRCMD_CHECKSUM} ]]; then
      unset DIRCMD_CHECKSUM
      source ${DIRCMD_PATH}
      _dircmd_hook
      return 0
    fi
  fi
  if [[ ${DIRCMD_HASH} != "${HASH}" ]]; then
    export DIRCMD_HASH="$(_dircmd_get_hash)"
    if [[ -z "${OLDPWD}" ]]; then
      local OLD_DIR="${PWD}"
    else
      local OLD_DIR="${OLDPWD}"
    fi
    local NEW_DIR="${PWD}"

    if [[ -n "${DIRCMD_DEBUG}" ]]; then
      echo "OLD_DIR: ${OLD_DIR}"
      echo "NEW_DIR: ${NEW_DIR}"
    fi
    if echo "${OLD_DIR}" | grep -E -q "^${PWD}" && ! echo "${OLD_DIR}" | grep -E -q "^${PWD}$"; then
      if [[ -n "${DIRCMD_DEBUG}" ]]; then
        echo ">>> [up]"
      fi
      cd "${OLD_DIR}"
      while ! echo "${PWD}" | grep -E -q "^(/|${NEW_DIR})$"; do
        if [[ -n "${DIRCMD_DEBUG}" ]]; then
          echo "PWD: ${PWD}"
        fi
        _dircmd_source "exit"
        cd ..
      done
    elif echo "${PWD}" | grep -E -q "^${OLD_DIR}"; then
      if echo "${OLD_DIR}" | grep -E -q "^${PWD}$"; then
        if [[ -n "${DIRCMD_DEBUG}" ]]; then
          echo ">>> [first]"
        fi
        OLD_DIR="/"
      fi
      if [[ -n "${DIRCMD_DEBUG}" ]]; then
        echo ">>> [down]"
      fi
      while ! echo "${PWD}" | grep -E -q "^${OLD_DIR}$"; do
        if [[ -e .dircmd ]]; then
          local DIRCMD_LIST[${#DIRCMD_LIST[@]}]="${PWD}"
        fi
        cd ..
      done
      cd "${NEW_DIR}"
      for ((i = ${#DIRCMD_LIST[@]}; i >= 0; i--)); do
        cd "${DIRCMD_LIST[${i}]}"
        _dircmd_source "entry"
      done
      cd "${NEW_DIR}"
    else
      if [[ -n "${DIRCMD_DEBUG}" ]]; then
        echo ">>> [out]"
      fi
      cd "${OLD_DIR}"
      while ! echo "${PWD}" | grep -E -q "^(/|${NEW_DIR})$"; do
        if [[ -n "${DIRCMD_DEBUG}" ]]; then
          echo "PWD: ${PWD}"
        fi
        _dircmd_source "exit"
        cd ..
      done
      cd "${NEW_DIR}"
      OLD_DIR="/"
      while ! echo "${PWD}" | grep -E -q "^${OLD_DIR}$"; do
        if [[ -e .dircmd ]]; then
          local DIRCMD_LIST[${#DIRCMD_LIST[@]}]="${PWD}"
        fi
        cd ..
      done
      for ((i = ${#DIRCMD_LIST[@]}; i >= 0; i--)); do
        cd "${DIRCMD_LIST[${i}]}"
        _dircmd_source "entry"
      done
      cd "${NEW_DIR}"
    fi
  else
    if [[ -n "${DIRCMD_DEBUG}" ]]; then
      echo ">>> [same]"
    fi
  fi
  exec 6<&0
  export DIRCMD_HASH="$(_dircmd_get_hash)"
  return $previous_exit_status
}

if ! [[ "${PROMPT_COMMAND}" =~ _dircmd_hook ]]; then
  PROMPT_COMMAND="_dircmd_hook; ${PROMPT_COMMAND}"
fi

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
