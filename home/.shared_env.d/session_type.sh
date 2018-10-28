###############################################################################
# shared_env.d/session_type.sh
#
# Test whether the current shell is being used via a remote session.
#
# http://unix.stackexchange.com/a/9607
###############################################################################

if [ -z "${SESSION_TYPE}" ]
then
  if [ -n "${SSH_CLIENT}" ] || [ -n "${SSH_TTY}" ]
  then
    SESSION_TYPE="remote/ssh"
  elif ps > /dev/null 2>&1
  then # Not in macOS sandbox (https://stackoverflow.com/a/38598203)
    case $(ps -o comm= -p ${PPID}) in
      sshd|*/sshd)
        SESSION_TYPE="remote/ssh"
        ;;
    esac
  fi

  export SESSION_TYPE
fi
