From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/5] do not linearize expressions without a type
Date: Tue, 19 Sep 2017 04:13:31 +0200
Message-ID: <20170919021335.5881-2-luc.vanoostenryck@gmail.com>
References: <20170919021335.5881-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35697 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbdISCNm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 Sep 2017 22:13:42 -0400
Received: by mail-wr0-f195.google.com with SMTP id n64so1363597wrb.2
        for <linux-sparse@vger.kernel.org>; Mon, 18 Sep 2017 19:13:41 -0700 (PDT)
In-Reply-To: <20170919021335.5881-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Expressions without a type are the result of previous
errors which left them unevaluated or only partially
evaluated.

Further processing, like here linearization, then
produce nonsensical or erroneous results, with error
messages unrelated to the cause of the error, like:
"unknown expression (...)" or "call with no type!".

Fix this by refusing to linearize an expressions without
a type.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linearize.c b/linearize.c
index ba76397ea..c36735cdd 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1581,7 +1581,7 @@ static void linearize_argument(struct entrypoint *ep, struct symbol *arg, int nr
 
 pseudo_t linearize_expression(struct entrypoint *ep, struct expression *expr)
 {
-	if (!expr)
+	if (!expr || !expr->ctype)
 		return VOID;
 
 	current_pos = expr->pos;
-- 
2.14.0

