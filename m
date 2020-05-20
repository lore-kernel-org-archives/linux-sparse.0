From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [SPARSE PATCH] univ-init: conditionally accept { 0 } without
 warnings
Date: Wed, 20 May 2020 01:22:22 +0100
Message-ID: <2fcda487-733b-8ed1-e1f4-6c6204a68569@ramsayjones.plus.com>
References: <20200518235446.84256-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout02.plus.net ([212.159.14.17]:60393 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgETA36 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 19 May 2020 20:29:58 -0400
In-Reply-To: <20200518235446.84256-1-luc.vanoostenryck@gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>

Hi Luc,

Sorry for not getting back to you sooner on this (you would
think I was busy! ;-D ).

I have now found (one of) the patch(es) I was referring to before
(as a patch file on a memory stick - don't ask!).

On 19/05/2020 00:54, Luc Van Oostenryck wrote:
> In standard C '{ 0 }' is valid to initialize any compound object.
> OTOH, Sparse allows '{ }' for the same purpose but:
> 1) '{ }' is not standard
> 2) Sparse warns when using '0' to initialize pointers.
> 
> Some projects (git) legitimately like to be able to use the
> standard '{ 0 }' without the null-pointer warnings
> 
> So, add a new warning flag (-Wno-universal-initializer) to
> handle '{ 0 }' as '{ }', suppressing the warnings.

Hmm, I didn't think this would use a warning flag at all!

