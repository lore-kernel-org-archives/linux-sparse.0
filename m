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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F390C63798
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 16:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4C4320795
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 16:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCU/iwDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbgK0QwB (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 27 Nov 2020 11:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732128AbgK0QwB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Nov 2020 11:52:01 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78E5C0613D1
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 08:52:00 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r3so6260472wrt.2
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 08:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/3e9FMMFTb5bWEGpkd883UgRKrevSAneF3JDDaXlA4=;
        b=fCU/iwDgXNoyVIX0G2qoo/T2Bc5B2RAKFNt4j+1GO6z5+yIaHdGm42gkxb6czRnEm/
         +m3GCirASrcmY50MVEuPrMCB8YgM4JRZiFTF2V7CAmOSkUhXT7Wi/f6Q9jjIDYanpSQ8
         vI9E2GLYi7zCQaj/rb+3r1BvQP+HZ9W6lotKuyY/xSbCdM5PaFxo4mp6GskRnlqzHbcV
         JnY4CDCHDYDthMb8P6oAY88NUBDAyD64cz2pJcYKFphEs+W1OIkh6KMy72Z7MRMTIGub
         +gJYy7ZCfg84rRflDWpxXTk1I25o2B7HBVo+nb+wtcLYPi0iup91c0WJeiybu6Dmf3u+
         BDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/3e9FMMFTb5bWEGpkd883UgRKrevSAneF3JDDaXlA4=;
        b=ab5s1JiQJo8isa5X+47tny2yzjO84G02wGhuDDjMfi9YbeiNfEZ7n/OX54XE18/RMD
         sqcixjt9moTZ6SvRWE8brl6PIn8nmZuqaw03+4DkGGHY8BBpRYRqULjTJGGRxhAqCgN7
         QBeGWi0dhe7d4UY38YMiySIkK9vmkLDj1BeumL6mkeq10+caH5Tp7hbl1pJwGdhtLlto
         Yo4W/aRxTgxsuDtcmO3p3R1cyYHxIvF611o8YT0ZqN3RCqJ6xO3eZofYwH8QCSTCmpNo
         D1W2tgApB9zVFFwbo5xJCI+ntoP9aINApNE672AH/H3WPvSvqJhx4/rZTMQOmht2rROm
         pMWQ==
X-Gm-Message-State: AOAM533piPcSX0iEK1zlixarm4DfPvfDTQm1CzWmac4CMosu0izkTQXe
        508fV2UOF3umvePYf7wb2uIJPhFNLU8=
X-Google-Smtp-Source: ABdhPJxG72WumXCu2Qpd9EDgeAK6ux+HJjs41jxX7BfJJ9HUquUNBlxEY26pancACLXREBRTZJyjUw==
X-Received: by 2002:adf:e502:: with SMTP id j2mr11748516wrm.73.1606495919302;
        Fri, 27 Nov 2020 08:51:59 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:e9bd:38ae:745f:40ea])
        by smtp.gmail.com with ESMTPSA id y2sm15895539wrn.31.2020.11.27.08.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 08:51:58 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/8] add testscases for some factorization of distributive operations
Date:   Fri, 27 Nov 2020 17:49:43 +0100
Message-Id: <20201127164950.41517-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127164950.41517-1-luc.vanoostenryck@gmail.com>
References: <20201127164950.41517-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Add some testcases for factorizations of:
	(x * z) + (y * z) --> (x + y) * z
	(x | z) & (y | z) --> (x & y) | z
	(x & z) | (y & z) --> (x | y) & z
	(x & z) ^ (y & z) --> (x ^ y) & z
