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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8E6C433B4
	for <linux-sparse@archiver.kernel.org>; Sun, 18 Apr 2021 11:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D338610CC
	for <linux-sparse@archiver.kernel.org>; Sun, 18 Apr 2021 11:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhDRL5O (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 18 Apr 2021 07:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhDRL5O (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 18 Apr 2021 07:57:14 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FBAC061760
        for <linux-sparse@vger.kernel.org>; Sun, 18 Apr 2021 04:56:45 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id s15so37397205edd.4
        for <linux-sparse@vger.kernel.org>; Sun, 18 Apr 2021 04:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=07eS4yBn68wirJHAnWcxwjAWX50yqzrbmIiZnhblOAs=;
        b=HFcoqCOPbdsLRDL5tgtKPiBRgFchZBwsmMRA/IpGoCpBe5obDs9oymOGvwIv+lMuaV
         KZoMh/mZvv09dSsMAAounz44qJQXsjAwZJnwcdOw85w95hpyYzIHO9OBW8pPJPZbrXQw
         7QkOxtpOmwjE6tNJhLtITQszSopD6pP01RdlpCgkwRz00ZVKUjMyGxGDE6U06EgsXAKh
         rAng+ickF1nRtv7GVNJ1E7U/Cc99ZWMDhXeuW61qFaYK224E+jEzT4Oz4WQJtbK929kg
         QWmXes8j4uBjheCdnDTSJSETJytY36PTM7M7HiJjY16iM9WWLlJE3AWqY9YHIa/A+xyZ
         eMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=07eS4yBn68wirJHAnWcxwjAWX50yqzrbmIiZnhblOAs=;
        b=Ah58kNKioywtSqbGG78b4LBSm8b0S28Mndy+Ly5Ng/KQ3wWZeyO5Gb5sTNdb8NIkDG
         MWmsQUKsClluwugX4svBxaTuLdcN9+vvpC6N/rz/j1MYrpIk4NlYxkFHE7eaRkwdHtGm
         4pNsb6GaHvOSiulVt5lj9icCzgVfcCxyZSjnZePLUy3amSj8R4rlVsMR6PC1umcUomNK
         rn9n8xhmYTfmoHs3P6o+FLBG2Q3KMunOJGY1c7S2hmwVxcl4QjATMyWP2n1bNsua/nx9
         Bs7SUPXqc2XO16jjOzFtN1Cc6YAq1vyiO4SHeueKhhIU7l9Dv6MQ+w31UrCb8K8Tbg4x
         ewXg==
X-Gm-Message-State: AOAM5315g+tJIJDpulxgZZiwvbric9PUbKd/t7HfVw9i3nEahq86VelC
        mX5rJlkepWtDdkwmvL60pYBAnSDAyTg=
X-Google-Smtp-Source: ABdhPJz2rK66E9KMlcmAgiirhdub/oXl0ImDPclvPOgeX4EAAOsyxWFotiD06v+qR/a9SgKSDyvAhQ==
X-Received: by 2002:aa7:c40b:: with SMTP id j11mr20157244edq.219.1618747004539;
        Sun, 18 Apr 2021 04:56:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:959c:c85:d486:38cf])
        by smtp.gmail.com with ESMTPSA id y11sm10298199eds.10.2021.04.18.04.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 04:56:44 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] remove early simplification of casts during evaluation
Date:   Sun, 18 Apr 2021 13:56:35 +0200
Message-Id: <20210418115635.40608-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210418115635.40608-1-luc.vanoostenryck@gmail.com>
References: <20210418115635.40608-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The current code will simplify away some casts at evaluation time
but doesn't take in account some special cases:
* (bool)~<int>  is not equivalent to ~(bool)<int> (anything not all 0 or 1)
* (float)~<int> is not equivalent to ~(float)<int> which doesn't make sense.
* (int)(float)<int> is not a no-op if the (float) overflows

This kind of simplification is better done on the IR where the different
kind of casts correspond to distinct instructions.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                       | 44 +-------------------------------
 validation/eval/not-cast-bool.c  |  1 -
 validation/eval/not-cast-float.c |  1 -
 3 files changed, 1 insertion(+), 45 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index eea6b7adcf64..61f59ee3908e 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -226,12 +226,6 @@ static struct symbol *bigger_int_type(struct symbol *left, struct symbol *right)
 	return utype;
 }
 
-static int same_cast_type(struct symbol *orig, struct symbol *new)
-{
-	return orig->bit_size == new->bit_size &&
-	       orig->bit_offset == new->bit_offset;
-}
-
 static struct symbol *base_type(struct symbol *node, unsigned long *modp, struct ident **asp)
 {
 	unsigned long mod = 0;
@@ -316,10 +310,7 @@ static struct symbol *cast_to_bool(struct expression *expr);
 
 /*
  * This gets called for implicit casts in assignments and
- * integer promotion. We often want to try to move the
- * cast down, because the ops involved may have been
- * implicitly cast up, and we can get rid of the casts
- * early.
+ * integer promotion.
  */
 static struct expression * cast_to(struct expression *old, struct symbol *type)
 {
@@ -330,39 +321,6 @@ static struct expression * cast_to(struct expression *old, struct symbol *type)
 	if (old->ctype != &null_ctype && is_same_type(old, type))
 		return old;
 
-	/*
-	 * See if we can simplify the op. Move the cast down.
-	 */
-	switch (old->type) {
-	case EXPR_PREOP:
-		if (old->ctype->bit_size < type->bit_size)
-			break;
-		if (old->op == '~') {
-			old->ctype = type;
-			old->unop = cast_to(old->unop, type);
-			return old;
-		}
-		break;
-
-	case EXPR_IMPLIED_CAST:
-		warn_for_different_enum_types(old->pos, old->ctype, type);
-
-		if (old->ctype->bit_size >= type->bit_size) {
-			struct expression *orig = old->cast_expression;
-			if (same_cast_type(orig->ctype, type))
-				return orig;
-			if (old->ctype->bit_offset == type->bit_offset) {
-				old->ctype = type;
-				old->cast_type = type;
-				return old;
-			}
-		}
-		break;
-
-	default:
-		/* nothing */;
-	}
-
 	expr = alloc_expression(old->pos, EXPR_IMPLIED_CAST);
 	expr->ctype = type;
 	expr->cast_type = type;
diff --git a/validation/eval/not-cast-bool.c b/validation/eval/not-cast-bool.c
index af4224125c34..acd8bbf293db 100644
--- a/validation/eval/not-cast-bool.c
+++ b/validation/eval/not-cast-bool.c
@@ -8,7 +8,6 @@ static _Bool foo(void)
 /*
  * check-name: not-cast-bool
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
diff --git a/validation/eval/not-cast-float.c b/validation/eval/not-cast-float.c
index 445b91d7563e..d474d69bdda3 100644
--- a/validation/eval/not-cast-float.c
+++ b/validation/eval/not-cast-float.c
@@ -8,7 +8,6 @@ static int foo(void)
 /*
  * check-name: eval-bool-zext-neg
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.31.1

