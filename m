Return-Path: <SRS0=6y8R=D2=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D1CC433E7
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 18:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A9E9223BF
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 18:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuU6xsvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbgJSSsR (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 19 Oct 2020 14:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbgJSSsR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 19 Oct 2020 14:48:17 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1223C0613CE
        for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2020 11:48:16 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id o18so396346edq.4
        for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2020 11:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S584xrZeegmRgyqUZfujA13hS7WFqfk/Ga3xSQToWHk=;
        b=SuU6xsvNyJZXGPnQ2sIAww9hfZl4Of7c1nepZw33cyl1rro6ZddxF2PApdcmgBRRd3
         xCMpc1ViI1LRw5cypKvwe7iPZDFo8yfO+PrWyX4X58GDvOEO28ahbzlJW7rH0esceabt
         ohBUVWcW3NWhb3CftgbpnOBt2/YjyztLtFJs07T09CIgi8/Obm49GRgtJ8OMITzxZWr/
         WpdHSOumNzLFchfvJxXcMrQNn7JVlwfd/pM657k3y2ps0fGC4f+qLS9sxMNl5hLSG6C2
         KjgOy1DFH6w45wLHpciQlcEne+CuUF7jER22TtaRBC6YzVu5dU5dbggDu/yBRxJBDRtt
         LRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S584xrZeegmRgyqUZfujA13hS7WFqfk/Ga3xSQToWHk=;
        b=PgB5TChF/9h+u8MqGUkRLBAIumS+MKHCtOS/+x7E54Pvf+e2/8E5ZDw6gvdJJNJ2bR
         9puXaEv6GD0J2Fj2Oj5RmFw18gCBuMkRo+LLVildcAXRYs/P0Og/dCXo2zOrVR7WAO3j
         hzJI8cotytk1+QRSM3Gnjw7aSnVguxGjKs7Mj0J0gs+YpMzSBC+YQa8ydfKpWfMttF97
         1Fgngh6p/r4d4gSWzhhC4MzRT8NTYptaj+TdayB56STw/TtbVTytnbd/klBeOCxoccAq
         mqLLTBSQBGwSUqCS8HmYeOEEnZHG6SF98CWGWNLJHBQQiQ79/p45fxvy9S8aMZ4LeraK
         0vdw==
X-Gm-Message-State: AOAM531GtHk09c8hS4/Bx3fUOo8rtvvtDhNA2TuwodrZCLhtCe39OgnF
        XslLnUllasSs2/96CWLn84jBdcgdSIk=
X-Google-Smtp-Source: ABdhPJzlJoVaSJcfAYcUj9HqIl8OGxhLONJMxa1wlT6KZK6kY6KMSWvKenXev6i6PyEuJ4OsZbYblw==
X-Received: by 2002:aa7:dcd6:: with SMTP id w22mr1238602edu.378.1603133295140;
        Mon, 19 Oct 2020 11:48:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:7864:d3ae:24fc:dd60])
        by smtp.gmail.com with ESMTPSA id z22sm995231ejw.107.2020.10.19.11.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 11:48:14 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] teach sparse about -funsigned-bitfields
Date:   Mon, 19 Oct 2020 20:48:10 +0200
Message-Id: <20201019184810.35557-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Currently, Sparse treats 'plain' bitfields as unsigned.

However, this is this is inconsistent with how non-bitfield integers
are handled and with how GCC & clang handle bitfields.

So, teach sparse about '-funsigned-bitfields' and by default treat
these bitfields are signed, like done by GCC & clang and like done
for non-bitfield integers.

Also, avoid plain bitfields in IR related testcases.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 options.c                                  |  3 +++
 options.h                                  |  1 +
 sparse.1                                   |  6 ++++++
 symbol.c                                   |  4 ++--
 validation/linear/bitfield-sign-default.c  | 13 +++++++++++++
 validation/linear/bitfield-sign-signed.c   | 13 +++++++++++++
 validation/linear/bitfield-sign-unsigned.c | 13 +++++++++++++
 validation/linear/bitfield-size.c          | 10 +++++-----
 validation/optim/bitfield-size.c           | 15 ++-------------
 validation/optim/bitfield-store-loads.c    |  4 ++--
 10 files changed, 60 insertions(+), 22 deletions(-)
 create mode 100644 validation/linear/bitfield-sign-default.c
 create mode 100644 validation/linear/bitfield-sign-signed.c
 create mode 100644 validation/linear/bitfield-sign-unsigned.c

