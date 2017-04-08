<?php
	$output_format = 'txt';
	if (isset($argv[1]))
		$output_format = $argv[1];

	$rlib =	rlib_init();
	rlib_version();
	rlib_set_output_format_from_text($rlib, $output_format);
	rlib_add_report($rlib, "hungary.xml");
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
