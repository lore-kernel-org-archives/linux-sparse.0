From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/8] fix error in bad conditional
Date: Fri,  2 Feb 2018 13:17:29 +0100
Message-ID: <20180202121735.39621-3-luc.vanoostenryck@gmail.com>
References: <20180202121735.39621-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46161 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751463AbeBBMTt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 2 Feb 2018 07:19:49 -0500
Received: by mail-wr0-f193.google.com with SMTP id g21so22355006wrb.13
        for <linux-sparse@vger.kernel.org>; Fri, 02 Feb 2018 04:19:49 -0800 (PST)
In-Reply-To: <20180202121735.39621-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Commit "b5867a33b (fix evaluation of a function or array symbol in conditionals)"
added a missing call to degenerate(epxr) but this must not be done
if the expression is erroneous.

fix this by bypassing the call to degenerate() if the ctype is NULL.

Fixes: b5867a33b62c04811784c6fc233c601a4f2b0841
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                   | 4 +++-
 validation/bad-type-twice0.c | 1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 402fa04af..027993983 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -894,7 +894,9 @@ static struct symbol *evaluate_conditional(struct expression *expr, int iterator
 			ctype = NULL;
 		}
 	}
-	ctype = degenerate(expr);
+
+	if (ctype)
+		ctype = degenerate(expr);
 
 	return ctype;
 }
diff --git a/validation/bad-type-twice0.c b/validation/bad-type-twice0.c
index 2dbc91b03..7a9073c52 100644
--- a/validation/bad-type-twice0.c
+++ b/validation/bad-type-twice0.c
@@ -5,7 +5,6 @@ static int foo(a)
 
 /*
  * check-name: bad-type-twice0
- * check-known-to-fail
  *
  * check-error-start
 bad-type-twice0.c:3:16: error: incorrect type in conditional
-- 
2.16.0

