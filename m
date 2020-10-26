Return-Path: <SRS0=2wv3=EB=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD540C2D0A3
	for <linux-sparse@archiver.kernel.org>; Mon, 26 Oct 2020 04:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ACD420885
	for <linux-sparse@archiver.kernel.org>; Mon, 26 Oct 2020 04:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAM3vO2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421727AbgJZExw (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 26 Oct 2020 00:53:52 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42728 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1421724AbgJZExv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 26 Oct 2020 00:53:51 -0400
Received: by mail-ed1-f65.google.com with SMTP id v19so7935051edx.9
        for <linux-sparse@vger.kernel.org>; Sun, 25 Oct 2020 21:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vHuVCeZqXXjUwloiAlWVyPXFVkqUORu74pKpfM7S7Mk=;
        b=BAM3vO2tWDWGn0NtNR55WU8Hcw9jY7JDD1RO2pgP4NalyGgl1p0XQjIwOSjYg3bedk
         UzwKMauL3XNTEa03G5i4IM9CtxFJq8JsOWRBBnUfs6n4S+7r400LAhEzSrUCPMe3XujO
         0A2wFACpr8U86MM6SbxSYCJfcQmkRzp/9gqM2C2IXQvgMmwDgX7XGPmQc35mZA3op/cY
         O0KKpteakwWWv/BEWnoql3QZuu1XY4SX2rbqgTmyQVwJWabl3Or7O5XGpRWrZHdsOEyd
         OaVUweG+jxzauhPHzHmL89m/Zj5wGnrNKzpNxKT1sj9QeXwz/4MgYa4b7A6PoG2QHjc/
         tL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vHuVCeZqXXjUwloiAlWVyPXFVkqUORu74pKpfM7S7Mk=;
        b=dr+r3ZlqCyIM0JqwkWN7wKJw+ijlhjPFBvzuJursYvGL27Bich1b5/dswunuP3GOEl
         zdCFewBa93XbkRdWPTF56jFEAE9to/5H2ArYX1twDYOOZm+suQTauG9mHZOx5+XOZx2m
         6qHrKxxPjV8MnaFmuaK+sLmy2ozbenY/jnNN56yYTWavXLe01R6G80qhAS+ddI0N8feB
         l2Fj8CFpN1WjLwRnnqUpWmqqYHBt/82n0hiKAgRUQqejY7i5TD/86QeQyMF/AHF8yotT
         Nx3j9vw0cW0uGg0Yf9093+9+vkFk8dKXOXjKclUjGoKgqY9/xnusabC6Vg/kK0e492X0
         W5/g==
X-Gm-Message-State: AOAM533SKOCmKwQNHlX6fTrwmJO88qg4n0NRnqo7MTUXgZYKisM4Ftb+
        vwzi1hIOcrnnr6krSjIOlEkvpi54Ozw=
X-Google-Smtp-Source: ABdhPJxHe+ahXPpP3QdhglOKxyu6HXmFin1JwcAzMNe7F9e2/k5paokHixu30X3klwWz6l8cpHXN9A==
X-Received: by 2002:aa7:d892:: with SMTP id u18mr14414603edq.305.1603688029785;
        Sun, 25 Oct 2020 21:53:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:386e:dbb8:c5ed:3b46])
        by smtp.gmail.com with ESMTPSA id z22sm4949699ejw.107.2020.10.25.21.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 21:53:49 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] handle more graciously labels with no statement
Date:   Mon, 26 Oct 2020 05:53:38 +0100
Message-Id: <20201026045338.55218-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

In C a label must precede a statement. A null statement is OK
but a closing braces is not.

So, catch this situation, emit a warning and continue as if a
null statement was there.

This occurs currently on v5.10-rc1 because of some ifdefery.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/parse.c b/parse.c
index 31ecef0f554d..b6090d38cc61 100644
--- a/parse.c
+++ b/parse.c
@@ -2468,6 +2468,11 @@ static struct token *statement(struct token *token, struct statement **tree)
 					warn_label_usage(stmt->pos, s->label_pos, s->ident);
 			}
 			s->stmt = stmt;
+			if (match_op(token, '}')) {
+				warning(token->pos, "statement expected after label");
+				stmt->label_statement = alloc_statement(token->pos, STMT_NONE);
+				return token;
+			}
 			return statement(token, &stmt->label_statement);
 		}
 	}
-- 
2.29.0