diff --git a/options.c b/options.c
index 294dfd3be77a..a12d28669e05 100644
--- a/options.c
+++ b/options.c
@@ -81,6 +81,7 @@ unsigned long fpasses = ~0UL;
 int fpic = 0;
 int fpie = 0;
 int fshort_wchar = 0;
+int funsigned_bitfields = 0;
 int funsigned_char = 0;
 
 int Waddress = 0;
@@ -524,6 +525,8 @@ static struct flag fflags[] = {
 	{ "PIC",		&fpic,	handle_switch_setval, 2 },
 	{ "pie",		&fpie,	handle_switch_setval, 1 },
 	{ "PIE",		&fpie,	handle_switch_setval, 2 },
+	{ "signed-bitfields",	&funsigned_bitfields, NULL, OPT_INVERSE },
+	{ "unsigned-bitfields",	&funsigned_bitfields, NULL, },
 	{ "signed-char",	&funsigned_char, NULL,	OPT_INVERSE },
 	{ "short-wchar",	&fshort_wchar },
 	{ "unsigned-char",	&funsigned_char, NULL, },
diff --git a/options.h b/options.h
index abdf08645ad2..8e3071a755be 100644
--- a/options.h
+++ b/options.h
@@ -80,6 +80,7 @@ extern unsigned long fpasses;
 extern int fpic;
 extern int fpie;
 extern int fshort_wchar;
+extern int funsigned_bitfields;
 extern int funsigned_char;
 
 extern int Waddress;
diff --git a/sparse.1 b/sparse.1
index 48dab7a9a5c1..2a8eb1249da1 100644
--- a/sparse.1
+++ b/sparse.1
@@ -518,6 +518,12 @@ column numbers in warnings or errors.  If the value is less than 1 or
 greater than 100, the option is ignored.  The default is 8.
 .
 .TP
+.B \-f[no-]unsigned-bitfields, \-f[no-]signed-bitfields
+Determine the signedness of bitfields declared without an
+explicit sign ('signed' or 'unsigned').
+By default such bitfields are signed, like others plain integers.
+.
+.TP
 .B \-f[no-]unsigned-char, \-f[no-]signed-char
 Let plain 'char' be unsigned or signed.
 By default chars are signed.
diff --git a/symbol.c b/symbol.c
index 7f0c85580f06..aaeb8c100436 100644
--- a/symbol.c
+++ b/symbol.c
@@ -286,8 +286,8 @@ static struct symbol *examine_bitfield_type(struct symbol *sym)
 		sym->ctype.alignment = alignment;
 	modifiers = base_type->ctype.modifiers;
 
-	/* Bitfields are unsigned, unless the base type was explicitly signed */
-	if (!(modifiers & MOD_EXPLICITLY_SIGNED))
+	/* use -funsigned-bitfields to determine the sign if not explicit */
+	if (!(modifiers & MOD_EXPLICITLY_SIGNED) && funsigned_bitfields)
 		modifiers = (modifiers & ~MOD_SIGNED) | MOD_UNSIGNED;
 	sym->ctype.modifiers |= modifiers & MOD_SIGNEDNESS;
 	return sym;
diff --git a/validation/linear/bitfield-sign-default.c b/validation/linear/bitfield-sign-default.c
new file mode 100644
index 000000000000..9a2854e63c47
--- /dev/null
+++ b/validation/linear/bitfield-sign-default.c
@@ -0,0 +1,13 @@
+struct s {
+	int f:2;
+};
+
+static int getf(struct s s) { return s.f; }
+
+/*
+ * check-name: bitfield-sign-default
+ * check-command: test-linearize -fdump-ir=linearize $file
+ *
+ * check-output-ignore
+ * check-output-contains: sext\\.
+ */
diff --git a/validation/linear/bitfield-sign-signed.c b/validation/linear/bitfield-sign-signed.c
new file mode 100644
index 000000000000..59a07cebebc7
--- /dev/null
+++ b/validation/linear/bitfield-sign-signed.c
@@ -0,0 +1,13 @@
+struct s {
+	int f:2;
+};
+
+static int getf(struct s s) { return s.f; }
+
+/*
+ * check-name: bitfield-sign-signed
+ * check-command: test-linearize -fdump-ir=linearize -fsigned-bitfields $file
+ *
+ * check-output-ignore
+ * check-output-contains: sext\\.
+ */
diff --git a/validation/linear/bitfield-sign-unsigned.c b/validation/linear/bitfield-sign-unsigned.c
new file mode 100644
index 000000000000..099edaad979a
--- /dev/null
+++ b/validation/linear/bitfield-sign-unsigned.c
@@ -0,0 +1,13 @@
+struct s {
+	int f:2;
+};
+
+static int getf(struct s s) { return s.f; }
+
+/*
+ * check-name: bitfield-sign-unsigned
+ * check-command: test-linearize -fdump-ir=linearize -funsigned-bitfields $file
+ *
+ * check-output-ignore
+ * check-output-contains: zext\\.
+ */
diff --git a/validation/linear/bitfield-size.c b/validation/linear/bitfield-size.c
index dcda930dc510..719b0ab85fcc 100644
--- a/validation/linear/bitfield-size.c
+++ b/validation/linear/bitfield-size.c
@@ -19,7 +19,7 @@ void ucpy(struct u *d, const struct u *s)
 
 
 struct s {
-	int f:3;
+	signed int f:3;
 };
 
 int spostinc(struct s *x)
@@ -118,7 +118,7 @@ spostinc:
 	load.64     %r33 <- 0[x]
 	load.32     %r34 <- 0[%r33]
 	trunc.3     %r35 <- (32) %r34
-	zext.32     %r36 <- (3) %r35
+	sext.32     %r36 <- (3) %r35
 	add.32      %r37 <- %r36, $1
 	trunc.3     %r38 <- (32) %r37
 	load.32     %r39 <- 0[%r33]
@@ -126,7 +126,7 @@ spostinc:
 	and.32      %r41 <- %r39, $0xfffffff8
 	or.32       %r42 <- %r41, %r40
 	store.32    %r42 -> 0[%r33]
-	zext.32     %r43 <- (3) %r36
+	sext.32     %r43 <- (3) %r36
 	phisrc.32   %phi3(return) <- %r43
 	br          .L7
 
@@ -142,7 +142,7 @@ spreinc:
 	load.64     %r45 <- 0[x]
 	load.32     %r46 <- 0[%r45]
 	trunc.3     %r47 <- (32) %r46
-	zext.32     %r48 <- (3) %r47
+	sext.32     %r48 <- (3) %r47
 	add.32      %r49 <- %r48, $1
 	trunc.3     %r50 <- (32) %r49
 	load.32     %r51 <- 0[%r45]
@@ -150,7 +150,7 @@ spreinc:
 	and.32      %r53 <- %r51, $0xfffffff8
 	or.32       %r54 <- %r53, %r52
 	store.32    %r54 -> 0[%r45]
-	zext.32     %r55 <- (3) %r50
+	sext.32     %r55 <- (3) %r50
 	phisrc.32   %phi4(return) <- %r55
 	br          .L9
 
diff --git a/validation/optim/bitfield-size.c b/validation/optim/bitfield-size.c
index 0d2deeeac2dd..ea1ed57fb8fe 100644
--- a/validation/optim/bitfield-size.c
+++ b/validation/optim/bitfield-size.c
@@ -19,17 +19,6 @@ signed int get__bfs_b(struct bfs bf) { return bf.b; }
 signed int get_pbfs_a(struct bfs *bf) { return bf->a; }
 signed int get_pbfs_b(struct bfs *bf) { return bf->b; }
 
-
-struct bfi {
-	int a:4;
-	int  :2;
-	int b:4;
-};
-unsigned int get__bfi_a(struct bfi bf) { return bf.a; }
-unsigned int get__bfi_b(struct bfi bf) { return bf.b; }
-unsigned int get_pbfi_a(struct bfi *bf) { return bf->a; }
-unsigned int get_pbfi_b(struct bfi *bf) { return bf->b; }
-
 /*
  * check-name: bitfield size
  * check-command: test-linearize -Wno-decl $file
@@ -37,8 +26,8 @@ unsigned int get_pbfi_b(struct bfi *bf) { return bf->b; }
  *
  * check-output-excludes: and\\..*\\$960
  * check-output-excludes: zext\\.
- * check-output-pattern(8): and\\..*\\$15
+ * check-output-pattern(4): and\\..*\\$15
  * check-output-pattern(4): sext\\.
  * check-output-pattern(4): trunc\\.4
- * check-output-pattern(6): lsr\\..*\\$6
+ * check-output-pattern(4): lsr\\..*\\$6
  */
diff --git a/validation/optim/bitfield-store-loads.c b/validation/optim/bitfield-store-loads.c
index dc625131e188..f946715bffa3 100644
--- a/validation/optim/bitfield-store-loads.c
+++ b/validation/optim/bitfield-store-loads.c
@@ -1,6 +1,6 @@
 struct s {
-	char :2;
-	char f:3;
+	unsigned char :2;
+	unsigned char f:3;
 };
 
 int foo(struct s s, int a)
-- 
2.28.0

