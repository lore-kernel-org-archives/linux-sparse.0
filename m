Return-Path: <SRS0=Z4Q2=EE=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD51C4741F
	for <linux-sparse@archiver.kernel.org>; Thu, 29 Oct 2020 22:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFCC62076D
	for <linux-sparse@archiver.kernel.org>; Thu, 29 Oct 2020 22:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8j/pPYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgJ2W7Q (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 29 Oct 2020 18:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ2W7O (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 29 Oct 2020 18:59:14 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F62C0613CF
        for <linux-sparse@vger.kernel.org>; Thu, 29 Oct 2020 15:59:13 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id 7so6109336ejm.0
        for <linux-sparse@vger.kernel.org>; Thu, 29 Oct 2020 15:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5BFP++iHJdZ3y5EIYdno8kudTRDxmhcNNdwJ97FpolU=;
        b=b8j/pPYVGRjwBCl8ahRbUNhht+7JRnQOzDBBSkux4sg0mCMWolrSztJdzYhKXdDfcz
         DL3v7SWjdwPHUUbP45e/nMWWxMNrunhEHabT2/DTko3C8r+pQ2GhX4sbaQslg2ilK2Qv
         GtS/h/jpv5Boxux+TtBOZJfcOhyT03V3+qRtqthSScywJEDssP8xLH7SYTbf0V5AXNa3
         jLWkZqhrZsIGYL8OHrj0jJ3LoA4HTZG8fBqcS19nJteYKTMear6oM66fmJN8uokNPFd7
         ifLai4K7vKfF77D84hkg2MNjWisRwXMwV/eP1nlTJ+YQXAjEJPlwQwM96YJ2FLAvMzMY
         nWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5BFP++iHJdZ3y5EIYdno8kudTRDxmhcNNdwJ97FpolU=;
        b=qUeFNybZedaoEUyTKlyQA+CwaXosZfPFXnC2SEGNyyXTgDzQpoXEaDLovB64TCWPu+
         vWFvY1WBBZ8scENu8aLqXbaxF978gsetCfWWIkZ013uBRwhnsxgsS8dgUgNQdMyEtWsa
         GTrG70myLCYz4jAs4btBaDsikFwwRnMq9qLh8d5OlMrJCH51o7D0OlBYRih/duOkizNb
         75KGk2kJyGQ3gKQd1wUeGyjipfMP6ZDQwvyg823wYB4CqU5Y0SiJzqsXx2mn9HfUlg5i
         9GQA8zi1xVoNE1YmzzcLJmXKJx6OxRc5LNdAqFtE3jzWMWLmRVmTmh6rXzp37oSkD0MP
         1BpA==
X-Gm-Message-State: AOAM531vas6zTzMmGDIEVWwMCjCKYVLOdtojbW7ihbPyrsplxFl8nKLe
        L89sl1szX6HX/+oniyZqD6pHopdZ1w4=
X-Google-Smtp-Source: ABdhPJyeBpFeSMIJxbV7dEGORFa8+May6Q0/wSmNLPoxiXQO6jV2U+OfmUDW+B7MITJtjtR2dFgLTg==
X-Received: by 2002:a17:906:2987:: with SMTP id x7mr6191068eje.301.1604012351629;
        Thu, 29 Oct 2020 15:59:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d5b9:9762:e6d6:4f40])
        by smtp.gmail.com with ESMTPSA id v21sm2175224edt.80.2020.10.29.15.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 15:59:11 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] eval_insn: give an explicit type to operands of comparisons
Date:   Thu, 29 Oct 2020 23:59:05 +0100
Message-Id: <20201029225905.85037-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201029225905.85037-1-luc.vanoostenryck@gmail.com>
References: <20201029225905.85037-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Binary instructions like OP_ADD have the type of their result
the same as their inputs. This is not the case for compare
instructions.

The problem is that the structure for instructions contains
only one field for both types, interpreted as the result's type
 This causes sometimes incorrect results.

