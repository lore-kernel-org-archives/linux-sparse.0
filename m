From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] ctags: avoid null deref
Date: Tue,  2 Jan 2018 16:11:16 +0100
Message-ID: <20180102151116.22060-3-luc.vanoostenryck@gmail.com>
References: <20180101225817.3cb135dc04ea0195f28d8512@redchan.it>
 <20180102151116.22060-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:45575 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeABPLb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 2 Jan 2018 10:11:31 -0500
Received: by mail-wm0-f67.google.com with SMTP id 9so61627519wme.4
        for <linux-sparse@vger.kernel.org>; Tue, 02 Jan 2018 07:11:31 -0800 (PST)
In-Reply-To: <20180102151116.22060-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: foobar <foobar@redchan.it>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Protect the dereference of null base_type.

Reported-by: foobar <foobar@redchan.it>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ctags.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ctags.c b/ctags.c
index 9ec6b3c37..30976542d 100644
--- a/ctags.c
+++ b/ctags.c
@@ -135,7 +135,7 @@ static void examine_symbol(struct symbol *sym)
 
 	switch (sym->type) {
 	case SYM_NODE:
-		if (base->type == SYM_FN)
+		if (base && base->type == SYM_FN)
 			sym->kind = 'f';
 		examine_symbol(base);
 		break;
-- 
2.15.0

