Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9C578F4F
	for <linux-sparse@vger.kernel.org>; Mon, 22 Dec 2025 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766421586; cv=none; b=puiaAtkb0esuqkAr2+YK5y6aUNhg5r2Fr1KEZijaNrS1NqjSVLkdccVCYbsnAW0aJFLrN4s+lZt/Uaa1SCAtxqHCoJnKLyBZtfoeYzH8R/mISfUbbej9297dlEVgTxXjHTCafZDKppaWfAfw+IjagzSBOq9f9u23UqJInOWyw+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766421586; c=relaxed/simple;
	bh=qPjOEgD3V+miFi4CHHOOORM2knuSiiDu1eAItvtqyhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KkvoL494NFRfmN91uW0czZcjztD+JNvbAd+qYQ0Gw/7uAfBaIAsI+pUoCoFonfiJFM8r3TVhGTuuPOE5lD05FiURoDLcTrwnjm5fpoLG6ibxMrK2LhaWYSZIID8A+9zQQd7EouduXWfwyhVhjmGreVP7vW3QlceHvVI9Iy9tdRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=1SzveTfq; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="1SzveTfq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To; bh=2vDoBcZajDRqHSddxROQITpSka8dPktBtzjRVFK9jC0=; b=1SzveTfq40zo/hsd
	39rdC0B+EoyKorg8+ZskiCnz5g8ckW+cweEQjGhxdGjJ4ineO/FTjMU2EeJCoQ6J+sYNT8RgBUEVW
	EZpVnntiRVLJugKt7x4N4XnTzqbEu6bTy3vauSxm6P45FlJTVdU8LH+KLmkJict3W7xJlkEF4DoOD
	ulQxdbEJ7rsTS+u5xZt0pAWn626g33pDfYere9CqpCsx7YhAz/ot21rd1hSX7zFC5GOffiayMN7NI
	QaQGYa8FBlxleKAmFn2BQdnXiElbh2XQvNf9n/BAgknXghYJhIJHSMZBFanAS6swmM3Wv1YYh5MCc
	gKUFKxWNgsLfPVuJNg==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vXiKp-004DSr-I9; Mon, 22 Dec 2025 16:00:35 +0000
Received: from ben by rainbowdash with local (Exim 4.99)
	(envelope-from <ben@rainbowdash>)
	id 1vXiKp-00000000P2f-12OG;
	Mon, 22 Dec 2025 16:00:35 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-sparse@vger.kernel.org,
	sparse@chrisli.org
Cc: luc.vanoostenryck@gmail.com,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH v2 3/4] evaluate: check variadic argument types against formatting info
Date: Mon, 22 Dec 2025 16:00:33 +0000
Message-Id: <20251222160034.96188-4-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
In-Reply-To: <20251222160034.96188-1-ben.dooks@codethink.co.uk>
References: <20251222160034.96188-1-ben.dooks@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

The variadic argumebt code did not check any of the variadic arguments
as it did not previously know the possible type. Now we have the possible
formatting information stored in the ctype, we can do some checks on the
printf formatting types.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
V2:
  - try and reduce size/if nesting of parse_printf_get_fmt()
  - change return for parse_format_printf() and try and simplify
  - reworked the test code to reduce numner of test functions
  - bailed out early if verification isn't ok
---
 Makefile        |   1 +
 builtin.c       |   4 +-
 evaluate.c      |  14 +-
 evaluate.h      |  10 +-
 verify-format.c | 460 ++++++++++++++++++++++++++++++++++++++++++++++++
 verify-format.h |   6 +
 6 files changed, 488 insertions(+), 7 deletions(-)
 create mode 100644 verify-format.c
 create mode 100644 verify-format.h

diff --git a/Makefile b/Makefile
index e172758b..670e95aa 100644
--- a/Makefile
+++ b/Makefile
@@ -90,6 +90,7 @@ LIB_OBJS += tokenize.o
 LIB_OBJS += unssa.o
 LIB_OBJS += utils.o
 LIB_OBJS += version.o
+LIB_OBJS += verify-format.o
 
 PROGRAMS :=
 PROGRAMS += compile
