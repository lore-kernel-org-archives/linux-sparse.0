From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] fix hardcoded size of wide chars
Date: Fri, 19 May 2017 13:20:51 +0200
Message-ID: <20170519112053.24632-2-luc.vanoostenryck@gmail.com>
References: <20170519112053.24632-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35327 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754392AbdESLVF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 19 May 2017 07:21:05 -0400
Received: by mail-wr0-f194.google.com with SMTP id g12so2622257wrg.2
        for <linux-sparse@vger.kernel.org>; Fri, 19 May 2017 04:21:04 -0700 (PDT)
In-Reply-To: <20170519112053.24632-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The size of wide chars was hardcoded to 32.

Fix this by using a variable to hold this 'bits_in_wchar',
like done for all others datatypes.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 char.c   | 4 ++--
 target.c | 2 ++
 target.h | 2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/char.c b/char.c
index e2b3863be..c52521bc8 100644
--- a/char.c
+++ b/char.c
@@ -84,7 +84,7 @@ void get_char_constant(struct token *token, unsigned long long *val)
 		end = p + type - TOKEN_WIDE_CHAR;
 	}
 	p = parse_escape(p, &v, end,
-			type < TOKEN_WIDE_CHAR ? bits_in_char : 32, token->pos);
+			type < TOKEN_WIDE_CHAR ? bits_in_char : bits_in_wchar, token->pos);
 	if (p != end)
 		warning(token->pos,
 			"multi-character character constant");
@@ -113,7 +113,7 @@ struct token *get_string_constant(struct token *token, struct expression *expr)
 			done = next;
 		}
 	}
-	bits = is_wide ? 32 : bits_in_char;
+	bits = is_wide ? bits_in_wchar : bits_in_char;
 	while (token != done) {
 		unsigned v;
 		const char *p = token->string->data;
diff --git a/target.c b/target.c
index 17b228ae9..86a9e2e63 100644
--- a/target.c
+++ b/target.c
@@ -22,6 +22,8 @@ int bits_in_long = 32;
 int bits_in_longlong = 64;
 int bits_in_longlonglong = 128;
 
+int bits_in_wchar = 32;
+
 int max_int_alignment = 4;
 
 /*
diff --git a/target.h b/target.h
index 78c85cf7e..8326fa21a 100644
--- a/target.h
+++ b/target.h
@@ -20,6 +20,8 @@ extern int bits_in_long;
 extern int bits_in_longlong;
 extern int bits_in_longlonglong;
 
+extern int bits_in_wchar;
+
 extern int max_int_alignment;
 
 /*
-- 
2.13.0

