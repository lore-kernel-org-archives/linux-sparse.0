From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 19/48] dump-ir: add an helper to parse sub-options
Date: Wed, 23 Aug 2017 22:15:25 +0200
Message-ID: <20170823201554.90551-20-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35786 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932565AbdHWUQh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:16:37 -0400
Received: by mail-wm0-f68.google.com with SMTP id x79so648266wma.2
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:16:37 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 lib.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/lib.c b/lib.c
index e1454661b..c107505a7 100644
--- a/lib.c
+++ b/lib.c
@@ -476,6 +476,41 @@ static void handle_arch_finalize(void)
 }
 
 
+struct mask_map {
+	const char *name;
+	unsigned long mask;
+};
+
+static unsigned long lookup_mask(const char *name, const struct mask_map *map)
+{
+	for (; map->name; map++) {
+		if (strcmp(name, map->name) == 0)
+			return map->mask;
+	}
+	return 0;
+}
+
+inline
+static unsigned long handle_suboption_mask(char *arg, const struct mask_map *map)
+{
+	const char *token;
+	unsigned long mask = 0;
+
+	if (*arg == '\0')
+		return lookup_mask("$default", map);
+	if (*arg != '=')
+		return ~0UL;
+	arg++;
+	while ((token = strsep(&arg, ",+"))) {
+		unsigned long opt = lookup_mask(token, map);
+		if (!opt)
+			return ~0UL;
+		mask |= opt;
+	}
+	return mask;
+}
+
+
 struct flag {
 	const char *name;
 	int *flag;
-- 
2.14.0

