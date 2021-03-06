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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48BEC433E0
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 10:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DFCC6501B
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 10:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhCFKGA (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 6 Mar 2021 05:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhCFKF7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 6 Mar 2021 05:05:59 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC359C061760
        for <linux-sparse@vger.kernel.org>; Sat,  6 Mar 2021 02:05:58 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id r17so8697659ejy.13
        for <linux-sparse@vger.kernel.org>; Sat, 06 Mar 2021 02:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yJUErk6FrLpmdmFAUynssTvYnXkf3kxFQ/e396/koRU=;
        b=lHzLlsPVYc10GGnjdIw7nn9JHjIoOyFgt3M0mhXP7b/JMz0/EB1vgtlfoluy719jF6
         eRjAw47tm6HrYv7vGqI9nYGr8dN9fj4FVvsdn1j0ZTS6Vv0KBHeVqMAhURI06XR+cg0y
         E0N63Qb+ePFCGSVeLJ8DouxvBobo4QzcB85aCRrjFHfXtgaXPHbKjCB8+bSMrSWzS6zC
         5KE6Qs4OeHLAp/sOaEY3FxM1tx9gP4/SMXerQb5tqg/EOvUFZYWU968GpN23zT7Xp8hy
         /iAzfXERJHaClZKiwIKLOAD6npPVcSFqedwtJXa75BOEak6y4EhIHJyzs5MN1utXz4g9
         MHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yJUErk6FrLpmdmFAUynssTvYnXkf3kxFQ/e396/koRU=;
        b=nOVkTSjfZElaFPTI/nl/cjhkNLZqq0eFZ+j8g3Vryq/AsJ+kY8R5T3SNqEqjy3lS8W
         MCgMByi2v97FXpTHdseb6EmJbFSZjmYIpwxA1AcZIiLNDlr4n4lAbKuN0tL+rczcaql6
         TGmtyoc5nXrCC+h1Qd1CAjdedrkevWVbsiEEEqvEin/is5xxWLQNnpjqNPpzq37z0NAF
         mrfm2wfvUGl5TNN92UZH8KTFL8s+Vq4l27Wc1oFZA5mEdhKCgHgYOjUnJkZzAizgjing
         vfEB0LyQOy9S9N3Pv+G/ik4hUnHc6Jmw+1ledGZ+B/v0rglw3bhH3yYy7Ed7uNAtu5aa
         isUQ==
X-Gm-Message-State: AOAM531t91TISjR08f4KVRzlDVSu8TXESsfXSL9XZAMzhs3/vrrIDCp0
        F/mXTBSgp0shi7JKygrz5Ad5C5SWyqM=
X-Google-Smtp-Source: ABdhPJx6BYfB+JxUJz/S/TUnvCl2fHIFHVsaT0nAlDsKOfK62eDVLNaXC/FmKbFQ/VoOEh5CGbaSEg==
X-Received: by 2002:a17:907:7692:: with SMTP id jv18mr6309989ejc.475.1615025157759;
        Sat, 06 Mar 2021 02:05:57 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c537:1c5b:9ed2:3808])
        by smtp.gmail.com with ESMTPSA id i11sm2624020ejf.76.2021.03.06.02.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 02:05:57 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/6] ptrlist: ~fix TYPEOF()
Date:   Sat,  6 Mar 2021 11:05:47 +0100
Message-Id: <20210306100552.33784-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210306100552.33784-1-luc.vanoostenryck@gmail.com>
References: <20210306100552.33784-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The macro TYPEOF() return the type of the addresses of the pointers
stored in the list. That's one level too much in general.

Change it to simply return the type of the stored pointers.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ptrlist.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ptrlist.h b/ptrlist.h
index c5fa4cdd94cb..41d9011c8716 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -12,7 +12,7 @@
 
 /* Silly type-safety check ;) */
 #define CHECK_TYPE(head,ptr)		(void)(&(ptr) == &(head)->list[0])
-#define TYPEOF(head)			__typeof__(&(head)->list[0])
+#define TYPEOF(head)			__typeof__((head)->list[0])
 #define VRFY_PTR_LIST(head)		(void)(sizeof((head)->list[0]))
 
 #define LIST_NODE_NR (13)
@@ -251,7 +251,7 @@ extern void __free_ptr_list(struct ptr_list **);
 extern void split_ptr_list_head(struct ptr_list *);
 
 #define DO_INSERT_CURRENT(new, __head, __list, __nr) do {		\
-	TYPEOF(__head) __this, __last;					\
+	TYPEOF(__head) *__this, *__last;				\
 	if (__list->nr == LIST_NODE_NR) {				\
 		split_ptr_list_head((struct ptr_list*)__list);		\
 		if (__nr >= __list->nr) {				\
@@ -270,8 +270,8 @@ extern void split_ptr_list_head(struct ptr_list *);
 } while (0)
 
 #define DO_DELETE_CURRENT(__head, __list, __nr) do {			\
-	TYPEOF(__head) __this = __list->list + __nr;			\
-	TYPEOF(__head) __last = __list->list + __list->nr - 1;		\
+	TYPEOF(__head) *__this = __list->list + __nr;			\
+	TYPEOF(__head) *__last = __list->list + __list->nr - 1;		\
 	while (__this < __last) {					\
 		__this[0] = __this[1];					\
 		__this++;						\
-- 
2.30.0

