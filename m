From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH] Warn about explicit usage of sizeof(void) and sizeof(function)
Date: Thu, 25 Dec 2008 21:36:45 +0300
Message-ID: <20081225182817.26024.19045.stgit@zaytsev.su>
References: <4953C17B.8060803@numba-tu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:59402 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbYLYS11 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 25 Dec 2008 13:27:27 -0500
Received: by ug-out-1314.google.com with SMTP id 39so902410ugf.37
        for <linux-sparse@vger.kernel.org>; Thu, 25 Dec 2008 10:27:25 -0800 (PST)
In-Reply-To: <4953C17B.8060803@numba-tu.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Tommy Thorn <tommy@numba-tu.com>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

Tommy Thorn wrote:
> Christopher Li wrote:
>> So here is what I got. A patch address both of our need. It gives warning
>> of using sizeof(void) explicitly. void* + offset will continue to work without
>> warnings. It will also make is_byte_type() continue to work as it was
>> before.
>>
>> Here is my test script:
>>
>> void *p;
>>
>> int i = sizeof(void);
>> int j = sizeof(*p);
>>   

> I can't test it right now, but does it give a warning for both sizeof's 
> above? If just first results in a warning, then I think that quite 
> reasonable.

Both trigger the warning. I'm not sure this is a problem, as there are
no such usage cases in the kernel.

I added (hopefully the right way) handling of (sizeof(function)) to the
patch. function++ was already prohibited.

Running the test on the kernel right now.

--


From: Christopher Li <sparse@chrisli.org>

sizeof(void) and sizeof(function) still evaluate as 1
after the warning. void_ctype.bit_size remain zero so
is_byte_type() will continue to work.

Signed-Off-By: Christopher Li <sparse@chrisli.org>
[sizeof(function) added by Alexey Zaytsev]
Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
---
 evaluate.c |   13 ++++++++++++-
 symbol.c   |    2 +-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index f976645..e82be53 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -579,7 +579,7 @@ static struct symbol *evaluate_ptr_add(struct expression *expr, struct symbol *i
 	}
 
 	/* Get the size of whatever the pointer points to */
-	multiply = bits_to_bytes(base->bit_size);
+	multiply = (base == &void_ctype) ? 1 : bits_to_bytes(base->bit_size);
 
 	if (ctype == &null_ctype)
 		ctype = &ptr_ctype;
@@ -2044,8 +2044,19 @@ static struct symbol *evaluate_sizeof(struct expression *expr)
 		return NULL;
 
 	size = type->bit_size;
+
+	if (type->ctype.base_type == &void_ctype) {
+		warning(expr->pos, "expression using sizeof(void)");
+		size = bits_in_char;
+	}
+
+	if (is_function(type->ctype.base_type)) {
+		warning(expr->pos, "expression using sizeof on a function");
+		size = bits_in_char;
+	}
 	if ((size < 0) || (size & (bits_in_char - 1)))
 		expression_error(expr, "cannot size expression");
+
 	expr->type = EXPR_VALUE;
 	expr->value = bits_to_bytes(size);
 	expr->taint = 0;
diff --git a/symbol.c b/symbol.c
index 02844cf..4da253b 100644
--- a/symbol.c
+++ b/symbol.c
@@ -834,7 +834,7 @@ static const struct ctype_declare {
 	struct symbol *base_type;
 } ctype_declaration[] = {
 	{ &bool_ctype,	    SYM_BASETYPE, MOD_UNSIGNED,		    &bits_in_bool,	     &max_int_alignment, &int_type },
-	{ &void_ctype,	    SYM_BASETYPE, 0,			    &bits_in_char,	     NULL,		 NULL },
+	{ &void_ctype,	    SYM_BASETYPE, 0,			    NULL,		     NULL,		 NULL },
 	{ &type_ctype,	    SYM_BASETYPE, MOD_TYPE,		    NULL,		     NULL,		 NULL },
 	{ &incomplete_ctype,SYM_BASETYPE, 0,			    NULL,		     NULL,		 NULL },
 	{ &bad_ctype,	    SYM_BASETYPE, 0,			    NULL,		     NULL,		 NULL },

