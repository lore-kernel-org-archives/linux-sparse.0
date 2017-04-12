From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/5] teach sparse how to handle '-fmem-report'
Date: Wed, 12 Apr 2017 10:37:02 +0200
Message-ID: <20170412083703.11552-5-luc.vanoostenryck@gmail.com>
References: <20170412083703.11552-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33471 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753262AbdDLIhw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Apr 2017 04:37:52 -0400
Received: by mail-wr0-f196.google.com with SMTP id l28so3082323wre.0
        for <linux-sparse@vger.kernel.org>; Wed, 12 Apr 2017 01:37:51 -0700 (PDT)
In-Reply-To: <20170412083703.11552-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 7 +++----
 lib.h | 1 +
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib.c b/lib.c
index 1d21a2fb7..f316d120e 100644
--- a/lib.c
+++ b/lib.c
@@ -251,6 +251,7 @@ int dbg_entry = 0;
 int dbg_dead = 0;
 
 int fdump_linearize;
+int fmem_report = 0;
 
 int preprocess_only;
 
@@ -695,11 +696,9 @@ static char **handle_switch_f(char *arg, char **next)
 		return handle_switch_fdump(arg+5, next);
 
 	/* handle switches w/ arguments above, boolean and only boolean below */
+	if (handle_simple_switch(arg, "mem-report", &fmem_report))
+		return next;
 
-	if (!strncmp(arg, "no-", 3)) {
-		arg += 3;
-	}
-	/* handle switch here.. */
 	return next;
 }
 
diff --git a/lib.h b/lib.h
index fb612d154..14cb68af0 100644
--- a/lib.h
+++ b/lib.h
@@ -137,6 +137,7 @@ extern int dbg_entry;
 extern int dbg_dead;
 
 extern int fdump_linearize;
+extern int fmem_report;
 
 extern int arch_m64;
 
-- 
2.12.0

