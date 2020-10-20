Return-Path: <SRS0=cyFV=D3=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FACEC4363A
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EFAA2237B
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJ6PW6NF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438664AbgJTVKc (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438655AbgJTVKb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Oct 2020 17:10:31 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDDAC0613CE
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:31 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id t25so4821279ejd.13
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iaEWa5oZWpQFhq0vLL69tVQn5C5pjSR+2ukRX2MQSlM=;
        b=pJ6PW6NFSLvPQCjgMx49JgxHBO1jRnarI3syMaBOIdBeV8n7bHz88qrN4tfwD5jEcM
         sr5kNJcfGbQh11jWoEdOqe3UVy1Xk5TvsHJjAjnrVzj7tSK4CrKqdmcLZGfPFDt3Ia7x
         hGi5HY2xFxRpUECkGvq8RBI/DMBU8U4wg6Zf05KlxOzgAv1SzHrE4F5vgL8Tf1vE+gnp
         exLETTDJ3JmR4AnA0+lTX2rprDfZehSDF79UgSIK5aC+spcgyzoF/Ggu5cplDu+RP8O4
         RHgy+zI5Zv60ywQKZHQqi73an1SSyB3bk98iuIJEQBoOU3ZY3TJdggYuDdVnfwKIU6/T
         Q/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iaEWa5oZWpQFhq0vLL69tVQn5C5pjSR+2ukRX2MQSlM=;
        b=cnyMr7QNdnDJyFGOLj8Wc1vJWjUHTyV7yhjsddKtKtZdY+aeq2egnv3EmRXOEqWC+U
         0VZvKTxGfXg6uJIIeI2HQ/m5/RMScTZKhRu4dBgiCv4d80nhn24t+za6JdRsrn3xqBRH
         fT94vpY7enXmw0t7s4+qVI/viIzzUaauoiBhH1l/gNeDd12DCy3V4+4toRnalAj+6VM6
         PrGojIF8Cu2eS5ZvWpSclVDmrr1vwhjxLC5go5PKxSCNJzIWOJP6GuRSd0osxzm+0NSi
         Gw2sr9xey/GunQr+yub5IdZwlexMLq3mmZveo+MfManBCcLBOao/LIkDxWDAoeyiYMjl
         m3nQ==
X-Gm-Message-State: AOAM532pE3Jr4q7PF6MVOqAJ22+BOFT/+5YA857UDtZJ4IqdJntUayZQ
        5QHzDxanouvUGzPCeUBuIRaX58UN51U=
X-Google-Smtp-Source: ABdhPJwY4AfXYGABEeh19INinvnJsmZK04/85egDx8iN11RxsaanFXM4Jbe1ED/PNW0Mf2RUCrmDSA==
X-Received: by 2002:a17:906:8053:: with SMTP id x19mr84163ejw.139.1603228229784;
        Tue, 20 Oct 2020 14:10:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:85fe:66cb:a92b:c664])
        by smtp.gmail.com with ESMTPSA id d12sm4012848ejt.105.2020.10.20.14.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 14:10:29 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 06/22] add a flag to identify commutative & associative ops
Date:   Tue, 20 Oct 2020 23:10:05 +0200
Message-Id: <20201020211021.82394-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
References: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The way how the functions doing the simplification of commutative
or associative binops are called is simple but complicates the
simplification of a specific binop.

Fix this by adding a flag to the opcode table to identify the
commutative and the associative binops and using this flag
to call or not the functions doing the corresponding simplification.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 opcode.def | 50 +++++++++++++++++++--------------------
 opcode.h   |  5 ++++
 simplify.c | 69 ++++++++++++++++++++++++++++++++++++------------------
 3 files changed, 76 insertions(+), 48 deletions(-)

diff --git a/opcode.def b/opcode.def
index 1401d988d73a..c65722f0b9bb 100644
--- a/opcode.def
+++ b/opcode.def
@@ -15,16 +15,16 @@ OPCODE(COMPUTEDGOTO,    BADOP,    BADOP,    BADOP, 1, OPF_NONE)
 OPCODE_RANGE(TERMINATOR, RET, COMPUTEDGOTO)
 
 /* Binary */
