Return-Path: <SRS0=7JZe=EO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFDDC388F9
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 733B8208FE
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWxFmdE8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgKHBTr (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 20:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgKHBTr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 20:19:47 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6541C0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 17:19:46 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id p93so5052467edd.7
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 17:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BTe4oqqkhVayZ3QUm41sr/PWpvwMOebFAsXf9ijucz8=;
        b=XWxFmdE8YPT3TrjJ401Udi0MLvM/GDqx56v2PaqEaBLLkFRTtrYpvUqKdwGGINqzLc
         mvvdB0CybyWArC2yJLfQQ4q0LEJnkXKWrWWLgOHw4XUivKhyzAMuH/n/biExA97rrPCZ
         gYDiAHdh131sPrX5w/4XRhBZ6luysyLUF/f0+gB/JZ+axaA/K4pZGeSRAMenM/GOyisG
         QbmVP+93em6fG1o+Vex/4/XgfCv16QrR+EYqZaHAhH/TwFhyJkMrQWBL/4fyzZWqV+XA
         X2kMF21ZgAO5dF6+DhHO+kSZ1u3UeoVwZ6LXU6tvO79NkQhF/3B0I+3WL34Yagt3hATE
         fnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BTe4oqqkhVayZ3QUm41sr/PWpvwMOebFAsXf9ijucz8=;
        b=YdL4KJQVZ+DLl10gwYDwxKC8uNY/3cT7Yp3qFiZK9SZHUsI85sXJQTddh1bI0bUG8X
         WkpOLBXkmxmflEp8wCeGw+7CYt75XRgW0tAH8lHmfmowSsEcPB6J/lFjfW/CmvV8Wie4
         Pn+N/JwFRj+WPR1aH4n9MbFMhMdajMERUQuGcSRz6eKyAAI9iKKNiHBmtw+dKY1QOTfg
         13ipaiM8fmwabqmw40fZkVbmSb6LBZHauyi08KLGPsHGtON90FYJIA6Twvry4G1ipfer
         ZSEAtr7n8b+KeCa/sMAbddGHB0ukMS20TiWopNQilu2j/BVcxySclkOSv7n3yRZJ/KLs
         9reA==
X-Gm-Message-State: AOAM533pAZ5GBL9t7c3nZ/KHvnKh0qThOK+EEV1MqZerKVh5YK7W6YQV
        w63ug0wBrqojqJi1/GSgIMs/oYHQZ1I=
X-Google-Smtp-Source: ABdhPJxOjhD7N5svqmoV4lh8gN4BLo52jboZMGththjhnv2FJIoQ03DMNOFqtxTHHNEBQW0UH/KeUw==
X-Received: by 2002:a50:e61a:: with SMTP id y26mr9128049edm.71.1604798384777;
        Sat, 07 Nov 2020 17:19:44 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:fce6:5cb0:27db:5e8c])
        by smtp.gmail.com with ESMTPSA id t22sm4545127edq.64.2020.11.07.17.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 17:19:44 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 02/16] cmp: add testcases for the simplification of compares
