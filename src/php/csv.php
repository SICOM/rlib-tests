<?php 
	if (isset($argv[1])) {
		if (strcmp($argv[1], "--newheaders") == 0)
			$idx = 2;
		else
			$idx = 1;
	}

	$output_format = 'txt';
	if (isset($argv[$idx]))
		$output_format = $argv[$idx];

	$rlib =	rlib_init();
	rlib_set_output_format_from_text($rlib, $output_format);
	rlib_add_datasource_csv($rlib, "local_csv");
	rlib_add_query_as($rlib, "local_csv", "data.csv", "data");
	rlib_add_report($rlib, "csv.xml");
	rlib_set_output_parameter($rlib, "debugging", "yes");
	rlib_execute($rlib);

	if ($idx = 2) {
		$content_type = rlib_get_content_type($rlib);
		$replace_header = true;
		while (strlen($content_type) > 0) {
			header($content_type, $replace_header);
			$content_type = rlib_get_content_type($rlib);
			$replace_header = false;
		}
	} else {
		header(rlib_get_content_type($rlib));
	}
	rlib_spool($rlib);
	rlib_free($rlib);	
?>