One solution would be for compares instructions to use this type
for the type of the operands. This is non-ideal, though, because
there is a lot of generic code which use this type for the result
and changing this would create a lot of special cases to handle
compares instructions.

So, given that compares instructions need only 2 operands, add
a new field for them for the operands' type. This has essentially
zero impact on generic code, solves the current errors and allows
new simplifications that were previously impossible to do without
the informations about the input's type.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/IR.rst         |  1 +
 linearize.c                  | 16 ++++++++++++----
 linearize.h                  |  4 ++++
 simplify.c                   | 14 +++++++++++++-
 validation/optim/cmp-type0.c |  1 -
 validation/optim/cmp-type1.c |  1 -
 6 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/Documentation/IR.rst b/Documentation/IR.rst
index ff5af1c5868c..6330ee9c8f8e 100644
--- a/Documentation/IR.rst
+++ b/Documentation/IR.rst
@@ -134,6 +134,7 @@ They all have the following signature:
 	* .src1, .src2: operands (types must be compatible)
 	* .target: result of the operation (0/1 valued integer)
 	* .type: type of .target, must be an integral type
+	* .itype: type of the input operands
 
 .. op:: OP_SET_EQ
 	Compare equal.
diff --git a/linearize.c b/linearize.c
index d9a3ac4915a5..301a5d9ed19e 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1080,6 +1080,13 @@ static pseudo_t add_binary_op(struct entrypoint *ep, struct symbol *ctype, int o
 	return target;
 }
 
+static pseudo_t add_cmp_op(struct entrypoint *ep, struct symbol *ctype, int op, struct symbol *itype, pseudo_t left, pseudo_t right)
+{
+	pseudo_t target = add_binary_op(ep, ctype, op, left, right);
+	target->def->itype = itype;
+	return target;
+}
+
 static pseudo_t add_setval(struct entrypoint *ep, struct symbol *ctype, struct expression *val)
 {
 	struct instruction *insn = alloc_typed_instruction(OP_SETVAL, ctype);
@@ -1217,7 +1224,7 @@ static pseudo_t linearize_regular_preop(struct entrypoint *ep, struct expression
 		return pre;
 	case '!': {
 		pseudo_t zero = value_pseudo(0);
-		return add_binary_op(ep, ctype, OP_SET_EQ, pre, zero);
+		return add_cmp_op(ep, ctype, OP_SET_EQ, expr->unop->ctype, pre, zero);
 	}
 	case '~':
 		return add_unop(ep, ctype, OP_NOT, pre);
@@ -1444,7 +1451,7 @@ static inline pseudo_t add_convert_to_bool(struct entrypoint *ep, pseudo_t src,
 		zero = value_pseudo(0);
 		op = OP_SET_NE;
 	}
-	return add_binary_op(ep, &bool_ctype, op, src, zero);
+	return add_cmp_op(ep, &bool_ctype, op, type, src, zero);
 }
 
 static pseudo_t linearize_expression_to_bool(struct entrypoint *ep, struct expression *expr)
@@ -1773,10 +1780,11 @@ static pseudo_t linearize_compare(struct entrypoint *ep, struct expression *expr
 		[SPECIAL_UNSIGNED_LTE] = OP_SET_BE,
 		[SPECIAL_UNSIGNED_GTE] = OP_SET_AE,
 	};
-	int op = opcode_float(cmpop[expr->op], expr->right->ctype);
+	struct symbol *itype = expr->right->ctype;
+	int op = opcode_float(cmpop[expr->op], itype);
 	pseudo_t src1 = linearize_expression(ep, expr->left);
 	pseudo_t src2 = linearize_expression(ep, expr->right);
-	pseudo_t dst = add_binary_op(ep, expr->ctype, op, src1, src2);
+	pseudo_t dst = add_cmp_op(ep, expr->ctype, op, itype, src1, src2);
 	return dst;
 }
 
