From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 02/15] options: move -Wsparse-all's processing out of handle_onoff_switch()
Date: Sun,  5 Jul 2020 15:02:07 +0200
Message-ID: <20200705130220.26230-3-luc.vanoostenryck@gmail.com>
References: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgGENCb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 09:02:31 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AC3C061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 06:02:30 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id dm19so25930027edb.13
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 06:02:30 -0700 (PDT)
In-Reply-To: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Since handle_onoff_switch() can be used for other flags than the
warnings, the processing of -Wsparse-all should move elsewhere.

So move it into handle_switch_W().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib.c b/lib.c
index 709dd5176112..5128a5b64e9e 100644
--- a/lib.c
+++ b/lib.c
@@ -535,14 +535,6 @@ static char **handle_onoff_switch(char *arg, char **next, const struct flag warn
 	char *p = arg + 1;
 	unsigned i;
 
-	if (!strcmp(p, "sparse-all")) {
-		for (i = 0; warnings[i].name; i++) {
-			if (*warnings[i].flag != WARNING_FORCE_OFF && warnings[i].flag != &Wsparse_error)
-				*warnings[i].flag = WARNING_ON;
-		}
-		return NULL;
-	}
