Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DADDC43461
	for <linux-sparse@archiver.kernel.org>; Mon, 12 Apr 2021 21:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19CBA6135C
	for <linux-sparse@archiver.kernel.org>; Mon, 12 Apr 2021 21:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238773AbhDLVVo (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241461AbhDLVVn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Apr 2021 17:21:43 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27D1C06175F
        for <linux-sparse@vger.kernel.org>; Mon, 12 Apr 2021 14:21:24 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w23so16788461edx.7
        for <linux-sparse@vger.kernel.org>; Mon, 12 Apr 2021 14:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=taQt/yFMvKqZ4LVHJAl/i1/n6B7Qei3ktjv6VoJda4U=;
        b=vDVohqS6Wx82l1k/Mz2gDf9KKdf9uQzlcRYCwEKivRFiDpxbsjagQ1QyyRseXBU6C8
         qNU6BK0YO6CS605RiwbIvfJ/A1vWXm2DMKII6K0S7TMqzByIQXuli5FcQTAZKunCTNsO
         WF7PpHpk7aKc1waqz4dngdAQTL2wEu2jMWA4yqEsAyGvAtCO641SaCGzsX87D2zlKiGu
         qKeb5mGSOr5VeegVn/HLxZIHfWt2/cVcofD76i0Zdgtwd7eQ342pIC6H3gaiBM0qv0JM
         t2EcQPu6TwhsI545DqSjo3lNiqLjCKPfqRCpFJNCDDJCrbcUY1uftl6IHEve6guxNF+N
         Vmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=taQt/yFMvKqZ4LVHJAl/i1/n6B7Qei3ktjv6VoJda4U=;
        b=reqmikApNWw0KHjB0yaDjeorJnhjXhvLDFy+ns0dD+U7fX2WJy7+nyaiypNI6k0ToK
         DjcMsfNa4AnHlucLVeh8jndJ4yLjzfPnIFQkOOE1BFlVluGUMifkraKDdkrC/G4GlsXn
         8cdaGBD7sLttguEmJ7/pp8KkyTNGCKG/ylFaQJz4BULhi7vuCt0AjpoL6cD2jUgewhOH
         7lJ3VesUhUts6/AbkuTBwwTnwM1i6n2n8iZxrwhZ/Czmne4oyM+LpRFJpBpJ5YNByOut
         xtYK5TTLnt9yDr4rLUu3tXxJ+IdNAvd8hGs/8dn7OyyxzI8TYs8fBRZp43Hi5Y20pGGF
         G90A==
X-Gm-Message-State: AOAM5335R25DV1m/3JpP/5X2DShCjvnMPCIZWCV9mAx6PkvUrxSjlsEz
        cCenoBnOAVNJbwN/BK+FY/9XaSGq5Ww=
X-Google-Smtp-Source: ABdhPJwzK5IfXWgix58RDOvUlX3UNjc7VhSvLvR06auWXcTYZuMxyEf7QEFk+E8KiGYV0+Zhq3Q22w==
X-Received: by 2002:a05:6402:22a6:: with SMTP id cx6mr31156552edb.55.1618262483538;
        Mon, 12 Apr 2021 14:21:23 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:6903:692b:54da:df0c])
        by smtp.gmail.com with ESMTPSA id g11sm7744156edt.35.2021.04.12.14.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:21:23 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 4/8] scheck: add a symbolic checker
Date:   Mon, 12 Apr 2021 23:21:07 +0200
Message-Id: <20210412212111.29186-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210412212111.29186-1-luc.vanoostenryck@gmail.com>
References: <20210412212111.29186-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Some instruction simplifications can be quite tricky and thus easy to
get wrong. Often, they also are hard to test (for example, you can
test it with a few input values but of course not all combinations).

I'm used to validate some of these with an independent tool
(Alive cfr. [1], [2]) which is quite neat but has some issues:
1) This tool doesn't work with Sparse's IR or C source but it needs to
   have the tests written in its own language (very close to LLVM's IR).
   So it can be used to test if the logic of a simplification but
   not if implemented correctly.
2) This tool isn't maintained anymore (has some bugs too) and it's
   successor (Alive2 [3]) is not quite as handy to me (I miss the
   pre-conditions a lot).

