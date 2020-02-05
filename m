From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH] dissect: introduce reporter->r_memdef()
Date: Wed, 5 Feb 2020 13:53:18 +0100
Message-ID: <20200205125318.GA14560@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50817 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726386AbgBEMxZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 5 Feb 2020 07:53:25 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

To report where is the member of struct/union defined.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c      | 12 +++++++++++-
 dissect.h      |  1 +
 test-dissect.c |  6 ++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/dissect.c b/dissect.c
index 88eaab1..60fccbd 100644
--- a/dissect.c
+++ b/dissect.c
@@ -203,6 +203,12 @@ static bool deanon(struct symbol *base, struct ident *node, struct symbol *paren
 	return true;
 }
 
+static void report_memdef(struct symbol *sym, struct symbol *mem)
+{
+	if (sym && mem->ident)
+		reporter->r_memdef(sym, mem);
+}
+
 static void examine_sym_node(struct symbol *node, struct symbol *parent)
 {
 	struct symbol *base;
@@ -236,8 +242,12 @@ static void examine_sym_node(struct symbol *node, struct symbol *parent)
 
 			if (base->ident || deanon(base, name, parent))
 				reporter->r_symdef(base);
+
+			if (base->ident)
+				parent = base;
 			DO_LIST(base->symbol_list, mem,
-				examine_sym_node(mem, base->ident ? base : parent));
+				examine_sym_node(mem, parent);
+				report_memdef(parent, mem));
 		default:
 			return;
 		}
diff --git a/dissect.h b/dissect.h
index 664736c..1f5b1d9 100644
--- a/dissect.h
+++ b/dissect.h
@@ -19,6 +19,7 @@
 struct reporter
 {
 	void (*r_symdef)(struct symbol *);
+	void (*r_memdef)(struct symbol *, struct symbol *);
 
 	void (*r_symbol)(unsigned, struct position *, struct symbol *);
 	void (*r_member)(unsigned, struct position *, struct symbol *, struct symbol *);
diff --git a/test-dissect.c b/test-dissect.c
index af1212a..e725eec 100644
--- a/test-dissect.c
+++ b/test-dissect.c
@@ -75,10 +75,16 @@ static void r_symdef(struct symbol *sym)
 	r_symbol(-1, &sym->pos, sym);
 }
 
+static void r_memdef(struct symbol *sym, struct symbol *mem)
+{
+	r_member(-1, &mem->pos, sym, mem);
+}
+
 int main(int argc, char **argv)
 {
 	static struct reporter reporter = {
 		.r_symdef = r_symdef,
+		.r_memdef = r_memdef,
 		.r_symbol = r_symbol,
 		.r_member = r_member,
 	};
-- 
2.5.0
