From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/9] add is_pseudo_value()
Date: Wed, 31 May 2017 05:21:59 +0200
Message-ID: <20170531032207.95830-2-luc.vanoostenryck@gmail.com>
References: <20170531032207.95830-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36027 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdEaDWS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 30 May 2017 23:22:18 -0400
Received: by mail-wm0-f66.google.com with SMTP id k15so1016527wmh.3
        for <linux-sparse@vger.kernel.org>; Tue, 30 May 2017 20:22:17 -0700 (PDT)
In-Reply-To: <20170531032207.95830-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

