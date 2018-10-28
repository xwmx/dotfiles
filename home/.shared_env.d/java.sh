###############################################################################
# Java
###############################################################################

# Set $JAVA_HOME on macOS
#
# More Information:
# https://stackoverflow.com/q/1348842
if is_macos
then
  if [[ -z "${JAVA_HOME}" ]]
  then
    export JAVA_HOME
    JAVA_HOME="$(/usr/libexec/java_home)"
  fi
fi
