/*
 *  Copyright (C) 2003-2016 SICOM Systems, INC.
 *
 *  Authors: Bob Doan <bdoan@sicompos.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of version 2 of the GNU General Public
 * License as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 */

#include <config.h>

#include <stdio.h>
#include <rlib.h>
#include <rlib_input.h>

int main(int argc, char **argv) {
	const char *connstr;
	rlib *r;

	if (argc == 1) {
		printf("usage: %s [ pdf | xml | txt | csv | html ]\n", argv[0]);
		return 1;
	}

	connstr = "dbname=rlib user=rlib";

	r = rlib_init();
#ifdef rlib_set_query_cache_size
	rlib_set_query_cache_size(r, 2);
#endif
	if (rlib_add_datasource_postgres(r, "local_pg", connstr) < 0) {
		rlib_free(r);
		return 1;
	}
	rlib_add_query_as(r, "local_pg", "select * FROM products", "products");
	rlib_add_report(r, "products.xml");
	rlib_set_output_format_from_text(r, argv[1]);
	rlib_execute(r);
	rlib_spool(r);
	rlib_free(r);
	return 0;
}
