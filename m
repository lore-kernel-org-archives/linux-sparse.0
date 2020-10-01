Return-Path: <SRS0=XUoR=DI=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3DEC4727C
	for <linux-sparse@archiver.kernel.org>; Thu,  1 Oct 2020 09:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BCC62087D
	for <linux-sparse@archiver.kernel.org>; Thu,  1 Oct 2020 09:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbgJAJsn (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 1 Oct 2020 05:48:43 -0400
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:36338 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731067AbgJAJsn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Oct 2020 05:48:43 -0400
X-Greylist: delayed 1754 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Oct 2020 05:48:42 EDT
Received: from cpc98990-stkp12-2-0-cust216.10-2.cable.virginm.net ([86.26.12.217] helo=rainbowdash.codethink.co.uk)
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1kNukJ-0002op-As; Thu, 01 Oct 2020 10:19:27 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.94)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1kNukI-001YtY-IE; Thu, 01 Oct 2020 10:19:26 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-sparse@vger.kernel.org
Cc:     thomas.preston@codethink.co.uk, christopher.phang@codethink.co.uk,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 4/4] evaluate: check variadic argument types against formatting info
Date:   Thu,  1 Oct 2020 10:19:23 +0100
Message-Id: <20201001091923.372349-5-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001091923.372349-1-ben.dooks@codethink.co.uk>
References: <20201001091923.372349-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The variadic argumnet code did not check any of the variadic arguments
as it did not previously know the possible type. Now we have the possible
formatting information stored in the ctype, we can do some checks on the
printf formatting types.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
---
 Makefile        |   1 +
 builtin.c       |   2 +-
 evaluate.c      |  14 +-
 evaluate.h      |  10 +-
 verify-format.c | 496 ++++++++++++++++++++++++++++++++++++++++++++++++
 verify-format.h |   6 +
 6 files changed, 523 insertions(+), 6 deletions(-)
 create mode 100644 verify-format.c
 create mode 100644 verify-format.h

diff --git a/Makefile b/Makefile
index 09726ebb..457d9853 100644
--- a/Makefile
+++ b/Makefile
@@ -90,6 +90,7 @@ LIB_OBJS += target-xtensa.o
 LIB_OBJS += tokenize.o
 LIB_OBJS += unssa.o
 LIB_OBJS += utils.o
+LIB_OBJS += verify-format.o
 
 PROGRAMS :=
 PROGRAMS += compile
diff --git a/builtin.c b/builtin.c
index 26b612dc..ce9de28f 100644
--- a/builtin.c
+++ b/builtin.c
@@ -396,7 +396,7 @@ static int eval_sync_compare_and_swap(struct expression *expr)
 
 	if (!expr->ctype)	// __sync_val_compare_and_swap()
 		expr->ctype = ctype;
-	return evaluate_arguments(types, expr->args);
+	return evaluate_arguments(NULL, types, expr->args);
 
 err:
 	sparse_error(arg->pos, "invalid type for argument %d:", n);
diff --git a/evaluate.c b/evaluate.c
index c1ef348a..fb3c0adb 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -42,6 +42,7 @@
 #include "symbol.h"
 #include "target.h"
 #include "expression.h"
+#include "verify-format.h"
 
 struct symbol *current_fn;
 
@@ -1411,8 +1412,8 @@ static int whitelist_pointers(struct symbol *t1, struct symbol *t2)
 	return !Wtypesign;
 }
 
-static int check_assignment_types(struct symbol *target, struct expression **rp,
-	const char **typediff)
+int check_assignment_types(struct symbol *target, struct expression **rp,
+			   const char **typediff)
 {
 	struct symbol *source = degenerate(*rp);
 	struct symbol *t, *s;
@@ -2344,7 +2345,8 @@ static struct symbol *evaluate_alignof(struct expression *expr)
 	return size_t_ctype;
 }
 
