Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6945C4338F
	for <linux-sparse@archiver.kernel.org>; Fri, 13 Aug 2021 01:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8044A60232
	for <linux-sparse@archiver.kernel.org>; Fri, 13 Aug 2021 01:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238116AbhHMB0c (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 12 Aug 2021 21:26:32 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55405 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238139AbhHMB0c (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 12 Aug 2021 21:26:32 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 38EE95C0081;
        Thu, 12 Aug 2021 21:26:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 12 Aug 2021 21:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naive.systems;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=lh885xoYjkGpc
        aMTuALUig7UH7CVNQqBjYBbRHJwB5c=; b=Ewx4ceMDGRHNN/B41Gx6M6hwcx5CE
        dqCBbT5nTtbInWTtNdbBJW4zjSYv9HS479qI6uePzLvb1IPiz2uXUmy6zGSsEfSs
        xDqXCmPKemC9h5WlNwrQow8fjn0ENmzDTXpowJYgMBck0vHZQZZJgsODdUttVFiW
        EyKrSJuF4v/81wzXRWEgSKxUbr2ByMRegRYB5XbRrKej0YJ1j+Ue17vkt8WV7tXS
        kzWvg0BZi335lKT77zrzJvQAu+752w2DjlIVoQsGH0lv9TG6y4h43jvfkSqjL1Fx
        Qw/AN10PxXObt0HOI5Qw8ufjiiFMCiEX27VF4n6CHlgWgeKerY7qcyM7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=lh885xoYjkGpcaMTuALUig7UH7CVNQqBjYBbRHJwB5c=; b=Uzbx8F8+
        Uqj0wlLUBGQO5cFhnGPntCmRXqHwiErB0yBSFdJFtugI3l3ea1BQXiffaDtK76+9
        LFZPUjmO1l49sy8kXW5fMaNhqNorJkDdmOsP0GadEpZOdB3SA6sK0s681eOHfX6N
        BT+NwkIp+W7N0EmLLmsIQ9Lskdt0MWujaIwAjJ/ttCBlr4A4U1KFHG3vv09x6jhS
        Bm+93xGbXEp7Qs+2qhwsWFMgCq4jCE5wuh2ANqPsHlcr9WbbJHWG7o0b+DCsrlHR
        sZqMWbb1tvI4bGncr+88BaWF9b+jD0XxI++XcohOG1NMxIagXgwq0B37xO+wTpb8
        cshRmrto9M8u2Q==
X-ME-Sender: <xms:LsoVYfgKvKo7ycLI_p2pGMRPNzaa88xPKYQHMsYtkvAQy6cfO8OyUg>
    <xme:LsoVYcCXgRh-UV_T9kvj2ZHEz-ygexzTaA4lGpRU4PFDwjUgyzFlMhI2eQsildSw4
    _CpzVFyEvhQQiQVt7c>
X-ME-Received: <xmr:LsoVYfF05DnZ1YLv1-jlthcazz_vO8sqZECkhaALzbF8CeBHABTT-7h-D4KBPTS3Xt5AI0ZJOL8NB0WWVZHSHQ70ygUuVS_yptiSjReZGYIIVPsxMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkeeggdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfgvucffuhcu
    oeguuhhkvgesnhgrihhvvgdrshihshhtvghmsheqnecuggftrfgrthhtvghrnhepteeute
    euffdvueefvefhvdfgudfhgeejheekfefftdelfedtkeekgfevffetteehnecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepughukhgvsehnrghivh
    gvrdhshihsthgvmhhs
X-ME-Proxy: <xmx:LsoVYcS8Zfjc0ap2b5KemYPUcW6UjlgKbMCkyZqFXRyD8pCtKFgHnA>
    <xmx:LsoVYcw73WNTS5pvEQ2dFNzycPTWIeNfEe2MHH1ulO_oxeFVXs3Ckg>
    <xmx:LsoVYS5a4tEDmQuwT0NsPbiq2almz-KZcX6UwdQnGU0fx8LdSJ5f1A>
    <xmx:LsoVYX9271xpUPc9-BorAHTPO7H0gPUWqOHqPno3nOLreHPcPmD9jw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Aug 2021 21:26:05 -0400 (EDT)
From:   Ke Du <duke@naive.systems>
To:     luc.vanoostenryck@gmail.com
Cc:     linux-sparse@vger.kernel.org, Ke Du <duke@naive.systems>,
        Xiao Jia <xjia@naive.systems>
Subject: [PATCH 1/2] expose more functions to C++ in header files
Date:   Thu, 12 Aug 2021 20:25:10 -0500
Message-Id: <20210813012511.65397-2-duke@naive.systems>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210813012511.65397-1-duke@naive.systems>
References: <20210726182822.ylmd3vtm44txowoi@mail>
 <20210813012511.65397-1-duke@naive.systems>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Delete or shrink the ifndef __cplusplus guard to expose more facilities
to C++, such as sparse_initialize and the FOR_EACH_PTR macro.

Signed-off-by: Ke Du <duke@naive.systems>
Reviewed-by: Xiao Jia <xjia@naive.systems>
---
 lib.h     | 4 ++--
 ptrlist.h | 2 +-
 symbol.h  | 3 ---
 token.h   | 3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/lib.h b/lib.h
index 9809feee..0e9bd0cd 100644
--- a/lib.h
+++ b/lib.h
@@ -85,8 +85,6 @@ DECLARE_PTR_LIST(string_list, char);
 
 typedef struct pseudo *pseudo_t;
 
-#ifndef __cplusplus
-
 #ifdef __GNUC__
 #define FORMAT_ATTR(pos) __attribute__ ((__format__ (__printf__, pos, pos+1)))
 #define NORETURN_ATTR __attribute__ ((__noreturn__))
@@ -143,6 +141,8 @@ extern struct symbol_list *sparse_keep_tokens(char *filename);
 extern struct symbol_list *sparse(char *filename);
 extern void report_stats(void);
 
+#ifndef __cplusplus
+
 static inline int symbol_list_size(struct symbol_list *list)
 {
 	return ptr_list_size((struct ptr_list *)(list));
diff --git a/ptrlist.h b/ptrlist.h
index e281309f..67c7a208 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -109,6 +109,7 @@ extern void __free_ptr_list(struct ptr_list **);
 	DO_REVERSE(ptr, __head##ptr, __list##ptr, __nr##ptr, __rname##new, \
 		   new, __head##new, __list##new, __nr##new, PTR_ENTRY_UNTAG)
 
+#endif // __cpluplus
 
 #define FOR_EACH_PTR(head, ptr) \
 	DO_FOR_EACH(head, ptr, __head##ptr, __list##ptr, __nr##ptr, __name##ptr, PTR_ENTRY_NOTAG)
@@ -311,5 +312,4 @@ static inline void *tag_ptr(void *ptr, unsigned long tag)
 	return (void *)(tag | (unsigned long)ptr);
 }
 
-#endif // __cpluplus
 #endif /* PTR_LIST_H */
diff --git a/symbol.h b/symbol.h
index 503c9f09..c9d221e7 100644
--- a/symbol.h
+++ b/symbol.h
@@ -220,8 +220,6 @@ struct symbol {
 	pseudo_t pseudo;
 };
 
-#ifndef __cplusplus
-
 /* Modifiers */
 #define MOD_AUTO		0x00000001
 #define MOD_REGISTER		0x00000002
@@ -591,5 +589,4 @@ static inline void combine_address_space(struct position pos,
 	}
 }
 
-#endif	// __cplusplus
 #endif /* SYMBOL_H */
diff --git a/token.h b/token.h
index 1f3601a9..804cc6f8 100644
--- a/token.h
+++ b/token.h
@@ -197,7 +197,7 @@ struct token {
 	};
 };
 
-#ifndef __cplusplus
+
 
 #define MAX_STRING 8191
 
@@ -251,5 +251,4 @@ static inline int match_token_zero(struct token *token)
 	return token->number[0] == '0' && !token->number[1];
 }
 
-#endif	// __cplusplus
 #endif
-- 
2.31.1

