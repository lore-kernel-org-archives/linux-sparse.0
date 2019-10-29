From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: detecting misuse of of_get_property
Date: Tue, 29 Oct 2019 15:57:09 +0300
Message-ID: <20191029125606.GH1922@kadam>
References: <ec277c12-c608-6326-7723-be8cab4f524a@rasmusvillemoes.dk>
 <20191029104917.GI1944@kadam>
 <e255d01b-ecd7-8386-e99e-b3226dac27c4@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e255d01b-ecd7-8386-e99e-b3226dac27c4@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dan Carpenter <dan.carpenter@oracle.co>, linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 29, 2019 at 12:43:24PM +0100, Rasmus Villemoes wrote:
> On 29/10/2019 11.50, Dan Carpenter wrote:
> > This should probably work?
> 
> I haven't tested it, but yes, something like that. Can you also do the
> case of struct property::value, i.e. handling
> 
>   struct property *p = ...;
>   u32 *v = p->value;

Attached.

This has a bunch of flaws like "void *value = p->value;" doesn't
generate a warning.  A function that returns a u32 pointer doing
"return p->value;" doesn't generate a value.

Anyway, it's a starting point to experiment with.

regards,
dan carpenter


--0F1p//8PRICkK4MW
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="check_of_get_property.c"

/*
 * Copyright (C) 2019 Oracle.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see http://www.gnu.org/copyleft/gpl.txt
 */

#include "smatch.h"
#include "smatch_slist.h"

static int my_id;

static bool is_u8_or_endian(struct expression *expr)
{
	struct symbol *type;

	type = get_type(expr);
	if (!type || type->type != SYM_PTR)
		return true;
	type = get_base_type(type);
	if (type == &void_ctype)
		return true;
	if (type_bits(type) == 8)
		return true;
	if (type->type == SYM_RESTRICT)
		return true;
	return false;
}

static void match_of_get_property(const char *fn, struct expression *expr, void *unused)
{
	if (is_u8_or_endian(expr->left))
		return;
	sm_warning("'%s' returns big endian data", fn);
}

static void match_assign(struct expression *expr)
{
	struct expression *right;
	struct symbol *type;

	if (expr->op != '=')
		return;
	if (is_u8_or_endian(expr->left))
		return;

	right = strip_expr(expr->right);
	if (!is_void_pointer(right))
		return;
	if (right->type != EXPR_DEREF)
		return;
	if (!right->member || strcmp(right->member->name, "value") != 0)
		return;

	type = get_type(right->deref);
	if (!type || type->type != SYM_STRUCT || !type->ident ||
	    strcmp(type->ident->name, "property") != 0)
		return;

	sm_warning("'(struct property)->value' is big endian");
}

void check_of_get_property(int id)
{
	my_id = id;

	if (option_project != PROJ_KERNEL)
		return;

	add_function_assign_hook("of_get_property", &match_of_get_property, NULL);
	add_hook(&match_assign, ASSIGNMENT_HOOK);
}

--0F1p//8PRICkK4MW--
