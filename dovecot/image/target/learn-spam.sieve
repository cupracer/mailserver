require ["vnd.dovecot.pipe", "copy", "imapsieve"];
pipe :copy "rspamc-learn" ["learn_spam"];
