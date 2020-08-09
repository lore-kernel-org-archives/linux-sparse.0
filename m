Return-Path: <SRS0=O0OO=BT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4A1C433E1
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 16:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BFA1206B2
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 16:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoRiMJOc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgHIQwx (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 9 Aug 2020 12:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgHIQwj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Aug 2020 12:52:39 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ED8C061786
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 09:52:38 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id l4so7041333ejd.13
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 09:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1TrDH0w4q9ED0gS2HMBqlB1zthcVJYHAv8A53XgUNVo=;
        b=DoRiMJOcbjDR6PvjYLTG4QFHvCFdPanC34z0ebqjDjRVzRJ8hFzZSwKW1eqh4Kqyd4
         fIyLVHEdbBcSYke8XxjvXnVTXKoWTmZSt01H1A7UkJWWMJ83TnFE/qUG+w+T1CGI+lgX
         saEh4oi6ncDf1GEQq8TerFuV/EkPJoVM9A2xViOUXHj2Uxl5Q/oNTbJvF2w3OG5V2luq
         EX++i+eZjEcUywsbsFyZcxOa4ba5ThhX0EDoytWtLxd2MPydkNMs0aqBxHCUyFqzkYdz
         DAjfuJ5DF92UCDfUCZQMOXOqmQEnDI6hGdC7E8GAHmIscF3B9dH00+vwc9D6nta7zvEA
         49Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1TrDH0w4q9ED0gS2HMBqlB1zthcVJYHAv8A53XgUNVo=;
        b=IDugq+W6Gbi6jKEecR2aZLwM/uWyQwKG2lo3xF7g5PQk0DAb93//rs+RhD6kze4RuL
         7R8/X1pcrIR2RNVdWUKZfJGLr9uajJ73QYl0jfzwDmFkFT9r/DVyHuW9kDF5dh5pZfxO
         jWHpn8oK9pIZfrsKs2dKTd9RHwEIPJ9WCjiu1VSisdncwXTGgmemKSZIeO238z1mcjSp
         w/tQo+1PtnQxQ9EDfiTRXhqlI7jzN73OJGrpqBL0EDiE9Qol7vMt8dJAxcc61CBjU/4h
         WV3NfW7+NQmkn+vtoXuM1ssUKYPIyj6syL7y4gWItJwvnO/fn4tMkcVpUaiNKPGqTWsA
         NZmQ==
X-Gm-Message-State: AOAM530gPS54Jz1cRKvBPNRz8j9okTgaJwkDEuPhR/nhRe0hi0bHDllz
        Mua0LOHFKoFEgd/zypk8/iU4hSG6
X-Google-Smtp-Source: ABdhPJwMWEdebpuh4Z+ObIT/d60yaP2ulMqIX8xtXUCOlBIj4nwyGY0bBqll6S6BUrTUEtnj8CM/gg==
X-Received: by 2002:a17:906:4dd4:: with SMTP id f20mr19298198ejw.170.1596991956697;
        Sun, 09 Aug 2020 09:52:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:79f2:f43a:7be8:9ec8])
        by smtp.gmail.com with ESMTPSA id j11sm10810427ejx.0.2020.08.09.09.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 09:52:36 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/8] show-mod: add helper to show the modifiers but without ending space
Date:   Sun,  9 Aug 2020 18:52:22 +0200
Message-Id: <20200809165229.36677-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809165229.36677-1-luc.vanoostenryck@gmail.com>
References: <20200809165229.36677-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

modifier_string() returns either "" or a string with one or
several modifiers separated by a space. In this last case the
string has also a trailing space.

This trailing space is sometimes desired (for example when
composed with identifier name: "%s%s") but is also sometimes not
desired (for example when only the modifiers must be displayed).

So, create a variant of modifier_string() which doesn't add the
ending space: modifier_name().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 show-parse.c | 18 +++++++++++++++++-
 symbol.h     |  1 +
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/show-parse.c b/show-parse.c
index 51a151911e3b..17a4de8be64e 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -107,7 +107,7 @@ void debug_symbol(struct symbol *sym)
  * Symbol type printout. The type system is by far the most
  * complicated part of C - everything else is trivial.
  */
-const char *modifier_string(unsigned long mod)
+static const char *show_modifiers(unsigned long mod, int term)
 {
 	static char buffer[100];
 	int len = 0;
@@ -155,10 +155,26 @@ const char *modifier_string(unsigned long mod)
 			buffer[len++] = ' ';
 		}
 	}
+	if (len && !term)		// strip the trailing space
+		--len;
 	buffer[len] = 0;
 	return buffer;
 }
 
+///
+// show the modifiers, terminated by a space if not empty
+const char *modifier_string(unsigned long mod)
+{
+	return show_modifiers(mod, 1);
+}
+
+///
+// show the modifiers, without an ending space
+const char *modifier_name(unsigned long mod)
+{
+	return show_modifiers(mod, 0);
+}
+
 static void show_struct_member(struct symbol *sym)
 {
 	printf("\t%s:%d:%ld at offset %ld.%d", show_ident(sym->ident), sym->bit_size, sym->ctype.alignment, sym->offset, sym->bit_offset);
diff --git a/symbol.h b/symbol.h
index c2b60ce91c27..4792b008efe3 100644
--- a/symbol.h
+++ b/symbol.h
@@ -327,6 +327,7 @@ extern void init_linearized_builtins(int stream);
 extern void init_ctype(void);
 extern struct symbol *alloc_symbol(struct position, int type);
 extern void show_type(struct symbol *);
+extern const char *modifier_name(unsigned long mod);
 extern const char *modifier_string(unsigned long mod);
 extern void show_symbol(struct symbol *);
 extern int show_symbol_expr_init(struct symbol *sym);
-- 
2.28.0