I remember the discussion (on lkml and sparse ml) in which
there was general agreement that '{}' would be preferred
solution (if only it was standard C!). However, I thought
that (since some compilers don't support it e.g. msvc) the
next best solution would be for sparse to suppress the
warning if given the '= { 0 }' token sequence. (ie. no mention
of it being conditional on a option).

> 
> Reference: https://lore.kernel.org/git/1df91aa4-dda5-64da-6ae3-5d65e50a55c5@ramsayjones.plus.com/
> Reference: https://lore.kernel.org/git/e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com/
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
> 
> Suggestions for a better name than this -W[no-]universal-initializer
> are warmly welcome.

Heh, you know that I am no good at naming things - but this may well
give the impression of a C++ like 'int i{}' type initializer!

> 
> -- Luc
> 
> 
>  lib.c                      |  2 ++
>  lib.h                      |  1 +
>  parse.c                    |  7 +++++++
>  sparse.1                   |  8 ++++++++
>  token.h                    |  7 +++++++
>  validation/Wuniv-init-ko.c | 14 ++++++++++++++
>  validation/Wuniv-init-ok.c | 11 +++++++++++
>  7 files changed, 50 insertions(+)
>  create mode 100644 validation/Wuniv-init-ko.c
>  create mode 100644 validation/Wuniv-init-ok.c
> 
> diff --git a/lib.c b/lib.c
> index f9ec285e8fea..9ee8d3cf6b21 100644
> --- a/lib.c
> +++ b/lib.c
> @@ -295,6 +295,7 @@ int Wtransparent_union = 0;
>  int Wtypesign = 0;
>  int Wundef = 0;
>  int Wuninitialized = 1;
> +int Wuniversal_initializer = 1;
>  int Wunknown_attribute = 0;
>  int Wvla = 1;
>  
> @@ -782,6 +783,7 @@ static const struct flag warnings[] = {
>  	{ "typesign", &Wtypesign },
>  	{ "undef", &Wundef },
>  	{ "uninitialized", &Wuninitialized },
> +	{ "universal-initializer", &Wuniversal_initializer },
>  	{ "unknown-attribute", &Wunknown_attribute },
>  	{ "vla", &Wvla },
>  };
> diff --git a/lib.h b/lib.h
> index b18295a889cb..5e6db111170a 100644
> --- a/lib.h
> +++ b/lib.h
> @@ -184,6 +184,7 @@ extern int Wtransparent_union;
>  extern int Wtypesign;
>  extern int Wundef;
>  extern int Wuninitialized;
> +extern int Wuniversal_initializer;
>  extern int Wunknown_attribute;
>  extern int Wvla;
>  
> diff --git a/parse.c b/parse.c
> index a29c67c8cf41..48494afc6f2c 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -2750,6 +2750,13 @@ static struct token *initializer_list(struct expression_list **list, struct toke
>  {
>  	struct expression *expr;
>  
> +	// '{ 0 }' is equivalent to '{ }' unless wanting all possible
> +	// warnings about using '0' to initialize a null-pointer.
> +	if (!Wuniversal_initializer) {
> +		if (match_token_zero(token) && match_op(token->next, '}'))
> +			token = token->next;
> +	}
> +

Ha! This made me LOL! (see my patch below).

So simple. (I did think, at first, that deleting the '0' token was
not a good idea - then I realized that it's more like skipping/ignoring
the token than deleting it.)

I wish I had thought of it.

I have similar code in 'initializer()', rather than 'initializer_list()',
but I don't think it makes a big difference (you have already 'passed'
the initial '{' token).

>  	for (;;) {
>  		token = single_initializer(&expr, token);
>  		if (!expr)
> diff --git a/sparse.1 b/sparse.1
> index 574caef3acbb..50e928392573 100644
> --- a/sparse.1
> +++ b/sparse.1
> @@ -428,6 +428,14 @@ However, this behavior can lead to subtle errors.
>  
>  Sparse does not issue these warnings by default.
>  .
> +.TP
> +.B \-Wuniversal\-initializer
> +Do not suppress warnings about 0 used to initialize a null-pointer
> +when using '{ 0 }' as initializer.
> +
> +Sparse issues these warnings by default.  To turn them off, use
> +\fB\-Wno\-universal\-initializer\fR.
> +.
>  .SH MISC OPTIONS
>  .TP
>  .B \-\-arch=\fIARCH\fR
> diff --git a/token.h b/token.h
> index 292db167e4a8..33a6eda1cc53 100644
> --- a/token.h
> +++ b/token.h
> @@ -241,4 +241,11 @@ static inline int match_ident(struct token *token, struct ident *id)
>  	return token->pos.type == TOKEN_IDENT && token->ident == id;
>  }
>  
> +static inline int match_token_zero(struct token *token)
> +{
> +	if (token_type(token) != TOKEN_NUMBER)
> +		return false;
> +	return token->number[0] == '0' && !token->number[1];
> +}
> +
>  #endif
> diff --git a/validation/Wuniv-init-ko.c b/validation/Wuniv-init-ko.c
> new file mode 100644
> index 000000000000..315c211a5db6
> --- /dev/null
> +++ b/validation/Wuniv-init-ko.c
> @@ -0,0 +1,14 @@
> +struct s {
> +	void *ptr;
> +};
> +
> +
> +static struct s s = { 0 };
> +
> +/*
> + * check-name: univ-init-ko
> + *
> + * check-error-start
> +Wuniv-init-ko.c:6:23: warning: Using plain integer as NULL pointer
> + * check-error-end
> + */
> diff --git a/validation/Wuniv-init-ok.c b/validation/Wuniv-init-ok.c
> new file mode 100644
> index 000000000000..c39647517323
> --- /dev/null
> +++ b/validation/Wuniv-init-ok.c
> @@ -0,0 +1,11 @@
> +struct s {
> +	void *ptr;
> +};
> +
> +
> +static struct s s = { 0 };
> +
> +/*
> + * check-name: univ-init-ok
> + * check-command: sparse -Wno-universal-initializer $file
> + */
> 

The patch below was (I think) my third attempt. If memory serves
me, the first patch attempted to determine the '{0}' initializer
from the 'struct expession *' passed to bad_null() alone. However,
that did not allow me to distinguish '= { 0 }' from '= { 0, }',
so I needed to backup from evaluation to the parse.

Also, I remember that I wasn't happy with the test cases - this code
(should) affect the initialization of arrays of pointers, but I have
not even written any tests, let alone tried them! :(

Also, I didn't test the initialization of embedded struct/array fields
(and what should happen anyway? should '{ 0 }' also work for initializing
the sub-structure(s), or should it only work at the top-level?).

Also, I have just noticed, it seems that I can't decide if it should
be called 'zero aggregate initializer' or 'aggregate zero initializer'! :-P

ATB,
Ramsay Jones

-- >8 --
Subject: [PATCH] bad_null: suppress 0/NULL pointer warnings with '{0}'

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 evaluate.c                       |  3 ++-
 expression.h                     |  1 +
 parse.c                          | 30 +++++++++++++++++++++++
 validation/aggregate_zero_init.c | 42 ++++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100755 validation/aggregate_zero_init.c

diff --git a/evaluate.c b/evaluate.c
index b7bb1f52..a95e157e 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -820,8 +820,9 @@ const char *type_difference(struct ctype *c1, struct ctype *c2,
 
 static void bad_null(struct expression *expr)
 {
-	if (Wnon_pointer_null)
+	if (Wnon_pointer_null && !expr->zero_init) {
 		warning(expr->pos, "Using plain integer as NULL pointer");
+	}
 }
 
 static unsigned long target_qualifiers(struct symbol *type)
diff --git a/expression.h b/expression.h
index 3b79e0f1..4bcfe0aa 100644
--- a/expression.h
+++ b/expression.h
@@ -150,6 +150,7 @@ struct asm_operand {
 struct expression {
 	enum expression_type type:8;
 	unsigned flags:8;
+	unsigned zero_init:1;
 	int op;
 	struct position pos;
 	struct symbol *ctype;
diff --git a/parse.c b/parse.c
index a29c67c8..44aea888 100644
--- a/parse.c
+++ b/parse.c
@@ -2762,12 +2762,42 @@ static struct token *initializer_list(struct expression_list **list, struct toke
 	return token;
 }
 
+static int is_zero_token(struct token *token)
+{
+	return token_type(token) == TOKEN_NUMBER && !strcmp(token->number, "0");
+}
+
+/*
+ * starting with token, do we have an '{ 0 }' zero aggregate initializer
+ * token sequence?
+*/
+static int is_zero_aggregate_init(struct token *token)
+{
+	if (token && match_op(token, '{') &&
+	    token->next && is_zero_token(token->next) &&
+	    token->next->next && match_op(token->next->next, '}'))
+		return 1;
+	return 0;
+}
+
+static void set_zero_init(struct expression_list *list)
+{
+	if (expression_list_size(list) == 1) {
+		struct expression *expr = first_expression(list);
+		if (expr)
+			expr->zero_init = 1;
+	}
+}
+
 struct token *initializer(struct expression **tree, struct token *token)
 {
 	if (match_op(token, '{')) {
 		struct expression *expr = alloc_expression(token->pos, EXPR_INITIALIZER);
+		int zero_init = is_zero_aggregate_init(token);
 		*tree = expr;
 		token = initializer_list(&expr->expr_list, token->next);
+		if (zero_init)
+			set_zero_init(expr->expr_list);
 		return expect(token, '}', "at end of initializer");
 	}
 	return assignment_expression(token, tree);
diff --git a/validation/aggregate_zero_init.c b/validation/aggregate_zero_init.c
new file mode 100755
index 00000000..805adbfa
--- /dev/null
+++ b/validation/aggregate_zero_init.c
@@ -0,0 +1,42 @@
+#define NULL ((void *)0)
+
+struct ptrfirst {
+	char *ptr;
+	int scalar;
+};
+
+struct scalarfirst {
+	int scalar;
+	char *ptr;
+};
+
+static struct ptrfirst s1;
+static struct scalarfirst s2;
+
+static struct ptrfirst si1 = { 0 };
+static struct scalarfirst si2 = { 0 };
+
+static struct ptrfirst si3 = { 0, 0 };
+static struct scalarfirst si4 = { 0, 0 };
+
+static struct ptrfirst si5 = { NULL, 0 };
+static struct scalarfirst si6 = { 0, NULL };
+
+static struct ptrfirst si7 = { 0, };
+static struct scalarfirst si8 = { 0, };
+
+static void func(void)
+{
+	struct ptrfirst a1 = { 0 };
+	struct scalarfirst a1 = { 0 };
+}
+/*
+ * check-name: zero aggregate initializer suppresses NULL pointer warnings
+ *
+ * check-error-start
+aggregate_zero_init.c:19:32: warning: Using plain integer as NULL pointer
+aggregate_zero_init.c:20:38: warning: Using plain integer as NULL pointer
+aggregate_zero_init.c:25:32: warning: Using plain integer as NULL pointer
+ * check-error-end
+ */
+
-- 
2.26.2
