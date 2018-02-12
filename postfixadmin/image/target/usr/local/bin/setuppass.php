<?php

// taken from PostfixAdmin setup.php
function generate_setup_password_salt() {
	$salt = time() . '*' . random_str(32) . '*' . mt_rand(0,60000);
	$salt = md5($salt);
	return $salt;
}

// taken from PostfixAdmin setup.php
function encrypt_setup_password($password, $salt) {
	return $salt . ':' . sha1($salt . ':' . $password);
}

/**
 * Source: https://stackoverflow.com/questions/4356289/php-random-string-generator/31107425#31107425
 *
 * Generate a random string, using a cryptographically secure
 * pseudorandom number generator (random_int)
 *
 * For PHP 7, random_int is a PHP core function
 * For PHP 5.x, depends on https://github.com/paragonie/random_compat
 *
 * @param int $length      How many characters do we want?
 * @param string $keyspace A string of all possible characters
 *                         to select from
 * @return string
 */
function random_str($length, $keyspace = '.0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')
{
	$str = '';
	$max = mb_strlen($keyspace, '8bit') - 1;
	for ($i = 0; $i < $length; ++$i) {
		$str .= $keyspace[random_int(0, $max)];
	}
	return $str;
}

///////////////

if(empty($argv[1])) {
	echo "parameter missing";
	exit(1);
}else {
	echo encrypt_setup_password("$argv[1]", generate_setup_password_salt());
}

