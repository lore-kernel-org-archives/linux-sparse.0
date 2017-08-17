From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 4/4] fix promotion of struct & union
Date: Fri, 18 Aug 2017 00:35:58 +0200
Message-ID: <20170817223558.21258-5-luc.vanoostenryck@gmail.com>
References: <20170817223558.21258-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33213 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753510AbdHQWgO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 18:36:14 -0400
Received: by mail-wr0-f195.google.com with SMTP id n88so10664477wrb.0
        for <linux-sparse@vger.kernel.org>; Thu, 17 Aug 2017 15:36:14 -0700 (PDT)
In-Reply-To: <20170817223558.21258-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 linearize.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/linearize.c b/linearize.c
index 485d8eeec..a92a0e095 100644
--- a/linearize.c
+++ b/linearize.c
@@ -957,6 +957,8 @@ static int linearize_address_gen(struct entrypoint *ep,
  */
 static inline int is_promotable(struct symbol *type)
 {
+	struct symbol *member;
+
 	if (type->type == SYM_NODE)
 		type = type->ctype.base_type;
 	switch (type->type) {
@@ -967,7 +969,13 @@ static inline int is_promotable(struct symbol *type)
 		return 1;
 	case SYM_STRUCT:
 	case SYM_UNION:
-		return type->bit_size <= long_ctype.bit_size;
+		if (type->bit_size > long_ctype.bit_size)
+			return 0;
+		FOR_EACH_PTR(type->symbol_list, member) {
+			if (!is_promotable(member))
+				return 0;
+		} END_FOR_EACH_PTR(member);
+		return 1;
 	default:
 		break;
 	}
-- 
2.14.0

