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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344A4C433ED
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 13:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C43961028
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 13:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbhDJNbN (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 10 Apr 2021 09:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbhDJNbM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Apr 2021 09:31:12 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813AAC061762
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 06:30:57 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r12so12928559ejr.5
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 06:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=//RpLQUnrXKDd0qIHIFVdT2RzkfNuaPo446jPakCDEs=;
        b=KNKTrs+g9jVnyYS/d8TrEyNRN+eJbfc5wtNDtN0m2VA6vIXL4I4vS+uA4nftB5s32r
         sKJH3/JGc2PTLdJ9fOZyxds1/Sy98DC/XzpTOnNBIQzOo6XibYVHOc3F0oUSFxlPw76f
         y8JSKhjlqae84rH7+q7HHjkG2E6T4GCS0C6JpiAG12nkldqHf2nV76vB+1qJCZ5YyFwV
         871SIPOuEjpF/QbcGmlXnjdG0R51OAahh1BkRrmLakBpSYP1lhPdWftKTpY9lS2wqsji
         DRAj395GJu/GK7jM1lmzmoSx3xxMqtTxC5ch4EjgvH1pC/lmmAZByydm1TEnzBXS3BzH
         4zHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=//RpLQUnrXKDd0qIHIFVdT2RzkfNuaPo446jPakCDEs=;
        b=YgE6pxazT1lckHgdTEGF22FdDf7IfcLBySnh2MbsSsuNOiNgkd1jDazs/MVFwQxi+k
         wPV/Sl3zzxc+z2GWkzYPvVWyUo9LEmHWkKcyxb8QXDPCeSfaAHZ4PLGJoOtaosPKjIKd
         Ej8GdVSeOCcYQbrkwMzXvxAYcHuaAv8lKOlI1OmbMcPTt55fvrv+gLOLmp6NMyts6XdD
         zAdulDQSiCSHf4lC6R89DNUvUU++vXVzIbQZ9gb8EVcmxH4lAQd62uOBn/aZsi65Kh/e
         1KVCF3ccOwlFtVCWMHiUnPSRq1Kyhe5R5V9+pB1tuIBBp8dsLbIz2akUdeerU0JlYv3+
         3rLg==
X-Gm-Message-State: AOAM533yBjg66TMm1flVQh2lw9buDikOTwnSoOO4TGjGarNylPUxi3lm
        msJuC37rFfzZAyoQGcObiEBx0sTYtJE=
X-Google-Smtp-Source: ABdhPJw455EoDrDf7wRfC8n9BU/brhB6Snr9ltQNH1+tl808thYb2sOhRhsqTSKJUNCHXqgS6eWM+A==
X-Received: by 2002:a17:906:4801:: with SMTP id w1mr20174125ejq.475.1618061456228;
        Sat, 10 Apr 2021 06:30:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f96a:804d:4fe5:372f])
        by smtp.gmail.com with ESMTPSA id g26sm2594910ejz.70.2021.04.10.06.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 06:30:55 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/8] scheck: add a symbolic checker
Date:   Sat, 10 Apr 2021 15:30:41 +0200
Message-Id: <20210410133045.53189-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210410133045.53189-1-luc.vanoostenryck@gmail.com>
References: <20210410133045.53189-1-luc.vanoostenryck@gmail.com>
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
 scheck.c               | 302 +++++++++++++++++++++++++++++++++++++++++
 validation/scheck/ko.c |  10 ++
 validation/scheck/ok.c |  14 ++
 validation/test-suite  |   6 +
 7 files changed, 343 insertions(+)
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
index 000000000000..719aeea84e7c
--- /dev/null
+++ b/scheck.c
@@ -0,0 +1,302 @@
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
+static void binop(Btor *btor, struct instruction *insn)
+{
+	BoolectorSort s = get_sort(btor, insn->type, insn->pos);
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
+			case OP_BINCMP ... OP_BINCMP_END:
+				binop(btor, insn);
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

