Return-Path: <SRS0=cyFV=D3=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C53C388F7
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 060F8223BF
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgWehZkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438658AbgJTVK1 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438655AbgJTVK1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Oct 2020 17:10:27 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6E1C0613CE
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:27 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id o18so204944edq.4
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x36J6Qfw+zbVTS8VqSerMeYg0LTkmuxAfxnd3jpqPaw=;
        b=MgWehZknCCYUyH2RPZdODI7TE9uQwSBLNTWn2rbFON/jIFz1Q4fDUmgL1U5UiRrWkp
         iu6I0GhX57JBr7IDy63D8sQsAn69lLPORjjvxslzrbNohKFfZDYv/mN2j9m8AqxyHBS+
         vrgVYW1PeGNykiE7qnrY+hI7OKU1CtsjAa17zUljSsC6MtStVgoV5YF03kqAcxJa0qXn
         jKTo9Gxoe4elx723O+yXR6x24FDRdarbufDmxxcJ4jW5tAbBRoZMSU5G/8QCgQ66cl2t
         ei53pmklU2bLBcn2HxzmkTsU//ftoxudKh7FE8A+UgthMrP0eG4xfSYfsJ+3YeXJfHHH
         /j+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x36J6Qfw+zbVTS8VqSerMeYg0LTkmuxAfxnd3jpqPaw=;
        b=EQkDscqxgXlNiXRszcIvHnPl7QR0+fezW8xxUgMaVamKwT5fUNTb8YF2QdkT0OZ8j3
         nmL8reVqhSUjnII+nkKI4iaJrGzaYX+FH36A9T1Narek32oVCjMZycVxWlH9UIqvfVAo
         o6lm9sjdiXSgDn9U/d8sRbi9d1uJ0tUpzzgomSaT1defipZGObrE6w8UXot20c3wh888
         LhwaFIjEkM/wdl2F1HCQfFXwqF7sVqIpqr9OBhtDXBw6oeF2NJCV+zg35hgv8GG0DEty
         Ow5epecavy7w6E2niespNjO6jOaIN3ErxuyIYJExecCjJBAjuGEoewiE17SufAAE1o9y
         Z8jg==
X-Gm-Message-State: AOAM530Jy5Bu4Dko+tKmh/rDsroBoTM3JRl9u/3xnvWerGIFIxw8GYva
        1GhiwVXpvlx+VQwO10Ik/YL91LExIZw=
X-Google-Smtp-Source: ABdhPJwjrgozKBi5HQOUZ/M365B82SjF9FL9Wk5lh2QPUuX3M/F7D/s6LdMLGxjs0mem8riLeADURQ==
X-Received: by 2002:aa7:da48:: with SMTP id w8mr4924926eds.220.1603228225250;
        Tue, 20 Oct 2020 14:10:25 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:85fe:66cb:a92b:c664])
        by smtp.gmail.com with ESMTPSA id d12sm4012848ejt.105.2020.10.20.14.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 14:10:24 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 01/22] add testcases about OP_ADD & OP_SUB simplifications
Date:   Tue, 20 Oct 2020 23:10:00 +0200
Message-Id: <20201020211021.82394-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
References: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Add some testcases about basic simplifications of additions
and subtractions.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/canonical-sub-cte.c      | 10 ++++++++++
 validation/optim/reassoc-op-op1.c         | 15 +++++++++++++++
 validation/optim/simplify-add-neg.c       | 10 ++++++++++
 validation/optim/simplify-cte-sub-addl.c  | 10 ++++++++++
 validation/optim/simplify-cte-sub-addr.c  | 10 ++++++++++
 validation/optim/simplify-cte-sub-subr.c  | 10 ++++++++++
 validation/optim/simplify-neg-add.c       | 10 ++++++++++
 validation/optim/simplify-same-add-subl.c | 16 ++++++++++++++++
 validation/optim/simplify-same-add-subr.c | 16 ++++++++++++++++
 validation/optim/simplify-same-addl-sub.c | 10 ++++++++++
 validation/optim/simplify-same-sub-addl.c | 10 ++++++++++
 validation/optim/simplify-same-subl-add.c | 12 ++++++++++++
 validation/optim/simplify-same-subr-add.c | 12 ++++++++++++
 validation/optim/simplify-sub-neg.c       | 10 ++++++++++
 validation/optim/simplify-zero-sub.c      | 10 ++++++++++
 15 files changed, 171 insertions(+)
 create mode 100644 validation/optim/canonical-sub-cte.c
 create mode 100644 validation/optim/reassoc-op-op1.c
 create mode 100644 validation/optim/simplify-add-neg.c
 create mode 100644 validation/optim/simplify-cte-sub-addl.c
 create mode 100644 validation/optim/simplify-cte-sub-addr.c
 create mode 100644 validation/optim/simplify-cte-sub-subr.c
 create mode 100644 validation/optim/simplify-neg-add.c
 create mode 100644 validation/optim/simplify-same-add-subl.c
 create mode 100644 validation/optim/simplify-same-add-subr.c
 create mode 100644 validation/optim/simplify-same-addl-sub.c
 create mode 100644 validation/optim/simplify-same-sub-addl.c
 create mode 100644 validation/optim/simplify-same-subl-add.c
 create mode 100644 validation/optim/simplify-same-subr-add.c
 create mode 100644 validation/optim/simplify-sub-neg.c
 create mode 100644 validation/optim/simplify-zero-sub.c

