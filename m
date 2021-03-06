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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028C0C43381
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 10:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C72026501B
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 10:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhCFKGe (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 6 Mar 2021 05:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhCFKGC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 6 Mar 2021 05:06:02 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD89C06175F
        for <linux-sparse@vger.kernel.org>; Sat,  6 Mar 2021 02:06:01 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id w17so8742770ejc.6
        for <linux-sparse@vger.kernel.org>; Sat, 06 Mar 2021 02:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/LMBevJmSCgopHRMDM4i5KKOiTA64I50nZ8Hg+dL4cU=;
        b=fQZyqesVms9Y5nCqF2bsITvxgATNejYgpjIZ06wbywiHU9bzLx7Cj8zMnimwG1yrxc
         HA7AjVouqbdHt659XFUJjuOKnSXyltgyTsNHteRxJEXYr6FXKhdfttzycRJVEAROGVvZ
         ETM2hIA+QbBZ+IYNmjIByJpyTxO42g2Yy5Pi+VVEfXcLJZZ6EN/N1hhlvxDns8WBRlHM
         /tKv0XMqqr7K+oTGAAoKfGxmlpkQBTgwnear7d3NpIWi2qC0yS8sDkkHz/88DhChHQQX
         rY/t5klLHIRHoWgsvDve5M3jM+QTYNyd3E8J6n3IZtah0HztcEivfLKFq+EnLYXp9B6A
         +Cig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/LMBevJmSCgopHRMDM4i5KKOiTA64I50nZ8Hg+dL4cU=;
        b=e9yJ56+ivjA0+rQjQce7CLuVUxFBToeEv0MFWYM2MIBz8uxzHrEVekPAL+05+5vWuM
         oiL3c7WrcDTa/EkgM0AVoqjtJK8F6n2JiCLhejMe+bykmwEiThEf7pQXlrikhc0/QDkV
         pZtLNTm+CNG3jD0Yq+tLAqfGXE9nMlh1NmbkyC8UpToQlvnA/kSLVfZLlmPz9cbRDz8W
         XHF+/Byaw4bgaz8WIw19knW08q5c6Z2h3pyKzY/n3YC7aeHFp/dUReMmGSiNy8HRZiRu
         A7wdXQk/KwCnrQR2hzWI9ZdVeJ1r7EuHk00biW2B2cSCArIOAspeVj0W5AuT51sUVHlK
         mxgA==
X-Gm-Message-State: AOAM5320gN9Bzx2Wv25Kxx4coJB+WOwPvjVy+nlSi8bM69Bjg6FO3kWS
        DfFlyyGx3hERP6PVR2SnuXVlNBdLSQQ=
X-Google-Smtp-Source: ABdhPJwLNtlD7t8gOLIunt2vL9FR2XRhcSynhFsO98rOYxqSM8ucLhHzgGTmeoEpl7S69P4mh9cRAg==
X-Received: by 2002:a17:906:f02:: with SMTP id z2mr6344871eji.469.1615025160341;
        Sat, 06 Mar 2021 02:06:00 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c537:1c5b:9ed2:3808])
        by smtp.gmail.com with ESMTPSA id i11sm2624020ejf.76.2021.03.06.02.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 02:06:00 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/6] ptrlist: make linearize_ptr_list() generic
Date:   Sat,  6 Mar 2021 11:05:51 +0100
Message-Id: <20210306100552.33784-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210306100552.33784-1-luc.vanoostenryck@gmail.com>
References: <20210306100552.33784-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The ptrlist API has a function to copy the elements of a ptrlist
into an array but it's not typed and thus needs a wrapper (or casts)
for each type it's used for. Also, 'linearize' is confusing since
this is unrelated to Sparse's linearization.

Simplify this by adding a generic (but type-safe) macro for this
(and changing the name): ptr_list_to_array()

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ptrlist.h  | 6 ++++++
 simplify.c | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/ptrlist.h b/ptrlist.h
index 0b06142252f5..5a3dcbeb97ae 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -84,6 +84,12 @@ extern void __free_ptr_list(struct ptr_list **);
 		(PTRLIST_TYPE(lst)) ptr_list_nth_entry(head, nth);\
 	})
 
+#define ptr_list_to_array(list, array, size) ({				\
+		struct ptr_list* head = (struct ptr_list*)(list);	\
+		CHECK_TYPE(list, *array);				\
+		linearize_ptr_list(head, (void**)array, size);		\
+	})
+
 ////////////////////////////////////////////////////////////////////////
 // API
 #define PREPARE_PTR_LIST(head, ptr) \
diff --git a/simplify.c b/simplify.c
index 584078ddca89..cf5b3d748808 100644
--- a/simplify.c
+++ b/simplify.c
@@ -83,7 +83,7 @@ static struct basic_block *phi_parent(struct basic_block *source, pseudo_t pseud
 //	number of element, a positive number if there was
 //	more than expected and a negative one if less.
 //
-// :note: we can't reuse a function like linearize_ptr_list()
+// :note: we can't reuse ptr_list_to_array() for the phi-sources
 //	because any VOIDs in the phi-list must be ignored here
 //	as in this context they mean 'entry has been removed'.
 static int get_phisources(struct instruction *sources[], int nbr, struct instruction *insn)
@@ -116,7 +116,7 @@ static int if_convert_phi(struct instruction *insn)
 	bb = insn->bb;
 	if (get_phisources(array, 2, insn))
 		return 0;
-	if (linearize_ptr_list((struct ptr_list *)bb->parents, (void **)parents, 3) != 2)
+	if (ptr_list_to_array(bb->parents, parents, 3) != 2)
 		return 0;
 	p1 = array[0]->phi_src;
 	bb1 = array[0]->bb;
-- 
2.30.0

