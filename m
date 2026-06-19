Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D5840D58D
	for <linux-sparse@vger.kernel.org>; Fri, 19 Jun 2026 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781852745; cv=none; b=gAPA4k1eqlUfi6ogXzWvIj0+1jYqR6HgISG3oO7DRA63HGsQgLZJq7XhcbqbGe9UvuyDdfNw0wZbTFC6LNDf21wcl3sIovd42naxMzA5lIyN3bEimfi7K5UhW3SSkW58dAhUr7ngqUn8tzUi3EdoUi0+LiRNo0F6C82XvuCIkPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781852745; c=relaxed/simple;
	bh=YuI6hX64lbUs26dKqdIZC+RKp3RLtNdvvxoVLTpr0zI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fIP84TaHxyE5dRqXweJM7wFAWmu7Gpx2VNN6WY4nw5GnpXbIaIAVsF+n9gnco3AmGm97OEVjXCy9ABgSFr3x3qVgvL+/y9y1Jn/wkn73eV61GVlmiJpj8b+3rO40A/uDRDQ/EhOqbIH47D6bPYFEU9QGNk4+YE6D8UOXmRCnf70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=T8prGHXp; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="T8prGHXp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To; bh=9veOIcZsonZKgLOGJd3MUIe0ZnJLAYctdevUpOPRT6I=; b=T8prGHXpdxnznogo
	qN+LGtG2teerHCoQelTFII3R/VutVbywMv3BDTf+/kyJ513G1a7M4FcNHgVAkZSKeUy9Sv4shulZO
	GW645ixC6vcRNfLwUY4aWrBCDseRPEzzRG52DOEDAnueZG+O+QVWfay7RpZJelOfgJ8CuYJ84+kXh
	YxiXR3bSwn4VlfpktssG4NpD7TnKx0/2q/Z3zzYa0sxSNlYuuRDo/HiOSHyAhSjY6tmbAWGNm74MM
	AdXnWDcyLXVMdH4MA78twQDHGYBpVZSw+5f7yko1WkeSJICk6ngFlzfmRmBs2QXs+ozBBNFiPGjfw
	JFeehLsgKxDVL4vBrQ==;
Received: from [63.135.74.212] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1waTIE-00Ap9n-C6; Fri, 19 Jun 2026 08:05:34 +0100
Received: from ben by rainbowdash with local (Exim 4.99.4)
	(envelope-from <ben@rainbowdash>)
	id 1waTID-0000000033n-2ZaK;
	Fri, 19 Jun 2026 08:05:33 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-sparse@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [RFC v4 3/4] evaluate: check variadic argument types against formatting info
Date: Fri, 19 Jun 2026 08:05:31 +0100
Message-Id: <20260619070532.11664-4-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
In-Reply-To: <20260619070532.11664-1-ben.dooks@codethink.co.uk>
References: <20260619070532.11664-1-ben.dooks@codethink.co.uk>
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
V3:
  - fixed issue with kernel testing
  - fixed logic error in one check
V4:
  - rewritten to deal with scanf
  - made some of the format code common and tried to simplify
  - fixed bugs found with checking linux-kernel#

Note, this is quite a re-write from the original so probably will
need re-reviewing
---
 Makefile        |   1 +
 builtin.c       |   4 +-
 evaluate.c      |  14 +-
 evaluate.h      |  10 +-
 verify-format.c | 571 ++++++++++++++++++++++++++++++++++++++++++++++++
 verify-format.h |   6 +
 6 files changed, 599 insertions(+), 7 deletions(-)
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
index a704c5e8..80e9fa39 100644
--- a/builtin.c
+++ b/builtin.c
@@ -439,7 +439,7 @@ static int evaluate_generic_int_op(struct expression *expr)
 		NEXT_PTR_LIST(t);
 	} END_FOR_EACH_PTR(arg);
 	FINISH_PTR_LIST(t);
-	return evaluate_arguments(types, expr->args);
+	return evaluate_arguments(NULL, types, expr->args);
 
 err:
 	sparse_error(arg->pos, "non-integer type for argument %d:", n);
@@ -503,7 +503,7 @@ static int eval_atomic_common(struct expression *expr)
 
 	if (!expr->ctype)	// set the return type, if needed
 		expr->ctype = ctype;
-	return evaluate_arguments(types, expr->args);
+	return evaluate_arguments(NULL, types, expr->args);
 
 err:
 	sparse_error(arg->pos, "invalid type for argument %d:", n);
diff --git a/evaluate.c b/evaluate.c
index 85a6447b..4303bae1 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -42,6 +42,7 @@
 #include "symbol.h"
 #include "target.h"
 #include "expression.h"
+#include "verify-format.h"
 
 struct symbol *current_fn;
 
