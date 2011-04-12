From: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Subject: [PATCH 2/4] more transparent dealing with tokens/position
Date: Tue, 12 Apr 2011 13:19:09 +0200
Message-ID: <4DA4352D.6040602@seznam.cz>
References: <4DA430F9.3070709@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fep18.mx.upcmail.net ([62.179.121.38]:61613 "EHLO
	fep18.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab1DLLTM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 12 Apr 2011 07:19:12 -0400
In-Reply-To: <4DA430F9.3070709@seznam.cz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org

Unify usage of `eof_token'.

Version with respective assertions added will be provided,
mainly for convenient testing.  I used it to proceeded sparse itself
and linux-2.6.35.12 sources with no assertion violation encountered.

Signed-off-by: Jan Pokorny <pokorny_jan@seznam.cz>
---
 pre-process.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index 603cc00..c0fc89d 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -794,7 +794,7 @@ out:
 
 static int free_preprocessor_line(struct token *token)
 {
-	while (token_type(token) != TOKEN_EOF) {
+	while (!eof_token(token)) {
 		struct token *free = token;
 		token = token->next;
 		__free_token(free);
-- 
1.7.1
