From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] evaluate: mark evaluate_generic_selection() as static
Date: Sat, 30 May 2020 18:51:38 +0100
Message-ID: <37ef319f-ed1e-071d-ff4b-cb3a997fbf65@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:34876 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgE3Rvl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 30 May 2020 13:51:41 -0400
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


Commit c100a7ab (add support for _Generic, 2020-05-28) added the
function evaluate_generic_selection() as an external symbol, without
providing an external declaration in a header file. This causes
sparse to issue a warning as part of the 'selfcheck' target.

Since this function does not (currently) need to be an external symbol,
mark it as static.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 evaluate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/evaluate.c b/evaluate.c
index 5f2b7d6f..8d2e6869 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3280,7 +3280,7 @@ static int type_selection(struct symbol *ctrl, struct symbol *type)
 	return !type_difference(&c, &t, 0, 0);
 }
 
-struct symbol *evaluate_generic_selection(struct expression *expr)
+static struct symbol *evaluate_generic_selection(struct expression *expr)
 {
 	struct type_expression *map;
 	struct expression *res;
-- 
2.26.2
