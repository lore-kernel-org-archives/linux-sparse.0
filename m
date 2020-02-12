From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 1/2] dissect: don't set ->ident = '?' in no_member()
Date: Wed, 12 Feb 2020 11:04:14 +0100
Message-ID: <20200212100414.GA23415@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48060 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728715AbgBLKET (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Feb 2020 05:04:19 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

no_member() sets ->ident = built_in_ident("?") for the case when dissect()
can't figure out the name of initialized member. For example:

	struct EMPTY {} var = { 10 };

the output:

	1:25  var        -w-   m EMPTY.?           bad type

This is useful, but dissect should not dictate the policy. Let r_member()
decide how this case should be reported.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c      | 6 +++---
 test-dissect.c | 7 ++++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/dissect.c b/dissect.c
index 6706690..05bddc8 100644
--- a/dissect.c
+++ b/dissect.c
@@ -123,11 +123,11 @@ static inline struct symbol *no_member(struct ident *name)
 {
 	static struct symbol sym = {
 		.type = SYM_BAD,
+		.ctype.base_type = &bad_ctype,
 		.kind = 'm',
 	};
 
-	sym.ctype.base_type = &bad_ctype;
-	sym.ident = name ?: built_in_ident("?");
+	sym.ident = name;
 
 	return &sym;
 }
@@ -137,7 +137,7 @@ static struct symbol *report_member(usage_t mode, struct position *pos,
 {
 	struct symbol *ret = mem->ctype.base_type;
 
-	if (mem->ident)
+	if (mem->ident || mem->type == SYM_BAD)
 		reporter->r_member(fix_mode(ret, mode), pos, type, mem);
 
 	return ret;
diff --git a/test-dissect.c b/test-dissect.c
index 4b2d3be..58b3e63 100644
--- a/test-dissect.c
+++ b/test-dissect.c
@@ -80,13 +80,14 @@ err:
 
 static void r_member(unsigned mode, struct position *pos, struct symbol *sym, struct symbol *mem)
 {
-	struct ident *si, *mi;
+	struct ident *ni, *si, *mi;
 
 	print_usage(pos, sym, mode);
 
-	si = sym->ident ?: built_in_ident("?");
+	ni = built_in_ident("?");
+	si = sym->ident ?: ni;
 	/* mem == NULL means entire struct accessed */
-	mi = mem ? mem->ident : built_in_ident("*");
+	mi = mem ? (mem->ident ?: ni) : built_in_ident("*");
 
 	printf("%c m %.*s.%-*.*s %s\n",
 		symscope(sym), si->len, si->name,
-- 
2.5.0
