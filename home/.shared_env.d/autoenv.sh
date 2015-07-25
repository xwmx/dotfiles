###############################################################################
# Autoenv: Directory-based Environments
#
# If a directory contains a `.env` file, it will automatically be executed
# when you `cd` into it.
#
# This is great for...
#
# - auto-activating virtualenvs
# - project-specific environment variables
# - making millions
# - Foreman env files are completely compatible.
#
#You can also nest envs within eachother.
#
# https://github.com/kennethreitz/autoenv
###############################################################################

# Initialize
if [[ -e "/usr/local/opt/autoenv/activate.sh" ]]
then
  source "/usr/local/opt/autoenv/activate.sh"
fi