-OPCODE(ADD,             BADOP,    BADOP,    FADD,  2, OPF_TARGET)
-OPCODE(SUB,             BADOP,    BADOP,    FSUB,  2, OPF_TARGET)
-OPCODE(MUL,             BADOP,    BADOP,    FMUL,  2, OPF_TARGET)
-OPCODE(DIVU,            BADOP,    BADOP,    FDIV,  2, OPF_TARGET)
-OPCODE(DIVS,            BADOP,    BADOP,    FDIV,  2, OPF_TARGET)
-OPCODE(MODU,            BADOP,    BADOP,    BADOP, 2, OPF_TARGET)
-OPCODE(MODS,            BADOP,    BADOP,    BADOP, 2, OPF_TARGET)
-OPCODE(SHL,             BADOP,    BADOP,    BADOP, 2, OPF_TARGET)
-OPCODE(LSR,             BADOP,    BADOP,    BADOP, 2, OPF_TARGET)
-OPCODE(ASR,             BADOP,    BADOP,    BADOP, 2, OPF_TARGET)
+OPCODE(ADD,             BADOP,    BADOP,    FADD,  2, OPF_TARGET|OPF_COMMU|OPF_ASSOC|OPF_BINOP)
+OPCODE(MUL,             BADOP,    BADOP,    FMUL,  2, OPF_TARGET|OPF_COMMU|OPF_ASSOC|OPF_BINOP)
+OPCODE(SUB,             BADOP,    BADOP,    FSUB,  2, OPF_TARGET|OPF_BINOP)
+OPCODE(DIVU,            BADOP,    BADOP,    FDIV,  2, OPF_TARGET|OPF_BINOP)
+OPCODE(DIVS,            BADOP,    BADOP,    FDIV,  2, OPF_TARGET|OPF_BINOP)
+OPCODE(MODU,            BADOP,    BADOP,    BADOP, 2, OPF_TARGET|OPF_BINOP)
+OPCODE(MODS,            BADOP,    BADOP,    BADOP, 2, OPF_TARGET|OPF_BINOP)
+OPCODE(SHL,             BADOP,    BADOP,    BADOP, 2, OPF_TARGET|OPF_BINOP)
+OPCODE(LSR,             BADOP,    BADOP,    BADOP, 2, OPF_TARGET|OPF_BINOP)
+OPCODE(ASR,             BADOP,    BADOP,    BADOP, 2, OPF_TARGET|OPF_BINOP)
 
 /* Floating-point binops */
 OPCODE(FADD,            BADOP,    BADOP,    BADOP, 2, OPF_TARGET)
@@ -33,9 +33,9 @@ OPCODE(FMUL,            BADOP,    BADOP,    BADOP, 2, OPF_TARGET)
 OPCODE(FDIV,            BADOP,    BADOP,    BADOP, 2, OPF_TARGET)
 
 /* Logical */
-OPCODE(AND,             BADOP,    BADOP,    BADOP, 2, OPF_TARGET)
-OPCODE(OR,              BADOP,    BADOP,    BADOP, 2, OPF_TARGET)
-OPCODE(XOR,             BADOP,    BADOP,    BADOP, 2, OPF_TARGET)
+OPCODE(AND,             BADOP,    BADOP,    BADOP, 2, OPF_TARGET|OPF_COMMU|OPF_ASSOC|OPF_BINOP)
+OPCODE(OR,              BADOP,    BADOP,    BADOP, 2, OPF_TARGET|OPF_COMMU|OPF_ASSOC|OPF_BINOP)
+OPCODE(XOR,             BADOP,    BADOP,    BADOP, 2, OPF_TARGET|OPF_COMMU|OPF_ASSOC|OPF_BINOP)
 OPCODE_RANGE(BINARY, ADD, XOR)
 
 /* floating-point comparison */
@@ -56,21 +56,21 @@ OPCODE(FCMP_UNO,        FCMP_ORD, FCMP_UNO, BADOP, 2, OPF_TARGET)
 OPCODE_RANGE(FPCMP, FCMP_ORD, FCMP_UNO)
 
 /* Binary comparison */
-OPCODE(SET_EQ,          SET_NE,   SET_EQ,   FCMP_OEQ, 2, OPF_TARGET)
-OPCODE(SET_LT,          SET_GE,   SET_GT,   FCMP_OLT, 2, OPF_TARGET)
-OPCODE(SET_LE,          SET_GT,   SET_GE,   FCMP_OLE, 2, OPF_TARGET)
-OPCODE(SET_GE,          SET_LT,   SET_LE,   FCMP_OGE, 2, OPF_TARGET)
-OPCODE(SET_GT,          SET_LE,   SET_LT,   FCMP_OGT, 2, OPF_TARGET)
-OPCODE(SET_B,           SET_AE,   SET_A,    FCMP_OLT, 2, OPF_TARGET)
-OPCODE(SET_BE,          SET_A,    SET_AE,   FCMP_OLE, 2, OPF_TARGET)
-OPCODE(SET_AE,          SET_B,    SET_BE,   FCMP_OGE, 2, OPF_TARGET)
-OPCODE(SET_A,           SET_BE,   SET_B,    FCMP_OGT, 2, OPF_TARGET)
-OPCODE(SET_NE,          SET_EQ,   SET_NE,   FCMP_UNE, 2, OPF_TARGET)
+OPCODE(SET_EQ,          SET_NE,   SET_EQ,   FCMP_OEQ, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE|OPF_COMMU)
+OPCODE(SET_LT,          SET_GE,   SET_GT,   FCMP_OLT, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE)
+OPCODE(SET_LE,          SET_GT,   SET_GE,   FCMP_OLE, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE)
+OPCODE(SET_GE,          SET_LT,   SET_LE,   FCMP_OGE, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE)
+OPCODE(SET_GT,          SET_LE,   SET_LT,   FCMP_OGT, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE)
+OPCODE(SET_B,           SET_AE,   SET_A,    FCMP_OLT, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE)
+OPCODE(SET_BE,          SET_A,    SET_AE,   FCMP_OLE, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE)
+OPCODE(SET_AE,          SET_B,    SET_BE,   FCMP_OGE, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE)
+OPCODE(SET_A,           SET_BE,   SET_B,    FCMP_OGT, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE)
+OPCODE(SET_NE,          SET_EQ,   SET_NE,   FCMP_UNE, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE|OPF_COMMU)
 OPCODE_RANGE(BINCMP, SET_EQ, SET_NE)
 
 /* Uni */
