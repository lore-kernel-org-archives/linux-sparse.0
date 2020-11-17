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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20292C63777
	for <linux-sparse@archiver.kernel.org>; Tue, 17 Nov 2020 21:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2BB522250
	for <linux-sparse@archiver.kernel.org>; Tue, 17 Nov 2020 21:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+vo8XNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgKQV3B (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgKQV3A (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 17 Nov 2020 16:29:00 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC28C0613CF
        for <linux-sparse@vger.kernel.org>; Tue, 17 Nov 2020 13:29:00 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id k27so4107932ejs.10
        for <linux-sparse@vger.kernel.org>; Tue, 17 Nov 2020 13:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XcRT78qTY/3pPmcoP6RSEWKvkQjqz7eMKwW1f49nRdg=;
        b=F+vo8XNo9ZkUbGuC5IcHXuFAfB7mv24tpWPrfxIN9CkJLUcQE16sK2D3HYKosgkqJ1
         1pA3i5Ax2owN1Mk+Z6X9svjxSFpuFZPN+/a8nVI1i2KAKHl5CSzKRplWF1EH6rIqfR0b
         ED+8Ie2oaZOyqN26ZlbWjzFIoHzPIPvdLbzUWx+bpUv/xFnwG681REiaZ3dbq0QjxjcB
         GxAnoW2Cv66gOX4O0QMb/UiRYM7CzDQTi+70mk2haGR7KPMwLZGesUTa9haNzz57lN3O
         4u7JUNBCUdw4Nw2+7ta7l4lOR0n6Jpf3m3uZRXRCcBCIWEWkR8H5vwfzCq/cUhoOJQ0Y
         6XcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XcRT78qTY/3pPmcoP6RSEWKvkQjqz7eMKwW1f49nRdg=;
        b=TPBEnK4VghN4YPLdjMEq3H3LIPsfsDwjz46m4nmuBu0iydQkiL0/SbVnZjKjMhj9iR
         bXfAsjmYu1IeFIod0nK3sblNMJmdkj3R7AdYqRGoBMUmEDZ/5BT5BC48S5HI/2tH3ocS
         zVQdGJFC8GpIv23eYQtSATTJP/v7UW23u/26+7mTjEA2Mvc+7jqZsHJPZlFj2yRHxLfI
         56tDW6kXWC54XlX/eDo8sdZ2AKoMiyh4CylbQZZAXmeValr+jg+oZbQowIm7okitZO9X
         mw2vgxR3hpPkKWPMp37ZmbPN94OajHZyABm07WfJET40xCBN+kyPBBm4u+P2V63Nf/wW
         TTQA==
X-Gm-Message-State: AOAM533oypx31oYqy2uAd94pqiEQ3rzhBmI2RsFqdsvQmMzd8iYMG6Me
        9P3+Zvab8Q1nWcwU4Skc55LxHnFDqFs=
X-Google-Smtp-Source: ABdhPJyHJ3rp7KWPTEQGN1YkzS6HYDuYKdqWxb7WMHu70D1k5cLjKSVwx6hb2xGhwO+Mt0476izATw==
X-Received: by 2002:a17:906:3187:: with SMTP id 7mr21237017ejy.225.1605648538783;
        Tue, 17 Nov 2020 13:28:58 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:ad5d:5272:2152:8b92])
        by smtp.gmail.com with ESMTPSA id y15sm12438838eds.56.2020.11.17.13.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:28:57 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] casts should drop qualifiers
Date:   Tue, 17 Nov 2020 22:28:29 +0100
Message-Id: <20201117212829.99552-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <CAHk-=wivBmCoux_bVz_tZ12byZS=oZ7+F2Og8OjJGM5aiM-KQQ@mail.gmail.com>
References: <CAHk-=wivBmCoux_bVz_tZ12byZS=oZ7+F2Og8OjJGM5aiM-KQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Casts should drop qualifiers but Sparse doesn't do this yet.

The fix seems pretty simple: after having evaluated the type of
the cast, if this type is a SYM_NODE and contains qualifiers,
make a copy of the type with the qualifiers removed and use
this copy as the type.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---

This seems a bit too simple to be true but it seems correct and
it passes the testcase here under and a related testcase from GCC.

 evaluate.c                    | 13 +++++++++++++
 validation/eval/cast-unqual.c | 14 ++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 validation/eval/cast-unqual.c

diff --git a/evaluate.c b/evaluate.c
index 43a611696787..004cd2f9b339 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2998,6 +2998,18 @@ static struct symbol *evaluate_compound_literal(struct expression *expr, struct
 	return sym;
 }
 
+static struct symbol *unqualify_type(struct symbol *ctype)
+{
+	if (ctype->type == SYM_NODE && (ctype->ctype.modifiers & MOD_QUALIFIER)) {
+		struct symbol *unqual = alloc_symbol(ctype->pos, 0);
+
+		*unqual = *ctype;
+		unqual->ctype.modifiers &= ~MOD_QUALIFIER;
+		return unqual;
+	}
+	return ctype;
+}
+
 static struct symbol *evaluate_cast(struct expression *expr)
 {
 	struct expression *source = expr->cast_expression;
@@ -3025,6 +3037,7 @@ static struct symbol *evaluate_cast(struct expression *expr)
 		return evaluate_compound_literal(expr, source);
 
 	ctype = examine_symbol_type(expr->cast_type);
+	ctype = unqualify_type(ctype);
 	expr->ctype = ctype;
 	expr->cast_type = ctype;
 
diff --git a/validation/eval/cast-unqual.c b/validation/eval/cast-unqual.c
new file mode 100644
index 000000000000..0ea318875c96
--- /dev/null
+++ b/validation/eval/cast-unqual.c
@@ -0,0 +1,14 @@
+#define cvr const volatile restrict
+
+_Static_assert([typeof((cvr int) 0)] == [int]);
+_Static_assert([typeof((cvr int *) 0)] == [cvr int *]);
+
+static int *function(volatile int x)
+{
+	extern typeof((typeof(x)) (x)) y;
+	return &y;
+}
+
+/*
+ * check-name: cast-unqual
+ */
-- 
2.29.2