Date:   Sun,  8 Nov 2020 02:19:32 +0100
Message-Id: <20201108011939.94252-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201108011939.94252-1-luc.vanoostenryck@gmail.com>
References: <20201108011939.94252-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/canonical-cmpu.c | 16 ++++++++++++++++
 validation/optim/cmp-sext-sext.c  | 18 ++++++++++++++++++
 validation/optim/cmp-sext-simm.c  | 30 ++++++++++++++++++++++++++++++
 validation/optim/cmp-sext-uimm.c  | 26 ++++++++++++++++++++++++++
 validation/optim/cmp-sext.c       | 24 ++++++++++++++++++++++++
 validation/optim/cmp-zext-simm.c  | 24 ++++++++++++++++++++++++
 validation/optim/cmp-zext-uimm0.c | 21 +++++++++++++++++++++
 validation/optim/cmp-zext-uimm1.c | 16 ++++++++++++++++
 validation/optim/cmp-zext-uimm2.c | 30 ++++++++++++++++++++++++++++++
 validation/optim/cmp-zext-zext.c  | 18 ++++++++++++++++++
 validation/optim/cmp-zext.c       | 18 ++++++++++++++++++
 validation/optim/set-uimm1.c      | 11 +++++++++++
 validation/optim/set-uimm2.c      | 13 +++++++++++++
 validation/optim/set-uimm3.c      | 11 +++++++++++
 validation/optim/zext-cmpu.c      | 17 +++++++++++++++++
 15 files changed, 293 insertions(+)
 create mode 100644 validation/optim/canonical-cmpu.c
 create mode 100644 validation/optim/cmp-sext-sext.c
 create mode 100644 validation/optim/cmp-sext-simm.c
 create mode 100644 validation/optim/cmp-sext-uimm.c
 create mode 100644 validation/optim/cmp-sext.c
 create mode 100644 validation/optim/cmp-zext-simm.c
 create mode 100644 validation/optim/cmp-zext-uimm0.c
 create mode 100644 validation/optim/cmp-zext-uimm1.c
 create mode 100644 validation/optim/cmp-zext-uimm2.c
 create mode 100644 validation/optim/cmp-zext-zext.c
 create mode 100644 validation/optim/cmp-zext.c
 create mode 100644 validation/optim/set-uimm1.c
 create mode 100644 validation/optim/set-uimm2.c
 create mode 100644 validation/optim/set-uimm3.c
 create mode 100644 validation/optim/zext-cmpu.c

