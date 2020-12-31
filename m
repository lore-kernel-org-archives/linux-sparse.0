Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60BDC43381
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94339207A3
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgLaKLZ (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 31 Dec 2020 05:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgLaKLZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Dec 2020 05:11:25 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D9EC06179C
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:44 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id w5so19682270wrm.11
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mf7zjX5KmM5k3fF3eJhd5hveKy9U4QqMRckHW+fXhmI=;
        b=NieNwFR6k0VBr1tWDHAMNpTht6QmK99f9QunsQLOwGPQbIXxQIcX5EggDSfLh8WEnE
         Q/YN6xRYBVfjxx48ZwI46SGSqaIkKlDBVfKwGD2a58ed6FipPYiAiVwMAlbTA+ufFTm3
         d7GG9Te+MoNVeybzYzx6Ovbp5rIzM0esP5r/CX0fQ5b074VAgYE9XWth0lh9qD5D6uBQ
         gWIxHwLdkhQZqR1sKrqLneZV90h/i6qHCDM9YGyNaT0Xe2vcxk59DqON8XFl9EwGhUg1
         mKctSoyH+0gflFiAGU1ofO1TarO2rGDJSz0qxZpPsKYdn+JI/kV1L1Wm5PlHgQIuSzIf
         6XIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mf7zjX5KmM5k3fF3eJhd5hveKy9U4QqMRckHW+fXhmI=;
        b=rG9mk9arGnTikDv+0cp1lmnpwWlc5Fk5v8P4+Qffih30Ch07jbfdB+47bGgiWmI+Y3
         i4Kn1VfECjp3evQprlYZHzTQeAtyELwSSNfsuFcuYloB6NWzVs5wxLXarI463sf79tIY
         HM+4PkVmDxynsnNFhWRPgK83bSHfkvgPOiwRqwtBItdaRBdKswnNBqELZht+qf0288PH
         sIbkmvQ0+ZoO0rjh+Zd5fSoYyds3cQ1a5C9f/i53gQPJkCifI7HmKgDIrAAqX1c/rQRG
         hSO5fKgp003MpW2kW5QQl5o2XBGTB1oNKxgFTZJ+Tl027JsaCviMaq+yIGpqlDXMptVu
         eU5Q==
X-Gm-Message-State: AOAM530VdLhALtw2V8E5el9I2ZF1UJh0hNCTBhqmFq4h2hM5FmWx7kL9
        +ct9HFAOiHB8IpCbyQHz1RPxB9iosxg=
X-Google-Smtp-Source: ABdhPJxSn7YwivmxWUPpwrde/qcM8ghYHoCwbEtqkyWHCY5ZinsvFjoNe4a00TJlXeQI6qd/w3N6Fg==
X-Received: by 2002:a05:6000:1152:: with SMTP id d18mr64443132wrx.6.1609409443453;
        Thu, 31 Dec 2020 02:10:43 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:7c8c:1eb2:47fd:b5e7])
        by smtp.gmail.com with ESMTPSA id n3sm66161019wrw.61.2020.12.31.02.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 02:10:42 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 04/16] add testcases for type attributes
Date:   Thu, 31 Dec 2020 11:10:22 +0100
Message-Id: <20201231101034.59978-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
References: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Currently, type attributes are not handled correctly.

Add some testcases for them.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/type-attribute-align.c | 20 ++++++++++++++++++
 validation/type-attribute-as.c    | 34 +++++++++++++++++++++++++++++++
 validation/type-attribute-mod.c   | 22 ++++++++++++++++++++
 validation/type-attribute-qual.c  | 15 ++++++++++++++
 4 files changed, 91 insertions(+)
 create mode 100644 validation/type-attribute-align.c
 create mode 100644 validation/type-attribute-as.c
 create mode 100644 validation/type-attribute-mod.c
 create mode 100644 validation/type-attribute-qual.c

diff --git a/validation/type-attribute-align.c b/validation/type-attribute-align.c
new file mode 100644
index 000000000000..d9358bff8327
--- /dev/null
+++ b/validation/type-attribute-align.c
@@ -0,0 +1,20 @@
+#define __aligned(N)	__attribute__((aligned(N)))
+#define alignof(X)	__alignof__(X)
+
+struct s {
+	short a, b, c;
+} __aligned(2*sizeof(short));
+
+static int fs(void) { return  sizeof(struct s); }
+static int fa(void) { return alignof(struct s); }
+
+void main(void)
+{
+	_Static_assert( sizeof(struct s) == 4 * sizeof(short), "size");
+	_Static_assert(alignof(struct s) == 2 * sizeof(short), "alignment");
+}
+
+/*
+ * check-name: type-attribute-align
+ * check-known-to-fail
+ */
diff --git a/validation/type-attribute-as.c b/validation/type-attribute-as.c
new file mode 100644
index 000000000000..b40b4e7dddf5
--- /dev/null
+++ b/validation/type-attribute-as.c
@@ -0,0 +1,34 @@
+#define	__as		__attribute__((address_space(__as)))
+
+struct s {
+	int i;
+} __as;
+
+
+extern void use0(void *);
+extern void use1(void __as *);
+
+void main(void)
+{
+	struct s s;
+	int i;
+
+	use0(&s);	// KO
+	use0(&i);	// OK
+	use1(&s);	// OK
+	use1(&i);	// KO
+}
+
+/*
+ * check-name: type-attribute-as
+ * check-known-to-fail
+ *
+ * check-error-start
+type-attribute-as.c:16:15: warning: incorrect type in argument 1 (different address spaces)
+type-attribute-as.c:16:15:    expected void *
+type-attribute-as.c:16:15:    got struct s __as *
+type-attribute-as.c:19:15: warning: incorrect type in argument 1 (different address spaces)
+type-attribute-as.c:19:15:    expected void __as *
+type-attribute-as.c:19:15:    got int *
+ * check-error-end
+ */
diff --git a/validation/type-attribute-mod.c b/validation/type-attribute-mod.c
new file mode 100644
index 000000000000..0e7b166a4aec
--- /dev/null
+++ b/validation/type-attribute-mod.c
@@ -0,0 +1,22 @@
+#define	__noderef	__attribute__((noderef))
+
+struct s {
+	int i;
+} __noderef;
+
+
+void main(void)
+{
+	struct s s;
+
+	s.i = 0;
+}
+
+/*
+ * check-name: type-attribute-mod
+ * check-known-to-fail
+ *
+ * check-error-start
+type-attribute-mod.c:12:9: warning: dereference of noderef expression
+ * check-error-end
+ */
diff --git a/validation/type-attribute-qual.c b/validation/type-attribute-qual.c
new file mode 100644
index 000000000000..62d8b98ee3df
--- /dev/null
+++ b/validation/type-attribute-qual.c
@@ -0,0 +1,15 @@
+static const struct s {
+	int x;
+} map[2];
+
+static void foo(struct s *p, int v)
+{
+	p->x += v;
+}
+
+/*
+ * check-name: type-attribute-qual
+ * check-description: When declaring a type and a variable in the same
+ *	declaration, ensure that type qualifiers apply to the variable
+ *	and not to the type.
+ */
-- 
2.29.2

