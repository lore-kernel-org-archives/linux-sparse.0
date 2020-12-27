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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36392C433E0
	for <linux-sparse@archiver.kernel.org>; Sun, 27 Dec 2020 11:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA572224B8
	for <linux-sparse@archiver.kernel.org>; Sun, 27 Dec 2020 11:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgL0LEt (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 27 Dec 2020 06:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgL0LEt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 27 Dec 2020 06:04:49 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2ECC061794
        for <linux-sparse@vger.kernel.org>; Sun, 27 Dec 2020 03:04:08 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id g185so6791099wmf.3
        for <linux-sparse@vger.kernel.org>; Sun, 27 Dec 2020 03:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TwsEre0+wy7WGpgCfW0B5sRI88WvSwX0ugiGXs0WJIg=;
        b=cEYvwSCjWIzj2TrcBysu7yuvure/x14DEVI6lKVlESPJEpenMbOWnTOp3dNg5E2bKu
         UCwP2iOrZ96zI2Hy9hYcrrPBqDUyMLBZtGkQyRdB8rBvdR1fMGKEPfcUw74FA7gkQaCW
         U+pXVuk9nbSFT+7LJgvvWNch/3H7/IOld6+uZ/69i4xsjOLCKfhkgY2kru51Lmmtovh5
         p/YvutNygNK7wKO5B5CnAfuXoW5U1ZI5G6htB/fVI3v5cn67PGwtEint4Lxyi9i5BF3z
         1EP2UA2gdbbFgozuSJ7i5rKvH4KCwRLWXsO26Raa96142l2+lgC/bW3JyU66JagppsFV
         VtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TwsEre0+wy7WGpgCfW0B5sRI88WvSwX0ugiGXs0WJIg=;
        b=FAJi0rGleLmNzfIqZyxmC4d04qqmCrkiN6CHIjKvNPwAA1XUXc1SiozdldSVHeTEl/
         B5BWkX88w1KGt4Z2C87Wnf5nM3zcm5P8ZHc9m3wrwpOCa5jWjN3cb5/Zw6xfNX4k9ecG
         aC2EmG76O9vjvJPkZ+FOkRuvkAm/Kfa3QhRNopuMqBEBCznv+jrsmhoCOe7w22cwB7Uj
         mZ26uJwp8px5UA1CmKCm+aUPgp6/7wwTFeunakqsUa7mfqIqHa2iElhGcLrKk1Xq5tBt
         fNKiVF1cAIjQAqfGv+Rmo2hyw2OeH55yjAWhHqBNBhI7rzfWEpwGHY7VNoK/3subGbbN
         pWcA==
X-Gm-Message-State: AOAM532SC5WPBfgjHqN4H/LlYdvjyaviv8SSaMWIXkyNYJ6T+cozGo66
        1M1wDgnGhvuYbK1Cx5mF8ZjktZ3euYs=
X-Google-Smtp-Source: ABdhPJyErL5SzKuK9OtT/bHSIrTXkW14yJn1RQFT1Iu4wqqyY59g5GOP8rtUMXtfMqg+MRVBA/RoWQ==
X-Received: by 2002:a1c:df85:: with SMTP id w127mr16331525wmg.166.1609067046235;
        Sun, 27 Dec 2020 03:04:06 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c99c:3949:2fe7:7420])
        by smtp.gmail.com with ESMTPSA id z2sm16059307wml.23.2020.12.27.03.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 03:04:05 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] ptrlist: avoid mixing reverse and non-reverse macros
Date:   Sun, 27 Dec 2020 12:04:01 +0100
Message-Id: <20201227110401.34501-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The macros used to iterate the ptrlists exist in two kinds:
those to iterate forward direction and those to iterate in the
reverse direction.

Those macros must be used in pair: one for the top of the loop and
one at the end of the loop. However, if we mix them, for example like:
	FOR_EACH_PTR(list, var) {
		...
	} FOR_EACH_PTR_REVERSE(var);

things will still work for lists with a single block (most of them)
but will behave strangely and of course wrongly when reaching the
next block.

