From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 03/15] options: move on top the definition of warning type enums
Date: Sun,  5 Jul 2020 15:02:08 +0200
Message-ID: <20200705130220.26230-4-luc.vanoostenryck@gmail.com>
References: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgGENCc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 09:02:32 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C9FC061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 06:02:31 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d18so26551962edv.6
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 06:02:31 -0700 (PDT)
In-Reply-To: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This allows to reuse these enums in earlier helpers.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib.c b/lib.c
index 5128a5b64e9e..43d55a0648ee 100644
--- a/lib.c
+++ b/lib.c
@@ -250,6 +250,12 @@ void die(const char *fmt, ...)
 static struct token *pre_buffer_begin = NULL;
 static struct token *pre_buffer_end = NULL;
 
+enum warning_type {
+	WARNING_OFF,
+	WARNING_ON,
+	WARNING_FORCE_OFF
+};
+
 int Waddress = 0;
 int Waddress_space = 1;
 int Wbitwise = 1;
@@ -523,12 +529,6 @@ static int opt_##NAME(const char *arg, const char *opt, TYPE *ptr, int flag)	\
 OPT_NUMERIC(ullong, unsigned long long, strtoull)
 OPT_NUMERIC(uint, unsigned int, strtoul)
 
-enum {
-	WARNING_OFF,
-	WARNING_ON,
-	WARNING_FORCE_OFF
-};
