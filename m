From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/6] keyword: add test case for reserved '_Static_assert'
Date: Fri,  5 May 2017 03:50:29 +0200
Message-ID: <20170505015034.65164-2-luc.vanoostenryck@gmail.com>
References: <20170505015034.65164-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36005 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbdEEBvt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 4 May 2017 21:51:49 -0400
Received: by mail-wr0-f195.google.com with SMTP id v42so2991755wrc.3
        for <linux-sparse@vger.kernel.org>; Thu, 04 May 2017 18:51:49 -0700 (PDT)
In-Reply-To: <20170505015034.65164-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/reserved.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/validation/reserved.c b/validation/reserved.c
index e5d7af862..2ca9ac40a 100644
--- a/validation/reserved.c
+++ b/validation/reserved.c
@@ -16,6 +16,7 @@ static int (__typeof__);
 static int (inline);
 static int (__inline);
 static int (__inline__);
+static int (_Static_assert);
 /*
  * check-name: const et.al. are reserved identifiers
  * check-error-start:
@@ -37,5 +38,6 @@ reserved.c:15:12: error: Trying to use reserved word '__typeof__' as identifier
 reserved.c:16:12: error: Trying to use reserved word 'inline' as identifier
 reserved.c:17:12: error: Trying to use reserved word '__inline' as identifier
 reserved.c:18:12: error: Trying to use reserved word '__inline__' as identifier
+reserved.c:19:12: error: Trying to use reserved word '_Static_assert' as identifier
  * check-error-end:
  */
-- 
2.12.0

