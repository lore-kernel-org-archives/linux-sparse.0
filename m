From: "Darren Jenkins\\" <darrenrjenkins@gmail.com>
Subject: Sparse RFC
Date: Mon, 26 Mar 2007 23:29:35 +1000
Message-ID: <1174915776.1142.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.227]:16826 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613AbXCZN36 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 26 Mar 2007 09:29:58 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2109511wxd
        for <linux-sparse@vger.kernel.org>; Mon, 26 Mar 2007 06:29:57 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sparse mailing list <linux-sparse@vger.kernel.org>

G'day people,

I have been playing around with the sparse code, and was thinking of
adding a few of the checks that my company uses from other code
checkers, starting with checking that macro arguments have brackets
around them. (Because this is the test my/other code most often fails)

I have put together a quick patch to see what everyone thinks of it. It
is obviously not a finished product but I wanted to see peoples
reactions to this type of thing.

I also have a few questions;

1) Do we want to add a Wdescription switch for each test sparse
performs ? or do we want to group tests under Wstyle Wefficiency
WCodingStandard type group switches ?

2) For the macro argument checking would it be better if I checked for
either a bracket or low precedence operator on both sides of the
argument ? like either a comma or a type of assignment operator? it
would not be a foolproof check then but would seem more sensible to me,
and might be more acceptable to users.

Anyway here is the patch 


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
index afae77a..a04a157 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -1034,7 +1034,9 @@ static struct token *parse_expansion(str
 		} else if (match_op(token->next, SPECIAL_HASHHASH)) {
 			try_arg(token, TOKEN_QUOTED_ARGUMENT, arglist);
 		} else {
-			try_arg(token, TOKEN_MACRO_ARGUMENT, arglist);
+			int argument = try_arg(token, TOKEN_MACRO_ARGUMENT, arglist);
+			if (argument  == 1 && Wmacro_argument_brackets && (!match_op(token->next, ')') || !match_op(last, '(')) )
+				warning(token->pos, "Macro argument is not bracketed in expansion");
 		}
 		if (token_type(token) == TOKEN_ERROR)
 			goto Earg;
diff --git a/token.h b/token.h
diff --git a/tokenize.c b/tokenize.c

 
