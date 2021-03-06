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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CB8C433E9
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 10:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A93A464E01
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 10:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhCFKGe (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 6 Mar 2021 05:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbhCFKGC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 6 Mar 2021 05:06:02 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373BAC061760
        for <linux-sparse@vger.kernel.org>; Sat,  6 Mar 2021 02:06:02 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id mm21so8678740ejb.12
        for <linux-sparse@vger.kernel.org>; Sat, 06 Mar 2021 02:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x1YcUyJjabQEKrMRUFckmxH6727IAtukLJ8KrLaI8nM=;
        b=SPAHbHhjujiHipimr43waa8qYQN10iOCtUqI2IwaK2vUnkVcuUMWmRF0Xp/l71BDyD
         forWlmLfXdk8tTwZPHPyM89Z5iiyyDFijkvKM/3lXZ3VdobvDyr59cskkHT7AdVn8Vm9
         IsT9pe3yViJJ5O4fPEd0AkZd2VonQoaDIJenF+7HLQ4so9cAJMOa6bPHDUgblVl8qeNF
         dYpKW9Jjjz2vImiOnfEuxWBj48fzBd4NY09jkjmdOgLXWtyQ0i+cjAl6bJwAlC/6UbgB
         CaTIq5OJ0v3BWvdQhoPgCVEtdbdg+8+FBuNJalFD1zC+VUcACZ8APbQkOUFPEU2i4f3k
         hlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x1YcUyJjabQEKrMRUFckmxH6727IAtukLJ8KrLaI8nM=;
        b=A0q1K5ta+25KT8zCO4+1glWixfA8xtimp/D99eGJbS6Q3JExIbJbsJTjVxELplcgmE
         P/2JyOEpdz/Qbia28sYjV1a8zjVEA+Dld3s+p0Q79s+p7pGn98LLDIsjjUgyBXA4D9bp
         OM7WLENoyFBADl+tL8Xk3DXFvI4xxAxVZUkC3dfGlvlAVpkedj94g39BmHwwHe22Brpm
         08gPmEFU4NihP+Jy6fMYtdU+6l5fnmW1zXkiQpCmPbBZ5ruvcmtoTW0Wm6le9JouD5iH
         SqaQ3vq4AZqQdVPTXsqNdlMToKSV4ME0v5vSX9LGLR3jq4CoLpcizMrPBFgytwYsx50L
         uONg==
X-Gm-Message-State: AOAM532uRc6sj5eluC/hK6mrTYZdTWPkz4opbmovSZEEJX58yUm59+2I
        lYn42HjE1xK77yRZ7nyKzjwA+U+QXpA=
X-Google-Smtp-Source: ABdhPJzkDavrVl/otsN0DyA5ubDCGkp+8y3sEJo7p4rSOz166KS9jAzgmVMt+BIr8WbUFxwsgfRuxA==
X-Received: by 2002:a17:906:4e17:: with SMTP id z23mr6420538eju.439.1615025160962;
        Sat, 06 Mar 2021 02:06:00 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c537:1c5b:9ed2:3808])
        by smtp.gmail.com with ESMTPSA id i11sm2624020ejf.76.2021.03.06.02.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 02:06:00 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/6] ptrlist: change return value of linearize_ptr_list()/ptr_list_to_array()
Date:   Sat,  6 Mar 2021 11:05:52 +0100
Message-Id: <20210306100552.33784-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210306100552.33784-1-luc.vanoostenryck@gmail.com>
References: <20210306100552.33784-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The function linearize_ptr_list() is annoying to use because it
returns the number of elements put in the array. So, if you need
to know if the list contained the expected number of entries,
you need to allocate to array with one more entries and check
that the return value is one less than the maximum size.

Change this, so that this function returns the total number of
entries in the list, much like it's done for snprintf().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ptrlist.c  | 10 +++++-----
 simplify.c |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/ptrlist.c b/ptrlist.c
index 0f0b3f6d818f..ecfbc07b2b6d 100644
--- a/ptrlist.c
+++ b/ptrlist.c
@@ -154,10 +154,10 @@ void *ptr_list_nth_entry(struct ptr_list *list, unsigned int idx)
 // @head: the list to be linearized
 // @arr: a ``void*`` array to fill with @head's entries
 // @max: the maximum number of entries to store into @arr
-// @return: the number of entries linearized.
+// @return: the number of entries in the list.
 //
 // Linearize the entries of a list up to a total of @max,
-// and return the nr of entries linearized.
+// and return the nunmber of entries in the list.
 //
 // The array to linearize into (@arr) should really
 // be ``void *x[]``, but we want to let people fill in any kind
@@ -170,14 +170,14 @@ int linearize_ptr_list(struct ptr_list *head, void **arr, int max)
 
 		do {
 			int i = list->nr;
+			nr += i;
+			if (max == 0)
+				continue;
 			if (i > max) 
 				i = max;
 			memcpy(arr, list->list, i*sizeof(void *));
 			arr += i;
-			nr += i;
 			max -= i;
-			if (!max)
-				break;
 		} while ((list = list->next) != head);
 	}
 	return nr;
diff --git a/simplify.c b/simplify.c
index cf5b3d748808..207af8edf28f 100644
--- a/simplify.c
+++ b/simplify.c
@@ -108,7 +108,7 @@ static int get_phisources(struct instruction *sources[], int nbr, struct instruc
 static int if_convert_phi(struct instruction *insn)
 {
 	struct instruction *array[2];
-	struct basic_block *parents[3];
+	struct basic_block *parents[2];
 	struct basic_block *bb, *bb1, *bb2, *source;
 	struct instruction *br;
 	pseudo_t p1, p2;
@@ -116,7 +116,7 @@ static int if_convert_phi(struct instruction *insn)
 	bb = insn->bb;
 	if (get_phisources(array, 2, insn))
 		return 0;
-	if (ptr_list_to_array(bb->parents, parents, 3) != 2)
+	if (ptr_list_to_array(bb->parents, parents, 2) != 2)
 		return 0;
 	p1 = array[0]->phi_src;
 	bb1 = array[0]->bb;
-- 
2.30.0

