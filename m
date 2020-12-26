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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60596C433E9
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3819220809
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgLZRwm (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 26 Dec 2020 12:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgLZRwl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 26 Dec 2020 12:52:41 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A7FC061786
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:52:01 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g185so5680021wmf.3
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qJbIGhOqDBsJ5wzt+ehYGeYpOmYaV2Urn+P67g4E58E=;
        b=tVkfOuaZkXgngzgMIiBDUPbvop5qE/4mXXKNS+v1NIuGSHwCcX9kvbKuajXQT3q4Ql
         bZ917LLQl37fVKeN2RpEx1Fhub91ruhGBieSIV6l1hxW+n/hutOoACub/9FNI9J+K8VS
         bNR0XblbIB+V7x/2r8nFH9h0jelc1aLsSA/OLq/oZ0yzR0ywzoVG4MKGULXWSIo622XI
         Fz+qz/YrDWTgPBcyuiW43fJfsTd9QOvhun/viFRLWwvNeH9++YViyL07Jq1u/xzYNBjB
         p6TD0VGewoVhGDL71D1Xp0lsjFfNIA3NiMPKWKgWuGirfyoG9X8Yp9Rg6AEAD1fz8udm
         ZFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qJbIGhOqDBsJ5wzt+ehYGeYpOmYaV2Urn+P67g4E58E=;
        b=YlN7y1crphJ5Si+b9XAtN6fOfw3x8ZvmfgakqJbKzGEoZz4UxMfgl/2tBNoFtUB+9G
         GxTGWo0da4I86OqKKMQWOT2euzb1uqG4f092zctqyYMaCUEELfJ8+lW6pu+BwoPiYkp9
         Ukwqry/bm8Bco/dcsGDJmFSomy/iCJGLrjjVLI14lsFq1Iz3WUDlyX/7/ssde6IK8NFe
         1rvzrK7xbrsdxtTphmX4qmWJzpgL+UfpTreyqLiyIEq4I93DoNBhoFLz5i/GDL88cmei
         qU/jBxTs6lTJfBXC8pOMq+PQrHGNViaxHLB5Nh2uETLpkMKVHX/ElIr60uEeVtY/HxT5
         /2gg==
X-Gm-Message-State: AOAM530AnOWB2ZksAe9xDrFG0ifEPpZd87DsNEABae4Nj6+IC9lkOtHR
        2dUfqowx4dWEzX9ckjx6DObhBxFoaa8=
X-Google-Smtp-Source: ABdhPJxXdpcu/o4W4bLRf4RFMXBTjQjHfU78SQK4C8+BfGeSLc85HefhQSEoEufbOumQ7feJQ/p4lA==
X-Received: by 2002:a1c:4843:: with SMTP id v64mr13260984wma.186.1609005120041;
        Sat, 26 Dec 2020 09:52:00 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:10a5:37c9:8c28:d3e9])
        by smtp.gmail.com with ESMTPSA id c4sm12780813wmf.19.2020.12.26.09.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 09:51:59 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 04/16] add testcases for type attributes
Date:   Sat, 26 Dec 2020 18:51:17 +0100
Message-Id: <20201226175129.9621-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
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
 validation/type-attribute-qual.c  | 12 +++++++++++
 4 files changed, 88 insertions(+)
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
index 000000000000..ab19a605bda1
--- /dev/null
+++ b/validation/type-attribute-qual.c
@@ -0,0 +1,12 @@
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
+ */
-- 
2.29.2

