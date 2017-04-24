<?php
	$data[0][0] = "key";
	$data[0][1] = "value";

	$data[1][0] = "ÁRVÍZTŰRŐ";
	$data[1][1] = "TÜKÖRFÚRÓGÉP";

	$data[2][0] = "árvíztűrő";
	$data[2][1] = "tükörfúrógép";

	$output_format = 'txt';
	if (isset($argv[1]))
		$output_format = $argv[1];

	$rlib =	rlib_init();
	rlib_version();
	rlib_set_output_format_from_text($rlib, $output_format);
	rlib_add_datasource_array($rlib, "local_array");
	rlib_add_query_as($rlib, "local_array", "data", "data");
	rlib_add_report($rlib, "hungary2.xml");
	rlib_set_output_encoding($rlib, "ISO8859-2");
	rlib_set_output_parameter($rlib, "pdf_fontname", "Liberation Mono");

	rlib_execute($rlib);
	$my_header = explode("\n", rlib_get_content_type($rlib));
	foreach($my_header as $x) {
		if($x != '')
			header($x);
	}
	rlib_spool($rlib);
	rlib_free($rlib);
?>
