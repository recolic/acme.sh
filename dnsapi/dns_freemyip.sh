#!/usr/bin/env sh
#
#Author: Recolic Keghart <root@recolic.net>
#
########  Public functions #####################

freemyip_token=90c55c84d72bf53f87e65a3c

#Usage: dns_freemyip_add   _acme-challenge.www.domain.com   "XKrxpRBosdIKFzxW_CT3KLZNf6q0HG9i01zxXp5CPBs"
dns_freemyip_add() {
  fulldomain="$1"
  txtvalue="$2"

  _info "Add TXT record using freemyip.com api"
  _info "WARNING: If your DDNS domain is 'MYDOMAIN.freemyip.com', you can only create certificate for 'MYDOMAIN.freemyip.com' or '*.MYDOMAIN.freemyip.com'. Subdomains are not supported. "
  _debug "fulldomain: $fulldomain"
  _debug "txtvalue(should be empty on deleting): $txtvalue"

  # txtvalue must be url-encoded. But it's not necessary for acme txt value. 
  _get "https://freemyip.com/update?token=$freemyip_token&domain=$fulldomain&txt=$txtvalue" | grep OK
  return $?
}

#Usage: fulldomain txtvalue
#Remove the txt record after validation.
dns_freemyip_rm() {
  fulldomain="$1"
  txtvalue="$2"

  _info "Delete TXT record using freemyip.com api"
  _debug "fulldomain: $fulldomain"
  _debug "txtvalue: $txtvalue"

  # Leave the TXT record as empty or "null" to delete the record. 
  _get "https://freemyip.com/update?token=$freemyip_token&domain=$fulldomain&txt=" | grep OK
  return $?
}

