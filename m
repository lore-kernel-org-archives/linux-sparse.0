From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] predefine: fix multi-token predefine
Date: Sun,  5 Jul 2020 15:11:46 +0200
Message-ID: <20200705131146.26439-3-luc.vanoostenryck@gmail.com>
References: <20200705131146.26439-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgGENLx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 09:11:53 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3105BC061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 06:11:53 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id e22so32179407edq.8
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 06:11:53 -0700 (PDT)
In-Reply-To: <20200705131146.26439-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The function predefine() and its variants are only valid
if they define a single-token value.

However, when a type is signed, predefine_min() will produce
a multi-token value.

Fix this by using add_pre_buffer() instead of predefine().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 predefine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/predefine.c b/predefine.c
index ff457b389480..d05b1018fdce 100644
--- a/predefine.c
+++ b/predefine.c
@@ -52,7 +52,7 @@ static void predefined_min(const char *name, struct symbol *type)
 	snprintf(buf, sizeof(buf), "__%s_MIN__", name);
 
 	if (is_signed_type(type))
-		predefine(buf, 1, "(-__%s_MAX__ - 1)", name);
+		add_pre_buffer("#weak_define %s (-__%s_MAX__ - 1)\n", buf, name);
 	else
 		predefine(buf, 1, "0%s", suffix);
 }
-- 
2.27.0
