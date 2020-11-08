Return-Path: <SRS0=7JZe=EO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_75_100,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDB2C55178
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90175208FE
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTrx6/JU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgKHBTs (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 20:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgKHBTs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 20:19:48 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF434C0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 17:19:47 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id o23so7240370ejn.11
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 17:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8gVPXs/rbigDWFwLnam3zKNJjYpp4HrSmOqZCzHuqe0=;
        b=lTrx6/JUP7RmRngGBDca/k6ZngqPpGUy5ZH78mxJlfcB0F8f7fYwrq+JYFDeEZWKf2
         stT6VjQloy4F6s3/s5YDUGEJyVJ/9Cy/SOJJi2OvRN7qIEyM7qYo6obyGjfC0vfYvkKc
         PbVrSoVD4XgO+J8dRUKzHg/yhdtkWjshTgGTki7gX8L7kvAlYOMGTtFhuXWcLvNGL/Rp
         W0QwgMBvpqH3yNgWXkhcbZx06BE/66uDyAGBdRvALczZiS52wvrPE34/PaFuMu2vNtUz
         a6w4L+/EgAwITltforyDEXOe2teqYhZxdBqIYxK5vVBAeMt8zXs4xBUm8TygptII2TvN
         7ahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8gVPXs/rbigDWFwLnam3zKNJjYpp4HrSmOqZCzHuqe0=;
        b=CUqGmFiMPJA+iW80YwjzPeTcNLCJvJDfPTjmzNbBswYamDD4gh6uZD2x4EOfMLqUY6
         P0AQYc2J88he67EdwjcMDWMSv2BpgSEVRc4OZNai64CNq7LzmUsmfD1SFx0nGqvVnixU
         50gSS9UEe08dti8osXqflB77M7iE0l8CO6T7gnydOXYMA5ydw0Jsr/sg4Mpx7ZoBE7hY
         8TvBsCGIQGwHw+SOBkL6qC2dpHyyWX0xWsJQajL2QMBHsi5p+AG7cnbXf4yXqf9bZfwU
         IA9oND3zo75lpDSbSRJMrno9UVEObchTfQuTERKJOU2SqubvPDbhYdZQ6WWUL8OVSnsE
         oc7A==
X-Gm-Message-State: AOAM530TVp7qTR4yzfvG7HlF9tMaOAdy1mlW/RIYwHXA1xrDszjp9AnD
        RCvXMAzL5fY7dDelwctMeJAJlr9Y1ck=
X-Google-Smtp-Source: ABdhPJxeSIbtl9q7jUR34bhGje0USSomRrnpbBnJeD+8AUbU+VXZ4AxlSspCjweFHVFMK0zjWF1kwA==
X-Received: by 2002:a17:906:ec9:: with SMTP id u9mr8794959eji.400.1604798386047;
        Sat, 07 Nov 2020 17:19:46 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:fce6:5cb0:27db:5e8c])
        by smtp.gmail.com with ESMTPSA id t22sm4545127edq.64.2020.11.07.17.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 17:19:45 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 03/16] cmp: add signed/unsigned to opcode table
Date:   Sun,  8 Nov 2020 02:19:33 +0100
Message-Id: <20201108011939.94252-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201108011939.94252-1-luc.vanoostenryck@gmail.com>
References: <20201108011939.94252-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The opcode table allows to efficiently store some properties of
the IR instructions and the correspondence between some of them.

One of these correspondences the 'signed' / 'unsigned' version
of otherwise identical instructions. This is useful for some
transformation of compare instructions but is not present yet
in the table. So, add this now.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 opcode.c   |   3 +-
 opcode.def | 164 ++++++++++++++++++++++++++---------------------------
 opcode.h   |   8 ++-
 3 files changed, 90 insertions(+), 85 deletions(-)