diff --git a/linearize.h b/linearize.h
index 57fe20352e39..77ae7c9ac976 100644
--- a/linearize.h
+++ b/linearize.h
@@ -123,6 +123,10 @@ struct instruction {
 		struct /* binops and sel */ {
 			pseudo_t src1, src2, src3;
 		};
+		struct /* compare */ {
+			pseudo_t _src1, _src2;		// alias .src[12]
+			struct symbol *itype;		// input operands' type
+		};
 		struct /* slice */ {
 			pseudo_t base;
 			unsigned from, len;
diff --git a/simplify.c b/simplify.c
index 6f75b1ae9794..3a4179f444a6 100644
--- a/simplify.c
+++ b/simplify.c
@@ -635,6 +635,11 @@ static pseudo_t eval_op(int op, unsigned size, pseudo_t src1, pseudo_t src2)
 	default:
 		return NULL;
 	}
+
+	// Warning: this should be done with the output size which may
+	// be different than the input size used here. But it differs
+	// only for compares which are not concerned since only returning
+	// 0 or 1 and for casts which are not handled here.
 	res &= bits;
 
 	return value_pseudo(res);
@@ -767,7 +772,11 @@ static int simplify_mask_shift(struct instruction *sh, unsigned long long mask)
 
 static pseudo_t eval_insn(struct instruction *insn)
 {
-	return eval_op(insn->opcode, insn->size, insn->src1, insn->src2);
+	unsigned size = insn->size;
+
+	if (opcode_table[insn->opcode].flags & OPF_COMPARE)
+		size = insn->itype->bit_size;
+	return eval_op(insn->opcode, size, insn->src1, insn->src2);
 }
 
 static long long check_shift_count(struct instruction *insn, unsigned long long uval)
@@ -1009,6 +1018,7 @@ static int simplify_seteq_setne(struct instruction *insn, long long value)
 		//	setcc.m %r <- %a, $b
 		// and similar for setne/eq ... 0/1
 		insn->opcode = inverse ? opcode_table[opcode].negate : opcode;
+		insn->itype = def->itype;
 		use_pseudo(insn, def->src1, &insn->src1);
 		use_pseudo(insn, def->src2, &insn->src2);
 		remove_usage(old, &insn->src1);
@@ -1025,6 +1035,7 @@ static int simplify_seteq_setne(struct instruction *insn, long long value)
 		// into:
 		//	setne.1 %s <- %a, $0
 		// and same for setne/eq ... 0/1
+		insn->itype = def->orig_type;
 		return replace_pseudo(insn, &insn->src1, def->src);
 	case OP_TRUNC:
 		if (!one_use(old))
@@ -1671,6 +1682,7 @@ static int simplify_cast(struct instruction *insn)
 			//	setcc.m	%r <- %a, %b
 			// and same for s/zext/trunc/
 			insn->opcode = def->opcode;
+			insn->itype = def->orig_type;
 			use_pseudo(insn, def->src2, &insn->src2);
 			return replace_pseudo(insn, &insn->src1, def->src1);
 		}
diff --git a/validation/optim/cmp-type0.c b/validation/optim/cmp-type0.c
index 695d082b6aed..024e53373ad0 100644
--- a/validation/optim/cmp-type0.c
+++ b/validation/optim/cmp-type0.c
@@ -6,7 +6,6 @@ static int foo(long long a)
 /*
  * check-name: cmp-type0
  * check-command: test-linearize $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-contains: ret.*\\$1
diff --git a/validation/optim/cmp-type1.c b/validation/optim/cmp-type1.c
index 2fb78a0bb86a..e098a3ac1945 100644
--- a/validation/optim/cmp-type1.c
+++ b/validation/optim/cmp-type1.c
@@ -9,7 +9,6 @@ int foo(void)
 /*
  * check-name: cmp-type1
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-contains: ret\\..*\\$1
-- 
2.29.0