So, this patch implement the same idea but fully integrated with
Sparse. This mean that you can write a test in C, let Sparse process
and simplify it and then directly validate it and not only for
a few values but symbolically, for all possible values.

Note: Of course, this is not totally stand-alone and depends on
      an external library for the solver (Boolector, see [4], [5]).

Note: Currently, it's just a proof of concept and, except the
      included tests, it's only very slightly tested (and untested
      with anything more complex than a few instructions).

[1] https://blog.regehr.org/archives/1170
[2] https://www.cs.utah.edu/~regehr/papers/pldi15.pdf
[3] https://blog.regehr.org/archives/1722
[4] https://boolector.github.io/
[5] https://boolector.github.io/papers/BrummayerBiere-TACAS09.pdf

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 .gitignore             |   1 +
 Makefile               |   7 +
 ident-list.h           |   3 +
 scheck.c               | 315 +++++++++++++++++++++++++++++++++++++++++
 validation/scheck/ko.c |  10 ++
 validation/scheck/ok.c |  14 ++
 validation/test-suite  |   6 +
 7 files changed, 356 insertions(+)
 create mode 100644 scheck.c
 create mode 100644 validation/scheck/ko.c
 create mode 100644 validation/scheck/ok.c

diff --git a/.gitignore b/.gitignore
index 6a28fa50f8bb..b22f86b1ddfb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -17,6 +17,7 @@
 /example
 /graph
 /obfuscate
+/scheck
 /semind
 /sparse
 /sparse-llvm
diff --git a/Makefile b/Makefile
index f9883da101c7..a0178a65a11a 100644
--- a/Makefile
+++ b/Makefile
@@ -227,6 +227,13 @@ else
 $(warning Your system does not have llvm, disabling sparse-llvm)
 endif
 
+ifeq ($(HAVE_BOOLECTOR),yes)
+PROGRAMS += scheck
+scheck-cflags  := -I${BOOLECTORDIR}/include/boolector
+scheck-ldflags := -L${BOOLECTORDIR}/lib
+scheck-ldlibs  := -lboolector -llgl -lbtor2parser
+endif
+
 ########################################################################
 LIBS := libsparse.a
 OBJS := $(LIB_OBJS) $(EXTRA_OBJS) $(PROGRAMS:%=%.o)
diff --git a/ident-list.h b/ident-list.h
index 8049b6940745..918f54d75fc4 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -78,6 +78,9 @@ IDENT(memset); IDENT(memcpy);
 IDENT(copy_to_user); IDENT(copy_from_user);
 IDENT(main);
 
+/* used by the symbolic checker */
+IDENT(__assert);
+
 #undef __IDENT
 #undef IDENT
 #undef IDENT_RESERVED
