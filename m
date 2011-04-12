From: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Subject: Re: [PATCH 2/4] more transparent dealing with tokens/position
Date: Tue, 12 Apr 2011 13:25:55 +0200
Message-ID: <4DA436C3.8060602@seznam.cz>
References: <4DA430F9.3070709@seznam.cz> <4DA4352D.6040602@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fep18.mx.upcmail.net ([62.179.121.38]:63086 "EHLO
	fep18.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881Ab1DLL0A (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 12 Apr 2011 07:26:00 -0400
In-Reply-To: <4DA4352D.6040602@seznam.cz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org

Unify usage of `eof_token', version with respective asserts,
mainly intended for convenient testing.

Signed-off-by: Jan Pokorny <pokorny_jan@seznam.cz>
---
 pre-process.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index 603cc00..cee3d29 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -19,6 +19,7 @@
 #include <fcntl.h>
 #include <limits.h>
 #include <time.h>
+#include <assert.h>
 
 #include "lib.h"
 #include "allocate.h"
@@ -794,11 +795,13 @@ out:
 
 static int free_preprocessor_line(struct token *token)
 {
-	while (token_type(token) != TOKEN_EOF) {
+	while (!eof_token(token)) {
+		assert(token_type(token) != TOKEN_EOF);
 		struct token *free = token;
 		token = token->next;
 		__free_token(free);
 	};
+	assert(token_type(token) == TOKEN_EOF);
 	return 1;
 }
 
-- 
1.7.1
