path = "/usr/local/etc/dkim/$selector.key";
selector = "RSPAMD_DKIM_NAME";

### Enable DKIM signing for alias sender addresses
allow_username_mismatch = true;
