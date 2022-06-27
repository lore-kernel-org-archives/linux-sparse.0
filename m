Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812AFCCA47E
	for <linux-sparse@archiver.kernel.org>; Mon, 27 Jun 2022 19:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237721AbiF0TGA (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 27 Jun 2022 15:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbiF0TF5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Jun 2022 15:05:57 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A800325C7
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jun 2022 12:05:52 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r18so6541642edb.9
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jun 2022 12:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t3FlkA6KGyMSetsfDdWNAVCtVWa7Kh2+c3Hx2va4nkU=;
        b=DCio9e6WSIjJ8d6mbmqKUjJZw9Z3M+U6b/TFRN3+5skIH4IW+wEZADToJPfsK43/05
         ntOKW6RjUVGTQZ7XIETzHOZPqFhLoNuKi2HypzSVHd4vlBueR55PlfS43RVATIYo+7dr
         sW42KdG6b5+h6Rjl9iZeV2rYQIffAIIurPxhivqZ3CvpsWgtbMIXty7VrXud+XHpYWoQ
         zPzCLW/cs4oyXuesui7N9dGJryA2suyhkuKOKWwnakgS/gDeGosCwUprKot4X91QapCJ
         lPcCr5xmyy8j9e80JUUbC9U+VRU4p7RtMdWya5498y0TQ8p7My+B5J+MAqbehTHut3Oo
         FmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t3FlkA6KGyMSetsfDdWNAVCtVWa7Kh2+c3Hx2va4nkU=;
        b=wxd4PXzE/J0oyVrSpVqCqgzRqhDxbd5CfWP3OcakzARr8awfUO0e4a0vjOrMNpcBEl
         91BxZzAw+Euszm4xK3FnvkHJgpjVCJyGLQ1tSgrL2m2WWkug3H6hLItRcjF9QbVuc5fA
         Bg8GWfvZanMBHWqCRbpBoWXRnvvIq1gWB4EY+KsjD74CSBi681z8H4FZ6P4sQEFlhIb1
         8HQgPr93zgqmt5P06eP6GchzSL9mO0IvTdAev9kQbktkDt2s/d4gTaynnxqR+lCtf0Rn
         I/pC/rBmyaNCYyFF5404bJGViqSXzsRPN82+2SN4aoSiXW/IA8ijkpnXc/fEA4/QiWpe
         hyOg==
X-Gm-Message-State: AJIora85lsSqMB7GAmX5fDNtqtOzuiBSDTWKoyoEHUIksVY14FTpCbPg
        5Ln5/d5Q9afQ+ITK7aUE3YGZJkPc82U=
X-Google-Smtp-Source: AGRyM1u3MLVAeMypU3rrFb5O1LlVhhWu2SkVfJBKAiERKHvZINMHW+uTg69Nyu025NYqiF0+zdhf+A==
X-Received: by 2002:a05:6402:2312:b0:437:69ec:adef with SMTP id l18-20020a056402231200b0043769ecadefmr1188133eda.366.1656356751318;
        Mon, 27 Jun 2022 12:05:51 -0700 (PDT)
Received: from localhost.localdomain (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id p24-20020a170906615800b00709343c0017sm5456776ejl.98.2022.06.27.12.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 12:05:50 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/5] bitwise: do not remove the signedness of bitwise types
Date:   Mon, 27 Jun 2022 21:05:39 +0200
Message-Id: <20220627190540.13358-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627190540.13358-1-luc.vanoostenryck@gmail.com>
References: <CAHk-=wj8gM8q04v2jS5JGjEdoE2d+B4_nm74xrFjZ77f9YRsbA@mail.gmail.com>
 <20220627190540.13358-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

When bitwise types were added [1] the signedness modifiers
were removed from them. More exactly, it was MOD_SPECIFIER
which was removed. I suppose this was done because then
MOD_SPECIFIER contained the signedness bits but also MOD_CHAR,
MOD_LONG, ...  and those had to be removed.

But currently MOD_SPECIFIER contains only MOD_SIGNEDNESS
and the signedness info can be useful for bitwise types too.

So, do not removed anymore MOD_SPECIFIER from the bitwise
types' modifiers.

[1] commit 032f492af0ac ("[PATCH] __attribute__((bitwise))")

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c                          | 1 -
 show-parse.c                     | 2 +-
 validation/linear/bitwise-cmpu.c | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/parse.c b/parse.c
index 3d6fef7cb011..14fe9e15448a 100644
--- a/parse.c
+++ b/parse.c
@@ -1586,7 +1586,6 @@ static struct token *declaration_specifiers(struct token *token, struct decl_sta
 		}
 		type = alloc_symbol(token->pos, SYM_BASETYPE);
 		*type = *ctx->ctype.base_type;
-		type->ctype.modifiers &= ~MOD_SPECIFIER;
 		type->ctype.base_type = ctx->ctype.base_type;
 		type->type = SYM_RESTRICT;
 		ctx->ctype.base_type = type;
diff --git a/show-parse.c b/show-parse.c
index e2fc18bb4b3d..2ab2479b8181 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -318,7 +318,7 @@ deeper:
 		if (as)
 			prepend(name, "%s ", show_as(as));
 
-		if (sym && (sym->type == SYM_BASETYPE || sym->type == SYM_ENUM))
+		if (sym && (sym->type == SYM_BASETYPE || sym->type == SYM_ENUM || sym->type == SYM_RESTRICT))
 			mod &= ~MOD_SPECIFIER;
 		s = modifier_string(mod);
 		len = strlen(s);
diff --git a/validation/linear/bitwise-cmpu.c b/validation/linear/bitwise-cmpu.c
index 8932436a7764..e151b9741fa3 100644
--- a/validation/linear/bitwise-cmpu.c
+++ b/validation/linear/bitwise-cmpu.c
@@ -8,7 +8,6 @@ static int gtu(bu32 x, bu32 y)  { return (x >  y); }
 /*
  * check-name: bitwise-cmpu
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-excludes: setlt\\.
-- 
2.36.1

