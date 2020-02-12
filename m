From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 2/2] dissect: kill no_member()
Date: Wed, 12 Feb 2020 11:04:37 +0100
Message-ID: <20200212100437.GA23419@redhat.com>
References: <20200212100414.GA23415@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43655 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728754AbgBLKEo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Feb 2020 05:04:44 -0500
In-Reply-To: <20200212100414.GA23415@redhat.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

It is trivial and has a single caller, lookup_member().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/dissect.c b/dissect.c
index 05bddc8..40baf64 100644
--- a/dissect.c
+++ b/dissect.c
@@ -119,19 +119,6 @@ static usage_t fix_mode(struct symbol *type, usage_t mode)
 	return mode;
 }
 
-static inline struct symbol *no_member(struct ident *name)
-{
-	static struct symbol sym = {
-		.type = SYM_BAD,
-		.ctype.base_type = &bad_ctype,
-		.kind = 'm',
-	};
-
-	sym.ident = name;
-
-	return &sym;
-}
-
 static struct symbol *report_member(usage_t mode, struct position *pos,
 					struct symbol *type, struct symbol *mem)
 {
@@ -308,8 +295,20 @@ found:
 
 static struct symbol *lookup_member(struct symbol *type, struct ident *name, int *addr)
 {
-	return __lookup_member(type, name, addr)
-		?: no_member(name);
+	struct symbol *mem = __lookup_member(type, name, addr);
+
+	if (!mem) {
+		static struct symbol bad_member = {
+			.type = SYM_BAD,
+			.ctype.base_type = &bad_ctype,
+			.kind = 'm',
+		};
+
+		mem = &bad_member;
+		mem->ident = name;
+	}
+
+	return mem;
 }
 
 static struct expression *peek_preop(struct expression *expr, int op)
-- 
2.5.0