-int evaluate_arguments(struct symbol_list *argtypes, struct expression_list *head)
+int evaluate_arguments(struct symbol *fn, struct symbol_list *argtypes,
+		       struct expression_list *head)
 {
 	struct expression *expr;
 	struct symbol *argtype;
@@ -2385,6 +2387,10 @@ int evaluate_arguments(struct symbol_list *argtypes, struct expression_list *hea
 		NEXT_PTR_LIST(argtype);
 	} END_FOR_EACH_PTR(expr);
 	FINISH_PTR_LIST(argtype);
+
+	if (fn && Wformat)
+		verify_format_attribute(fn, head);
+
 	return 1;
 }
 
@@ -3208,7 +3214,7 @@ static struct symbol *evaluate_call(struct expression *expr)
 		if (!sym->op->args(expr))
 			return NULL;
 	} else {
-		if (!evaluate_arguments(ctype->arguments, arglist))
+		if (!evaluate_arguments(ctype, ctype->arguments, arglist))
 			return NULL;
 		args = expression_list_size(expr->args);
 		fnargs = symbol_list_size(ctype->arguments);
diff --git a/evaluate.h b/evaluate.h
index a16e9703..3f51129d 100644
--- a/evaluate.h
+++ b/evaluate.h
@@ -28,8 +28,16 @@ void evaluate_symbol_list(struct symbol_list *list);
 
 ///
 // evaluate the arguments of a function
+// @fn: the symbol of the prototype
 // @argtypes: the list of the types in the prototype
 // @args: the list of the effective arguments
-int evaluate_arguments(struct symbol_list *argtypes, struct expression_list *args);
+int evaluate_arguments(struct symbol *fn, struct symbol_list *argtypes, struct expression_list *args);
 
+///
+// check if assignment types are compatible
+// @target: the target assignment
+// @rp: the expression
+// @typediff: the resulant message if different type
+int check_assignment_types(struct symbol *target, struct expression **rp,
+			   const char **typediff);
 #endif
diff --git a/verify-format.c b/verify-format.c
new file mode 100644
index 00000000..2da9d206
--- /dev/null
+++ b/verify-format.c
@@ -0,0 +1,496 @@
+/*
+ * sparse/verify-format.c
+ *
+ * Copyright (C) 2019 Codethink Ltd.
+ *	Written by Ben Dooks <ben.dooks@codethink.co.uk>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ *
+ * Verification code for format-attributes (currently printf)
+ */
+#include <stdlib.h>
+#include <stdarg.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <string.h>
+#include <ctype.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <limits.h>
+
+#include "evaluate.h"
+#include "lib.h"
+#include "allocate.h"
+#include "parse.h"
+#include "token.h"
+#include "symbol.h"
+#include "target.h"
+#include "expression.h"
+#include "verify-format.h"
+
+struct format_type {
+	const char	*format;
+	int		(*test)(struct format_type *fmt,
+				struct expression **expr,
+				struct symbol *ctype,
+				struct symbol **target,
+				const char **typediff);
+	struct symbol	*data;
+};
+
+struct format_state {
+	struct expression	*expr;
+	unsigned int		first;
+	unsigned int		fmt_index;
+	unsigned int		arg_index;
+	unsigned int		used_position: 1;
+};
+
+static int printf_fmt_numtype(struct format_type *fmt,
+			      struct expression **expr,
+			      struct symbol *ctype,
+			      struct symbol **target, const char **typediff)
+{
+	struct symbol *type = fmt->data;
+	*target = type;
+	return check_assignment_types(*target, expr, typediff);
+}
+
+static int printf_fmt_string(struct format_type *fmt,
+			     struct expression **expr,
+			     struct symbol *ctype,
+			     struct symbol **target, const char **typediff)
+{
+	*target = &const_string_ctype;
+	return check_assignment_types(*target, expr, typediff);
+}
+
+static int printf_fmt_pointer(struct format_type *fmt,
+			      struct expression **expr,
+			      struct symbol *ctype,
+			      struct symbol **target, const char **typediff)
+{
+	*target = &const_ptr_ctype;
+	return check_assignment_types(*target, expr, typediff);
+}
+
+static int printf_fmt_print_pointer(struct format_type *fmt,
+				    struct expression **expr,
+				    struct symbol *ctype,
+				    struct symbol **target,
+				    const char **typediff)
+{
+	// TODO TODO: fix this here!!!
+	int ret;
+	*target = &const_ptr_ctype;
+	ret = check_assignment_types(*target, expr, typediff);
+	if (ret == 0) {
+		/* if just printing, ignore address-space mismatches */
+		if (strcmp(*typediff, "different address spaces") == 0)
+			ret = 1;
+	}
+	return ret;
+}
+
+static struct format_type printf_fmt_ptr_ref = {
+	.format = "p",
+	.test = printf_fmt_pointer,
+};
+
+static struct expression *get_nth_expression(struct expression_list *args, int nr)
+{
+	return ptr_list_nth_entry((struct ptr_list *)args, nr);
+}
+
+static int is_float_spec(char t)
+{
+	return t == 'f' || t == 'g' || t == 'F' || t == 'G';
+}
+
+static struct format_type *parse_printf_get_fmt(struct format_type *type,
+						const char *msg, const char **msgout)
+{
+	const char *ptr = msg;
+	int szmod=0;
+
+	type->test = NULL;
+	*msgout = ptr;
+
+	if (*ptr == 's') {
+		ptr++;
+		type->test = printf_fmt_string;
+	} else if (*ptr == 'c') {
+		ptr++;
+		type->test = printf_fmt_numtype;
+		type->data = &char_ctype;
+	} else if (*ptr == 'p') {
+		ptr++;
+		type->test = printf_fmt_print_pointer;
+		/* check for pointer being printed as hex explicitly */
+		if (*ptr == 'x' || *ptr == 'X') {
+			ptr++;
+		} else if (isalpha(*ptr)) {
+			/* probably some extra specifiers after %p */
+			ptr++;
+			type->test = printf_fmt_pointer;
+		}
+	} else if (*ptr == 'z') {
+		// todo - we should construct pointer to int/etc //
+
+		ptr++;
+		if (*ptr == 'd' || *ptr == 'i') {
+			ptr++;
+			type->test = printf_fmt_numtype;
+			type->data = ssize_t_ctype;
+		} else if (*ptr == 'u' || *ptr == 'x' || *ptr == 'X' ||
+			   *ptr == 'o') {
+			ptr++;
+			type->test = printf_fmt_numtype;
+			type->data = size_t_ctype;
+		}
+	} else {
+		if (*ptr == 'l') {
+			szmod++;
+			ptr++;
+			if (*ptr == 'l') {
+				szmod++;
+				ptr++;
+			}
+		} else {
+			if (*ptr == 'h') { // short/char to int
+				szmod = -1;
+				ptr++;
+				if (*ptr == 'h')  // promotion from char
+					ptr++;
+			}
+			if (*ptr == 't') {  // ptrdiff_t
+				szmod = 2;
+				ptr++;
+			}
+			if (*ptr == 'j') { // intmax_t
+				// todo - replace iwth intmax_ctype when added
+				szmod = 1;
+				ptr++;
+			}
+		}
+
+		if (*ptr == 'x' || *ptr == 'X' || *ptr == 'u' || *ptr == 'o') {
+			ptr++;
+			type->test = printf_fmt_numtype;
+			switch (szmod) {
+			case -1:
+				type->data = &ushort_ctype;
+				break;
+			case 0:
+				type->data = &uint_ctype;
+				break;
+			case 1:
+				type->data = &ulong_ctype;
+				break;
+			case 2:
+				type->data = &ullong_ctype;
+				break;
+			default:
+				type->test = NULL;
+			}
+		} else if (*ptr == 'i' || *ptr == 'd') {
+			ptr++;
+			type->test = printf_fmt_numtype;
+			switch (szmod) {
+			case -1:
+				type->data = &short_ctype;
+				break;
+			case 0:
+				type->data = &int_ctype;
+				break;
+			case 1:
+				type->data = &long_ctype;
+				break;
+			case 2:
+				type->data = &llong_ctype;
+				break;
+			default:
+				type->test = NULL;
+			}
+		} else if (*ptr == 'L' && is_float_spec(ptr[1])) {
+			type->test = printf_fmt_numtype;
+			type->data = &ldouble_ctype;
+			ptr += 2;
+		} else if (is_float_spec(*ptr)) {
+			type->test = printf_fmt_numtype;
+			type->data = szmod == 1 ? &ldouble_ctype :  &double_ctype;
+			ptr++;
+		} else if (*ptr == 'n') {	/* pointer to an de-referenced int/etc */
+			// todo - we should construct pointer to int/etc //
+			// also should not have any flags or widths for this
+			type->test = printf_fmt_pointer;
+			ptr++;
+		} else {
+			// anything else here?
+		}
+	}
+
+	if (type->test == NULL)
+		return NULL;
+
+	*msgout = ptr;
+	return type;
+}
+
+static int is_printf_flag(char ch)
+{
+	return ch == '0' || ch == '+' || ch == '-' || ch == ' ' || ch == '#';
+}
+
+static int printf_check_position(const char **fmt)
+{
+	const char *ptr= *fmt;
+
+	if (!isdigit(*ptr))
+		return -1;
+	while (isdigit(*ptr))
+		ptr++;
+	if (*ptr == '$') {
+		const char *pos = *fmt;
+		*fmt = ptr+1;
+		return strtoul(pos, NULL, 10);
+	}
+	return -1;
+}
+
+static void parse_format_printf_checkpos(struct format_state *state, const char *which)
+{
+	if (state->used_position) {
+		warning(state->expr->pos,
+			"format %d: %s: no position specified",
+			state->arg_index-1, which);
+	}
+}
+
+static int parse_format_printf_argfield(const char **fmtptr,
+					struct format_state *state,
+					struct expression_list *args,
+					int *pos, const char *which)
+{
+	struct expression *expr;
+	struct symbol *ctype;
+	const char *fmt = *fmtptr;
+	int argpos = -1;
+
+	/* check for simple digit-string width/precision specifier first */
+	if (*fmt != '*') {
+		while (isdigit(*fmt))
+			fmt++;
+		*fmtptr = fmt;
+		return 0;
+	}
+
+	fmt++;
+	argpos = printf_check_position(&fmt);
+
+	if (argpos > 0) {
+		argpos += state->first - 1;
+		state->used_position = 1;
+	} else {
+		argpos = (*pos)++;
+		state->arg_index++;
+		parse_format_printf_checkpos(state, which);
+	}
+
+	*fmtptr = fmt;
+	expr = get_nth_expression(args, argpos-1);
+	if (!expr) {
+		warning(state->expr->pos, "%s: no argument at position %d", which, argpos);
+		return 1;
+	}
+
+	/* check the value we got was int/uint type */
+	ctype = expr->ctype;
+	if (ctype) {
+		struct symbol *target = &int_ctype;
+
+		if (ctype != &int_ctype && ctype != &uint_ctype) {
+			warning(expr->pos, "incorrect type for %s argument %d", which, argpos);
+			info(expr->pos, "   expected %s", show_typename(target));
+			info(expr->pos, "   got %s", show_typename(ctype));
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * printf format parsing code
+ *
+ * this code currently does not:
+ * - check castable types (such as int vs long vs long long)
+ * - validate all arguments specified are also used...
+ */
+static int parse_format_printf(const char **fmtstring,
+			       struct format_state *state,
+			       struct expression_list *args)
+{
+	struct format_type ftype;	/* temp storage for format info */
+	struct format_type *type;	/* type found from the parse */
+	struct expression *expr;
+	const char *fmt = *fmtstring;	/* pointer to parse position */
+	const char *fmtpost = NULL;	/* moved to end of the parsed format */
+	int pos = state->arg_index;	/* position of the argument */
+	int error = 0;
+	int ret;
+
+	if (!fmt) {
+		warning(state->expr->pos, "no format string passed");
+		return -1;
+	}
+
+	/* trivial check for %% */
+	fmt++;
+	if (fmt[0] == '%') {
+		*fmtstring = fmt+1;
+		return 0;
+	}
+
+	state->arg_index++;
+	state->fmt_index++;
+
+	ret = printf_check_position(&fmt);
+	if (ret == 0) {
+		/* we got an invalid position argument */
+		error++;
+	} else if (ret < 0) {
+		parse_format_printf_checkpos(state, "position");
+	} else {
+		state->used_position = 1;
+		pos = ret + state->first - 1;
+	}
+
+	/* get rid of any formatting flag bits */
+	while (is_printf_flag(*fmt))
+		fmt++;
+
+	/* now there is the posibility of a width specifier */
+	if (parse_format_printf_argfield(&fmt, state, args, &pos, "width"))
+		error++;
+
+	/* now we might have the precision specifier */
+	if (*fmt == '.') {
+		fmt++;
+		if (parse_format_printf_argfield(&fmt, state, args, &pos, "position"))
+			error++;
+	}
+
+	type = parse_printf_get_fmt(&ftype, fmt, &fmtpost);
+
+	if (!type && fmt[0] == 'p')
+		type = &printf_fmt_ptr_ref;	/* probably some extension */
+
+	if (type) {
+		struct symbol *ctype, *target = NULL;
+		const char *typediff = "different types";
+		int ret;
+
+		*fmtstring = fmtpost;
+		expr = get_nth_expression(args, pos-1);
+		if (!expr) {
+			/* no argument, but otherwise valid argument string */
+			warning(state->expr->pos, "no argument at position '%d'", pos);
+			return 0;
+		}
+
+		ctype = expr->ctype;
+		if (!ctype)
+			return -3;
+
+		ret = type->test(type, &expr, ctype, &target, &typediff);
+		if (!target)	/* shouldn't happen, but catch anyway */
+			return -4;
+
+		if (ret == 0) {
+			warning(expr->pos, "incorrect type in argument %d (%s)", pos, typediff);
+			info(expr->pos, "   expected %s", show_typename(target));
+			info(expr->pos, "   got %s", show_typename(ctype));
+		}
+	} else {
+		/* try and find the end of this format string by looking for a space*/
+		fmtpost = *fmtstring;
+		while (*fmtpost > ' ')
+			fmtpost++;
+		warning(state->expr->pos, "cannot evaluate type '%.*s'",
+			(int)(fmtpost - *fmtstring), *fmtstring);
+		*fmtstring += 1;
+		return -1;
+	}
+
+	return 1;
+}
+
+/*
+ * attempt to run through a printf format string and work out the types
+ * it specifies. The format is parsed from the __attribute__(format())
+ * in the parser code which stores the positions of the message and arg
+ * start in the ctype.
+ */
+void verify_format_attribute(struct symbol *fn, struct expression_list *args)
+{
+	struct format_state state = { };
+	struct expression *expr;
+	struct expression *init;
+	const char *fmt_string;
+
+	if (!fn->ctype.format.index)
+		return;
+
+	expr = get_nth_expression(args, fn->ctype.format.index-1);
+	if (!expr)
+		return;
+
+	if (expr->type != EXPR_SYMBOL || expr->symbol->ident)
+		return;			// not a literal
+	init = expr->symbol->initializer;
+	if (!init || init->type != EXPR_STRING)
+		return;			// not a string
+	fmt_string = init->string->data;
+
+	state.expr = expr;
+	state.first = fn->ctype.format.first;
+	state.arg_index = fn->ctype.format.first;
+
+	if (!fmt_string) {
+		warning(expr->pos, "not a format string?");
+	} else {
+		const char *string = fmt_string;
+		int fail = 0;
+
+		while (string[0]) {
+			if (string[0] != '%') {
+				/* strip anything before the '%' */
+				string++;
+				continue;
+			}
+
+			if (parse_format_printf(&string, &state, args) < 0)
+				fail++;
+		}
+
+		if (fail > 0)
+			/* format string may have '\n' etc embedded in it */
+			warning(expr->pos, "cannot evaluate format string");
+	}
+}
diff --git a/verify-format.h b/verify-format.h
new file mode 100644
index 00000000..4a7ef79d
--- /dev/null
+++ b/verify-format.h
@@ -0,0 +1,6 @@
+#ifndef VERIFY_FORMAT_H
+#define VERIFY_FORMAT_H
+
+void verify_format_attribute(struct symbol *fn, struct expression_list *args);
+
+#endif
-- 
2.28.0

