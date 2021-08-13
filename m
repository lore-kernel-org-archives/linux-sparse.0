Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2054C4338F
	for <linux-sparse@archiver.kernel.org>; Fri, 13 Aug 2021 01:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF09360F57
	for <linux-sparse@archiver.kernel.org>; Fri, 13 Aug 2021 01:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238173AbhHMB05 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 12 Aug 2021 21:26:57 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:43979 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238139AbhHMB05 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 12 Aug 2021 21:26:57 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id CE9745C0129;
        Thu, 12 Aug 2021 21:26:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 12 Aug 2021 21:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naive.systems;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=pXU2IlpXOBXDH
        +xpk2NQLCpGgsTo3x4TM8oZtbWZWHI=; b=H2ystZ9NgPaWQttoEn9p39umauYxh
        EO9seIOLbRBFElM249eblMrM/yrYbos3WWL+w0k1I66Y3S2wMq8P8H+f4h1dCqgp
        DdVh7BrlMGP9x3NAGPYgFtvsyauJD5IWl0tDN0gDfZO3a1fwOmCTslgcYIiJbpsj
        eFQj6UkMSPFoo9FNQOI2Q9PDqEWyiuaXVwIhom4/HumrBxaLYP6xIEHVfxCmFyUi
        YZ/B31A+U4mcG9bGhVFp8KpiEgUCmr/qLN3ItLrtc4kYnBFJkG8Tssr6p6SMklmG
        YiPdOa6ObSwqfT9dkZ/QACRaJkvV501xEGEhYgYV6Y7ihYcy5gPwrqVjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=pXU2IlpXOBXDH+xpk2NQLCpGgsTo3x4TM8oZtbWZWHI=; b=rICW8RHr
        Zu1rvwd/+0NDoEw+WfTwvIZ9td+aupq+J+0MLPX0chQ5f/GtTATt1KqqAF2Lstxj
        rth1lBJdxRnpVeWqGW6fmJ73NXpg6vFcnhFBGhJuYt8YRUtV+OpPxznDmgT/kr9V
        hjc6rPVNPRZYTSSpUBn3qSBhM1vmu/yfjfAFEtAi5ep8lb+2WL9MvrKz/kts1huA
        QHi22emoxRjZJMgtQO6xBwKh4E5a+wf8T20aWk/ynk1gjHQlPyVqv2SRVq4ZaCFg
        I0qX0po5BxoZJPkWdaz6zlXFzzdvsSIseinnIi45oeVy0sTMh65R9U6NMzN7ImF/
        Iz3ZllWrupVI/w==
X-ME-Sender: <xms:RsoVYfzfbd242YF2bt_LswKmRxqWmCY6iCHttD0ybaozbUvKgSnj8Q>
    <xme:RsoVYXTiSkuqaJBUDeJ1-ihMqrmDL_s7mFR5Lc3yMry3CvWTdFjf7EoiaqgUtbIJB
    CShs9oqYBOzKjJ98aE>
X-ME-Received: <xmr:RsoVYZX7pqjoabwdP8zk4fPN8Dckr-bJz67wWfVZoC1O2AZNWwBR4cJqzq_5tjacbZbUMXnnvcZIkYBWXMKHZokqZDt6qN9V8y40nL79TE9JzCXZfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkeeggdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfgvucffuhcu
    oeguuhhkvgesnhgrihhvvgdrshihshhtvghmsheqnecuggftrfgrthhtvghrnhepteeute
    euffdvueefvefhvdfgudfhgeejheekfefftdelfedtkeekgfevffetteehnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepughukhgvsehnrghivh
    gvrdhshihsthgvmhhs
X-ME-Proxy: <xmx:RsoVYZhoYD2hgPHPaXkFoTBFg0sYnPN3f-AA2F4ODrqggO_BAOr6lQ>
    <xmx:RsoVYRDdaDhDgHHX__VsJ5Zg4rYImMnw270xMQjqyR7OP8OFLIGTzg>
    <xmx:RsoVYSIc6WYNQVrLvtynlkfTTkOSXtSJWclEINaN4zxvylQOxngxBQ>
    <xmx:RsoVYUN87Aa3g8NQC4dpowC_kfxCgbb06kvoWyixQ6ZI13ex9y4wYA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Aug 2021 21:26:30 -0400 (EDT)
From:   Ke Du <duke@naive.systems>
To:     luc.vanoostenryck@gmail.com
Cc:     linux-sparse@vger.kernel.org, Ke Du <duke@naive.systems>,
        Xiao Jia <xjia@naive.systems>
Subject: [PATCH 2/2] make implicit type conversion explicit
Date:   Thu, 12 Aug 2021 20:25:11 -0500
Message-Id: <20210813012511.65397-3-duke@naive.systems>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210813012511.65397-1-duke@naive.systems>
References: <20210726182822.ylmd3vtm44txowoi@mail>
 <20210813012511.65397-1-duke@naive.systems>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Make implicit type converison from void* to other types explicit so
ptrlist.h and token.h can be included as C++ library. Without this
change, when including these in C++, clang complains that it cannot
initialize return object of a more specific type with an lvalue of type
void*.

Signed-off-by: Ke Du <duke@naive.systems>
Reviewed-by: Xiao Jia <xjia@naive.systems>
---
 ptrlist.h | 2 +-
 token.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ptrlist.h b/ptrlist.h
index 67c7a208..9fd20f84 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -303,7 +303,7 @@ extern void split_ptr_list_head(struct ptr_list *);
 
 static inline void update_tag(void *p, unsigned long tag)
 {
-	unsigned long *ptr = p;
+	unsigned long *ptr = (unsigned long *)p;
 	*ptr = tag | (~3UL & *ptr);
 }
 
diff --git a/token.h b/token.h
index 804cc6f8..7a97a478 100644
--- a/token.h
+++ b/token.h
@@ -204,7 +204,7 @@ struct token {
 static inline struct token *containing_token(struct token **p)
 {
 	void *addr = (char *)p - ((char *)&((struct token *)0)->next - (char *)0);
-	return addr;
+	return (struct token *)addr;
 }
 
 #define token_type(x) ((x)->pos.type)
-- 
2.31.1

