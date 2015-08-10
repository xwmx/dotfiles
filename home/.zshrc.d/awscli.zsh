###############################################################################
# AWS Command Line Interface (CLI)
#
# The AWS Command Line Interface (CLI) is a unified tool to manage your AWS
# services. With just one tool to download and configure, you can control
# multiple AWS services from the command line and automate them through
# scripts.
#
# The AWS CLI introduces a new set of simple file commands for efficient file
# transfers to and from Amazon S3.
#
# https://aws.amazon.com/cli/
###############################################################################

# Load zsh autocompletion.
#
# http://docs.aws.amazon.com/cli/latest/userguide/cli-command-completion.html
_aws_zsh_completer="/usr/local/bin/aws_zsh_completer.sh"
if [[ -e "$_aws_zsh_completer" ]]
then
  source "$_aws_zsh_completer"
fi
