From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH] fix alignment for _Bool
Date: Fri, 25 May 2007 04:57:44 +0100
Message-ID: <E1HrQvw-00018c-J7@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:58095 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbXEYD5p (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 May 2007 23:57:45 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1HrQvw-00018c-J7
	for linux-sparse@vger.kernel.org; Fri, 25 May 2007 04:57:44 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


_Bool ends up with 0 for alignment, which means that _Bool member in a struct
resets the next field offset to 0.  Should be (at least) 1...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 symbol.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/symbol.c b/symbol.c
index 45d40ee..20a04f3 100644
--- a/symbol.c
+++ b/symbol.c
@@ -832,7 +832,7 @@ void init_ctype(void)
 		struct symbol *sym = ctype->ptr;
 		unsigned long bit_size = ctype->bit_size ? *ctype->bit_size : -1;
 		unsigned long maxalign = ctype->maxalign ? *ctype->maxalign : 0;
-		unsigned long alignment = bit_size >> 3;
+		unsigned long alignment = (bit_size + 7) >> 3;
 
 		if (alignment > maxalign)
 			alignment = maxalign;
-- 
1.5.0-rc2.GIT
