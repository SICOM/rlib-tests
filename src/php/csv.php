<?php 
	$output_format = 'txt';
	if (isset($argv[1]))
		$output_format = $argv[1];

	$rlib =	rlib_init();
	rlib_set_output_format_from_text($rlib, $output_format);
	rlib_add_datasource_csv($rlib, "local_csv");
	rlib_add_query_as($rlib, "local_csv", "data.csv", "data");
	rlib_add_report($rlib, "csv.xml");
	rlib_set_output_parameter($rlib, "debugging", "yes");
	rlib_execute($rlib);
	header(rlib_get_content_type($rlib));
	rlib_spool($rlib);
	rlib_free($rlib);	
?>
