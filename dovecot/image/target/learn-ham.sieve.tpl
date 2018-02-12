require ["vnd.dovecot.pipe", "copy", "imapsieve"];
pipe :copy "rspamc -h rspamd -P RSPAMD_WEB_PASSWORD" ["learn_ham"];
