###############################################################################
# .mutt/accounts/example@example.com
#
# Example settings for a gmail mutt account.
###############################################################################

export MUTT_PROVIDER="gmail"
export MUTT_ACCOUNT_EMAIL="example@example.com"
export MUTT_ACCOUNT_REALNAME="FirstName LastName"
# Example OS X keychain password retrieval.
export MUTT_ACCOUNT_PASSWORD="$(
  security find-generic-password \
    -gs "${MUTT_ACCOUNT_EMAIL}" \
    ${HOME}/Library/Keychains/login.keychain 2>&1 \
    | grep password \
    | cut -d '"' -f 2
)"