-OPCODE(NOT,             BADOP,    BADOP,    BADOP, 1, OPF_TARGET)
-OPCODE(NEG,             BADOP,    BADOP,    FNEG,  1, OPF_TARGET)
+OPCODE(NOT,             BADOP,    BADOP,    BADOP, 1, OPF_TARGET|OPF_UNOP)
+OPCODE(NEG,             BADOP,    BADOP,    FNEG,  1, OPF_TARGET|OPF_UNOP)
 OPCODE(FNEG,            BADOP,    BADOP,    BADOP, 1, OPF_TARGET)
 OPCODE(TRUNC,           BADOP,    BADOP,    BADOP, 1, OPF_TARGET)
 OPCODE(ZEXT,            BADOP,    BADOP,    BADOP, 1, OPF_TARGET)
diff --git a/opcode.h b/opcode.h
index e426bed4f7e2..bb94ec81c832 100644
--- a/opcode.h
+++ b/opcode.h
@@ -20,6 +20,11 @@ extern const struct opcode_table {
 	unsigned int flags:6;
 #define			OPF_NONE	0
 #define			OPF_TARGET	(1 << 0)
+#define			OPF_COMMU	(1 << 1)
+#define			OPF_ASSOC	(1 << 2)
+#define			OPF_UNOP	(1 << 3)
+#define			OPF_BINOP	(1 << 4)
+#define			OPF_COMPARE	(1 << 5)
 } opcode_table[];
 
 
diff --git a/simplify.c b/simplify.c
index 3cac124f7d9f..db7a1e47ff0a 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1736,35 +1736,57 @@ found:
 
 int simplify_instruction(struct instruction *insn)
 {
+	unsigned flags;
+	int changed = 0;
+
 	if (!insn->bb)
 		return 0;
-	switch (insn->opcode) {
-	case OP_ADD: case OP_MUL:
-	case OP_AND: case OP_OR: case OP_XOR:
-		canonicalize_commutative(insn);
-		if (simplify_binop(insn))
-			return REPEAT_CSE;
-		return simplify_associative_binop(insn);
 
-	case OP_SET_EQ: case OP_SET_NE:
-		canonicalize_commutative(insn);
-		return simplify_binop(insn);
+	flags = opcode_table[insn->opcode].flags;
+	if (flags & OPF_COMMU)
+		canonicalize_commutative(insn) ;
+	if (flags & OPF_COMPARE)
+		canonicalize_compare(insn) ;
+	if (flags & OPF_BINOP) {
+		if ((changed = simplify_binop(insn)))
+			return changed;
+	}
+	if (flags & OPF_ASSOC) {
+		if ((changed = simplify_associative_binop(insn)))
+			return changed;
+	}
+	if (flags & OPF_UNOP) {
+		if ((changed = simplify_unop(insn)))
+			return changed;
+	}
 
-	case OP_SET_LE: case OP_SET_GE:
-	case OP_SET_LT: case OP_SET_GT:
-	case OP_SET_B:  case OP_SET_A:
-	case OP_SET_BE: case OP_SET_AE:
-		canonicalize_compare(insn);
-		/* fall through */
+	switch (insn->opcode) {
+	case OP_ADD:
 	case OP_SUB:
-	case OP_DIVU: case OP_DIVS:
-	case OP_MODU: case OP_MODS:
+	case OP_MUL:
+	case OP_AND:
+	case OP_OR:
+	case OP_XOR:
 	case OP_SHL:
-	case OP_LSR: case OP_ASR:
-		return simplify_binop(insn);
-
-	case OP_NOT: case OP_NEG: case OP_FNEG:
-		return simplify_unop(insn);
+	case OP_LSR:
+	case OP_ASR:
+	case OP_NOT:
+	case OP_NEG:
+	case OP_DIVU:
+	case OP_DIVS:
+	case OP_MODU:
+	case OP_MODS:
+	case OP_SET_EQ:
+	case OP_SET_NE:
+	case OP_SET_LE:
+	case OP_SET_GE:
+	case OP_SET_LT:
+	case OP_SET_GT:
+	case OP_SET_B:
+	case OP_SET_A:
+	case OP_SET_BE:
+	case OP_SET_AE:
+		break;
 	case OP_LOAD:
 		if (!has_users(insn->target))
 			return kill_instruction(insn);
@@ -1778,6 +1800,7 @@ int simplify_instruction(struct instruction *insn)
 	case OP_SEXT: case OP_ZEXT:
 	case OP_TRUNC:
 		return simplify_cast(insn);
+	case OP_FNEG:
 	case OP_FCVTU: case OP_FCVTS:
 	case OP_UCVTF: case OP_SCVTF:
 	case OP_FCVTF:
-- 
2.28.0

