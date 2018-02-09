<?php

$CONF['configured'] = true;
$CONF['default_language'] = 'de';
$CONF['database_host'] = 'mysql';
$CONF['database_user'] = 'app';
$CONF['database_password'] = 'MYSQL_PASSWORD';
$CONF['database_name'] = 'app';
$CONF['smtp_server'] = 'postfix';
$CONF['admin_email'] = 'admin@MYHOSTNAME';
$CONF['smtp_client'] = 'MYHOSTNAME';
$CONF['page_size'] = '25';
$CONF['maxquota'] = '8192';
$CONF['default_aliases'] = array (
	'abuse' => 'abuse@MYHOSTNAME',
	'hostmaster' => 'hostmaster@MYHOSTNAME',
	'postmaster' => 'postmaster@MYHOSTNAME',
	'webmaster' => 'webmaster@MYHOSTNAME'
);
$CONF['used_quotas'] = 'YES';
$CONF['quota'] = 'YES';
$CONF['new_quota_table'] = 'YES';

$CONF['setup_password'] = 'd0aa80e46bb3ef8c1eaae28d2fb8c9c5:732576f1b8f41295e120aa382fdbbd6f4390dc0f';

