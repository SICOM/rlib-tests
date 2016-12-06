<?php
	$hostname = "localhost";
	$username = "rlib";
	$password = "rlib";
	$database = "rlib";	

	$output_format = 'txt';
	if (isset($argv[1]))
		$output_format = $argv[1];

	$rlib =	rlib_init();
	rlib_set_output_format_from_text($rlib, $output_format);
	rlib_add_datasource_mysql($rlib, "local_mysql", $hostname, $username, $password, $database);
	rlib_add_query_as($rlib, "local_mysql", "select * FROM products", "products");
	rlib_add_report($rlib, "products.xml");
	rlib_execute($rlib);
	header(rlib_get_content_type($rlib));
	rlib_spool($rlib);
	rlib_free($rlib);
?>