diff --git a/builtin.c b/builtin.c
index 3a29c3ae..e4751445 100644
--- a/builtin.c
+++ b/builtin.c
@@ -438,7 +438,7 @@ static int evaluate_generic_int_op(struct expression *expr)
 		NEXT_PTR_LIST(t);
 	} END_FOR_EACH_PTR(arg);
 	FINISH_PTR_LIST(t);
-	return evaluate_arguments(types, expr->args);
+	return evaluate_arguments(NULL, types, expr->args);
 
 err:
 	sparse_error(arg->pos, "non-integer type for argument %d:", n);
@@ -502,7 +502,7 @@ static int eval_atomic_common(struct expression *expr)
 
 	if (!expr->ctype)	// set the return type, if needed
 		expr->ctype = ctype;
-	return evaluate_arguments(types, expr->args);
+	return evaluate_arguments(NULL, types, expr->args);
 
 err:
 	sparse_error(arg->pos, "invalid type for argument %d:", n);
diff --git a/evaluate.c b/evaluate.c
index fe716f63..4ffbba73 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -42,6 +42,7 @@
 #include "symbol.h"
 #include "target.h"
 #include "expression.h"
+#include "verify-format.h"
 
 struct symbol *current_fn;
 
@@ -1386,8 +1387,8 @@ static int whitelist_pointers(struct symbol *t1, struct symbol *t2)
 	return !Wtypesign;
 }
 
-static int check_assignment_types(struct symbol *target, struct expression **rp,
-	const char **typediff)
+int check_assignment_types(struct symbol *target, struct expression **rp,
+			   const char **typediff)
 {
 	struct symbol *source = degenerate(*rp);
 	struct symbol *t, *s;
@@ -2324,7 +2325,8 @@ static struct symbol *evaluate_alignof(struct expression *expr)
 	return size_t_ctype;
 }
 
-int evaluate_arguments(struct symbol_list *argtypes, struct expression_list *head)
+int evaluate_arguments(struct symbol *fn, struct symbol_list *argtypes,
+		       struct expression_list *head)
 {
 	struct expression *expr;
 	struct symbol *argtype;
@@ -2365,6 +2367,10 @@ int evaluate_arguments(struct symbol_list *argtypes, struct expression_list *hea
 		NEXT_PTR_LIST(argtype);
 	} END_FOR_EACH_PTR(expr);
 	FINISH_PTR_LIST(argtype);
+
+	if (fn && Wformat)
+		verify_format_attribute(fn, head);
+
 	return 1;
 }
 
