From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Allow array declarators to have 'restrict' in them
Date: Thu, 18 Jun 2009 09:44:54 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906180940490.16802@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49686 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751376AbZFRQoz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Jun 2009 12:44:55 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org


Otherwise sparse is very unhappy about the current glibc header files 
(aio.h, netdb.h. regex.h and spawn.h at a minimum).

It's a hack, and not a proper parsing with saving the information. It just 
ignores any "restrict" keyword at the start of an abstract array 
declaration, but it's better than what we have now.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 ident-list.h |    1 +
 parse.c      |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/ident-list.h b/ident-list.h
index 29ddeca..0ee81bc 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -83,6 +83,7 @@ IDENT(stdcall); IDENT(__stdcall__);
 IDENT(fastcall); IDENT(__fastcall__);
 IDENT(dllimport); IDENT(__dllimport__);
 IDENT(dllexport); IDENT(__dllexport__);
+IDENT(restrict); IDENT(__restrict);
 
 /* Preprocessor idents.  Direct use of __IDENT avoids mentioning the keyword
  * itself by name, preventing these tokens from expanding when compiling
diff --git a/parse.c b/parse.c
index fbeebb0..df696e5 100644
--- a/parse.c
+++ b/parse.c
@@ -1431,6 +1431,8 @@ static struct token *abstract_array_declarator(struct token *token, struct symbo
 {
 	struct expression *expr = NULL;
 
+	if (match_idents(token, &restrict_ident, &__restrict_ident, NULL))
+		token = token->next;
 	token = parse_expression(token, &expr);
 	sym->array_size = expr;
 	return token;

