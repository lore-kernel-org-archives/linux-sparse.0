From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 1/8] add is_pseudo_value()
Date: Sat,  3 Jun 2017 10:01:28 +0200
Message-ID: <20170603080135.46477-2-luc.vanoostenryck@gmail.com>
References: <20170603080135.46477-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33593 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbdFCIBo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 3 Jun 2017 04:01:44 -0400
Received: by mail-wm0-f65.google.com with SMTP id b84so22124676wmh.0
        for <linux-sparse@vger.kernel.org>; Sat, 03 Jun 2017 01:01:43 -0700 (PDT)
In-Reply-To: <20170603080135.46477-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/linearize.h b/linearize.h
index bac82d7ff..c704b87b4 100644
--- a/linearize.h
+++ b/linearize.h
@@ -45,6 +45,13 @@ extern struct pseudo void_pseudo;
 
 #define VOID (&void_pseudo)
 
+
+static inline int is_pseudo_value(pseudo_t p, long long value)
+{
+	return p->type == PSEUDO_VAL && p->value == value;
+}
+
+
 struct multijmp {
 	struct basic_block *target;
 	int begin, end;
-- 
2.13.0

