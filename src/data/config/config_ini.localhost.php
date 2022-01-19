<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC <contact@vinades.vn>
 * @Copyright (C) 2022 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
<<<<<<< HEAD
 * @Createdate Wed, 19 Jan 2022 03:54:17 GMT
=======
 * @Createdate Wed, 19 Jan 2022 06:27:38 GMT
>>>>>>> 5cfc04f09c258aaf53857e2bbd69432103949bb5
 */

if (!defined('NV_MAINFILE')) {
    die('Stop!!!');
}

$sys_info['disable_classes'] = [];
$sys_info['disable_functions'] = [];
$sys_info['ini_set_support'] = true;
$sys_info['supports_rewrite'] = 'rewrite_mode_apache';
$sys_info['zlib_support'] = true;
$sys_info['mb_support'] = true;
$sys_info['iconv_support'] = true;
$sys_info['allowed_set_time_limit'] = true;
$sys_info['os'] = 'WINDOWS NT';
$sys_info['fileuploads_support'] = true;
$sys_info['curl_support'] = true;
$sys_info['ftp_support'] = false;
$sys_info['string_handler'] = 'mb';
$sys_info['support_cache'] = ['redis'];
$sys_info['php_compress_methods'] = ['deflate' => 'gzdeflate', 'gzip' => 'gzencode', 'x-gzip' => 'gzencode', 'compress' => 'gzcompress', 'x-compress' => 'gzcompress'];
$sys_info['server_headers'] = ['server' => 'Apache/2.4.41 (Win64) OpenSSL/1.1.1c PHP/7.3.11','x-powered-by' => 'PHP/7.3.11','content-length' => '0','content-type' => 'text/html; charset=UTF-8'];
$sys_info['ip6_support'] = true;

ini_set('display_errors', '0');
ini_set('display_startup_errors', '0');
ini_set('log_errors', '0');
ini_set('memory_limit', '6400M');
ini_set('session.cookie_httponly', '1');
ini_set('session.gc_maxlifetime', '3600');
ini_set('user_agent', 'NV4');

<<<<<<< HEAD
$iniSaveTime = 1642564457;
=======
$iniSaveTime = 1642573658;
>>>>>>> 5cfc04f09c258aaf53857e2bbd69432103949bb5
