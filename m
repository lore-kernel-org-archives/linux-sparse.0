Return-Path: <SRS0=i4AA=IE=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BFEC433E9
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 10:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D82A64E01
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 10:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhCFKGB (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 6 Mar 2021 05:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhCFKGA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 6 Mar 2021 05:06:00 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB36BC06175F
        for <linux-sparse@vger.kernel.org>; Sat,  6 Mar 2021 02:05:59 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id r17so8697691ejy.13
        for <linux-sparse@vger.kernel.org>; Sat, 06 Mar 2021 02:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qX3SBZ21v82TcVuRdPFXeNxVl38j3X/+7mvmbmRuvxs=;
        b=hrRg7K6+cag4yc/vC5rTENt1wyP7dmZEzmMLjYltGeBZOKqF8il7El1lMJi2BCFEw0
         s5x6wBnwq/QpMJ6lhSkV3oXNaAfmGbyyRYMHbNk92yoBgNwsm6X86i3iwDoSfRrNxPOV
         8Wrq7d0tGPPIwsYBSQEa50TKY2q/gfNvOpaivZG7GHLq2CFCZTLSaqOfe6oc8ipvRZjD
         pVOitGGK4pjAe019YuUuo/LY1XBLq/jq3PzLMeA9Rh4xz+PoDZj1NqhhX6SEPHH3+aLH
         4+61Pvy/BnRGkSYQP8Di/vtbrlle1ozH5DN0PkfLmz0nHaS54HtrYYCjXO47uV/UdPjm
         M0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qX3SBZ21v82TcVuRdPFXeNxVl38j3X/+7mvmbmRuvxs=;
        b=ERR0zgtqDxWOuhFNQ05phNPXsmlud+tCRtAwqeZgPkjDx/8Qwb6BUZRWNjBwlf0iUx
         d9qkAhFORnkILlHaPwTlHebYlJ0nIAdhBF7dfGllWo0g+aHeCwv2+UwPYDLDLIc2oplR
         /Dakt0HwW+5bLhfXZSscZ1BzOiVDV4GOQoRLlLbWZL9tRzWlCPahqcjOtOci+c7/Qre/
         0SzUYPKDD2XIYqTWJSzzOfa90kHI+3XVk9tEQQbrvo9RS7EUfaSddUktBsoLSzpU7j00
         QhVY2wytT1OpE7kyitgXlMUoglqS2nqBkgLoT3fGm5ntVCS5bZXCVQGtqBMpJz2G6lkK
         RJQw==
X-Gm-Message-State: AOAM5339LOTqh2dK1WIQ5wzhPkvjPubF/SrMrqs2Co8rn+nEAHpWaVPY
        MGHRkA39cayuFUunNSXsB/7UscOxE2E=
X-Google-Smtp-Source: ABdhPJxLrzrnrtt0xwccZs8EfTRie2cMHok6I9kK1+FHKKJXDSMu6+vrYKWhR7F2FP6baafkAd3+SQ==
X-Received: by 2002:a17:907:7637:: with SMTP id jy23mr5523630ejc.12.1615025158525;
        Sat, 06 Mar 2021 02:05:58 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c537:1c5b:9ed2:3808])
        by smtp.gmail.com with ESMTPSA id i11sm2624020ejf.76.2021.03.06.02.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 02:05:58 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/6] ptrlist: change TYPEOF() into PTRLIST_TYPE()
Date:   Sat,  6 Mar 2021 11:05:48 +0100
Message-Id: <20210306100552.33784-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210306100552.33784-1-luc.vanoostenryck@gmail.com>
References: <20210306100552.33784-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The name of the macro TYPEOF() is too generic and doesn't explain
that it only returns the type of the pointers stored in ptrlists.

So, change he name to something more explicit: PTRLIST_TYPE().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ptrlist.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/ptrlist.h b/ptrlist.h
index 41d9011c8716..3b952097545f 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -12,7 +12,7 @@
 
 /* Silly type-safety check ;) */
 #define CHECK_TYPE(head,ptr)		(void)(&(ptr) == &(head)->list[0])
-#define TYPEOF(head)			__typeof__((head)->list[0])
+#define PTRLIST_TYPE(head)		__typeof__((head)->list[0])
 #define VRFY_PTR_LIST(head)		(void)(sizeof((head)->list[0]))
 
 #define LIST_NODE_NR (13)
@@ -75,7 +75,7 @@ extern void __free_ptr_list(struct ptr_list **);
 
 #define ptr_list_nth(lst, nth) ({					\
 		struct ptr_list* head = (struct ptr_list*)(lst);	\
-		(__typeof__((lst)->list[0])) ptr_list_nth_entry(head, nth);\
+		(PTRLIST_TYPE(lst)) ptr_list_nth_entry(head, nth);\
 	})
 
 ////////////////////////////////////////////////////////////////////////
@@ -251,7 +251,7 @@ extern void __free_ptr_list(struct ptr_list **);
 extern void split_ptr_list_head(struct ptr_list *);
 
 #define DO_INSERT_CURRENT(new, __head, __list, __nr) do {		\
-	TYPEOF(__head) *__this, *__last;				\
+	PTRLIST_TYPE(__head) *__this, *__last;				\
 	if (__list->nr == LIST_NODE_NR) {				\
 		split_ptr_list_head((struct ptr_list*)__list);		\
 		if (__nr >= __list->nr) {				\
@@ -270,8 +270,8 @@ extern void split_ptr_list_head(struct ptr_list *);
 } while (0)
 
 #define DO_DELETE_CURRENT(__head, __list, __nr) do {			\
-	TYPEOF(__head) *__this = __list->list + __nr;			\
-	TYPEOF(__head) *__last = __list->list + __list->nr - 1;		\
+	PTRLIST_TYPE(__head) *__this = __list->list + __nr;		\
+	PTRLIST_TYPE(__head) *__last = __list->list + __list->nr - 1;	\
 	while (__this < __last) {					\
 		__this[0] = __this[1];					\
 		__this++;						\
-- 
2.30.0