diff --git a/opcode.c b/opcode.c
index 98ad768f8706..0cc7e435ed42 100644
--- a/opcode.c
+++ b/opcode.c
@@ -23,10 +23,11 @@
 #include "opcode.h"
 
 const struct opcode_table opcode_table[OP_LAST] = {
-#define OPCODE(OP,NG,SW,TF,N,FL)	\
+#define OPCODE(OP,NG,SW,SG,TF,N,FL)	\
 	[OP_##OP] = {			\
 		.negate   = OP_##NG,	\
 		.swap     = OP_##SW,	\
+		.sign     = OP_##SG,	\
 		.to_float = OP_##TF,	\
 		.arity    = N,		\
 		.flags    = FL,		\
diff --git a/opcode.def b/opcode.def
index c65722f0b9bb..2627abd4d894 100644
--- a/opcode.def
+++ b/opcode.def
@@ -1,114 +1,114 @@
-//      OPCODE          negated   swaped    float  arity, flags
+//     OPCODE        negated   swaped    sign   float  arity, flags
 
-OPCODE(BADOP,           BADOP,    BADOP,    BADOP, 0, OPF_NONE)
+OPCODE(BADOP,        BADOP,    BADOP,    BADOP, BADOP, 0, OPF_NONE)
 
 /* Entry */
-OPCODE(ENTRY,           BADOP,    BADOP,    BADOP, 0, OPF_NONE)
+OPCODE(ENTRY,        BADOP,    BADOP,    BADOP, BADOP, 0, OPF_NONE)
 
 /* Terminator */
-OPCODE(RET,             BADOP,    BADOP,    BADOP, 1, OPF_NONE)
-OPCODE(BR,              BADOP,    BADOP,    BADOP, 0, OPF_NONE)
-OPCODE(CBR,             BADOP,    BADOP,    BADOP, 1, OPF_NONE)
-OPCODE(SWITCH,          BADOP,    BADOP,    BADOP, 1, OPF_NONE)
-OPCODE(UNREACH,         BADOP,    BADOP,    BADOP, 0, OPF_NONE)
-OPCODE(COMPUTEDGOTO,    BADOP,    BADOP,    BADOP, 1, OPF_NONE)
+OPCODE(RET,          BADOP,    BADOP,    BADOP, BADOP, 1, OPF_NONE)
+OPCODE(BR,           BADOP,    BADOP,    BADOP, BADOP, 0, OPF_NONE)
+OPCODE(CBR,          BADOP,    BADOP,    BADOP, BADOP, 1, OPF_NONE)
+OPCODE(SWITCH,       BADOP,    BADOP,    BADOP, BADOP, 1, OPF_NONE)
+OPCODE(UNREACH,      BADOP,    BADOP,    BADOP, BADOP, 0, OPF_NONE)
+OPCODE(COMPUTEDGOTO, BADOP,    BADOP,    BADOP, BADOP, 1, OPF_NONE)
 OPCODE_RANGE(TERMINATOR, RET, COMPUTEDGOTO)
 
 /* Binary */
-OPCODE(ADD,             BADOP,    BADOP,    FADD,  2, OPF_TARGET|OPF_COMMU|OPF_ASSOC|OPF_BINOP)
-OPCODE(MUL,             BADOP,    BADOP,    FMUL,  2, OPF_TARGET|OPF_COMMU|OPF_ASSOC|OPF_BINOP)
-OPCODE(SUB,             BADOP,    BADOP,    FSUB,  2, OPF_TARGET|OPF_BINOP)
-OPCODE(DIVU,            BADOP,    BADOP,    FDIV,  2, OPF_TARGET|OPF_BINOP)
-OPCODE(DIVS,            BADOP,    BADOP,    FDIV,  2, OPF_TARGET|OPF_BINOP)
-OPCODE(MODU,            BADOP,    BADOP,    BADOP, 2, OPF_TARGET|OPF_BINOP)
-OPCODE(MODS,            BADOP,    BADOP,    BADOP, 2, OPF_TARGET|OPF_BINOP)
-OPCODE(SHL,             BADOP,    BADOP,    BADOP, 2, OPF_TARGET|OPF_BINOP)
-OPCODE(LSR,             BADOP,    BADOP,    BADOP, 2, OPF_TARGET|OPF_BINOP)
-OPCODE(ASR,             BADOP,    BADOP,    BADOP, 2, OPF_TARGET|OPF_BINOP)
+OPCODE(ADD,          BADOP,    BADOP,    BADOP, FADD,  2, OPF_TARGET|OPF_COMMU|OPF_ASSOC|OPF_BINOP)
+OPCODE(MUL,          BADOP,    BADOP,    BADOP, FMUL,  2, OPF_TARGET|OPF_COMMU|OPF_ASSOC|OPF_BINOP)
+OPCODE(SUB,          BADOP,    BADOP,    BADOP, FSUB,  2, OPF_TARGET|OPF_BINOP)
+OPCODE(DIVU,         BADOP,    BADOP,    DIVS,  FDIV,  2, OPF_TARGET|OPF_BINOP)
+OPCODE(DIVS,         BADOP,    BADOP,    DIVU,  FDIV,  2, OPF_TARGET|OPF_BINOP)
+OPCODE(MODU,         BADOP,    BADOP,    MODS,  BADOP, 2, OPF_TARGET|OPF_BINOP)
+OPCODE(MODS,         BADOP,    BADOP,    MODU,  BADOP, 2, OPF_TARGET|OPF_BINOP)
+OPCODE(LSR,          BADOP,    BADOP,    ASR,   BADOP, 2, OPF_TARGET|OPF_BINOP)
+OPCODE(ASR,          BADOP,    BADOP,    LSR,   BADOP, 2, OPF_TARGET|OPF_BINOP)
+OPCODE(SHL,          BADOP,    BADOP,    BADOP, BADOP, 2, OPF_TARGET|OPF_BINOP)
 
 /* Floating-point binops */
-OPCODE(FADD,            BADOP,    BADOP,    BADOP, 2, OPF_TARGET)
-OPCODE(FSUB,            BADOP,    BADOP,    BADOP, 2, OPF_TARGET)
-OPCODE(FMUL,            BADOP,    BADOP,    BADOP, 2, OPF_TARGET)
-OPCODE(FDIV,            BADOP,    BADOP,    BADOP, 2, OPF_TARGET)
+OPCODE(FADD,         BADOP,    BADOP,    BADOP, BADOP, 2, OPF_TARGET)
+OPCODE(FSUB,         BADOP,    BADOP,    BADOP, BADOP, 2, OPF_TARGET)
+OPCODE(FMUL,         BADOP,    BADOP,    BADOP, BADOP, 2, OPF_TARGET)
+OPCODE(FDIV,         BADOP,    BADOP,    BADOP, BADOP, 2, OPF_TARGET)
 
 /* Logical */
-OPCODE(AND,             BADOP,    BADOP,    BADOP, 2, OPF_TARGET|OPF_COMMU|OPF_ASSOC|OPF_BINOP)
-OPCODE(OR,              BADOP,    BADOP,    BADOP, 2, OPF_TARGET|OPF_COMMU|OPF_ASSOC|OPF_BINOP)
-OPCODE(XOR,             BADOP,    BADOP,    BADOP, 2, OPF_TARGET|OPF_COMMU|OPF_ASSOC|OPF_BINOP)
+OPCODE(AND,          BADOP,    BADOP,    BADOP, BADOP, 2, OPF_TARGET|OPF_COMMU|OPF_ASSOC|OPF_BINOP)
+OPCODE(OR,           BADOP,    BADOP,    BADOP, BADOP, 2, OPF_TARGET|OPF_COMMU|OPF_ASSOC|OPF_BINOP)
+OPCODE(XOR,          BADOP,    BADOP,    BADOP, BADOP, 2, OPF_TARGET|OPF_COMMU|OPF_ASSOC|OPF_BINOP)
 OPCODE_RANGE(BINARY, ADD, XOR)
 
 /* floating-point comparison */
-OPCODE(FCMP_ORD,        FCMP_UNO, FCMP_ORD, BADOP, 2, OPF_TARGET)
-OPCODE(FCMP_OEQ,        FCMP_UNE, FCMP_OEQ, BADOP, 2, OPF_TARGET)
-OPCODE(FCMP_ONE,        FCMP_UEQ, FCMP_ONE, BADOP, 2, OPF_TARGET)
-OPCODE(FCMP_UEQ,        FCMP_ONE, FCMP_UEQ, BADOP, 2, OPF_TARGET)
-OPCODE(FCMP_UNE,        FCMP_OEQ, FCMP_UNE, BADOP, 2, OPF_TARGET)
-OPCODE(FCMP_OLT,        FCMP_UGE, FCMP_OGT, BADOP, 2, OPF_TARGET)
-OPCODE(FCMP_OLE,        FCMP_UGT, FCMP_OGE, BADOP, 2, OPF_TARGET)
-OPCODE(FCMP_OGE,        FCMP_ULT, FCMP_OLE, BADOP, 2, OPF_TARGET)
-OPCODE(FCMP_OGT,        FCMP_ULE, FCMP_OLT, BADOP, 2, OPF_TARGET)
-OPCODE(FCMP_ULT,        FCMP_OGE, FCMP_UGT, BADOP, 2, OPF_TARGET)
-OPCODE(FCMP_ULE,        FCMP_OGT, FCMP_UGE, BADOP, 2, OPF_TARGET)
-OPCODE(FCMP_UGE,        FCMP_OLT, FCMP_ULE, BADOP, 2, OPF_TARGET)
-OPCODE(FCMP_UGT,        FCMP_OLE, FCMP_ULT, BADOP, 2, OPF_TARGET)
-OPCODE(FCMP_UNO,        FCMP_ORD, FCMP_UNO, BADOP, 2, OPF_TARGET)
+OPCODE(FCMP_ORD,     FCMP_UNO, FCMP_ORD, BADOP, BADOP, 2, OPF_TARGET)
+OPCODE(FCMP_OEQ,     FCMP_UNE, FCMP_OEQ, BADOP, BADOP, 2, OPF_TARGET)
+OPCODE(FCMP_ONE,     FCMP_UEQ, FCMP_ONE, BADOP, BADOP, 2, OPF_TARGET)
+OPCODE(FCMP_UEQ,     FCMP_ONE, FCMP_UEQ, BADOP, BADOP, 2, OPF_TARGET)
+OPCODE(FCMP_UNE,     FCMP_OEQ, FCMP_UNE, BADOP, BADOP, 2, OPF_TARGET)
+OPCODE(FCMP_OLT,     FCMP_UGE, FCMP_OGT, BADOP, BADOP, 2, OPF_TARGET)
+OPCODE(FCMP_OLE,     FCMP_UGT, FCMP_OGE, BADOP, BADOP, 2, OPF_TARGET)
+OPCODE(FCMP_OGE,     FCMP_ULT, FCMP_OLE, BADOP, BADOP, 2, OPF_TARGET)
+OPCODE(FCMP_OGT,     FCMP_ULE, FCMP_OLT, BADOP, BADOP, 2, OPF_TARGET)
+OPCODE(FCMP_ULT,     FCMP_OGE, FCMP_UGT, BADOP, BADOP, 2, OPF_TARGET)
+OPCODE(FCMP_ULE,     FCMP_OGT, FCMP_UGE, BADOP, BADOP, 2, OPF_TARGET)
+OPCODE(FCMP_UGE,     FCMP_OLT, FCMP_ULE, BADOP, BADOP, 2, OPF_TARGET)
+OPCODE(FCMP_UGT,     FCMP_OLE, FCMP_ULT, BADOP, BADOP, 2, OPF_TARGET)
+OPCODE(FCMP_UNO,     FCMP_ORD, FCMP_UNO, BADOP, BADOP, 2, OPF_TARGET)
 OPCODE_RANGE(FPCMP, FCMP_ORD, FCMP_UNO)
 
 /* Binary comparison */
-OPCODE(SET_EQ,          SET_NE,   SET_EQ,   FCMP_OEQ, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE|OPF_COMMU)
-OPCODE(SET_LT,          SET_GE,   SET_GT,   FCMP_OLT, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE)
-OPCODE(SET_LE,          SET_GT,   SET_GE,   FCMP_OLE, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE)
-OPCODE(SET_GE,          SET_LT,   SET_LE,   FCMP_OGE, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE)
-OPCODE(SET_GT,          SET_LE,   SET_LT,   FCMP_OGT, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE)
-OPCODE(SET_B,           SET_AE,   SET_A,    FCMP_OLT, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE)
-OPCODE(SET_BE,          SET_A,    SET_AE,   FCMP_OLE, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE)
-OPCODE(SET_AE,          SET_B,    SET_BE,   FCMP_OGE, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE)
-OPCODE(SET_A,           SET_BE,   SET_B,    FCMP_OGT, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE)
-OPCODE(SET_NE,          SET_EQ,   SET_NE,   FCMP_UNE, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE|OPF_COMMU)
+OPCODE(SET_EQ,       SET_NE,   SET_EQ,  SET_EQ, FCMP_OEQ, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE|OPF_COMMU)
+OPCODE(SET_LT,       SET_GE,   SET_GT,  SET_B,  FCMP_OLT, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE|OPF_SIGNED)
+OPCODE(SET_LE,       SET_GT,   SET_GE,  SET_BE, FCMP_OLE, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE|OPF_SIGNED)
+OPCODE(SET_GE,       SET_LT,   SET_LE,  SET_AE, FCMP_OGE, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE|OPF_SIGNED)
+OPCODE(SET_GT,       SET_LE,   SET_LT,  SET_A,  FCMP_OGT, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE|OPF_SIGNED)
+OPCODE(SET_B,        SET_AE,   SET_A,   SET_LT, FCMP_OLT, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE|OPF_UNSIGNED)
+OPCODE(SET_BE,       SET_A,    SET_AE,  SET_LE, FCMP_OLE, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE|OPF_UNSIGNED)
+OPCODE(SET_AE,       SET_B,    SET_BE,  SET_GE, FCMP_OGE, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE|OPF_UNSIGNED)
+OPCODE(SET_A,        SET_BE,   SET_B,   SET_GT, FCMP_OGT, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE|OPF_UNSIGNED)
+OPCODE(SET_NE,       SET_EQ,   SET_NE,  SET_NE, FCMP_UNE, 2, OPF_TARGET|OPF_BINOP|OPF_COMPARE|OPF_COMMU)
 OPCODE_RANGE(BINCMP, SET_EQ, SET_NE)
 
 /* Uni */
-OPCODE(NOT,             BADOP,    BADOP,    BADOP, 1, OPF_TARGET|OPF_UNOP)
-OPCODE(NEG,             BADOP,    BADOP,    FNEG,  1, OPF_TARGET|OPF_UNOP)
-OPCODE(FNEG,            BADOP,    BADOP,    BADOP, 1, OPF_TARGET)
-OPCODE(TRUNC,           BADOP,    BADOP,    BADOP, 1, OPF_TARGET)
-OPCODE(ZEXT,            BADOP,    BADOP,    BADOP, 1, OPF_TARGET)
-OPCODE(SEXT,            BADOP,    BADOP,    BADOP, 1, OPF_TARGET)
-OPCODE(FCVTU,           BADOP,    BADOP,    BADOP, 1, OPF_TARGET)
-OPCODE(FCVTS,           BADOP,    BADOP,    BADOP, 1, OPF_TARGET)
-OPCODE(UCVTF,           BADOP,    BADOP,    BADOP, 1, OPF_TARGET)
-OPCODE(SCVTF,           BADOP,    BADOP,    BADOP, 1, OPF_TARGET)
-OPCODE(FCVTF,           BADOP,    BADOP,    BADOP, 1, OPF_TARGET)
-OPCODE(UTPTR,           BADOP,    BADOP,    BADOP, 1, OPF_TARGET)
-OPCODE(PTRTU,           BADOP,    BADOP,    BADOP, 1, OPF_TARGET)
-OPCODE(PTRCAST,         BADOP,    BADOP,    BADOP, 1, OPF_TARGET)
+OPCODE(NOT,          BADOP,    BADOP,    BADOP, BADOP, 1, OPF_TARGET|OPF_UNOP)
+OPCODE(NEG,          BADOP,    BADOP,    BADOP, FNEG,  1, OPF_TARGET|OPF_UNOP)
+OPCODE(FNEG,         BADOP,    BADOP,    BADOP, BADOP, 1, OPF_TARGET)
+OPCODE(TRUNC,        BADOP,    BADOP,    BADOP, BADOP, 1, OPF_TARGET)
+OPCODE(ZEXT,         BADOP,    BADOP,    SEXT,  BADOP, 1, OPF_TARGET)
+OPCODE(SEXT,         BADOP,    BADOP,    ZEXT,  BADOP, 1, OPF_TARGET)
+OPCODE(FCVTU,        BADOP,    BADOP,    FCVTS, BADOP, 1, OPF_TARGET)
+OPCODE(FCVTS,        BADOP,    BADOP,    FCVTU, BADOP, 1, OPF_TARGET)
+OPCODE(UCVTF,        BADOP,    BADOP,    SCVTF, BADOP, 1, OPF_TARGET)
+OPCODE(SCVTF,        BADOP,    BADOP,    UCVTF, BADOP, 1, OPF_TARGET)
+OPCODE(FCVTF,        BADOP,    BADOP,    BADOP, BADOP, 1, OPF_TARGET)
+OPCODE(UTPTR,        BADOP,    BADOP,    BADOP, BADOP, 1, OPF_TARGET)
+OPCODE(PTRTU,        BADOP,    BADOP,    BADOP, BADOP, 1, OPF_TARGET)
+OPCODE(PTRCAST,      BADOP,    BADOP,    BADOP, BADOP, 1, OPF_TARGET)
 OPCODE_RANGE(UNOP, NOT, PTRCAST)
-OPCODE(SYMADDR,         BADOP,    BADOP,    BADOP, 1, OPF_TARGET)
-OPCODE(SLICE,           BADOP,    BADOP,    BADOP, 1, OPF_TARGET)
+OPCODE(SYMADDR,      BADOP,    BADOP,    BADOP, BADOP, 1, OPF_TARGET)
+OPCODE(SLICE,        BADOP,    BADOP,    BADOP, BADOP, 1, OPF_TARGET)
 
 /* Select - three input values */
-OPCODE(SEL,             BADOP,    BADOP,    BADOP, 3, OPF_TARGET)
-OPCODE(FMADD,           BADOP,    BADOP,    BADOP, 3, OPF_TARGET)
+OPCODE(SEL,          BADOP,    BADOP,    BADOP, BADOP, 3, OPF_TARGET)
+OPCODE(FMADD,        BADOP,    BADOP,    BADOP, BADOP, 3, OPF_TARGET)
 
 /* Memory */
-OPCODE(LOAD,            BADOP,    BADOP,    BADOP, 1, OPF_TARGET)
-OPCODE(STORE,           BADOP,    BADOP,    BADOP, 1, OPF_NONE)
+OPCODE(LOAD,         BADOP,    BADOP,    BADOP, BADOP, 1, OPF_TARGET)
+OPCODE(STORE,        BADOP,    BADOP,    BADOP, BADOP, 1, OPF_NONE)
 
 /* Other */
-OPCODE(PHISOURCE,       BADOP,    BADOP,    BADOP, 1, OPF_TARGET)
-OPCODE(PHI,             BADOP,    BADOP,    BADOP, 0, OPF_TARGET)
-OPCODE(SETVAL,          BADOP,    BADOP,    BADOP, 0, OPF_TARGET)
-OPCODE(SETFVAL,         BADOP,    BADOP,    BADOP, 0, OPF_TARGET)
-OPCODE(CALL,            BADOP,    BADOP,    BADOP, 1, OPF_TARGET)
-OPCODE(INLINED_CALL,    BADOP,    BADOP,    BADOP, 0, OPF_NONE)
-OPCODE(NOP,             BADOP,    BADOP,    BADOP, 0, OPF_NONE)
-OPCODE(DEATHNOTE,       BADOP,    BADOP,    BADOP, 0, OPF_NONE)
-OPCODE(ASM,             BADOP,    BADOP,    BADOP, 0, OPF_NONE)
+OPCODE(PHISOURCE,    BADOP,    BADOP,    BADOP, BADOP, 1, OPF_TARGET)
+OPCODE(PHI,          BADOP,    BADOP,    BADOP, BADOP, 0, OPF_TARGET)
+OPCODE(SETVAL,       BADOP,    BADOP,    BADOP, BADOP, 0, OPF_TARGET)
+OPCODE(SETFVAL,      BADOP,    BADOP,    BADOP, BADOP, 0, OPF_TARGET)
+OPCODE(CALL,         BADOP,    BADOP,    BADOP, BADOP, 1, OPF_TARGET)
+OPCODE(INLINED_CALL, BADOP,    BADOP,    BADOP, BADOP, 0, OPF_NONE)
+OPCODE(NOP,          BADOP,    BADOP,    BADOP, BADOP, 0, OPF_NONE)
+OPCODE(DEATHNOTE,    BADOP,    BADOP,    BADOP, BADOP, 0, OPF_NONE)
+OPCODE(ASM,          BADOP,    BADOP,    BADOP, BADOP, 0, OPF_NONE)
 
 /* Sparse tagging (line numbers, context, whatever) */
-OPCODE(CONTEXT,         BADOP,    BADOP,    BADOP, 0, OPF_NONE)
-OPCODE(RANGE,           BADOP,    BADOP,    BADOP, 3, OPF_NONE)
+OPCODE(CONTEXT,      BADOP,    BADOP,    BADOP, BADOP, 0, OPF_NONE)
+OPCODE(RANGE,        BADOP,    BADOP,    BADOP, BADOP, 3, OPF_NONE)
 
 /* Needed to translate SSA back to normal form */
-OPCODE(COPY,            BADOP,    BADOP,    BADOP, 1, OPF_TARGET)
+OPCODE(COPY,         BADOP,    BADOP,    BADOP, BADOP, 1, OPF_TARGET)
diff --git a/opcode.h b/opcode.h
index bb94ec81c832..1524272f0320 100644
--- a/opcode.h
+++ b/opcode.h
@@ -4,7 +4,7 @@
 #include "symbol.h"
 
 enum opcode {
-#define OPCODE(OP,NG,SW,TF,N,FL)  OP_##OP,
+#define OPCODE(OP,NG,SW,SG,TF,N,FL)  OP_##OP,
 #define OPCODE_RANGE(OP,S,E)	OP_##OP = OP_##S, OP_##OP##_END = OP_##E,
 #include "opcode.def"
 #undef  OPCODE
@@ -15,9 +15,11 @@ enum opcode {
 extern const struct opcode_table {
 	int	negate:8;
 	int	swap:8;
+	int	sign:8;
 	int	to_float:8;
 	unsigned int arity:2;
-	unsigned int flags:6;
+	unsigned int :6;
+	unsigned int flags:8;
 #define			OPF_NONE	0
 #define			OPF_TARGET	(1 << 0)
 #define			OPF_COMMU	(1 << 1)
@@ -25,6 +27,8 @@ extern const struct opcode_table {
 #define			OPF_UNOP	(1 << 3)
 #define			OPF_BINOP	(1 << 4)
 #define			OPF_COMPARE	(1 << 5)
+#define			OPF_SIGNED	(1 << 6)
+#define			OPF_UNSIGNED	(1 << 7)
 } opcode_table[];
 
 
-- 
2.29.2

