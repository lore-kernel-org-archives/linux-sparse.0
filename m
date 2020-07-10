Return-Path: <SRS0=t/C/=AV=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA5CC433E0
	for <linux-sparse@archiver.kernel.org>; Fri, 10 Jul 2020 00:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7892A2065F
	for <linux-sparse@archiver.kernel.org>; Fri, 10 Jul 2020 00:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEkJpH8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgGJAN7 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 9 Jul 2020 20:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgGJAN6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Jul 2020 20:13:58 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E037C08C5CE
        for <linux-sparse@vger.kernel.org>; Thu,  9 Jul 2020 17:13:58 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id e22so3205389edq.8
        for <linux-sparse@vger.kernel.org>; Thu, 09 Jul 2020 17:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NfypURhc8fRwGKsCN3Fi1teRWpnr4uQOjC+FxPJZPQ4=;
        b=IEkJpH8nn4Zwk32560uUonQtDe2rrXJ14SEF85FjH6CukJ+JnyUCR4+Li5I8qzwPUR
         TEAHyih/gd0GubwTmzz13pAOtiofY5GpNAQON9NsW5/Idtp00wn8X0TdHKJ1DOSwxHA3
         G8RpXNMeVI9OZ0lQicvv+LdB10uyJVcO0DNIh8aGnYuW0PmXcaYBMm0L6KNh85NjTbke
         01QiZb6uQ6en49EQ5oXw+bCWrjC4D6cEzKDIuaDBn2Czh9RN0csWM9M/zkJt/rexPR/Q
         xnPSc4PZwDutXAWJfgy2ZYVPpUpfHlV0+rz+jFvv1QVQgH8yjPBCIq5JGCIf7ZcwgxOz
         fdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NfypURhc8fRwGKsCN3Fi1teRWpnr4uQOjC+FxPJZPQ4=;
        b=B+g4X9q34PTl5RbG5DS4DRMo6jBSDH0wbpkTCxzblVunTcFpw78qKN1sgVSlPZT93C
         xJtb5j3V5DxFbCVt2G/y62UZsY13s+5YbbM1QGIHJmm85onxyeoMoGkNXM2ueYL9fvCD
         d6fvNHR13U0ehkKLW430PdXj7DcUaKOw0XdlwazvzXOdGWnPu5Pmr0LLUsm+7KpC1OaN
         cCNYmF5YL6bV+WI3MFy/+lDN8L2XGqIrk0P2vH4b6j8davOvx95MZ+cMJgPDDaGyGsgF
         UwQoZ6/oC4O++m6OhZtBR/Rp7mREpAzajqy498yOYwV4j43OUfcTRhQNhXokZ1FHpCVz
         smMw==
X-Gm-Message-State: AOAM531/dd7whQ8NI9sOPC7dcywaDLJ8f3CT9EiRRanUzLDg4GwB4fm/
        D5cuYKywwkDWxGskRXKdM/IUbUsU
X-Google-Smtp-Source: ABdhPJxI9Qq0/1hAKAISR/MCJCgbwG4ocIJfFqlYx47q++tdbMFghFb4JyIA6oXEiere/S4kiOP3Fg==
X-Received: by 2002:aa7:d58c:: with SMTP id r12mr78422682edq.160.1594340036795;
        Thu, 09 Jul 2020 17:13:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:c80f:e21c:9480:e854])
        by smtp.gmail.com with ESMTPSA id u8sm2614199ejm.65.2020.07.09.17.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 17:13:56 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/4] [RFC] fix evaluation error with assignment of qualified arrays
Date:   Fri, 10 Jul 2020 02:13:22 +0200
Message-Id: <20200710001322.18391-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710001322.18391-1-luc.vanoostenryck@gmail.com>
References: <20200710001322.18391-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This is a fix for a problem reported today to the mailing list.

In check_assignment_types(), the first 'level' is checked by the
function itself but the next level is checked by the type_difference().
This later function take as arguments, beside the types to be
checked, the modifiers that can be assumed for each of the types
(this works as a kind of reverse mask).
But these modifiers are taken from target_qualifiers() which,
purposely ignore the modifiers for arrays introduced in commit
    984b7b66457c ("[PATCH] deal correctly with qualifiers on arrays")
with the comment:
    "Pointers to any array are considered as pointers to unqualified
    type as far as implicit conversions are concerned"

But by dropping these modifiers, type_difference() reports
incorrect results for pointers to qualified arrays.

So, do not use target_qualifiers() but take the modifiers directly
from the ctypes. Admittingly, I'm far from sure that this is the
right fix but it solve several wrong cases.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                     | 4 ++--
 validation/eval/array-quals0.c | 1 -
 validation/eval/array-quals1.c | 1 -
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index f515ce6f2de6..dddea76182ad 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1444,8 +1444,8 @@ static int check_assignment_types(struct symbol *target, struct expression **rp,
 		}
 		b1 = examine_pointer_target(t);
 		b2 = examine_pointer_target(s);
-		mod1 = target_qualifiers(t);
-		mod2 = target_qualifiers(s);
+		mod1 = t->ctype.modifiers & MOD_IGN;
+		mod2 = s->ctype.modifiers & MOD_IGN;
 		if (whitelist_pointers(b1, b2)) {
 			/*
 			 * assignments to/from void * are OK, provided that
diff --git a/validation/eval/array-quals0.c b/validation/eval/array-quals0.c
index 9cb08c1722d7..30727490289e 100644
--- a/validation/eval/array-quals0.c
+++ b/validation/eval/array-quals0.c
@@ -3,5 +3,4 @@ static const int (*p)[3] = a;
 
 /*
  * check-name: array-quals0
- * check-known-to-fail
  */
diff --git a/validation/eval/array-quals1.c b/validation/eval/array-quals1.c
index a1c3905826d5..d3e54f3ec8dc 100644
--- a/validation/eval/array-quals1.c
+++ b/validation/eval/array-quals1.c
@@ -25,7 +25,6 @@ static          void *const ko_vi__a = &vi__a;
 
 /*
  * check-name: array-quals1
- * check-known-to-fail
  *
  * check-error-start
 eval/array-quals1.c:12:38: warning: incorrect type in initializer (different modifiers)
-- 
2.27.0

