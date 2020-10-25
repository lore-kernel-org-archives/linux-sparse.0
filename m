Return-Path: <SRS0=+N6z=EA=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518B1C388F7
	for <linux-sparse@archiver.kernel.org>; Sun, 25 Oct 2020 17:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 022ED208A9
	for <linux-sparse@archiver.kernel.org>; Sun, 25 Oct 2020 17:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjjaNaSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417686AbgJYRkz (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 25 Oct 2020 13:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1417685AbgJYRkz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 25 Oct 2020 13:40:55 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3284C061755
        for <linux-sparse@vger.kernel.org>; Sun, 25 Oct 2020 10:40:54 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id w23so7045438edl.0
        for <linux-sparse@vger.kernel.org>; Sun, 25 Oct 2020 10:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8eIvrS+cWwCvvUx51zH72cNsS20MsV88iDFU6Jrxsss=;
        b=SjjaNaSXvD2Tzt5lZ9jy9vGqYkMsghPe6Fs58ysLlMWcVYh5NxJhbRf4Rb3i6CQYVX
         qQg/+Hy1M5V3SRLqZFvZkH7lUozs74EzPgUy6yYd311TvUV58rDgMbBv35dIOLCM72BP
         r6IpK4a/MwNkrC5RI54e3EAV7vZ4Pjc5lWV2rQvuIEUwPJSMTZX6BTkg1naYwpcDMDgD
         qIl1Wv6M0XcUG+ljfw9nrLjKCgmUGz+FgdCtVzE9KoQ2Vs/YC9gA+pYFZXd6OHMlAwtb
         xmj7OnXn0lwznO+MAojIuMO0bJIbL26XEqbMZ+WhdcbwTpIw1r/v5RxVd7eCjjUHOlAJ
         y8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8eIvrS+cWwCvvUx51zH72cNsS20MsV88iDFU6Jrxsss=;
        b=oKqsNClhkKQPtyqnkxef8RNWT7617JUkBQOBJfHt8FQ0RFLsNBYG3dAcrFgoC4uuuq
         bY7AzN9W0RD/+zSN41mpPUrBvZHoAwCCl6vdPiTfvwfQFCzS6GBejiMcK9t2e/kj8frg
         68BVp646WneyCUW7bsFhBNc5oj8D6KCKpn8noxmkSTxd9e/4hSlCWfEj1cEeIzIueTkw
         zrsRwyCIl2D2kwlfjiwQHFKK5pr8VvrpULo0idGljz1PwXNKElndYI+ABaYLzYPwPvxI
         2n2tSL9goUBo1OT5X/DOb7KtmjfXfgVsf8iRahkocCf/IY3hopvok84+d8EaA2jkXnhj
         PaDQ==
X-Gm-Message-State: AOAM531pYQCEKj/e4wz+AT7xWXCu4U0g8Bp5gC+Fli5mv/jeoKNaCMZS
        1NLDtukQ4F09UeKWDnoZnTlxUb9DRIk=
X-Google-Smtp-Source: ABdhPJwyCS1LzrwsR2eBFXavw4YI9SunViPbo5qY0W7dsxKeMLtEYMPgRLQU1BZpykyG1kgFSJW5rw==
X-Received: by 2002:aa7:cd90:: with SMTP id x16mr11987035edv.302.1603647653064;
        Sun, 25 Oct 2020 10:40:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:e5ce:9ac2:2b08:5ec5])
        by smtp.gmail.com with ESMTPSA id bt16sm4286255ejb.89.2020.10.25.10.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 10:40:52 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] warn on all missing parameter types
Date:   Sun, 25 Oct 2020 18:40:50 +0100
Message-Id: <20201025174050.49641-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

A warning is given for K&R parameters without type declaration
and these parameters are given an implicit type of int to
avoid several problems with false errors in the next stages.

However, this is only done for K&R functions with the optional
parameter type declarations. If the parameters has no type
declaration at all, no diagnostic is given and the type is left
as incomplete. In consequence, a function defined with a typo like
'int foo(oid)' instead of 'int foo(void)' is left undetected
(even with -Wold-style-definition and -Wstrict-prototypes enabled).

Fix this by:
1) adding the type check to declare_argument() so that
   all parameters have a real type.
2) downgrade the diagnostic to a warning for K&R functions.

Fixes: 6f7aa5e84dacec8e27a8d70090bba26a1a1276de
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c                            | 10 +++++++++-
 validation/asm-bad0.c              |  2 +-
 validation/bad-type-twice0.c       |  3 +--
 validation/badtype2.c              |  1 +
 validation/badtype3.c              |  1 +
 validation/implicit-KR-arg-type1.c | 11 +++++++++--
 6 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/parse.c b/parse.c
