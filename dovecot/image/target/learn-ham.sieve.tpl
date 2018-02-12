require ["vnd.dovecot.pipe", "copy", "imapsieve"];
pipe :copy "/usr/local/bin/rspamc-learn.sh" ["learn_ham"];
