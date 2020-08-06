Return-Path: <SRS0=443P=BQ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FCAC433E3
	for <linux-sparse@archiver.kernel.org>; Thu,  6 Aug 2020 19:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D3F02173E
	for <linux-sparse@archiver.kernel.org>; Thu,  6 Aug 2020 19:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+4qFtbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgHFTaU (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgHFTaS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Aug 2020 15:30:18 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42135C061756
        for <linux-sparse@vger.kernel.org>; Thu,  6 Aug 2020 12:30:17 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id kq25so38597822ejb.3
        for <linux-sparse@vger.kernel.org>; Thu, 06 Aug 2020 12:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n5gINhC93RtqUZgvecGvrwdyhe1McBasM8u/as0xh30=;
        b=c+4qFtbniE2HzJ/QujMP1QQXvPaKY+cyBHvoAbEmh3e8UK5xdqPgMF11VUJPNlHTxv
         9vsfuyrPvwWKMqpPRjTXF3DuPA5ya0cw+b5ivDE2+9by21cvTawM2eek4bRhIKdJJXEr
         6HX4jNNtdMjF0NCh3U1NZQ34H/yags+JMfr95whXHJ+gRx9562UZ/LSyPp2VVSxrbvj1
         rx2EFeYspFrLWwFiJHArdA0TiU83NnPaDxCDv05DXeyqjldB5wrs4yv3l+AxhzR3bk8G
         oCrMBoapEDSXoL08+8pLNvil0482RAhWXquSBGwH5dzW2HG3sIWM5S6cV7oNwwdKBq/F
         Pxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n5gINhC93RtqUZgvecGvrwdyhe1McBasM8u/as0xh30=;
        b=BkexlQ9O0Uzu3hewoTbqJr/DGAvoitSX++HNkTBxwDjRkW5WAUYEevc7EMwgyadr26
         +VWrVzHtJcC4ANyHXhOa1BM7UHVpVjLAMZDUv/VSbAFcpbszxQ5GAbinKzQvkX+5hM1L
         wogsWp9fXnkpgERXDpkSkYZ2LMNMbo1ssnflwqrtQyvFT+UTZA01X4TJP+wmj1ejCAmG
         pdK4yg1sIpNzb6yJ1ZQiZBDG6RBQ7+RVHa/R4sNvYU1tNxIYJsRNdvABnRrIhV9NMi4x
         iy4T0hxQcrGMigW7kb4zUoZ9SU92I7ha9wIQqy6rtE4P59U0zmKKp7VI04EEQnG36d73
         ttTQ==
X-Gm-Message-State: AOAM532l+A/lEMYJFm/lwPiN233SmDnKnQbPJzk/PxNFyJ0AqiFHfzcB
        9O2quSYe6SrGbQC/wIa7ZFGSjaGk
X-Google-Smtp-Source: ABdhPJz5JUt2lHa7oURVgvMrLx5byd2NXWNCTNhJYgBYwe2KMrLo6WLE5G4y1DN5G0lAF+u0+6jgzw==
X-Received: by 2002:a17:906:269a:: with SMTP id t26mr5888328ejc.286.1596742215725;
        Thu, 06 Aug 2020 12:30:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:d567:ec52:e0a5:f485])
        by smtp.gmail.com with ESMTPSA id t19sm4055972edw.63.2020.08.06.12.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 12:30:14 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Stafford Horne <shorne@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/4] shift-assign: restrict shift count to unsigned int
Date:   Thu,  6 Aug 2020 21:30:02 +0200
Message-Id: <20200806193003.10144-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200806193003.10144-1-luc.vanoostenryck@gmail.com>
References: <20200806193003.10144-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

After the RHS of shift-assigns had been integer-promoted,
both gcc & clang seems to restrict it to an unsigned int.
This only make a difference when the shift count is negative
and would it make it UB.

Better to have the same generated code, so make the same here.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                        | 5 +++++
 validation/linear/shift-assign2.c | 1 -
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/evaluate.c b/evaluate.c
index 6d8ecd7f6c25..a9adc72f6b57 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1348,6 +1348,11 @@ static int evaluate_assign_op(struct expression *expr)
 			unrestrict(expr->right, sclass, &s);
 			source = integer_promotion(s);
 			expr->right = cast_to(expr->right, source);
+
+			// both gcc & clang seems to do this, so ...
+			if (target->bit_size > source->bit_size)
+				expr->right = cast_to(expr->right, &uint_ctype);
+
 			goto Cast;
 		} else if (!(sclass & TYPE_RESTRICT))
 			goto usual;
diff --git a/validation/linear/shift-assign2.c b/validation/linear/shift-assign2.c
index 30d74376478e..9990ac38e800 100644
--- a/validation/linear/shift-assign2.c
+++ b/validation/linear/shift-assign2.c
@@ -13,7 +13,6 @@ u64 u64s32(u64 a, s32 b) { a >>= b; return a; }
 /*
  * check-name: shift-assign2
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-start
 s64s16:
-- 
2.28.0

