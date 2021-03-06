<?php
	$hostname = "localhost";
	$username = "rlib";
	$password = "rlib";
	$database = "rlib";	

	$RLIB_DEBUGGING="1";
	$RPDF_DEBUGGING="1";

	$RLIB_CREATE_TEST_CASE="on";
	$RLIB_TEST_CASE_DIR="generated";

	$output_format = 'txt';
	if (isset($argv[1]))
		$output_format = $argv[1];

	$rlib =	rlib_init();
	rlib_set_output_format_from_text($rlib, $output_format);
	rlib_add_datasource_mysql($rlib, "local_mysql", $hostname, $username, $password, $database);
	rlib_add_query_as($rlib, "local_mysql", "select * FROM products", "products");
	rlib_add_report($rlib, "products.xml");
	rlib_execute($rlib);
	$my_header = explode("\n", rlib_get_content_type($rlib));
	foreach($my_header as $x) {
		if($x != '')
			header($x);
	}
	rlib_spool($rlib);
	rlib_free($rlib);
?>
