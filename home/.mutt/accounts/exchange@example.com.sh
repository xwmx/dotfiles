###############################################################################
# .mutt/accounts/exchange@example.com
#
# Example settings for an exchange mutt account.
###############################################################################

export MUTT_PROVIDER="exchange"
export MUTT_ACCOUNT_EMAIL="exchange@example.com"
export MUTT_ACCOUNT_REALNAME="FirstName LastName"
export MUTT_ACCOUNT_SMTP_SERVER="smtp.example.com"
export MUTT_ACCOUNT_IMAP_SERVER="imap.example.com"
# Example OS X keychain password retrieval.
export MUTT_ACCOUNT_PASSWORD="$(
  security find-generic-password \
    -gs "${MUTT_ACCOUNT_EMAIL}" \
    ${HOME}/Library/Keychains/login.keychain 2>&1 \
    | grep password \
    | cut -d '"' -f 2
)"
