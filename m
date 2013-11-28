From: Franz Schrober <franzschrober@gmail.com>
Subject: [PATCHv2 5/5] sparse: Also check bit_offset when checking implicit casts
Date: Thu, 28 Nov 2013 11:16:22 +0100
Message-ID: <1385633782-775-6-git-send-email-franzschrober@gmail.com>
References: <1385633782-775-1-git-send-email-franzschrober@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:63656 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757932Ab3K1KRF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Nov 2013 05:17:05 -0500
Received: by mail-bk0-f53.google.com with SMTP id na10so3653586bkb.26
        for <linux-sparse@vger.kernel.org>; Thu, 28 Nov 2013 02:17:04 -0800 (PST)
In-Reply-To: <1385633782-775-1-git-send-email-franzschrober@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: jw+debian@jameswestby.net, sparse@chrisli.org, franzschrober@gmail.com, Franz Schrober <franzschrober@yahoo.de>

From: Franz Schrober <franzschrober@yahoo.de>

The comparison in same_cast_type only checked the bit_size of the new and the
old symbol. The bit_offset was only compared with itself and thus would always
be true. Instead Linus most likely wanted to compare the bit_offset of the new
and the old symbol. This regression was introduced in
47f53396a1d62719c44941f84370ead80181728e ("If two implied casts end up undoing
each other, just remove them.").

Reported-by: James Westby <jw+debian@jameswestby.net>
Signed-off-by: Franz Schrober <franzschrober@yahoo.de>
---
 evaluate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/evaluate.c b/evaluate.c
index 5b643d8..6655615 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -191,7 +191,8 @@ left:
 
 static int same_cast_type(struct symbol *orig, struct symbol *new)
 {
-	return orig->bit_size == new->bit_size && orig->bit_offset == orig->bit_offset;
+	return orig->bit_size == new->bit_size &&
+	       orig->bit_offset == new->bit_offset;
 }
 
 static struct symbol *base_type(struct symbol *node, unsigned long *modp, unsigned long *asp)
-- 
1.8.4.4

