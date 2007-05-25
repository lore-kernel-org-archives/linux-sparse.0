From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH] saner reporting of overlaps in initializers
Date: Fri, 25 May 2007 04:57:34 +0100
Message-ID: <E1HrQvm-00018O-Ig@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:58093 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbXEYD5f (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 May 2007 23:57:35 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1HrQvm-00018O-Ig
	for linux-sparse@vger.kernel.org; Fri, 25 May 2007 04:57:34 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Fix the check for overlapping initializers; the current code tries to
skip ones with zero ->bit_size, but doesn't get it right.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 expand.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/expand.c b/expand.c
index aafbfe0..a46f1c2 100644
--- a/expand.c
+++ b/expand.c
@@ -874,7 +874,9 @@ static void verify_nonoverlapping(struct expression_list **list)
 	struct expression *b;
 
 	FOR_EACH_PTR(*list, b) {
-		if (a && a->ctype && a->ctype->bit_size && bit_offset(a) == bit_offset(b)) {
+		if (!b->ctype || !b->ctype->bit_size)
+			continue;
+		if (a && bit_offset(a) == bit_offset(b)) {
 			sparse_error(a->pos, "Initializer entry defined twice");
 			info(b->pos, "  also defined here");
 			return;
-- 
1.5.0-rc2.GIT
