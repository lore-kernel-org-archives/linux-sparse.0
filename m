From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] show_pseudo(): protect against NULL ->sym
Date: Wed, 14 Feb 2018 01:28:03 +0100
Message-ID: <20180214002804.22668-2-luc.vanoostenryck@gmail.com>
References: <20180214002804.22668-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54300 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966183AbeBNA2M (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 19:28:12 -0500
Received: by mail-wm0-f67.google.com with SMTP id i186so19175673wmi.4
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 16:28:12 -0800 (PST)
In-Reply-To: <20180214002804.22668-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

When displaying a PSEUDO_SYM, the corresponding symbol is
dereferenced but it's possible that this symbol is NULL
when a type error is present.

Fix this by explicitly checking against null ->sym and
emitting "<bad symbol>" if null.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linearize.c b/linearize.c
index 3b4b0d9b4..c174d631f 100644
--- a/linearize.c
+++ b/linearize.c
@@ -111,6 +111,10 @@ const char *show_pseudo(pseudo_t pseudo)
 		struct symbol *sym = pseudo->sym;
 		struct expression *expr;
 
+		if (!sym) {
+			snprintf(buf, 64, "<bad symbol>");
+			break;
+		}
 		if (sym->bb_target) {
 			snprintf(buf, 64, ".L%u", sym->bb_target->nr);
 			break;
-- 
2.16.0