diff --git a/validation/optim/canonical-sub-cte.c b/validation/optim/canonical-sub-cte.c
new file mode 100644
index 000000000000..223be96fa5a5
--- /dev/null
+++ b/validation/optim/canonical-sub-cte.c
@@ -0,0 +1,10 @@
+int sub_cte(int x) { return (x - 1) != (x + -1); }
+
+/*
+ * check-name: canonical-sub-cte
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: ret\\..*\\$0
+ */
diff --git a/validation/optim/reassoc-op-op1.c b/validation/optim/reassoc-op-op1.c
new file mode 100644
index 000000000000..aa7092ff57a0
--- /dev/null
+++ b/validation/optim/reassoc-op-op1.c
@@ -0,0 +1,15 @@
+int foo(int x, int *ptr)
+{
+	int t = x + 1;
+	*ptr = t;
+	return t + -1;
+}
+
+/*
+ * check-name: reassoc-op-op1
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-pattern(1): add\\.
+ */
diff --git a/validation/optim/simplify-add-neg.c b/validation/optim/simplify-add-neg.c
new file mode 100644
index 000000000000..19b64b096567
--- /dev/null
+++ b/validation/optim/simplify-add-neg.c
@@ -0,0 +1,10 @@
+int add_neg(int x, int y) { return x + -y; }
+
+/*
+ * check-name: simplify-add-neg
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: sub\\..*%arg1, %arg2
+ */
diff --git a/validation/optim/simplify-cte-sub-addl.c b/validation/optim/simplify-cte-sub-addl.c
new file mode 100644
index 000000000000..49e510062c03
--- /dev/null
+++ b/validation/optim/simplify-cte-sub-addl.c
@@ -0,0 +1,10 @@
+int cte_sub_addl(int x) { return (1 - x) + 1; }
+
+/*
+ * check-name: simplify-cte-sub-addl
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: sub\\..*\\$2, %arg1
+ */
diff --git a/validation/optim/simplify-cte-sub-addr.c b/validation/optim/simplify-cte-sub-addr.c
new file mode 100644
index 000000000000..81f5b34551c6
--- /dev/null
+++ b/validation/optim/simplify-cte-sub-addr.c
@@ -0,0 +1,10 @@
+int cte_sub_addr(int x) { return 2 - (x + 1); }
+
+/*
+ * check-name: simplify-cte-sub-addr
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: sub\\..*\\$1, %arg1
+ */
diff --git a/validation/optim/simplify-cte-sub-subr.c b/validation/optim/simplify-cte-sub-subr.c
new file mode 100644
index 000000000000..950b233e60c3
--- /dev/null
+++ b/validation/optim/simplify-cte-sub-subr.c
@@ -0,0 +1,10 @@
+int cte_sub_subr(int x) { return 1 - (1 - x); }
+
+/*
+ * check-name: simplify-cte-sub-subr
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: ret\\..* %arg1
+ */
diff --git a/validation/optim/simplify-neg-add.c b/validation/optim/simplify-neg-add.c
new file mode 100644
index 000000000000..66a820f28069
--- /dev/null
+++ b/validation/optim/simplify-neg-add.c
@@ -0,0 +1,10 @@
+int neg_add(int x, int y) { return -x + y; }
+
+/*
+ * check-name: simplify-neg-add
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: sub\\..*%arg2, %arg1
+ */
diff --git a/validation/optim/simplify-same-add-subl.c b/validation/optim/simplify-same-add-subl.c
new file mode 100644
index 000000000000..1f17ef0b968e
--- /dev/null
+++ b/validation/optim/simplify-same-add-subl.c
@@ -0,0 +1,16 @@
+int add_subl(int x, int y) { return (x + y) - x; }
+
+/*
+ * check-name: simplify-same-add-subl
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-start
+add_subl:
+.L0:
+	<entry-point>
+	ret.32      %arg2
+
+
+ * check-output-end
+ */
diff --git a/validation/optim/simplify-same-add-subr.c b/validation/optim/simplify-same-add-subr.c
new file mode 100644
index 000000000000..e8540703ee7d
--- /dev/null
+++ b/validation/optim/simplify-same-add-subr.c
@@ -0,0 +1,16 @@
+int add_subr(int x, int y) { return (x + y) - y; }
+
+/*
+ * check-name: simplify-same-add-subr
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-start
+add_subr:
+.L0:
+	<entry-point>
+	ret.32      %arg1
+
+
+ * check-output-end
+ */
diff --git a/validation/optim/simplify-same-addl-sub.c b/validation/optim/simplify-same-addl-sub.c
new file mode 100644
index 000000000000..51d2b07966f4
--- /dev/null
+++ b/validation/optim/simplify-same-addl-sub.c
@@ -0,0 +1,10 @@
+int foo(int x, int y) { return x + (y - x); }
+
+/*
+ * check-name: simplify-same-addl-sub
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: ret\\..*%arg2
+ */
diff --git a/validation/optim/simplify-same-sub-addl.c b/validation/optim/simplify-same-sub-addl.c
new file mode 100644
index 000000000000..78f217399e50
--- /dev/null
+++ b/validation/optim/simplify-same-sub-addl.c
@@ -0,0 +1,10 @@
+int foo(int x, int y) { return (x - y) + y; }
+
+/*
+ * check-name: simplify-same-sub-addl
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: ret\\..*%arg1
+ */
diff --git a/validation/optim/simplify-same-subl-add.c b/validation/optim/simplify-same-subl-add.c
new file mode 100644
index 000000000000..dbc0fe97f126
--- /dev/null
+++ b/validation/optim/simplify-same-subl-add.c
@@ -0,0 +1,12 @@
+int subl_add(int x, int y) { return x - (x + y); }
+
+/*
+ * check-name: simplify-same-subl-add
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: neg\\..* %arg2
+ * check-output-excludes: add\\.
+ * check-output-excludes: sub\\.
+ */
diff --git a/validation/optim/simplify-same-subr-add.c b/validation/optim/simplify-same-subr-add.c
new file mode 100644
index 000000000000..bafd2643bfd0
--- /dev/null
+++ b/validation/optim/simplify-same-subr-add.c
@@ -0,0 +1,12 @@
+int subr_add(int x, int y) { return x - (y + x); }
+
+/*
+ * check-name: simplify-same-subr-add
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: neg\\..* %arg2
+ * check-output-excludes: add\\.
+ * check-output-excludes: sub\\.
+ */
diff --git a/validation/optim/simplify-sub-neg.c b/validation/optim/simplify-sub-neg.c
new file mode 100644
index 000000000000..b6fcc2baabec
--- /dev/null
+++ b/validation/optim/simplify-sub-neg.c
@@ -0,0 +1,10 @@
+int sub_neg(int x, int y) { return x - -y; }
+
+/*
+ * check-name: simplify-sub-neg
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: add\\..*%arg., %arg.
+ */
diff --git a/validation/optim/simplify-zero-sub.c b/validation/optim/simplify-zero-sub.c
new file mode 100644
index 000000000000..cc8fe7a3159b
--- /dev/null
+++ b/validation/optim/simplify-zero-sub.c
@@ -0,0 +1,10 @@
+int zero_sub(int x) { return 0 - x; }
+
+/*
+ * check-name: simplify-zero-sub
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: neg\\..* %arg1
+ */
-- 
2.28.0

