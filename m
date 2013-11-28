From: Franz Schrober <franzschrober@gmail.com>
Subject: [PATCHv2 2/5] Revert "Fix mistaken comparison that becomes a no-op."
Date: Thu, 28 Nov 2013 11:16:19 +0100
Message-ID: <1385633782-775-3-git-send-email-franzschrober@gmail.com>
References: <1385633782-775-1-git-send-email-franzschrober@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:58977 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667Ab3K1KQ5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Nov 2013 05:16:57 -0500
Received: by mail-bk0-f44.google.com with SMTP id d7so3686435bkh.17
        for <linux-sparse@vger.kernel.org>; Thu, 28 Nov 2013 02:16:55 -0800 (PST)
In-Reply-To: <1385633782-775-1-git-send-email-franzschrober@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: jw+debian@jameswestby.net, sparse@chrisli.org, franzschrober@gmail.com, Franz Schrober <franzschrober@yahoo.de>

From: Franz Schrober <franzschrober@yahoo.de>

James Westby is the only person not reacting when asking him about the MIT
license change over email or social media. So he has to count as not accepting
and reverting his contributions is the only way to to avoid possible legal
problems. The contributions can be re-added later when they are rewritten from
scratch.

This reverts commit 006eff06c7adcfb0d06c6fadf6e9b64f0488b2bf.

Cc: James Westby <jw+debian@jameswestby.net>
Signed-off-by: Franz Schrober <franzschrober@yahoo.de>
---
 evaluate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/evaluate.c b/evaluate.c
index 19be637..4b4ea6e 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -175,7 +175,7 @@ left:
 
 static int same_cast_type(struct symbol *orig, struct symbol *new)
 {
-	return orig->bit_size == new->bit_size && orig->bit_offset == new->bit_offset;
+	return orig->bit_size == new->bit_size && orig->bit_offset == orig->bit_offset;
 }
 
 static struct symbol *base_type(struct symbol *node, unsigned long *modp, unsigned long *asp)
-- 
1.8.4.4

