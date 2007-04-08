From: "Darren Jenkins\\" <darrenrjenkins@gmail.com>
Subject: [PATCH] Sparse- add macro bracket checking
Date: Sun, 08 Apr 2007 18:09:39 +1000
Message-ID: <1176019781.8951.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:58186 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801AbXDHIKV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 8 Apr 2007 04:10:21 -0400
Received: by py-out-1112.google.com with SMTP id a29so777928pyi
        for <linux-sparse@vger.kernel.org>; Sun, 08 Apr 2007 01:10:20 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sparse mailing list <linux-sparse@vger.kernel.org>

G'day people,

I have done some more work on the macro bracket checking and I think it
is now at a pretty workable stage so I thought I would submit it and see
what everyone thinks.

My Idea with this was apart from the obvious cases, to check everything
that would compile with brackets around it. So if you find code that
this will warn about, but which will not compile with brackets around it
please yell out.

I don't know much about this sort of thing, I guess I am doing this to
learn new stuff. So I am very open to suggestions or comments.

Also should I add some pass and fail cases to the validation suite or
something ?


Anyway here it is.

Signed-off-by: Darren Jenkins <darrenrjenkins@gmail.com>
diff --git a/allocate.h b/allocate.h
diff --git a/bitmap.h b/bitmap.h
diff --git a/lib.c b/lib.c
index 79a5c55..27c9fe1 100644
--- a/lib.c
+++ b/lib.c
@@ -204,6 +204,7 @@ int Waddress_space = 1;
 int Wenum_mismatch = 1;
 int Wdo_while = 1;
 int Wuninitialized = 1;
+int Wmacro_argument_brackets = 1;
 
 int dbg_entry = 0;
 int dbg_dead = 0;
diff --git a/lib.h b/lib.h
index 472624d..2657ce3 100644
--- a/lib.h
+++ b/lib.h
@@ -98,6 +98,7 @@ extern int Wshadow;
 extern int Wcast_truncate;
 extern int Wdo_while;
 extern int Wuninitialized;
+extern int Wmacro_argument_brackets;
 
 extern int dbg_entry;
 extern int dbg_dead;
diff --git a/pre-process.c b/pre-process.c
index afae77a..22fa674 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -996,6 +996,69 @@ static int try_arg(struct token *token, 
 	return 0;
 }
 
+unsigned int bracketed_badly(struct token * after, struct token * before)
+{
+	struct token * ptr;
+
+
+	if ( token_type(after) != TOKEN_IDENT ) {
+
+		if ( match_op(after, SPECIAL_HASHHASH) || match_op(after, '(') ) {
+			return 0u;
+		}
+
+		if ( before == NULL || match_op(before, ';') || match_op(before, '{') || match_op(before, '}') ) {
+
+			if ( match_op(after, '=') 		 || match_op(after, SPECIAL_EQUAL)      || 
+			     match_op(after, SPECIAL_GTE) 	 || match_op(after, SPECIAL_LTE)        ||
+			     match_op(after, SPECIAL_XOR_ASSIGN) || match_op(after, SPECIAL_MOD_ASSIGN) ||
+			     match_op(after, SPECIAL_SUB_ASSIGN) || match_op(after, SPECIAL_AND_ASSIGN) ||
+			     match_op(after, SPECIAL_MUL_ASSIGN) || match_op(after, SPECIAL_OR_ASSIGN)    ) {
+				return 1u;
+			}
+			return 0u;
+		}
+
+		if ( token_type(before) == TOKEN_CONCAT || token_type(before) == TOKEN_IDENT || match_op(before, '#') ) {
+			return 0u;
+		}
+
+		if ( match_op(before, '(') || match_op(before, ',') ) {
+
+			if ( match_op(after, ')')  || match_op(after, ',') ) {
+				return 0u;
+			}
+
+			if ( match_op(after, '*') ) {
+
+				if ( match_op(after->next, ')') ) {
+					return 0u;
+				}
+
+				for (ptr = after->next; !eof_token(ptr); ptr = ptr->next) {
+
+					if ( token_type(ptr) == TOKEN_IDENT || match_op(ptr, '(') || match_op(ptr, ',') || match_op(ptr, ';') || 
+					     match_op(ptr, '#') || match_op(ptr, SPECIAL_HASHHASH) || match_op(ptr, ')') || match_op(ptr, '=')  ) {
+						break;
+					} else if ( token_type(ptr) != TOKEN_IDENT && !match_op(ptr, '*') ) {
+						return 1u;
+					}
+				}
+				return 0u;
+			}
+			return 1u;
+		}
+		else if ( (match_op(before, '*') && match_op(after, '=')) || (match_op(before, '[') && match_op(after, ']')) ) {
+			return 0u;
+		}
+		return 1u;
+	}
+	return 0u;
+}
+
+
+
+
 static struct token *parse_expansion(struct token *expansion, struct token *arglist, struct ident *name)
 {
 	struct token *token = expansion;
@@ -1034,7 +1097,12 @@ static struct token *parse_expansion(str
 		} else if (match_op(token->next, SPECIAL_HASHHASH)) {
 			try_arg(token, TOKEN_QUOTED_ARGUMENT, arglist);
 		} else {
-			try_arg(token, TOKEN_MACRO_ARGUMENT, arglist);
+			int argument = try_arg(token, TOKEN_MACRO_ARGUMENT, arglist);
+			if ( Wmacro_argument_brackets          && 
+			     argument == 1                     &&
+			     bracketed_badly(token->next, last)  ) {
+				warning(token->pos, "Macro argument No. %d is not bracketed in expansion", token->argnum + 1);
+			}
 		}
 		if (token_type(token) == TOKEN_ERROR)
 			goto Earg;
diff --git a/ptrlist.h b/ptrlist.h
diff --git a/token.h b/token.h
diff --git a/tokenize.c b/tokenize.c
