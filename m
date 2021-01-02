Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C5FC433E0
	for <linux-sparse@archiver.kernel.org>; Sat,  2 Jan 2021 10:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44082207AA
	for <linux-sparse@archiver.kernel.org>; Sat,  2 Jan 2021 10:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbhABKK3 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 2 Jan 2021 05:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbhABKK2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 2 Jan 2021 05:10:28 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128FCC061573
        for <linux-sparse@vger.kernel.org>; Sat,  2 Jan 2021 02:09:48 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d26so26076077wrb.12
        for <linux-sparse@vger.kernel.org>; Sat, 02 Jan 2021 02:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TDVpH9xgCVcNMsOyRyVmPG4M0g1mYCd9k9zNIBG+xzg=;
        b=s6jyRIbINwKQOq0l02kZF5NnMjMyH30RIDVR6k4Ia7wde11C8ABIGb1SMAUaeHzwLp
         NVz7IW2yIznNbeVIsB4w09dL2nMbMKdA2lb8liQBRVMSv7D7qBUNcXiEZ1n8vGgnddCG
         CIZQWoXlLoyUQSY0pEZT1cwv0PQlEgsaS94KY9qEs+Yw+pDiw4blVgLV5pqHe3knNK7p
         2QhdeF0pbFl9B9Gsr6/5Cix2OZPBmz3qQNvfGgLUWAy2O7U5DPdvkVwz2v8YycAkuKyO
         ME6B46NNjZjF6PFfVIlNYsZwMoZH+esWtDbKyp22LV5OAuXf0R5WX7Nf/Zr+uibK4NP7
         fyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TDVpH9xgCVcNMsOyRyVmPG4M0g1mYCd9k9zNIBG+xzg=;
        b=KwtI3sRrf1ZqqHK+uq11RMX6RMqvpeoQ0WsLRC3uYfivu4Y7FjyxNAY7YYZ5WLhF2o
         7GiYnbJD2NJa5g8Fgx1I2Rnd5Fpd66zzQ5NQ5XOXiv4zNS0ltAf68P5PPh44y7e8GyM3
         wZsZV8agDFvlBZbb1bB65pklyuD17xEntbljOEIWm8a10BEMo9KR6D2j6omqwHnftwwz
         Hl8Jbhn37zDndEihjxSX6tMYYfXgR9w+zlvtvSViFRKdZx9PDgWkC/YumS3TInMgDM7V
         xaVQX+0dVqdFKZAsV2h/50raPsxAmHtY4cU+YAS/BWgXNJ2b90HTs/VKXFYV7+7bH38H
         hanQ==
X-Gm-Message-State: AOAM532+Q5LdMlteu+pdy81an1yQz6H/z/MVScGxBkyp2tO1VTlMCkhI
        hZdPN5JdKnQREyb3xXDMY+myiCpAXxk=
X-Google-Smtp-Source: ABdhPJy91l1NKARBJJpuMii9EpuJ+4RgPfj6P3uJXTT6467anZse/owKcH+CfSDmSvrW7GNLbCAYgg==
X-Received: by 2002:adf:f70c:: with SMTP id r12mr71204059wrp.234.1609582186322;
        Sat, 02 Jan 2021 02:09:46 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:9416:7242:911d:d307])
        by smtp.gmail.com with ESMTPSA id h15sm76994446wru.4.2021.01.02.02.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jan 2021 02:09:45 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] RFC: problems with cast optimization at evaluation time
Date:   Sat,  2 Jan 2021 11:09:34 +0100
Message-Id: <20210102100934.28459-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The current code will, at evaluation time, optimize some cast.
For example, code like:
	int i  = <some value>;
	char c = ~i;
will be optimized to what would essentially be:
	int i = <some value>;
	char c = ~(char) i;

This is fine but it has at least two problems:
	int i = <some value>;
	bool b = ~i;
is not the same as the 'optimized' (it's would only be for 0 and -1):
	int i = <some value>;
	bool b = ~(bool)i;
Same with floats:
	int i = <some value>;
	float f = ~i;
in this case the 'optimized' form doesn't even make sense:
	int i = <some value>;
	float f = ~(float)i;

It's easy enough to add a test to only allow this on 'true' integer types
like done in the patch.

However, the same problem also exist for the optimization of the
sequence of two implied cast (only that this is rare and I haven't
succeed to reproduce a case where it is wrong). For example,
a conversion of an integer to a float can overflow, so a conversion
like 'int -> float -> int' is not always a no-op.

Again it's easy enough to add some checks but I wonder if all this
is really worth. My gut feeling is that this should not be done at
evaluation time and should only be done after linearization.
I just wonder if this simplification wasn't done for some specific
purpose other than avoiding an allocation and keeping the AST small?

-- Luc
---
 evaluate.c                       |  2 +-
 validation/eval/not-cast-bool.c  | 14 ++++++++++++++
 validation/eval/not-cast-float.c | 14 ++++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 validation/eval/not-cast-bool.c
 create mode 100644 validation/eval/not-cast-float.c

diff --git a/evaluate.c b/evaluate.c
index 41871e18503a..843b56a0386a 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -337,7 +337,7 @@ static struct expression * cast_to(struct expression *old, struct symbol *type)
 	case EXPR_PREOP:
 		if (old->ctype->bit_size < type->bit_size)
 			break;
-		if (old->op == '~') {
+		if (old->op == '~' && is_int_type(type) && !is_bool_type(type)) {
 			old->ctype = type;
 			old->unop = cast_to(old->unop, type);
 			return old;
diff --git a/validation/eval/not-cast-bool.c b/validation/eval/not-cast-bool.c
new file mode 100644
index 000000000000..acd8bbf293db
--- /dev/null
+++ b/validation/eval/not-cast-bool.c
@@ -0,0 +1,14 @@
+static _Bool foo(void)
+{
+	unsigned char c = 1;
+	_Bool b = ~c;
+	return b;
+}
+
+/*
+ * check-name: not-cast-bool
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
diff --git a/validation/eval/not-cast-float.c b/validation/eval/not-cast-float.c
new file mode 100644
index 000000000000..d474d69bdda3
--- /dev/null
+++ b/validation/eval/not-cast-float.c
@@ -0,0 +1,14 @@
+static int foo(void)
+{
+	int i = 123;
+	float x = ~i;
+	return (x < 0);
+}
+
+/*
+ * check-name: eval-bool-zext-neg
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-returns: 1
+ */
-- 
2.29.2