diff --git a/scheck.c b/scheck.c
new file mode 100644
index 000000000000..63cbfa2d3404
--- /dev/null
+++ b/scheck.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: MIT
+// Copyright (C) 2021 Luc Van Oostenryck
+
+///
+// Symbolic checker for Sparse's IR
+// --------------------------------
+//
+// This is an example client program with a dual purpose:
+//	# It shows how to translate Sparse's IR into the language
+//	  of SMT solvers (only the part concerning integers,
+//	  floating-point and memory is ignored).
+//	# It's used as a simple symbolic checker for the IR.
+//	  The idea is to create a mini-language that allows to
+//	  express some assertions with some pre-conditions.
+
+#include <stdarg.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <ctype.h>
+#include <unistd.h>
+#include <fcntl.h>
+
+#include <boolector.h>
+#include "lib.h"
+#include "expression.h"
+#include "linearize.h"
+#include "symbol.h"
+#include "builtin.h"
+
+
+#define dyntype incomplete_ctype
+static const struct builtin_fn builtins_scheck[] = {
+	{ "__assert", &void_ctype, 0, { &bool_ctype }, .op = &generic_int_op },
+	{}
+};
+
+
+static BoolectorSort get_sort(Btor *btor, struct symbol *type, struct position pos)
+{
+	if (!is_int_type(type)) {
+		sparse_error(pos, "invalid type");
+		return NULL;
+	}
+	return boolector_bitvec_sort(btor, type->bit_size);
+}
+
+static BoolectorNode *mkvar(Btor *btor, BoolectorSort s, pseudo_t pseudo)
+{
+	static char buff[33];
+	BoolectorNode *n;
+
+	if (pseudo->priv)
+		return pseudo->priv;
+
+	switch (pseudo->type) {
+	case PSEUDO_VAL:
+		sprintf(buff, "%llx", pseudo->value);
+		return boolector_consth(btor, s, buff);
+	case PSEUDO_ARG:
+	case PSEUDO_REG:
+		n = boolector_var(btor, s, show_pseudo(pseudo));
+		break;
+	default:
+		fprintf(stderr, "invalid pseudo: %s\n", show_pseudo(pseudo));
+		return NULL;
+	}
+	return pseudo->priv = n;
+}
+
+static BoolectorNode *get_arg(Btor *btor, struct instruction *insn, int idx)
+{
+	pseudo_t arg = ptr_list_nth(insn->arguments, idx);
+	struct symbol *type = ptr_list_nth(insn->fntypes, idx + 1);
+	BoolectorSort s = get_sort(btor, type, insn->pos);
+
+	return mkvar(btor, s, arg);
+}
+
+static BoolectorNode *zext(Btor *btor, struct instruction *insn, BoolectorNode *s)
+{
+	int old = boolector_get_width(btor, s);
+	int new = insn->type->bit_size;
+	return boolector_uext(btor, s, new - old);
+}
+
+static BoolectorNode *sext(Btor *btor, struct instruction *insn, BoolectorNode *s)
+{
+	int old = boolector_get_width(btor, s);
+	int new = insn->type->bit_size;
+	return boolector_sext(btor, s, new - old);
+}
+
+static BoolectorNode *slice(Btor *btor, struct instruction *insn, BoolectorNode *s)
+{
+	int old = boolector_get_width(btor, s);
+	int new = insn->type->bit_size;
+	return boolector_slice(btor, s, old - new - 1, 0);
+}
+
+static void binary(Btor *btor, BoolectorSort s, struct instruction *insn)
+{
+	BoolectorNode *t, *a, *b;
+
+	a = mkvar(btor, s, insn->src1);
+	b = mkvar(btor, s, insn->src2);
+	if (!a || !b)
+		return;
+	switch (insn->opcode) {
+	case OP_ADD:	t = boolector_add(btor, a, b); break;
+	case OP_SUB:	t = boolector_sub(btor, a, b); break;
+	case OP_MUL:	t = boolector_mul(btor, a, b); break;
+	case OP_AND:	t = boolector_and(btor, a, b); break;
+	case OP_OR:	t = boolector_or (btor, a, b); break;
+	case OP_XOR:	t = boolector_xor(btor, a, b); break;
+	case OP_SHL:	t = boolector_sll(btor, a, b); break;
+	case OP_LSR:	t = boolector_srl(btor, a, b); break;
+	case OP_ASR:	t = boolector_sra(btor, a, b); break;
+	case OP_DIVS:	t = boolector_sdiv(btor, a, b); break;
+	case OP_DIVU:	t = boolector_udiv(btor, a, b); break;
+	case OP_MODS:	t = boolector_srem(btor, a, b); break;
+	case OP_MODU:	t = boolector_urem(btor, a, b); break;
+	case OP_SET_EQ:	t = zext(btor, insn, boolector_eq(btor, a, b)); break;
+	case OP_SET_NE:	t = zext(btor, insn, boolector_ne(btor, a, b)); break;
+	case OP_SET_LT:	t = zext(btor, insn, boolector_slt(btor, a, b)); break;
+	case OP_SET_LE:	t = zext(btor, insn, boolector_slte(btor, a, b)); break;
+	case OP_SET_GE:	t = zext(btor, insn, boolector_sgte(btor, a, b)); break;
+	case OP_SET_GT:	t = zext(btor, insn, boolector_sgt(btor, a, b)); break;
+	case OP_SET_B:	t = zext(btor, insn, boolector_ult(btor, a, b)); break;
+	case OP_SET_BE:	t = zext(btor, insn, boolector_ulte(btor, a, b)); break;
+	case OP_SET_AE:	t = zext(btor, insn, boolector_ugte(btor, a, b)); break;
+	case OP_SET_A:	t = zext(btor, insn, boolector_ugt(btor, a, b)); break;
+	default:
+		fprintf(stderr, "unsupported insn\n");
+		return;
+	}
+	insn->target->priv = t;
+}
+
+static void binop(Btor *btor, struct instruction *insn)
+{
+	BoolectorSort s = get_sort(btor, insn->type, insn->pos);
+	binary(btor, s, insn);
+}
+
+static void icmp(Btor *btor, struct instruction *insn)
+{
+	BoolectorSort s = get_sort(btor, insn->itype, insn->pos);
+	binary(btor, s, insn);
+}
+
+static void unop(Btor *btor, struct instruction *insn)
+{
+	BoolectorSort s = get_sort(btor, insn->type, insn->pos);
+	BoolectorNode *t, *a;
+
+	a = mkvar(btor, s, insn->src1);
+	if (!a)
+		return;
+	switch (insn->opcode) {
+	case OP_NEG:	t = boolector_neg(btor, a); break;
+	case OP_NOT:	t = boolector_not(btor, a); break;
+	case OP_SEXT:	t = sext(btor, insn, a); break;
+	case OP_ZEXT:	t = zext(btor, insn, a); break;
+	case OP_TRUNC:	t = slice(btor, insn, a); break;
+	default:
+		fprintf(stderr, "unsupported insn\n");
+		return;
+	}
+	insn->target->priv = t;
+}
+
+static void ternop(Btor *btor, struct instruction *insn)
+{
+	BoolectorSort s = get_sort(btor, insn->type, insn->pos);
+	BoolectorNode *t, *a, *b, *c, *z, *d;
+
+	a = mkvar(btor, s, insn->src1);
+	b = mkvar(btor, s, insn->src2);
+	c = mkvar(btor, s, insn->src3);
+	if (!a || !b || !c)
+		return;
+	switch (insn->opcode) {
+	case OP_SEL:
+		z = boolector_zero(btor, s);
+		d = boolector_ne(btor, a, z);
+		t = boolector_cond(btor, d, b, c);
+		break;
+	default:
+		fprintf(stderr, "unsupported insn\n");
+		return;
+	}
+	insn->target->priv = t;
+}
+
+static bool check_btor(Btor *btor, BoolectorNode *n, struct instruction *insn)
+{
+	char model_format[] = "btor";
+	int res;
+
+	boolector_assert(btor, boolector_not(btor, n));
+	res = boolector_sat(btor);
+	switch (res) {
+	case BOOLECTOR_UNSAT:
+		return 1;
+	case BOOLECTOR_SAT:
+		sparse_error(insn->pos, "assertion failed");
+		show_entry(insn->bb->ep);
+		boolector_dump_btor(btor, stdout);
+		boolector_print_model(btor, model_format, stdout);
+		break;
+	default:
+		sparse_error(insn->pos, "SMT failure");
+		break;
+	}
+	return 0;
+}
+
+static bool check_assert(Btor *btor, struct instruction *insn)
+{
+	BoolectorNode *a = get_arg(btor, insn, 0);
+	BoolectorNode *z = boolector_zero(btor, boolector_get_sort(btor, a));
+	BoolectorNode *n = boolector_ne(btor, a, z);
+	return check_btor(btor, n, insn);
+}
+
+static bool check_call(Btor *btor, struct instruction *insn)
+{
+	pseudo_t func = insn->func;
+	struct ident *ident = func->ident;
+
+	if (ident == &__assert_ident)
+		return check_assert(btor, insn);
+	return 0;
+}
+
+static bool check_function(struct entrypoint *ep)
+{
+	Btor *btor = boolector_new();
+	struct basic_block *bb;
+	int rc = 0;
+
+	boolector_set_opt(btor, BTOR_OPT_MODEL_GEN, 1);
+
+	FOR_EACH_PTR(ep->bbs, bb) {
+		struct instruction *insn;
+		FOR_EACH_PTR(bb->insns, insn) {
+			if (!insn->bb)
+				continue;
+			switch (insn->opcode) {
+			case OP_ENTRY:
+				continue;
+			case OP_BINARY ... OP_BINARY_END:
+				binop(btor, insn);
+				break;
+			case OP_BINCMP ... OP_BINCMP_END:
+				icmp(btor, insn);
+				break;
+			case OP_UNOP ... OP_UNOP_END:
+				unop(btor, insn);
+				break;
+			case OP_SEL:
+				ternop(btor, insn);
+				break;
+			case OP_CALL:
+				rc = check_call(btor, insn);
+				goto out;
+			case OP_RET:
+				goto out;
+			default:
+				fprintf(stderr, "unsupported insn\n");
+				goto out;
+			}
+		} END_FOR_EACH_PTR(insn);
+	} END_FOR_EACH_PTR(bb);
+	fprintf(stderr, "unterminated function\n");
+
+out:
+	boolector_release_all(btor);
+	boolector_delete(btor);
+	return rc;
+}
+
+static void check_functions(struct symbol_list *list)
+{
+	struct symbol *sym;
+
+	FOR_EACH_PTR(list, sym) {
+		struct entrypoint *ep;
+
+		expand_symbol(sym);
+		ep = linearize_symbol(sym);
+		if (!ep || !ep->entry)
+			continue;
+		check_function(ep);
+	} END_FOR_EACH_PTR(sym);
+}
+
+int main(int argc, char **argv)
+{
+	struct string_list *filelist = NULL;
+	char *file;
+
+	Wdecl = 0;
+
+	sparse_initialize(argc, argv, &filelist);
+
+	declare_builtins(0, builtins_scheck);
+
+	// Expand, linearize and check.
+	FOR_EACH_PTR(filelist, file) {
+		check_functions(sparse(file));
+	} END_FOR_EACH_PTR(file);
+	return 0;
+}
diff --git a/validation/scheck/ko.c b/validation/scheck/ko.c
new file mode 100644
index 000000000000..dbd861ea17fd
--- /dev/null
+++ b/validation/scheck/ko.c
@@ -0,0 +1,10 @@
+static void ko(int x)
+{
+	__assert((~x) == (~0 + x));
+}
+
+/*
+ * check-name: scheck-ko
+ * check-command: scheck $file
+ * check-known-to-fail
+ */
diff --git a/validation/scheck/ok.c b/validation/scheck/ok.c
new file mode 100644
index 000000000000..113912e01aad
--- /dev/null
+++ b/validation/scheck/ok.c
@@ -0,0 +1,14 @@
+static void ok(int x)
+{
+	__assert((~x) == (~0 - x));	// true but not simplified yet
+}
+
+static void always(int x)
+{
+	__assert((x - x) == 0);		// true and simplified
+}
+
+/*
+ * check-name: scheck-ok
+ * check-command: scheck $file
+ */
diff --git a/validation/test-suite b/validation/test-suite
index 1b05c75e9f74..2f7950ef50a4 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -13,6 +13,9 @@ prog_name=`basename $0`
 if [ ! -x "$default_path/sparse-llvm" ]; then
 	disabled_cmds="sparsec sparsei sparse-llvm sparse-llvm-dis"
 fi
+if [ ! -x "$default_path/scheck" ]; then
+	disabled_cmds="$disabled_cmds scheck"
+fi
 
 # flags:
 #	- some tests gave an unexpected result
@@ -513,6 +516,7 @@ echo "    -a                         append the created test to the input file"
 echo "    -f                         write a test known to fail"
 echo "    -l                         write a test for linearized code"
 echo "    -p                         write a test for pre-processing"
+echo "    -s                         write a test for symbolic checking"
 echo
 echo "argument(s):"
 echo "    file                       file containing the test case(s)"
@@ -540,6 +544,8 @@ do_format()
 			linear=1 ;;
 		-p)
 			def_cmd='sparse -E $file' ;;
+		-s)
+			def_cmd='scheck $file' ;;
 
 		help|-*)
 			do_format_help
-- 
2.31.1