@@ -1387,8 +1388,8 @@ static int whitelist_pointers(struct symbol *t1, struct symbol *t2)
 	return !Wtypesign;
 }
 
-static int check_assignment_types(struct symbol *target, struct expression **rp,
-	const char **typediff)
+int check_assignment_types(struct symbol *target, struct expression **rp,
+			   const char **typediff)
 {
 	struct symbol *source = degenerate(*rp);
 	struct symbol *t, *s;
@@ -2325,7 +2326,8 @@ static struct symbol *evaluate_alignof(struct expression *expr)
 	return size_t_ctype;
 }
 
-int evaluate_arguments(struct symbol_list *argtypes, struct expression_list *head)
+int evaluate_arguments(struct symbol *fn, struct symbol_list *argtypes,
+		       struct expression_list *head)
 {
 	struct expression *expr;
 	struct symbol *argtype;
@@ -2366,6 +2368,10 @@ int evaluate_arguments(struct symbol_list *argtypes, struct expression_list *hea
 		NEXT_PTR_LIST(argtype);
 	} END_FOR_EACH_PTR(expr);
 	FINISH_PTR_LIST(argtype);
+
+	if (fn && Wformat)
+		verify_format_attribute(fn, head);
+
 	return 1;
 }
 
@@ -3192,7 +3198,7 @@ static struct symbol *evaluate_call(struct expression *expr)
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
index 00000000..02238dd0
--- /dev/null
+++ b/verify-format.c
@@ -0,0 +1,571 @@
+/*
+ * sparse/verify-format.c
+ *
+ * Copyright (C) 2019,2026 Codethink Ltd.
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
+ * Verification code for format-attributes (printf, scanf)
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
+	struct symbol	*data;
+
+	/* if ptr_deref and it is a pointer type, we do care about
+	 * any address space differences, otherwise just ignore
+	 */
+	bool ptr_deref;
+};
+
+struct format_state {
+	struct expression	*fmt_expr;
+	struct expression	*pos_expr;
+	struct format_type	ftype;
+	struct attr_format_ext_type *ext_types;
+	unsigned int		first;
+	unsigned int		position;
+	unsigned int		arg_index;
+	unsigned int		used_position: 1;
+};
+
+static struct expression *get_nth_expression(struct expression_list *args, int nr)
+{
+	return ptr_list_nth_entry((struct ptr_list *)args, nr);
+}
+
+/* parser for general scanf/printf format bits
+ *
+ * note, only roughly in order of the initial letters
+ */
+static int parse_general_fmt(struct format_type *type,
+			     bool is_scanf,
+			     const char *msg,
+			     const char **msgout)
+{
+	const char *ptr = msg;
+	int szmod = 0;
+
+	type->ptr_deref = false;
+	*msgout = ptr;
+
+retry:
+	switch (*ptr++) {
+	case 'c':
+		type->data = &char_ctype;
+		break;
+	case 'i':
+	case 'd':
+		switch (szmod) {
+		case -2:
+			type->data = &char_ctype;
+			break;
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
+		break;
+	case 'f':
+	case 'F':
+	case 'g':
+	case 'G':
+		type->data = szmod == 1 ? &ldouble_ctype :  &double_ctype;
+		break;
+	case 'h':
+		szmod = -1;
+		if (*ptr == 'h')  { // promotion from char
+			szmod = -2;
+			ptr++;
+		}
+		goto retry;
+	case 'L':
+		szmod = 1;
+		goto retry;
+	case 'l':
+		szmod++;
+		goto retry;
+	case 't':
+		szmod = 2;
+		goto retry;
+	case 'j':
+		szmod = 3;
+		goto retry;
+	case 'p':
+		/* check for pointer being printed as hex explicitly */
+
+		type->data = is_scanf ? &ptr_ctype :  &const_ptr_ctype;
+		if (*ptr == 'x' || *ptr == 'X') {
+			ptr++;
+		} else if (isalpha(*ptr)) {
+			/* probably some extra specifiers after %p or some
+			 * linux kernel extension */
+			type->ptr_deref = true;
+			ptr++;
+		}
+		break;
+	case 's':
+		/* note, %ls is wchar, not char and does this work with sscanf? */
+		type->data = is_scanf ? &string_ctype : &const_string_ctype;
+		type->ptr_deref = true;
+		break;
+	case 'n':
+		/* pointer to an interger to write count into */
+		type->data = is_scanf ? &int_ctype : intptr_ctype;
+		type->ptr_deref = true;
+		break;
+	case 'x':
+	case 'X':
+	case 'u':
+	case 'o':
+		switch (szmod) {
+		case -2:
+			type->data = &uchar_ctype;
+			break;
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
+	case 'z':
+		if (*ptr == 'd' || *ptr == 'i') {
+			ptr++;
+			type->data = ssize_t_ctype;
+		} else if (*ptr == 'u' || *ptr == 'x' || *ptr == 'X' ||
+			   *ptr == 'o') {
+			ptr++;
+			type->data = size_t_ctype;
+		}
+		break;
+	default:
+		return 0;
+	}
+
+	*msgout = ptr;
+	return 1;
+}
+
+// msgout is end of parsed format msg
+static int parse_printf_get_fmt(struct format_type *type,
+				const char *msg,
+				const char **msgout)
+{
+	int ret = parse_general_fmt(type, false, msg, msgout);
+	const char *ptr = msg;
+
+	if (ret > 0)
+		return ret;
+
+	// %w is a special case for printf.
+
+	*msgout = ptr;
+	return ret;
+}
+
+static int is_printf_flag(char ch)
+{
+	return ch == '0' || ch == '+' || ch == '-' || ch == ' ' || ch == '#';
+}
+
+static int printf_parse_position(const char **fmt)
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
+		warning(state->fmt_expr->pos,
+			"format %d: %s: explicit position needed",
+			state->arg_index, which);
+	}
+}
+
+static int parse_format_printf_argfield(const char **fmtptr,
+					struct format_state *state,
+					struct expression_list *args,
+					const char *which)
+{
+	struct expression *expr;
+	const char *fmt = *fmtptr;
+	const char *typediff;
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
+	argpos = printf_parse_position(&fmt);
+
+	if (argpos > 0) {
+		argpos += state->first - 1;
+		state->used_position = 1;
+	} else {
+		argpos = state->arg_index++;
+		parse_format_printf_checkpos(state, which);
+	}
+
+	*fmtptr = fmt;
+	expr = get_nth_expression(args, argpos-1);
+	if (!expr) {
+		warning(state->fmt_expr->pos, "%s: no argument at position %d",
+			which, argpos);
+		return 1;
+	}
+
+	/* check the value we got was int/uint type */
+
+	if (check_assignment_types(&int_ctype, &expr, &typediff) == 0) {
+		warning(expr->pos, "incorrect type for %s argument %d", which, argpos);
+		info(expr->pos, "   expected %s", show_typename(&int_ctype));
+		info(expr->pos, "   got %s", show_typename(expr->ctype));
+	}
+
+	return 0;
+}
+
+static int parse_scanf_get_fmt(struct format_type *type,
+			       const char *msg,
+			       const char **msgout)
+{
+	int ret = parse_general_fmt(type, true, msg, msgout);
+	static struct symbol scanf_type;
+
+	/* if the general format found something, then we probably need
+	 * to change it to being a pointer to the type we found.
+	 */
+	if (ret > 0) {
+		if (type->data != &string_ctype) {
+			scanf_type.ctype.base_type = type->data;
+			scanf_type.type = SYM_PTR;
+			type->data = &scanf_type;
+		}
+	
+		return ret;
+	}
+
+	// todo - check for anything scanf specific here
+	return ret;
+}
+
+static const char *parse_scanf_skip_modifiers(const char *ptr)
+{
+	while (*ptr == 'm' || *ptr == '\'' || isdigit(*ptr))
+		ptr++;
+	return ptr;
+}
+
+static int parse_format_scanf(const char **fmtstring,
+			      struct format_state *state,
+			      struct expression_list *args)
+{
+	struct format_type *ftype = &state->ftype;
+	struct expression *expr;
+	const char *fmt = *fmtstring;	/* pointer to parse position */
+	const char *fmtpost = NULL;	/* moved to end of the parsed format */
+	int pos = state->arg_index;	/* position of the argument */
+	int ret;
+
+	/* trivial check for %% */
+	fmt++;
+	if (fmt[0] == '%') {
+		*fmtstring = fmt+1;
+		return 0;
+	}
+
+	/* this is discarded input, so just ignore */
+	if (fmt[0] == '*') {
+		*fmtstring = fmt+1;
+		return 0;
+	}
+
+	pos = printf_parse_position(&fmt);
+	if (pos > 0) {
+		state->used_position = 1;
+		pos += state->first - 1;
+	} else {
+		parse_format_printf_checkpos(state, "position");
+		pos = state->arg_index++;
+	}
+	state->position = pos;
+
+	fmt = parse_scanf_skip_modifiers(fmt);
+	*fmtstring = fmt;
+
+	ret = parse_scanf_get_fmt(ftype, fmt, &fmtpost);
+	if (!ret) {
+		/* assume it's a single character we just don't know about
+		 * such as a linux-kernel extended format.
+		 */
+		fmtpost = *fmtstring + 2;
+		warning(state->fmt_expr->pos, "cannot evaluate type '%.*s'",
+			(int)(fmtpost - *fmtstring), *fmtstring);
+		*fmtstring += 1;
+		return -1;
+	}
+
+	*fmtstring = fmtpost;
+	expr = get_nth_expression(args, pos-1);
+	if (!expr) {
+		/* no argument, but otherwise valid argument string */
+		warning(state->fmt_expr->pos, "no argument at position '%d'", pos);
+		return 0;
+	}
+
+	state->pos_expr = expr;
+	return 1;
+}
+
+/*
+ * printf format parsing code
+ *
+ * this code currently does not:
+ * - check castable types (such as int vs long vs long long)
+ * - validate all arguments specified are also used...
+ *
+ * positional arguments make this more difficult as they get consumed first if
+ * no explicit position is used. If the position is explicilty stated then that
+ * is the first int$ argument and the width and precision fields must also be
+ * explicity defined.
+ */
+static int parse_format_printf(const char **fmtstring,
+			       struct format_state *state,
+			       struct expression_list *args)
+{
+	struct format_type *ftype = &state->ftype;
+	struct expression *expr;
+	const char *fmt = *fmtstring;	/* pointer to parse position */
+	const char *fmtpost = NULL;	/* moved to end of the parsed format */
+	int pos;			/* position of the argument */
+	int ret;
+
+	/* trivial check for %% */
+	fmt++;
+	if (fmt[0] == '%') {
+		*fmtstring = fmt+1;
+		return 0;
+	}
+
+	/* if there's an explicit position, then work out where it is and
+	 * mark it as this will go before the width/precision.
+	 */
+	pos = printf_parse_position(&fmt);
+	if (pos > 0) {
+		state->used_position = 1;
+		pos += state->first - 1;
+	}
+
+	/* get rid of any formatting flag bits */
+	while (is_printf_flag(*fmt))
+		fmt++;
+
+	/* now there is the posibility of a width specifier */
+	if (parse_format_printf_argfield(&fmt, state, args, "width"))
+		return -1;
+
+	/* now we might have the precision specifier */
+	if (*fmt == '.') {
+		fmt++;
+		if (parse_format_printf_argfield(&fmt, state, args, "precision"))
+			return -1;
+	}
+
+	if (pos < 0) {
+		parse_format_printf_checkpos(state, "position");
+		pos = state->arg_index++;
+	}
+	state->position = pos;
+
+	ret = parse_printf_get_fmt(ftype, fmt, &fmtpost);
+	if (!ret) {
+		/* assume it's a single character we just don't know about
+		 * such as a linux-kernel extended format.
+		 */
+		fmtpost = *fmtstring + 2;
+		warning(state->fmt_expr->pos, "cannot evaluate type '%.*s'",
+			(int)(fmtpost - *fmtstring), *fmtstring);
+		*fmtstring += 1;
+		return -1;
+	}
+
+	*fmtstring = fmtpost;
+	expr = get_nth_expression(args, pos-1);
+	if (!expr) {
+		/* no argument, but otherwise valid argument string */
+		warning(state->fmt_expr->pos, "no argument at position '%d'", pos);
+		return 0;
+	}
+
+	state->pos_expr = expr;
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
+	int ret, fail = 0;
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
+
+	init = expr->symbol->initializer;
+	if (!init || init->type != EXPR_STRING) {
+		warning(expr->pos, "not a format string");
+		return;			// not a string
+	}
+	fmt_string = init->string->data;
+
+	state.fmt_expr = expr;
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
+		const char *typediff = "different types";
+
+		if (string[0] != '%') {
+			/* strip anything before the '%' */
+			string++;
+			continue;
+		}
+
+		switch (fn->ctype.format.type) {
+		case FMT_PRINTF:
+			ret = parse_format_printf(&string, &state, args);
+			break;
+		case FMT_SCANF:
+			ret = parse_format_scanf(&string, &state, args);
+			break;
+		default:
+			warning(expr->pos, "not printf or scanf format");
+			string++;
+			ret = -1;
+		}
+
+		if (ret < 0) {
+			fail++;
+			continue;
+		} else if (ret == 0)
+			continue;
+
+		if (!state.ftype.data) {
+			warning(expr->pos, "got here with no type data");
+			continue;
+		}
+
+		ret = check_assignment_types(state.ftype.data, &state.pos_expr, &typediff);
+		if (ret == 0 && !state.ftype.ptr_deref) {
+			/* if just printing, ignore address-space mismatches */
+
+			if (strcmp(typediff, "different address spaces") == 0)
+				ret = 1;
+		}
+
+		if (ret == 0) {
+			warning(expr->pos, "incorrect type in argument %d (%s)", state.position, typediff);
+			info(expr->pos, "   expected %s", show_typename(state.ftype.data));
+			info(expr->pos, "   got %s", show_typename(state.pos_expr->ctype));
+		}
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

