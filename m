From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH][RFC] Re: sparse handles int64_t type wrong
Date: Tue, 12 Dec 2006 21:18:27 -0800
Message-ID: <20061213051827.GA13748@chrisli.org>
References: <1165952070.17896.7.camel@chaos.malinovka7.net> <Pine.LNX.4.64.0612121143280.3535@woody.osdl.org> <Pine.LNX.4.64.0612121155450.3535@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:50480 "EHLO
	rwcrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964936AbWLMFlG (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 13 Dec 2006 00:41:06 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612121155450.3535@woody.osdl.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Yura Pakhuchiy <pakhuchiy@gmail.com>, Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org

I took a stab at it.  It seems that direct_declarator() does handle
attributes, but it does not change the ctype to the declarator.
It is kind of awkward that the type is already build when it hit
the attribute in the end. It need to go back to overwrite
the already parsed type.

I have this patch seems make the test case happy. I am not sure
this is correct or not.
 
Chris
 

Index: sparse/parse.c
===================================================================
--- sparse.orig/parse.c	2006-12-12 21:12:29.000000000 -0800
+++ sparse/parse.c	2006-12-12 21:12:47.000000000 -0800
@@ -837,6 +837,10 @@ static struct token *handle_attributes(s
 			struct ctype thistype = { 0, };
 			token = attribute_specifier(token->next, &thistype);
 			apply_ctype(token->pos, &thistype, ctype);
+			if (is_int_type(ctype->base_type) && ctype->modifiers & MOD_SPECIFIER) {
+				ctype->base_type = ctype_integer(ctype->modifiers);
+				ctype->modifiers &= ~MOD_SPECIFIER;
+			}
 			continue;
 		}
 		if (match_idents(token, &asm_ident, &__asm_ident, &__asm___ident)) {
Index: sparse/show-parse.c
===================================================================
--- sparse.orig/show-parse.c	2006-12-12 21:12:29.000000000 -0800
+++ sparse/show-parse.c	2006-12-12 21:12:47.000000000 -0800
@@ -98,7 +98,7 @@ const char *modifier_string(unsigned lon
 	const char *res,**ptr, *names[] = {
 		"auto", "register", "static", "extern",
 		"const", "volatile", "[signed]", "[unsigned]",
-		"[char]", "[short]", "[long]", "[long]",
+		"[char]", "[short]", "[long]", "[long long]",
 		"[typdef]", "[structof]", "[unionof]", "[enum]",
 		"[typeof]", "[attribute]", "inline", "[addressable]",
 		"[nocast]", "[noderef]", "[accessed]", "[toplevel]",
Index: sparse/test-parsing.c
===================================================================
