From: Edward Cree <ecree@solarflare.com>
Subject: [RFC PATCH 1/2] Allow casting to a restricted type if
 !restricted_value
Date: Fri, 17 Feb 2017 15:11:15 +0000
Message-ID: <1d8e35fa-643b-afa4-8089-f5a945a50eef@solarflare.com>
References: <e8e65c94-4d07-b20e-1bdb-30c7a8d1108f@solarflare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nbfkord-smmo01.seg.att.com ([209.65.160.76]:7794 "EHLO
        nbfkord-smmo01.seg.att.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934112AbdBQPL0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 17 Feb 2017 10:11:26 -0500
In-Reply-To: <e8e65c94-4d07-b20e-1bdb-30c7a8d1108f@solarflare.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

If the operand of a cast to a restricted type is an unrestricted value,
 the cast should not produce a warning, since an equivalent implied cast
 (e.g. in an initialiser) would not do so.

Signed-off-by: Edward Cree <ecree@solarflare.com>
---
 evaluate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/evaluate.c b/evaluate.c
index e350c0c..8e855b1 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2771,7 +2771,7 @@ static struct symbol *evaluate_cast(struct expression *expr)
                t2 = unfoul(t2);

        if (t1 != t2) {
-               if (class1 & TYPE_RESTRICT)
+               if ((class1 & TYPE_RESTRICT) && restricted_value(target, t1))
                        warning(expr->pos, "cast to %s",
                                show_typename(t1));
                if (class2 & TYPE_RESTRICT)

The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.
