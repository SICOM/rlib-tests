/*
 *  Copyright (C) 2017 SICOM Systems, INC.
 *
 *  Author: Zoltán Böszörményi <zboszormenyi@sicom.com>
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

#include <limits.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <rlib.h>

static char cwd[PATH_MAX];

int main(int argc, char **argv) {
	rlib *r;

	if (argc == 1) {
		printf("usage: %s [ pdf | xml | txt | csv | html ]\n", argv[0]);
		return 1;
	}

	if (getcwd(cwd, sizeof(cwd)) == NULL)
		return 1;
	strcat(cwd, "/locale");

	r = rlib_init();
	rlib_bindtextdomain(r, "translate", cwd);
	rlib_set_locale(r, "en_US");
	rlib_add_report(r, "translate.xml");
	rlib_set_output_format_from_text(r, argv[1]);
	rlib_set_output_encoding(r, "UTF-8");
	rlib_execute(r);
	rlib_spool(r);
	rlib_free(r);

	return 0;
}