@@ -3191,7 +3197,7 @@ static struct symbol *evaluate_call(struct expression *expr)
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
index 00000000..3e343d96
--- /dev/null
+++ b/verify-format.c
@@ -0,0 +1,460 @@
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
+static int printf_fmt_type(struct format_type *fmt,
+			   struct expression **expr,
+			   struct symbol *ctype,
+			   struct symbol **target, const char **typediff)
+{
+	struct symbol *type = fmt->data;
+	*target = type;
+	return check_assignment_types(*target, expr, typediff);
+}
+
+static int printf_fmt_print_pointer(struct format_type *fmt,
+				    struct expression **expr,
+				    struct symbol *ctype,
+				    struct symbol **target,
+				    const char **typediff)
+{
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
+static struct expression *get_nth_expression(struct expression_list *args, int nr)
+{
+	return ptr_list_nth_entry((struct ptr_list *)args, nr);
+}
+
+static struct format_type *parse_printf_get_fmt(struct format_type *type,
+						const char *msg,
+						const char **msgout)
+{
+	const char *ptr = msg;
+	int szmod = 0;
+
+	type->test = NULL;
+	*msgout = ptr;
+
+retry:
+	switch (*ptr++) {
+	case 's':
+		type->test = printf_fmt_type;
+		type->data = &const_string_ctype;
+		break;
+	case 'c':
+		type->test = printf_fmt_type;
+		type->data = &char_ctype;
+		break;
+	case 'p':
+		type->test = printf_fmt_print_pointer;
+		/* check for pointer being printed as hex explicitly */
+		if (*ptr == 'x' || *ptr == 'X') {
+			ptr++;
+		} else if (isalpha(*ptr)) {
+			/* probably some extra specifiers after %p or some
+			 * linux kernel extension */
+			ptr++;
+			type->data = &const_ptr_ctype;
+			type->test = printf_fmt_type;
+		}
+		break;
+	case 'z':
+		if (*ptr == 'd' || *ptr == 'i') {
+			ptr++;
+			type->test = printf_fmt_type;
+			type->data = ssize_t_ctype;
+		} else if (*ptr == 'u' || *ptr == 'x' || *ptr == 'X' ||
+			   *ptr == 'o') {
+			ptr++;
+			type->test = printf_fmt_type;
+			type->data = size_t_ctype;
+		}
+		break;
+
+	case 'n':
+		/* pointer to an interger to write count into */
+		type->data = intptr_ctype;
+		type->test = printf_fmt_type;
+		break;
+	case 'l':
+		szmod++;
+		goto retry;
+
+	case 'h':
+		szmod = -1;
+		if (*ptr == 'h')  // promotion from char
+			ptr++;
+		goto retry;
+	case 't':
+		szmod = 2;
+		goto retry;
+
+	case 'j':
+		szmod = 3;
+		goto retry;
+	case 'x':
+	case 'X':
+	case 'u':
+	case 'o':
+		type->test = printf_fmt_type;
+		switch (szmod) {
+		case -1:
+			type->data = &ushort_ctype;
+			break;
+		case 0:
+			type->data = &uint_ctype;
+			break;
+		case 1:
+			type->data = &ulong_ctype;
+			break;
+		case 2:
+			type->data = &ullong_ctype;
+			break;
+		case 3:
+			type->data = uintmax_ctype;
+			break;
+		}
+		break;
+	case 'i':
+	case 'd':
+		type->test = printf_fmt_type;
+		switch (szmod) {
+		case -1:
+			type->data = &short_ctype;
+			break;
+		case 0:
+			type->data = &int_ctype;
+			break;
+		case 1:
+			type->data = &long_ctype;
+			break;
+		case 2:
+			type->data = &llong_ctype;
+			break;
+		case 3:
+			type->data = intmax_ctype;
+			break;
+		}
+	case 'L':
+		szmod = 1;
+		goto retry;
+	case 'f':
+	case 'F':
+	case 'g':
+	case 'G':
+		type->test = printf_fmt_type;
+		type->data = szmod == 1 ? &ldouble_ctype :  &double_ctype;
+		break;
+
+	default:
+		return NULL;
+	}
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
+static void parse_format_printf_checkpos(struct format_state *state,
+					 const char *which)
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
+		warning(state->expr->pos, "%s: no argument at position %d",
+			which, argpos);
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
+	struct symbol *ctype, *target = NULL;
+	const char *typediff = "different types";
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
+	if (!type) {
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
+	*fmtstring = fmtpost;
+	expr = get_nth_expression(args, pos-1);
+	if (!expr) {
+		/* no argument, but otherwise valid argument string */
+		warning(state->expr->pos, "no argument at position '%d'", pos);
+		return 0;
+	}
+
+	ctype = expr->ctype;
+	if (!ctype)
+		return -1;
+
+	ret = type->test(type, &expr, ctype, &target, &typediff);
+	if (!target)	/* shouldn't happen, but catch anyway */
+		return -1;
+	if (!ret)
+		return 0;
+
+	warning(expr->pos, "incorrect type in argument %d (%s)", pos, typediff);
+	info(expr->pos, "   expected %s", show_typename(target));
+	info(expr->pos, "   got %s", show_typename(ctype));
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
+	const char *string, *fmt_string;
+	int fail = 0;
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
+		return;
+	}
+
+	string = fmt_string;
+	while (string[0]) {
+		if (string[0] != '%') {
+			/* strip anything before the '%' */
+			string++;
+			continue;
+		}
+
+		if (parse_format_printf(&string, &state, args) < 0)
+			fail++;
+	}
+
+	if (fail > 0)
+		/* format string may have '\n' etc embedded in it */
+		warning(expr->pos, "cannot evaluate format string");
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
2.37.2.352.g3c44437643

