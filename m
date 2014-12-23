From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH] sparse: Make struct token::special signed
Date: Tue, 23 Dec 2014 14:16:46 +0100
Message-ID: <1419340606-15606-1-git-send-email-rv@rasmusvillemoes.dk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:56735 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186AbaLWNRd (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 23 Dec 2014 08:17:33 -0500
Received: by mail-lb0-f175.google.com with SMTP id u10so5433938lbd.34
        for <linux-sparse@vger.kernel.org>; Tue, 23 Dec 2014 05:17:31 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>
Cc: Rasmus Villemoes <rv@rasmusvillemoes.dk>

There doesn't seem to be any reason for the special member of struct
token to be unsigned; AFAICT it is only ever being directly compared
to explicit characters and the SPECIAL_* enum constants using ==, !=
and in a switch statement. Making it plain int avoids an annoying
warning from match_op in token.h when compiling with -Wsign-compare.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 token.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/token.h b/token.h
index 8dbd80f..69d95d7 100644
--- a/token.h
+++ b/token.h
@@ -187,7 +187,7 @@ struct token {
 	union {
 		const char *number;
 		struct ident *ident;
-		unsigned int special;
+		int special;
 		struct string *string;
 		int argnum;
 		struct argcount count;
-- 
2.1.3

