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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF55C433DB
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA16D217A0
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgLZRxW (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 26 Dec 2020 12:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgLZRxW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 26 Dec 2020 12:53:22 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59235C06179F
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:52:10 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t16so6688425wra.3
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p4VcEExhsFaRRIZkRJF2C3i3j9qOJH/btzyHWM7ffns=;
        b=MBmakUrvgbIKn01MCr0KytMNWyblJyCEGAEVBpE9Mcj9648bV8M805uCWIwvBr5p0G
         bnNUpS1Xtop8ChRXr3fyEhGSBKow9+67f6U/EiL8RO04etSWQzOk8U+ihGkhbLdtryrq
         RLs+yqTzbWiAw4pUUuI2HAvK8+ZCbBMODuFUFaQnE1foMmYVwVOqk5ANffMD60gNSevE
         lPoFLn9qfjc2Op6sOqLiV7m0BGoz0pvYij6fgRy4tksl0tia5ayWUgCHdISvXSNpmymc
         zcztM5iIylutHGgxWR3/OzWV8g4BNG4W/VVZbTQ3+Zw/TuVbOX8/YWBLtLWSreJNhAN4
         oPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p4VcEExhsFaRRIZkRJF2C3i3j9qOJH/btzyHWM7ffns=;
        b=sd2GuQ5j0L9bUCsCwchcnWM1Ip+/mSSmgUOcBIqhKYXjUhBPZgLUIP4l10rICJiaQW
         fBjQ3pDTVDzSGi3gzJH9T6odaGhR5WqQJ2pJandwrC8kj0jW/B8zLcu5M00NxfjY9exE
         1REmB7qloGksynk31d9QdwVkx1GghyeVUghAknXa2+iEQqw4oTdErlR6J47zRtC2DekQ
         HHj7niDsibyAWRPUEFeWnozONKENg54dkRLzOY9Fb6XPzNUueJ9qhAiAh0a6z6hLwxCZ
         XTAL5q/W1IcEkf0n6du+IegURZbLTSwUR4+8wkxuOxW+xSTLkOjJH/g8NmEFFGRT99qq
         1tSg==
X-Gm-Message-State: AOAM531nqdbQpL4Ra2Qs1KVN47hJ7KpAVy665VK5IEtAoyl9Bh6+KlqG
        Ei7WfPJYkaX/Cn2Oc5F6ZhoJ534tKfg=
X-Google-Smtp-Source: ABdhPJzuS/HXTykulLmxtzLlScgKYQDVW3Ud5ezCT4aKDQNx3sN9EYGi15x8i9xW9uuMFL8c2VdyaQ==
X-Received: by 2002:adf:cd8f:: with SMTP id q15mr42350969wrj.79.1609005129090;
        Sat, 26 Dec 2020 09:52:09 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:10a5:37c9:8c28:d3e9])
        by smtp.gmail.com with ESMTPSA id c4sm12780813wmf.19.2020.12.26.09.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 09:52:08 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 14/16] struct-attr: fix: do not ignore struct/union/enum type attributes
Date:   Sat, 26 Dec 2020 18:51:27 +0100
Message-Id: <20201226175129.9621-15-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

GCC's syntax for type attributes is specified as:
    An attribute specifier list may appear as part of a struct,
    union or enum specifier. It may go either immediately after
    the struct, union or enum keyword, or after the closing brace.
    The former syntax is preferred. Where attribute specifiers
    follow the closing brace, they are considered to relate to
    the structure, union or enumerated type defined, not to any
    enclosing declaration the type specifier appears in, and the type
    defined is not complete until after the attribute specifiers.
In the section about type attributes, it's also said:
    You may specify type attributes in an enum, struct or union type
    declaration or definition by placing them immediately after the
    struct, union or enum keyword. A less preferred syntax is to
    place them just past the closing curly brace of the definition.

So, while placing the attribute after the closing curly is not
preferred, it is cleary legal (and it seems to be much more popular
than placing them just after the struct, union or enum keyword).

However, currently sparse doesn't handle this correctly:
- these attributes are parsed in declaration_specifiers() and
  added to the current decl_state
- when the ';' ending the type declaration is reached, the plain
  struct/union/enum is used and the content of the decl_state is
  simply ignored.
- if the declaration is for a variable, then those attributes
  are assigned to the variable (but not to the type).

Fix this by calling handle_attribute() once we have reached the
closing '}' of a struct/union/enum definition and applying these
attributes, if any, directly to the current base type.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c                           | 2 ++
 validation/packed-bitfield3.c     | 1 -
 validation/packed-bitfield4.c     | 1 -
 validation/type-attribute-align.c | 1 -
 validation/type-attribute-as.c    | 1 -
 validation/type-attribute-mod.c   | 1 -
 6 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/parse.c b/parse.c
index 5f33ac178a45..0fd2bb473a47 100644
--- a/parse.c
+++ b/parse.c
@@ -761,6 +761,8 @@ static struct token *struct_union_enum_specifier(enum type type,
 	token = parse(token->next, sym);
 	ctx->ctype.base_type = sym;
 	token =  expect(token, '}', "at end of specifier");
+	attr.ctype.base_type = sym;
+	token = handle_attributes(token, &attr);
 	apply_ctype(token->pos, &sym->ctype, &attr.ctype);
 
 	// Mark the structure as needing re-examination
diff --git a/validation/packed-bitfield3.c b/validation/packed-bitfield3.c
index 6acff875299f..a8f740700967 100644
--- a/validation/packed-bitfield3.c
+++ b/validation/packed-bitfield3.c
@@ -25,5 +25,4 @@ _Static_assert(   sizeof(struct c) == sizeof(u64));
 
 /*
  * check-name: packed-bitfield3
- * check-known-to-fail
  */
diff --git a/validation/packed-bitfield4.c b/validation/packed-bitfield4.c
index 0342b2414b6e..1a956344f2d3 100644
--- a/validation/packed-bitfield4.c
+++ b/validation/packed-bitfield4.c
@@ -15,5 +15,4 @@ static int ld(struct s *s)
 /*
  * check-name: packed-bitfield4
  * check-description: Is check_access() OK with short packed bitfields?
- * check-known-to-fail
  */
diff --git a/validation/type-attribute-align.c b/validation/type-attribute-align.c
index d9358bff8327..5f3db14aceb1 100644
--- a/validation/type-attribute-align.c
+++ b/validation/type-attribute-align.c
@@ -16,5 +16,4 @@ void main(void)
 
 /*
  * check-name: type-attribute-align
- * check-known-to-fail
  */
diff --git a/validation/type-attribute-as.c b/validation/type-attribute-as.c
index b40b4e7dddf5..38f06b374e25 100644
--- a/validation/type-attribute-as.c
+++ b/validation/type-attribute-as.c
@@ -21,7 +21,6 @@ void main(void)
 
 /*
  * check-name: type-attribute-as
- * check-known-to-fail
  *
  * check-error-start
 type-attribute-as.c:16:15: warning: incorrect type in argument 1 (different address spaces)
diff --git a/validation/type-attribute-mod.c b/validation/type-attribute-mod.c
index 0e7b166a4aec..d55011dfa09a 100644
--- a/validation/type-attribute-mod.c
+++ b/validation/type-attribute-mod.c
@@ -14,7 +14,6 @@ void main(void)
 
 /*
  * check-name: type-attribute-mod
- * check-known-to-fail
  *
  * check-error-start
 type-attribute-mod.c:12:9: warning: dereference of noderef expression
-- 
2.29.2