So, to avoid future debugging fun, add a unused variable, discarded
at compile time, but with distinct prefix for each direction. This way,
mixing the macros will create a warning at compile time.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ptrlist.h | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/ptrlist.h b/ptrlist.h
index 2411e745ab24..4bf8c709ac08 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -89,27 +89,27 @@ extern void __free_ptr_list(struct ptr_list **);
 	DO_FINISH(ptr, __head##ptr, __list##ptr, __nr##ptr)
 
 #define RECURSE_PTR_REVERSE(ptr, new)					\
-	DO_REVERSE(ptr, __head##ptr, __list##ptr, __nr##ptr,		\
+	DO_REVERSE(ptr, __head##ptr, __list##ptr, __nr##ptr, __rname##new, \
 		   new, __head##new, __list##new, __nr##new, PTR_ENTRY_UNTAG)
 
 
 #define FOR_EACH_PTR(head, ptr) \
-	DO_FOR_EACH(head, ptr, __head##ptr, __list##ptr, __nr##ptr, PTR_ENTRY_NOTAG)
+	DO_FOR_EACH(head, ptr, __head##ptr, __list##ptr, __nr##ptr, __name##ptr, PTR_ENTRY_NOTAG)
 
 #define FOR_EACH_PTR_TAG(head, ptr) \
-	DO_FOR_EACH(head, ptr, __head##ptr, __list##ptr, __nr##ptr, PTR_ENTRY_UNTAG)
+	DO_FOR_EACH(head, ptr, __head##ptr, __list##ptr, __nr##ptr, __name##ptr,  PTR_ENTRY_UNTAG)
 
 #define END_FOR_EACH_PTR(ptr) \
-	DO_END_FOR_EACH(ptr, __head##ptr, __list##ptr, __nr##ptr)
+	DO_END_FOR_EACH(ptr, __head##ptr, __list##ptr, __nr##ptr, __name##ptr)
 
 #define FOR_EACH_PTR_REVERSE(head, ptr) \
-	DO_FOR_EACH_REVERSE(head, ptr, __head##ptr, __list##ptr, __nr##ptr, PTR_ENTRY_NOTAG)
+	DO_FOR_EACH_REVERSE(head, ptr, __head##ptr, __list##ptr, __nr##ptr, __rname##ptr,  PTR_ENTRY_NOTAG)
 
 #define FOR_EACH_PTR_REVERSE_TAG(head, ptr) \
-	DO_FOR_EACH_REVERSE(head, ptr, __head##ptr, __list##ptr, __nr##ptr, PTR_ENTRY_UNTAG)
+	DO_FOR_EACH_REVERSE(head, ptr, __head##ptr, __list##ptr, __nr##ptr, __rname##ptr, PTR_ENTRY_UNTAG)
 
 #define END_FOR_EACH_PTR_REVERSE(ptr) \
-	DO_END_FOR_EACH_REVERSE(ptr, __head##ptr, __list##ptr, __nr##ptr)
+	DO_END_FOR_EACH_REVERSE(ptr, __head##ptr, __list##ptr, __nr##ptr, __rname##ptr)
 
 #define THIS_ADDRESS(ptr) \
 	DO_THIS_ADDRESS(ptr, __head##ptr, __list##ptr, __nr##ptr)
@@ -184,9 +184,10 @@ extern void __free_ptr_list(struct ptr_list **);
 		VRFY_PTR_LIST(__head); /* Sanity-check nesting */	\
 	} while (0)
 
-#define DO_FOR_EACH(head, ptr, __head, __list, __nr, PTR_ENTRY) do {	\
+#define DO_FOR_EACH(head, ptr, __head, __list, __nr, __name, PTR_ENTRY) do {	\
 	__typeof__(head) __head = (head);				\
 	__typeof__(head) __list = __head;				\
+	__typeof__(head) __name = __head;				\
 	int __nr;							\
 	if (!__head)							\
 		break;							\
@@ -196,14 +197,16 @@ extern void __free_ptr_list(struct ptr_list **);
 			if (__list->rm && !ptr)				\
 				continue;				\
 
-#define DO_END_FOR_EACH(ptr, __head, __list, __nr)			\
+#define DO_END_FOR_EACH(ptr, __head, __list, __nr, __name)		\
 		}							\
 	} while ((__list = __list->next) != __head);			\
+	(void) __name;						\
 } while (0)
 
-#define DO_FOR_EACH_REVERSE(head, ptr, __head, __list, __nr, PTR_ENTRY) do { \
+#define DO_FOR_EACH_REVERSE(head, ptr, __head, __list, __nr, __name, PTR_ENTRY) do { \
 	__typeof__(head) __head = (head);				\
 	__typeof__(head) __list = __head;				\
+	__typeof__(head) __name = __head;				\
 	int __nr;							\
 	if (!head)							\
 		break;							\
@@ -216,15 +219,17 @@ extern void __free_ptr_list(struct ptr_list **);
 				continue;				\
 
 
-#define DO_END_FOR_EACH_REVERSE(ptr, __head, __list, __nr)		\
+#define DO_END_FOR_EACH_REVERSE(ptr, __head, __list, __nr, __name)	\
 		}							\
 	} while (__list != __head);					\
+	(void) __name;							\
 } while (0)
 
-#define DO_REVERSE(ptr, __head, __list, __nr, new, __newhead,		\
+#define DO_REVERSE(ptr, __head, __list, __nr, __name, new, __newhead,	\
 		   __newlist, __newnr, PTR_ENTRY) do {			\
 	__typeof__(__head) __newhead = __head;				\
 	__typeof__(__head) __newlist = __list;				\
+	__typeof__(__head) __name = __list;				\
 	int __newnr = __nr;						\
 	new = ptr;							\
 	goto __inside##new;						\
-- 
2.29.2

