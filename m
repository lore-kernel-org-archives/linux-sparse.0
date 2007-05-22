From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 4/5] Fix an __attribute__() parsing error
Date: Tue, 22 May 2007 19:11:47 +0100
Message-ID: <46533263.3010108@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070606050006040203050907"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from anchor-fallback-96.mail.demon.net ([194.217.242.83]:41531 "EHLO
	anchor-fallback-96.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757578AbXEVTN5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 May 2007 15:13:57 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:4077 "EHLO
	anchor-post-34.mail.demon.net") by anchor-fallback-96.mail.demon.net
	with ESMTP id S613936AbXEVSRV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 May 2007 18:17:21 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

This is a multi-part message in MIME format.
--------------070606050006040203050907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

When updating this patch from the 0.3 version, I made the (new) third parameter
KW_ATTRIBUTE only, rather than (KW_ATTRIBUTE | KW_ASM), since it did not seem
correct to allow an asm there; is that correct?

The test case for this was abstracted from an example in the "expat.h" header file.

$cat ape.c

typedef void (__attribute__((__cdecl__)) *FP)(void *u, const char *n);

void set_FP(void *cb, FP f);

$

  parse.c |    5 ++++-
  1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/parse.c b/parse.c
index db5c9e6..16a6dce 100644
--- a/parse.c
+++ b/parse.c
@@ -1149,7 +1149,10 @@ static struct token *direct_declarator(struct token *token, struct symbol *decl,
  		if (token->special == '(') {
  			struct symbol *sym;
  			struct token *next = token->next;
-			int fn = (p && *p) || match_op(next, ')') || lookup_type(next);
+			int fn;
+
+			next = handle_attributes(next, ctype, KW_ATTRIBUTE);
+			fn = (p && *p) || match_op(next, ')') || lookup_type(next);

  			if (!fn) {
  				struct symbol *base_type = ctype->base_type;
-- 
1.5.1


--------------070606050006040203050907
Content-Type: text/plain;
 name="ape.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ape.c"


typedef void (__attribute__((__cdecl__)) *FP)(void *u, const char *n);

void set_FP(void *cb, FP f);


--------------070606050006040203050907--