and
	(x << s) | (y << s) --> ((x | y) << s)
	and same for &, ^, LSR and ASR.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/fact-add-mul.c   | 28 ++++++++++++++++++++++++++++
 validation/optim/fact-and-ior.c   | 28 ++++++++++++++++++++++++++++
 validation/optim/fact-and-shift.c | 27 +++++++++++++++++++++++++++
 validation/optim/fact-ior-and.c   | 28 ++++++++++++++++++++++++++++
 validation/optim/fact-ior-shift.c | 27 +++++++++++++++++++++++++++
 validation/optim/fact-xor-and.c   | 28 ++++++++++++++++++++++++++++
 validation/optim/fact-xor-shift.c | 27 +++++++++++++++++++++++++++
 7 files changed, 193 insertions(+)
 create mode 100644 validation/optim/fact-add-mul.c
 create mode 100644 validation/optim/fact-and-ior.c
 create mode 100644 validation/optim/fact-and-shift.c
 create mode 100644 validation/optim/fact-ior-and.c
 create mode 100644 validation/optim/fact-ior-shift.c
 create mode 100644 validation/optim/fact-xor-and.c
 create mode 100644 validation/optim/fact-xor-shift.c

diff --git a/validation/optim/fact-add-mul.c b/validation/optim/fact-add-mul.c
new file mode 100644
index 000000000000..48c3d656accc
--- /dev/null
+++ b/validation/optim/fact-add-mul.c
@@ -0,0 +1,28 @@
+int fr_abx(int a, int b, int x) { return ((a * x) + (b * x)) == ((a + b) * x); }
+int fl_abx(int a, int b, int x) { return ((x * a) + (x * b)) == ((a + b) * x); }
+int fm_abx(int a, int b, int x) { return ((a * x) + (x * b)) == ((a + b) * x); }
+int fn_abx(int a, int b, int x) { return ((x * a) + (b * x)) == ((a + b) * x); }
+
+int fr_bax(int b, int a, int x) { return ((a * x) + (b * x)) == ((b + a) * x); }
+int fl_bax(int b, int a, int x) { return ((x * a) + (x * b)) == ((b + a) * x); }
+int fm_bax(int b, int a, int x) { return ((a * x) + (x * b)) == ((b + a) * x); }
+int fn_bax(int b, int a, int x) { return ((x * a) + (b * x)) == ((b + a) * x); }
+
+int fr_axb(int a, int x, int b) { return ((a * x) + (b * x)) == ((a + b) * x); }
+int fl_axb(int a, int x, int b) { return ((x * a) + (x * b)) == ((a + b) * x); }
+int fm_axb(int a, int x, int b) { return ((a * x) + (x * b)) == ((a + b) * x); }
+int fn_axb(int a, int x, int b) { return ((x * a) + (b * x)) == ((a + b) * x); }
+
+int fr_bxa(int b, int x, int a) { return ((b * x) + (a * x)) == ((b + a) * x); }
+int fl_bxa(int b, int x, int a) { return ((x * b) + (x * a)) == ((b + a) * x); }
+int fm_bxa(int b, int x, int a) { return ((b * x) + (x * a)) == ((b + a) * x); }
+int fn_bxa(int b, int x, int a) { return ((x * b) + (a * x)) == ((b + a) * x); }
+
+/*
+ * check-name: fact-add-mul
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/fact-and-ior.c b/validation/optim/fact-and-ior.c
new file mode 100644
index 000000000000..f2a78eddf41d
--- /dev/null
+++ b/validation/optim/fact-and-ior.c
@@ -0,0 +1,28 @@
+int fr_abx(int a, int b, int x) { return ((a | x) & (b | x)) == ((a & b) | x); }
+int fl_abx(int a, int b, int x) { return ((x | a) & (x | b)) == ((a & b) | x); }
+int fm_abx(int a, int b, int x) { return ((a | x) & (x | b)) == ((a & b) | x); }
+int fn_abx(int a, int b, int x) { return ((x | a) & (b | x)) == ((a & b) | x); }
+
+int fr_bax(int b, int a, int x) { return ((a | x) & (b | x)) == ((b & a) | x); }
+int fl_bax(int b, int a, int x) { return ((x | a) & (x | b)) == ((b & a) | x); }
+int fm_bax(int b, int a, int x) { return ((a | x) & (x | b)) == ((b & a) | x); }
+int fn_bax(int b, int a, int x) { return ((x | a) & (b | x)) == ((b & a) | x); }
+
+int fr_axb(int a, int x, int b) { return ((a | x) & (b | x)) == ((a & b) | x); }
+int fl_axb(int a, int x, int b) { return ((x | a) & (x | b)) == ((a & b) | x); }
+int fm_axb(int a, int x, int b) { return ((a | x) & (x | b)) == ((a & b) | x); }
+int fn_axb(int a, int x, int b) { return ((x | a) & (b | x)) == ((a & b) | x); }
+
+int fr_bxa(int b, int x, int a) { return ((b | x) & (a | x)) == ((b & a) | x); }
+int fl_bxa(int b, int x, int a) { return ((x | b) & (x | a)) == ((b & a) | x); }
+int fm_bxa(int b, int x, int a) { return ((b | x) & (x | a)) == ((b & a) | x); }
+int fn_bxa(int b, int x, int a) { return ((x | b) & (a | x)) == ((b & a) | x); }
+
+/*
+ * check-name: fact-and-ior
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/fact-and-shift.c b/validation/optim/fact-and-shift.c
new file mode 100644
index 000000000000..401750216b44
--- /dev/null
+++ b/validation/optim/fact-and-shift.c
@@ -0,0 +1,27 @@
+typedef unsigned int uint;
+typedef   signed int sint;
+
+
+uint fact_and_shl(uint a, uint b, uint s)
+{
+	return ((a << s) & (b << s)) == ((a & b) << s);
+}
+
+uint fact_and_lsr(uint a, uint b, uint s)
+{
+	return ((a >> s) & (b >> s)) == ((a & b) >> s);
+}
+
+sint fact_and_asr(sint a, sint b, sint s)
+{
+	return ((a >> s) & (b >> s)) == ((a & b) >> s);
+}
+
+/*
+ * check-name: fact-and-shift
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/fact-ior-and.c b/validation/optim/fact-ior-and.c
new file mode 100644
index 000000000000..7af89df1e1f0
--- /dev/null
+++ b/validation/optim/fact-ior-and.c
@@ -0,0 +1,28 @@
+int fr_abx(int a, int b, int x) { return ((a & x) | (b & x)) == ((a | b) & x); }
+int fl_abx(int a, int b, int x) { return ((x & a) | (x & b)) == ((a | b) & x); }
+int fm_abx(int a, int b, int x) { return ((a & x) | (x & b)) == ((a | b) & x); }
+int fn_abx(int a, int b, int x) { return ((x & a) | (b & x)) == ((a | b) & x); }
+
+int fr_bax(int b, int a, int x) { return ((a & x) | (b & x)) == ((b | a) & x); }
+int fl_bax(int b, int a, int x) { return ((x & a) | (x & b)) == ((b | a) & x); }
+int fm_bax(int b, int a, int x) { return ((a & x) | (x & b)) == ((b | a) & x); }
+int fn_bax(int b, int a, int x) { return ((x & a) | (b & x)) == ((b | a) & x); }
+
+int fr_axb(int a, int x, int b) { return ((a & x) | (b & x)) == ((a | b) & x); }
+int fl_axb(int a, int x, int b) { return ((x & a) | (x & b)) == ((a | b) & x); }
+int fm_axb(int a, int x, int b) { return ((a & x) | (x & b)) == ((a | b) & x); }
+int fn_axb(int a, int x, int b) { return ((x & a) | (b & x)) == ((a | b) & x); }
+
+int fr_bxa(int b, int x, int a) { return ((b & x) | (a & x)) == ((b | a) & x); }
+int fl_bxa(int b, int x, int a) { return ((x & b) | (x & a)) == ((b | a) & x); }
+int fm_bxa(int b, int x, int a) { return ((b & x) | (x & a)) == ((b | a) & x); }
+int fn_bxa(int b, int x, int a) { return ((x & b) | (a & x)) == ((b | a) & x); }
+
+/*
+ * check-name: fact-ior-and
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/fact-ior-shift.c b/validation/optim/fact-ior-shift.c
new file mode 100644
index 000000000000..07fdf80604dc
--- /dev/null
+++ b/validation/optim/fact-ior-shift.c
@@ -0,0 +1,27 @@
+typedef unsigned int uint;
+typedef   signed int sint;
+
+
+uint fact_ior_shl(uint a, uint b, uint s)
+{
+	return ((a << s) | (b << s)) == ((a | b) << s);
+}
+
+uint fact_ior_lsr(uint a, uint b, uint s)
+{
+	return ((a >> s) | (b >> s)) == ((a | b) >> s);
+}
+
+sint fact_ior_asr(sint a, sint b, sint s)
+{
+	return ((a >> s) | (b >> s)) == ((a | b) >> s);
+}
+
+/*
+ * check-name: fact-ior-shift
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/fact-xor-and.c b/validation/optim/fact-xor-and.c
new file mode 100644
index 000000000000..905cbf4ab659
--- /dev/null
+++ b/validation/optim/fact-xor-and.c
@@ -0,0 +1,28 @@
+int fr_abx(int a, int b, int x) { return ((a & x) ^ (b & x)) == ((a ^ b) & x); }
+int fl_abx(int a, int b, int x) { return ((x & a) ^ (x & b)) == ((a ^ b) & x); }
+int fm_abx(int a, int b, int x) { return ((a & x) ^ (x & b)) == ((a ^ b) & x); }
+int fn_abx(int a, int b, int x) { return ((x & a) ^ (b & x)) == ((a ^ b) & x); }
+
+int fr_bax(int b, int a, int x) { return ((a & x) ^ (b & x)) == ((b ^ a) & x); }
+int fl_bax(int b, int a, int x) { return ((x & a) ^ (x & b)) == ((b ^ a) & x); }
+int fm_bax(int b, int a, int x) { return ((a & x) ^ (x & b)) == ((b ^ a) & x); }
+int fn_bax(int b, int a, int x) { return ((x & a) ^ (b & x)) == ((b ^ a) & x); }
+
+int fr_axb(int a, int x, int b) { return ((a & x) ^ (b & x)) == ((a ^ b) & x); }
+int fl_axb(int a, int x, int b) { return ((x & a) ^ (x & b)) == ((a ^ b) & x); }
+int fm_axb(int a, int x, int b) { return ((a & x) ^ (x & b)) == ((a ^ b) & x); }
+int fn_axb(int a, int x, int b) { return ((x & a) ^ (b & x)) == ((a ^ b) & x); }
+
+int fr_bxa(int b, int x, int a) { return ((b & x) ^ (a & x)) == ((b ^ a) & x); }
+int fl_bxa(int b, int x, int a) { return ((x & b) ^ (x & a)) == ((b ^ a) & x); }
+int fm_bxa(int b, int x, int a) { return ((b & x) ^ (x & a)) == ((b ^ a) & x); }
+int fn_bxa(int b, int x, int a) { return ((x & b) ^ (a & x)) == ((b ^ a) & x); }
+
+/*
+ * check-name: fact-xor-and
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/fact-xor-shift.c b/validation/optim/fact-xor-shift.c
new file mode 100644
index 000000000000..81fcda851400
--- /dev/null
+++ b/validation/optim/fact-xor-shift.c
@@ -0,0 +1,27 @@
+typedef unsigned int uint;
+typedef   signed int sint;
+
+
+uint fact_xor_shl(uint a, uint b, uint s)
+{
+	return ((a << s) ^ (b << s)) == ((a ^ b) << s);
+}
+
+uint fact_xor_lsr(uint a, uint b, uint s)
+{
+	return ((a >> s) ^ (b >> s)) == ((a ^ b) >> s);
+}
+
+sint fact_xor_asr(sint a, sint b, sint s)
+{
+	return ((a >> s) ^ (b >> s)) == ((a ^ b) >> s);
+}
+
+/*
+ * check-name: fact-xor-shift
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
-- 
2.29.2

