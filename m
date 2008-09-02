From: Brett Nash <nash@nash.id.au>
Subject: PATCH] pre-process.c: [trivial] Use a larger buffer [4k] for
 expanding tokens
Date: Wed, 3 Sep 2008 09:31:57 +1000
Message-ID: <20080903093157.0e2586cd@shanbei.fluffyspider.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/QN10/+9fsHIhtgG_qTZ90Tq"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from 218-214-60-232.people.net.au ([218.214.60.232]:32989 "EHLO
	sealpup.fluffyspider.com.au" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751647AbYIBXy4 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 2 Sep 2008 19:54:56 -0400
Received: from shanbei.fluffyspider.com.au
	([192.168.12.230] helo=shanbei.fluffyspider.com ident=nash)
	by sealpup.fluffyspider.com.au with esmtp (Exim 4.63)
	(envelope-from <nash@nash.id.au>)
	id 1KafLq-0006b5-HW
	for linux-sparse@vger.kernel.org; Wed, 03 Sep 2008 09:31:58 +1000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse development list <linux-sparse@vger.kernel.org>

--MP_/QN10/+9fsHIhtgG_qTZ90Tq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--MP_/QN10/+9fsHIhtgG_qTZ90Tq
Content-Type: text/x-patch;
 name=0001-pre-process.c-trivial-Use-a-larger-buffer-4k-fo.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-pre-process.c-trivial-Use-a-larger-buffer-4k-fo.patch

From a6ddce6cb7026b04a186f02def8a60ccb65ee3f3 Mon Sep 17 00:00:00 2001
From: Brett Nash <nash@nash.id.au>
Date: Wed, 3 Sep 2008 08:29:26 +1000
Subject: [PATCH] pre-process.c: [trivial] Use a larger buffer [4k] for expanding tokens
 Fixes error on assert(strcmp(somefn(x),str) == 0)


Signed-off-by: Brett Nash <nash@nash.id.au>
---
 pre-process.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index ca1d8ef..5269613 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -1401,7 +1401,7 @@ static int handle_endif(struct stream *stream, struct token **line, struct token
 
 static const char *show_token_sequence(struct token *token)
 {
-	static char buffer[1024];
+	static char buffer[4096];
 	char *ptr = buffer;
 	int whitespace = 0;
 
-- 
1.5.6.5


--MP_/QN10/+9fsHIhtgG_qTZ90Tq--
