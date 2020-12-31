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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBB9C433E9
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8E29207A3
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgLaKMH (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 31 Dec 2020 05:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgLaKMF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Dec 2020 05:12:05 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1938C0617A7
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:53 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d26so19664625wrb.12
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uzs0PRBDwTm5xhuPVtkISBci8qATErI9BQqOhnyKri4=;
        b=reOKdHltC1FhxtC4W8/y/wnEBBz97gdd34O+GWdypgxjhwW4RxRGTX+PBkhzWi32lO
         +rVn6RABWUnxJGctCDnFMdK5HC38Z/sPlIvhRTUcsHZstA09zcCv4IKG5m1gfz/2NViL
         mnQBPp0rFgEavUw9U850APRaci736u/K7xctaPba0Fb8l9pFUvE+vJwJq43u57dKSFq1
         4MzXfr5sTcxYyiOOy6/pbGQrCsvFr0RS5NLTlg4JrR9FLUGCDvsgI6XgReH/4gU1e7ZZ
         I7WSdwwZpDx6OOaY9BlafzA5u1/BGNjiZTTOyV5odfBLhvXPLco72DSZfi9enrg3f0Gf
         JEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uzs0PRBDwTm5xhuPVtkISBci8qATErI9BQqOhnyKri4=;
        b=HFcF76oK1wv46c6ybniPoPpKQ14Rn3wcMLx3WdKCEEW1OlW3OEjCD4sChsnwaFHdQF
         7bxj6XX1AJkeaoYEtZLQwOW2tlKrc6wDjnvmkvXi4FP/py/Nb3qQvS4RmVT15eCsthzi
         e79OJkDhQEPX0lfvNPRubGxYcrV+dcKyQUf+yQrrjE8WVKrZh5gujYgok9I6JAG2484s
         Gd2oMjnjVsTJlXY+Evo+TCOv4ktnpaMComRkO/3qebR58M3XggzS7kXo0mZAv1LLIoXH
         kytOeDIckYg68tr6n2v5gqw0UNRblVgWdcqVQYjCrwXiqywkPX9/tSrJgQ9tEd/cH/yZ
         A49g==
X-Gm-Message-State: AOAM530dgPgyRypWkHYTLwKcalUTZheJD1RrHY1vqtlF36xHxGIrdpI4
        vdflYuWtrEI5AX9ZuLlihNcHTrKi4BM=
X-Google-Smtp-Source: ABdhPJxEI8XVbGQwYiTyYNm8t/YAM6yCVevz5ApvZlGf/nMivoo7PDhxd52wLSe9zM5bKqpj7p4Vcw==
X-Received: by 2002:a5d:6cc9:: with SMTP id c9mr62675452wrc.411.1609409452677;
        Thu, 31 Dec 2020 02:10:52 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:7c8c:1eb2:47fd:b5e7])
        by smtp.gmail.com with ESMTPSA id n3sm66161019wrw.61.2020.12.31.02.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 02:10:52 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 14/16] struct-attr: fix: do not ignore struct/union/enum type attributes
Date:   Thu, 31 Dec 2020 11:10:32 +0100
Message-Id: <20201231101034.59978-15-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
References: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
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
index b38615b8d61d..338e525f46b9 100644
--- a/parse.c
+++ b/parse.c
@@ -764,6 +764,8 @@ static struct token *struct_union_enum_specifier(enum type type,
 
 	token = parse(token->next, sym);
 	token = expect(token, '}', "at end of specifier");
+	attr.ctype.base_type = sym;
+	token = handle_attributes(token, &attr);
 	apply_ctype(token->pos, &sym->ctype, &attr.ctype);
 
 	sym->endpos = token->pos;
diff --git a/validation/packed-bitfield3.c b/validation/packed-bitfield3.c
index c06e7c41cbcd..13368c84469e 100644
--- a/validation/packed-bitfield3.c
+++ b/validation/packed-bitfield3.c
@@ -25,5 +25,4 @@ _Static_assert(   sizeof(struct c) == 8);
 
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