diff --git a/validation/optim/canonical-cmpu.c b/validation/optim/canonical-cmpu.c
new file mode 100644
index 000000000000..482408aa90c1
--- /dev/null
+++ b/validation/optim/canonical-cmpu.c
@@ -0,0 +1,16 @@
+// canonicalize to == or !=
+int cmp_ltu_eq0(unsigned int x) { return (x <  1) == (x == 0); }
+int cmp_geu_ne0(unsigned int x) { return (x >= 1) == (x != 0); }
+
+// canonicalize to the smaller value
+int cmp_ltu(unsigned int x) { return (x <  256) == (x <= 255); }
+int cmp_geu(unsigned int x) { return (x >= 256) == (x >  255); }
+
+/*
+ * check-name: canonical-cmpu
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/cmp-sext-sext.c b/validation/optim/cmp-sext-sext.c
new file mode 100644
index 000000000000..ba6ed54e940c
--- /dev/null
+++ b/validation/optim/cmp-sext-sext.c
@@ -0,0 +1,18 @@
+#define T(TYPE)			__##TYPE##_TYPE__
+#define cmp(TYPE, X, OP, Y)	((T(TYPE)) X OP (T(TYPE)) Y)
+#define TEST(T1, T2, X, OP, Y)	cmp(T1, X, OP, Y) == cmp(T2, X, OP, Y)
+
+#define ARGS(TYPE)	T(TYPE) a, T(TYPE)b
+
+_Bool cmpe_sext_sext(ARGS(INT32)) { return TEST(UINT64, UINT32, a, ==, b); }
+_Bool cmps_sext_sext(ARGS(INT32)) { return TEST( INT64,  INT32, a, < , b); }
+_Bool cmpu_sext_sext(ARGS(INT32)) { return TEST(UINT64, UINT32, a, < , b); }
+
+/*
+ * check-name: cmp-sext-sext
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/cmp-sext-simm.c b/validation/optim/cmp-sext-simm.c
new file mode 100644
index 000000000000..c2099a6b8876
--- /dev/null
+++ b/validation/optim/cmp-sext-simm.c
@@ -0,0 +1,30 @@
+#define sext(X)	((long long) (X))
+#define POS	(1LL << 31)
+#define NEG	(-POS - 1)
+
+static int lt_ge0(int x) { return (sext(x) <  (POS + 0)) == 1; }
+static int lt_ge1(int x) { return (sext(x) <  (POS + 1)) == 1; }
+static int le_ge0(int x) { return (sext(x) <= (POS + 0)) == 1; }
+static int le_ge1(int x) { return (sext(x) <= (POS + 1)) == 1; }
+static int lt_lt0(int x) { return (sext(x) <  (NEG - 0)) == 1; }
+static int lt_lt1(int x) { return (sext(x) <  (NEG - 1)) == 1; }
+static int le_lt0(int x) { return (sext(x) <= (NEG - 0)) == 1; }
+static int le_lt1(int x) { return (sext(x) <= (NEG - 1)) == 1; }
+
+static int gt_ge0(int x) { return (sext(x) >  (POS + 0)) == 0; }
+static int gt_ge1(int x) { return (sext(x) >  (POS + 1)) == 0; }
+static int ge_ge0(int x) { return (sext(x) >= (POS + 0)) == 0; }
+static int ge_ge1(int x) { return (sext(x) >= (POS + 1)) == 0; }
+static int gt_lt0(int x) { return (sext(x) >  (NEG - 0)) == 0; }
+static int gt_lt1(int x) { return (sext(x) >  (NEG - 1)) == 0; }
+static int ge_lt0(int x) { return (sext(x) >= (NEG - 0)) == 0; }
+static int ge_lt1(int x) { return (sext(x) >= (NEG - 1)) == 0; }
+
+/*
+ * check-name: cmp-sext-simm
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/cmp-sext-uimm.c b/validation/optim/cmp-sext-uimm.c
new file mode 100644
index 000000000000..cc89a80694a1
--- /dev/null
+++ b/validation/optim/cmp-sext-uimm.c
@@ -0,0 +1,26 @@
+#define sext(X)	((unsigned long long) (X))
+#define POS	(1ULL << 31)
+#define NEG	((unsigned long long) -POS)
+
+int sext_ltu_p2(int x) { return (sext(x) <  (POS + 2)) == (x >= 0); }
+int sext_ltu_p1(int x) { return (sext(x) <  (POS + 1)) == (x >= 0); }
+int sext_ltu_p0(int x) { return (sext(x) <  (POS + 0)) == (x >= 0); }
+
+int sext_leu_p1(int x) { return (sext(x) <= (POS + 1)) == (x >= 0); }
+int sext_leu_p0(int x) { return (sext(x) <= (POS + 0)) == (x >= 0); }
+
+int sext_geu_m1(int x) { return (sext(x) >= (NEG - 1)) == (x < 0); }
+int sext_geu_m2(int x) { return (sext(x) >= (NEG - 2)) == (x < 0); }
+
+int sext_gtu_m1(int x) { return (sext(x) > (NEG - 1)) == (x < 0); }
+int sext_gtu_m2(int x) { return (sext(x) > (NEG - 2)) == (x < 0); }
+int sext_gtu_m3(int x) { return (sext(x) > (NEG - 3)) == (x < 0); }
+
+/*
+ * check-name: cmp-sext-uimm
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/cmp-sext.c b/validation/optim/cmp-sext.c
new file mode 100644
index 000000000000..2dd60fff064c
--- /dev/null
+++ b/validation/optim/cmp-sext.c
@@ -0,0 +1,24 @@
+#define T(TYPE)			__##TYPE##_TYPE__
+#define cmp(TYPE, X, OP, Y)	((T(TYPE)) X OP (T(TYPE)) Y)
+#define TEST(T1, T2, X, OP, Y)	cmp(T1, X, OP, Y) == cmp(T2, X, OP, Y)
+
+#define ARGS(TYPE)	T(TYPE) a, T(TYPE)b
+
+_Bool cmpe_sextp(ARGS(INT32)) { return TEST(UINT64, UINT32, a, ==, 0x7fffffff); }
+_Bool cmps_sextp(ARGS(INT32)) { return TEST( INT64,  INT32, a, < , 0x7fffffff); }
+_Bool cmpu_sextp(ARGS(INT32)) { return TEST(UINT64, UINT32, a, < , 0x7fffffff); }
+_Bool cmpe_sextn(ARGS(INT32)) { return TEST(UINT64, UINT32, a, ==, -1); }
+_Bool cmps_sextn(ARGS(INT32)) { return TEST( INT64,  INT32, a, < , -1); }
+_Bool cmpu_sextn(ARGS(INT32)) { return TEST(UINT64, UINT32, a, < , -1); }
+
+_Bool cmpltu_sext(int a) { return (a <  0x80000000ULL) == (a >= 0); }
+_Bool cmpgtu_sext(int a) { return (a >= 0x80000000ULL) == (a <  0); }
+
+/*
+ * check-name: cmp-sext
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/cmp-zext-simm.c b/validation/optim/cmp-zext-simm.c
new file mode 100644
index 000000000000..f89f8f8baa62
--- /dev/null
+++ b/validation/optim/cmp-zext-simm.c
@@ -0,0 +1,24 @@
+#define ZEXT(X)	((long long)(X))
+#define BITS	((long long)(~0U))
+
+int zext_ult(unsigned int x) { return (ZEXT(x) <  (BITS + 1)) == 1; }
+int zext_ule(unsigned int x) { return (ZEXT(x) <= (BITS + 0)) == 1; }
+int zext_uge(unsigned int x) { return (ZEXT(x) >= (BITS + 1)) == 0; }
+int zext_ugt(unsigned int x) { return (ZEXT(x) >  (BITS + 0)) == 0; }
+
+int zext_0le(unsigned int x) { return (ZEXT(x) <=  0) == (x == 0); }
+int zext_0ge(unsigned int x) { return (ZEXT(x) >   0) == (x != 0); }
+
+int zext_llt(unsigned int x) { return (ZEXT(x) <  -1) == 0; }
+int zext_lle(unsigned int x) { return (ZEXT(x) <= -1) == 0; }
+int zext_lge(unsigned int x) { return (ZEXT(x) >= -1) == 1; }
+int zext_lgt(unsigned int x) { return (ZEXT(x) >  -1) == 1; }
+
+/*
+ * check-name: cmp-zext-simm
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/cmp-zext-uimm0.c b/validation/optim/cmp-zext-uimm0.c
new file mode 100644
index 000000000000..f7bec338ca8f
--- /dev/null
+++ b/validation/optim/cmp-zext-uimm0.c
@@ -0,0 +1,21 @@
+#define zext(X)	((unsigned long long) (X))
+#define MAX	(1ULL << 32)
+
+#define TEST(X,OP,VAL)	(zext(X) OP (VAL)) == (X OP (VAL))
+
+int zext_ltu_0(unsigned int x) { return TEST(x, < , MAX); }
+int zext_ltu_m(unsigned int x) { return TEST(x, < , MAX - 1); }
+int zext_lte_0(unsigned int x) { return TEST(x, <=, MAX); }
+int zext_lte_m(unsigned int x) { return TEST(x, <=, MAX - 1); }
+int zext_gte_0(unsigned int x) { return TEST(x, >=, MAX); }
+int zext_gte_m(unsigned int x) { return TEST(x, >=, MAX - 1); }
+int zext_gtu_0(unsigned int x) { return TEST(x, > , MAX); }
+int zext_gtu_m(unsigned int x) { return TEST(x, > , MAX - 1); }
+
+/*
+ * check-name: cmp-zext-uimm0
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/cmp-zext-uimm1.c b/validation/optim/cmp-zext-uimm1.c
new file mode 100644
index 000000000000..ffcdaad5c1bd
--- /dev/null
+++ b/validation/optim/cmp-zext-uimm1.c
@@ -0,0 +1,16 @@
+#define zext(X)	((unsigned long long) (X))
+#define BITS	((1ULL << 32) - 1)
+
+int zext_lt_p(unsigned int x) { return (zext(x) <  (BITS + 1)) == 1; }
+int zext_le_p(unsigned int x) { return (zext(x) <= (BITS    )) == 1; }
+int zext_ge_p(unsigned int x) { return (zext(x) >= (BITS + 1)) == 0; }
+int zext_gt_p(unsigned int x) { return (zext(x) >  (BITS    )) == 0; }
+
+/*
+ * check-name: cmp-zext-uimm1
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/cmp-zext-uimm2.c b/validation/optim/cmp-zext-uimm2.c
new file mode 100644
index 000000000000..64f30b9a3df5
--- /dev/null
+++ b/validation/optim/cmp-zext-uimm2.c
@@ -0,0 +1,30 @@
+#define zext(X)	((unsigned long long) (X))
+
+int zext_ltu_q(unsigned x) { return (zext(x) <  0x100000001UL) == 1; }
+int zext_ltu_p(unsigned x) { return (zext(x) <  0x100000000UL) == 1; }
+int zext_ltu_0(unsigned x) { return (zext(x) <  0x0ffffffffUL) == (x <  0xffffffff); }
+int zext_ltu_m(unsigned x) { return (zext(x) <  0x0fffffffeUL) == (x <  0xfffffffe); }
+
+int zext_leu_q(unsigned x) { return (zext(x) <= 0x100000001UL) == 1; }
+int zext_leu_p(unsigned x) { return (zext(x) <= 0x100000000UL) == 1; }
+int zext_leu_0(unsigned x) { return (zext(x) <= 0x0ffffffffUL) == 1; }
+int zext_leu_m(unsigned x) { return (zext(x) <= 0x0fffffffeUL) == (x <= 0xfffffffe); }
+
+int zext_geu_q(unsigned x) { return (zext(x) >= 0x100000001UL) == 0; }
+int zext_geu_p(unsigned x) { return (zext(x) >= 0x100000000UL) == 0; }
+int zext_geu_0(unsigned x) { return (zext(x) >= 0x0ffffffffUL) == (x >= 0xffffffff); }
+int zext_geu_m(unsigned x) { return (zext(x) >= 0x0fffffffeUL) == (x >= 0xfffffffe); }
+
+int zext_gtu_q(unsigned x) { return (zext(x) >  0x100000001UL) == 0; }
+int zext_gtu_p(unsigned x) { return (zext(x) >  0x100000000UL) == 0; }
+int zext_gtu_0(unsigned x) { return (zext(x) >  0x0ffffffffUL) == 0; }
+int zext_gtu_m(unsigned x) { return (zext(x) >  0x0fffffffeUL) == (x >  0xfffffffe); }
+
+/*
+ * check-name: cmp-zext-uimm2
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/cmp-zext-zext.c b/validation/optim/cmp-zext-zext.c
new file mode 100644
index 000000000000..9f188297e214
--- /dev/null
+++ b/validation/optim/cmp-zext-zext.c
@@ -0,0 +1,18 @@
+#define T(TYPE)			__##TYPE##_TYPE__
+#define cmp(TYPE, X, OP, Y)	((T(TYPE)) X OP (T(TYPE)) Y)
+#define TEST(T1, T2, X, OP, Y)	cmp(T1, X, OP, Y) == cmp(T2, X, OP, Y)
+
+#define ARGS(TYPE)	T(TYPE) a, T(TYPE)b
+
+_Bool cmpe_zext_zext(ARGS(UINT32)) { return TEST(UINT64, UINT32, a, ==, b); }
+_Bool cmps_zext_zext(ARGS(UINT32)) { return TEST( INT64, UINT32, a, < , b); }
+_Bool cmpu_zext_zext(ARGS(UINT32)) { return TEST(UINT64, UINT32, a, < , b); }
+
+/*
+ * check-name: cmp-zext-zext
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/cmp-zext.c b/validation/optim/cmp-zext.c
new file mode 100644
index 000000000000..ecee6b5e9101
--- /dev/null
+++ b/validation/optim/cmp-zext.c
@@ -0,0 +1,18 @@
+#define T(TYPE)			__##TYPE##_TYPE__
+#define cmp(TYPE, X, OP, Y)	((T(TYPE)) X OP (T(TYPE)) Y)
+#define TEST(T1, T2, X, OP, Y)	cmp(T1, X, OP, Y) == cmp(T2, X, OP, Y)
+
+#define ARGS(TYPE)	T(TYPE) a, T(TYPE)b
+
+_Bool cmpe_zext(ARGS(UINT32)) { return TEST(UINT64, UINT32, a, ==, 0xffffffff); }
+_Bool cmps_zext(ARGS(UINT32)) { return TEST( INT64, UINT32, a, < , 0xffffffff); }
+_Bool cmpu_zext(ARGS(UINT32)) { return TEST(UINT64, UINT32, a, < , 0xffffffff); }
+
+/*
+ * check-name: cmp-zext
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/set-uimm1.c b/validation/optim/set-uimm1.c
new file mode 100644
index 000000000000..d6928f59d044
--- /dev/null
+++ b/validation/optim/set-uimm1.c
@@ -0,0 +1,11 @@
+static _Bool setle_umax(unsigned int a) { return (a <= ~0) == 1; }
+static _Bool setgt_umax(unsigned int a) { return (a >  ~0) == 0; }
+
+/*
+ * check-name: set-uimm1
+ * check-command: test-linearize $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/set-uimm2.c b/validation/optim/set-uimm2.c
new file mode 100644
index 000000000000..efa326f532ce
--- /dev/null
+++ b/validation/optim/set-uimm2.c
@@ -0,0 +1,13 @@
+static _Bool setlt_umax(unsigned int a) { return (a <  ~0) == (a != ~0); }
+static _Bool setle_umax(unsigned int a) { return (a <= ~1) == (a != ~0); }
+static _Bool setge_umax(unsigned int a) { return (a >= ~0) == (a == ~0); }
+static _Bool setgt_umax(unsigned int a) { return (a >  ~1) == (a == ~0); }
+
+/*
+ * check-name: set-uimm2
+ * check-command: test-linearize $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/set-uimm3.c b/validation/optim/set-uimm3.c
new file mode 100644
index 000000000000..b72ef8d6e819
--- /dev/null
+++ b/validation/optim/set-uimm3.c
@@ -0,0 +1,11 @@
+int le(int x) { return (x <= 0x7fffffffU) == (x >= 0); }
+int gt(int x) { return (x >  0x7fffffffU) == (x <  0); }
+
+/*
+ * check-name: set-uimm3
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/optim/zext-cmpu.c b/validation/optim/zext-cmpu.c
new file mode 100644
index 000000000000..279ed70e0fda
--- /dev/null
+++ b/validation/optim/zext-cmpu.c
@@ -0,0 +1,17 @@
+int ltg(unsigned x) { return (((long long)x) <  0x100000000ULL) == 1; }
+int ltl(unsigned x) { return (((long long)x) <  0x0ffffffffULL) == (x <  0xffffffffU); }
+int leg(unsigned x) { return (((long long)x) <= 0x0ffffffffULL) == 1; }
+int lel(unsigned x) { return (((long long)x) <= 0x0fffffffeULL) == (x <= 0xfffffffeU); }
+int geg(unsigned x) { return (((long long)x) >= 0x100000000ULL) == 0; }
+int gel(unsigned x) { return (((long long)x) >= 0x0ffffffffULL) == (x >= 0xffffffffU); }
+int gtg(unsigned x) { return (((long long)x) >  0x0ffffffffULL) == 0; }
+int gtl(unsigned x) { return (((long long)x) >  0x0fffffffeULL) == (x >  0xfffffffeU); }
+
+/*
+ * check-name: zext-cmpu
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
-- 
2.29.2

