From: "Christopher Li" <sparse@chrisli.org>
Subject: [PATCH] Warn about explicit usage of sizeof(void)
Date: Wed, 24 Dec 2008 18:09:14 -0800
Message-ID: <70318cbf0812241809h158e8767k30dce82acd886ffa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:3590 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbYLYCJP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Dec 2008 21:09:15 -0500
Received: by rv-out-0506.google.com with SMTP id f9so3865044rvb.7
        for <linux-sparse@vger.kernel.org>; Wed, 24 Dec 2008 18:09:14 -0800 (PST)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Tommy Thorn <tommy@numba-tu.com>
Cc: David Given <dg@cowlark.com>, linux-sparse@vger.kernel.org

On Wed, Dec 24, 2008 at 4:15 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Wed, Dec 24, 2008 at 3:35 PM, Tommy Thorn <tommy@numba-tu.com> wrote:
>>
>> You can't have one without the other as you will break identities like
>>
>>  (uintptr_t) (x + k) === (uintptr_t) x + sizeof (typeof (x)) * k
>>
>> which could appear in a macro.
>
> Right. That is exactly the place I actuall want to know. We should
> consider fix that in the source to have proper type. I expect there is
> not much place in the kernel use that.

I think you do have a point that from the "spase as a compiler" point
of view, there is need to maintain the compatibility with gcc. And I do
care about the current patch breaking the assumption of using
void_ctype.bit_size.

So here is what I got. A patch address both of our need. It gives warning
of using sizeof(void) explicitly. void* + offset will continue to work without
warnings. It will also make is_byte_type() continue to work as it was
before.

Here is my test script:

void *p;

int i = sizeof(void);
int j = sizeof(*p);

void* foo(void)
{
	return p + 1;
}

I run the kernel compile with C=2, guess what. None of the current
kernel code use sizeof(void) explicitly. So that is good news.

Every one happy?

Chris


============================================================

Warn about explicit usage of sizeof(void)

sizeof(void) still evaluate as 1 after the warning.
void_ctype.bit_size remain zero so is_byte_type()
will continue to work.

Signed-Off-By: Christopher Li <sparse@chrisli.org>

Index: sparse.chrisl/evaluate.c
===================================================================
--- sparse.chrisl.orig/evaluate.c
+++ sparse.chrisl/evaluate.c
@@ -584,7 +584,7 @@ static struct symbol *evaluate_ptr_add(s
 	}

 	/* Get the size of whatever the pointer points to */
-	multiply = bits_to_bytes(base->bit_size);
+	multiply = (base == &void_ctype) ? 1 : bits_to_bytes(base->bit_size);

 	if (ctype == &null_ctype)
 		ctype = &ptr_ctype;
@@ -2049,8 +2049,14 @@ static struct symbol *evaluate_sizeof(st
 		return NULL;

 	size = type->bit_size;
+
+	if (type->ctype.base_type == &void_ctype) {
+		warning(expr->pos, "expression using sizeof(void)");
+		size = bits_in_char;
+	}
 	if ((size < 0) || (size & (bits_in_char - 1)))
 		expression_error(expr, "cannot size expression");
+
 	expr->type = EXPR_VALUE;
 	expr->value = bits_to_bytes(size);
 	expr->taint = 0;
Index: sparse.chrisl/symbol.c
===================================================================
--- sparse.chrisl.orig/symbol.c
+++ sparse.chrisl/symbol.c
@@ -834,7 +834,7 @@ static const struct ctype_declare {
 	struct symbol *base_type;
 } ctype_declaration[] = {
 	{ &bool_ctype,	    SYM_BASETYPE, MOD_UNSIGNED,		    &bits_in_bool,	
   &max_int_alignment, &int_type },
-	{ &void_ctype,	    SYM_BASETYPE, 0,			    &bits_in_char,	     NULL,		 NULL },
+	{ &void_ctype,	    SYM_BASETYPE, 0,			    NULL,	     NULL,		 NULL },
 	{ &type_ctype,	    SYM_BASETYPE, MOD_TYPE,		    NULL,		     NULL,		 NULL },
 	{ &incomplete_ctype,SYM_BASETYPE, 0,			    NULL,		     NULL,		 NULL },
 	{ &bad_ctype,	    SYM_BASETYPE, 0,			    NULL,		     NULL,		 NULL },
