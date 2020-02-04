From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 1/4] dissect: don't report anonymous members in initializers
Date: Tue, 4 Feb 2020 17:51:38 +0100
Message-ID: <20200204165138.GA24340@redhat.com>
References: <20200204165119.GA24330@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27067 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727310AbgBDQvq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 4 Feb 2020 11:51:46 -0500
In-Reply-To: <20200204165119.GA24330@redhat.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

Change report_member() to not call ->r_member(mem) if !mem->ident.
This can only happen in initializer, the output gives no useful info
but looks like a bug. Test-case:

	struct {
		union {
			int x;
		};
	} var = {
		{}
	};

before this patch:

	1:8   s def  :var
	5:3   g def  var                              struct :var
	5:3   g -w-  var                              struct :var
	6:9   s -w-  :var.?                           union <noident>

after:

	1:8   s def  :var
	5:3   g def  var                              struct :var
	5:3   g -w-  var                              struct :var

We also need to change no_member() to ensure we still report the bad
initializers, this will be cleanuped later.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c      | 4 ++--
 test-dissect.c | 7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/dissect.c b/dissect.c
index 14d57bf..ff3a313 100644
--- a/dissect.c
+++ b/dissect.c
@@ -125,7 +125,7 @@ static inline struct symbol *no_member(struct ident *name)
 	};
 
 	sym.ctype.base_type = &bad_ctype;
-	sym.ident = name;
+	sym.ident = name ?: built_in_ident("?");
 
 	return &sym;
 }
@@ -135,7 +135,7 @@ static struct symbol *report_member(usage_t mode, struct position *pos,
 {
 	struct symbol *ret = mem->ctype.base_type;
 
-	if (reporter->r_member)
+	if (mem->ident && reporter->r_member)
 		reporter->r_member(fix_mode(ret, mode), pos, type, mem);
 
 	return ret;
diff --git a/test-dissect.c b/test-dissect.c
index 266148b..af1212a 100644
--- a/test-dissect.c
+++ b/test-dissect.c
@@ -56,14 +56,13 @@ static void r_symbol(unsigned mode, struct position *pos, struct symbol *sym)
 
 static void r_member(unsigned mode, struct position *pos, struct symbol *sym, struct symbol *mem)
 {
-	struct ident *ni, *si, *mi;
+	struct ident *si, *mi;
 
 	print_usage(pos, sym, mode);
 
-	ni = built_in_ident("?");
-	si = sym->ident ?: ni;
+	si = sym->ident ?: built_in_ident("?");
 	/* mem == NULL means entire struct accessed */
-	mi = mem ? (mem->ident ?: ni) : built_in_ident("*");
+	mi = mem ? mem->ident : built_in_ident("*");
 
 	printf("%.*s.%-*.*s %s\n",
 		si->len, si->name,
-- 
2.5.0