index 31ecef0f554d..a24d6bdc3f54 100644
--- a/parse.c
+++ b/parse.c
@@ -2713,6 +2713,14 @@ static void declare_argument(struct symbol *sym, struct symbol *fn)
 		sparse_error(sym->pos, "no identifier for function argument");
 		return;
 	}
+	if (sym->ctype.base_type == &incomplete_ctype) {
+		sym->ctype.base_type = &int_ctype;
+
+		if (Wimplicit_int) {
+			sparse_error(sym->pos, "missing type declaration for parameter '%s'",
+				show_ident(sym->ident));
+		}
+	}
 	bind_symbol(sym, sym->ident, NS_SYMBOL);
 }
 
@@ -2804,7 +2812,7 @@ static void apply_k_r_types(struct symbol_list *argtypes, struct symbol *fn)
 				goto match;
 		} END_FOR_EACH_PTR(type);
 		if (Wimplicit_int) {
-			sparse_error(arg->pos, "missing type declaration for parameter '%s'",
+			warning(arg->pos, "missing type declaration for parameter '%s'",
 				show_ident(arg->ident));
 		}
 		type = alloc_symbol(arg->pos, SYM_NODE);
diff --git a/validation/asm-bad0.c b/validation/asm-bad0.c
index aa9bf28d72af..4ba7857529e3 100644
--- a/validation/asm-bad0.c
+++ b/validation/asm-bad0.c
@@ -16,7 +16,7 @@ static void icons(void)
 	asm("template" : [out] "=r" (var): [in] string (0));
 }
 
-static void oexpr(oid)
+static void oexpr(void)
 {
 	asm("template" : [out] "=" (var[) : [in] "r" (0));
 }
diff --git a/validation/bad-type-twice0.c b/validation/bad-type-twice0.c
index 9e834d47df6f..e7ec7b75153d 100644
--- a/validation/bad-type-twice0.c
+++ b/validation/bad-type-twice0.c
@@ -7,7 +7,6 @@ static int foo(a)
  * check-name: bad-type-twice0
  *
  * check-error-start
-bad-type-twice0.c:3:16: error: non-scalar type in conditional:
-bad-type-twice0.c:3:16:    incomplete type a
+bad-type-twice0.c:1:16: error: missing type declaration for parameter 'a'
  * check-error-end
  */
diff --git a/validation/badtype2.c b/validation/badtype2.c
index 49fec87ce0a6..173dbfda7843 100644
--- a/validation/badtype2.c
+++ b/validation/badtype2.c
@@ -18,6 +18,7 @@ badtype2.c:2:14: error: got bar
 badtype2.c:3:14: error: Expected ; at end of declaration
 badtype2.c:3:14: error: got foo
 badtype2.c:6:3: error: Trying to use reserved word 'switch' as identifier
+badtype2.c:6:11: error: missing type declaration for parameter 'p'
 badtype2.c:7:3: error: not in switch scope
 badtype2.c:10:1: error: Expected ; at the end of type declaration
 badtype2.c:10:1: error: got }
diff --git a/validation/badtype3.c b/validation/badtype3.c
index 20f346c57488..c111d94e727d 100644
--- a/validation/badtype3.c
+++ b/validation/badtype3.c
@@ -16,6 +16,7 @@ badtype3.c:2:18: warning: identifier list not in definition
 badtype3.c:2:24: error: Expected ) in function declarator
 badtype3.c:2:24: error: got ,
 badtype3.c:5:3: error: Trying to use reserved word 'while' as identifier
+badtype3.c:5:10: error: missing type declaration for parameter 'cur'
 badtype3.c:7:7: error: break/continue not in iterator scope
 badtype3.c:9:3: error: Trying to use reserved word 'return' as identifier
 badtype3.c:9:10: error: Expected ; at end of declaration
diff --git a/validation/implicit-KR-arg-type1.c b/validation/implicit-KR-arg-type1.c
index fe199ef52cf1..c7eb39aef8c8 100644
--- a/validation/implicit-KR-arg-type1.c
+++ b/validation/implicit-KR-arg-type1.c
@@ -1,16 +1,23 @@
-int foo(a, b)
+static int foo(a, b)
 	int a;
 {
 	if (b)
 		return a;
 }
 
+static int bar(a)
+{
+	if (a)
+		return a;
+}
+
 /*
  * check-name: implicit-KR-arg-type1
  * check-command: sparse -Wold-style-definition -Wimplicit-int $file
  *
  * check-error-start
 implicit-KR-arg-type1.c:2:9: warning: non-ANSI definition of function 'foo'
-implicit-KR-arg-type1.c:1:12: error: missing type declaration for parameter 'b'
+implicit-KR-arg-type1.c:1:19: warning: missing type declaration for parameter 'b'
+implicit-KR-arg-type1.c:8:16: error: missing type declaration for parameter 'a'
  * check-error-end
  */
-- 
2.29.0

