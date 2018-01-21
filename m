From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] sparse: option to print compound global data symbol info
Date: Sat, 20 Jan 2018 19:36:24 -0800
Message-ID: <80f9f805-fb35-65d6-4a86-ebe0b740fe58@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:35779 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbeAUDh5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 20 Jan 2018 22:37:57 -0500
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

From: Randy Dunlap <rdunlap@infradead.org>
with help from Linus. (many moons ago)

sparse addition to print all compound/composite global data symbols
with their sizes and alignment.

usage: -list-symbols
Example: (in kernel tree)
  make C=2 CF="-list-symbols" arch/x86_64/kernel/smpboot.o
  arch/x86/kernel/smpboot.c:99:1: struct cpuinfo_x86 [addressable] [noderef] [toplevel] <asn:3>cpu_info: compound size 240, alignment 8

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
I have had versions of this patch around for about 10 (!) years, so I think
that it's time to try to have it merged -- although there could easily be
better ways to do this, so please tell me.

 lib.c    |    9 +++++++++
 lib.h    |    1 +
 sparse.1 |    5 +++++
 sparse.c |   41 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 55 insertions(+), 1 deletion(-)

--- orig/sparse.c
+++ next/sparse.c
@@ -36,6 +36,7 @@
 #include "allocate.h"
 #include "token.h"
 #include "parse.h"
+#include "ptrlist.h"
 #include "symbol.h"
 #include "expression.h"
 #include "linearize.h"
@@ -292,6 +293,39 @@ static void check_symbols(struct symbol_
 		exit(1);
 }
 
+extern int list_symbols;
+
+static void list_all_symbols(struct symbol_list *list)
+{
+	struct symbol *sym;
+
+	FOR_EACH_PTR(list, sym) {
+		/* Only show arrays, structures, unions, enums, & typedefs */
+		if (!(sym->namespace & (NS_STRUCT | NS_TYPEDEF | NS_SYMBOL)))
+			continue;
+		/* Only show types we actually examined (ie used) */
+		if (!sym->bit_size)
+			continue;
+		if (sym->type == SYM_FN || sym->type == SYM_ENUM)
+			continue;
+		if (!sym->ctype.base_type)
+			continue;
+		if (sym->ctype.base_type->type == SYM_FN)
+			continue;
+		if (sym->ctype.base_type->type == SYM_ENUM)
+			continue;
+		if (sym->ctype.base_type->type == SYM_BASETYPE)
+			continue;
+		/* Don't show unnamed types */
+		if (!sym->ident)
+			continue;
+		info(sym->pos, "%s: compound size %u, alignment %lu",
+			show_typename(sym),
+			sym->bit_size >> 3,
+			sym->ctype.alignment);
+	} END_FOR_EACH_PTR(sym);
+}
+
 int main(int argc, char **argv)
 {
 	struct string_list *filelist = NULL;
@@ -300,7 +334,12 @@ int main(int argc, char **argv)
 	// Expand, linearize and show it.
 	check_symbols(sparse_initialize(argc, argv, &filelist));
 	FOR_EACH_PTR_NOTAG(filelist, file) {
-		check_symbols(sparse(file));
+		struct symbol_list *res = sparse(file);
+
+		check_symbols(res);
+
+		if (list_symbols)
+			list_all_symbols(res);
 	} END_FOR_EACH_PTR_NOTAG(file);
 
 	report_stats();
--- orig/lib.c
+++ next/lib.c
@@ -258,6 +258,7 @@ int dump_macro_defs = 0;
 int dbg_entry = 0;
 int dbg_dead = 0;
 
+int list_symbols = 0;
 int fmem_report = 0;
 int fdump_linearize;
 unsigned long long fmemcpy_max_count = 100000;
@@ -393,6 +394,13 @@ static char **handle_switch_i(char *arg,
 	return next;
 }
 
+static char **handle_switch_l(char *arg, char **next)
+{
+	if (!strcmp(arg, "list-symbols"))
+		list_symbols = 1;
+	return next;
+}
+
 static char **handle_switch_M(char *arg, char **next)
 {
 	if (!strcmp(arg, "MF") || !strcmp(arg,"MQ") || !strcmp(arg,"MT")) {
@@ -903,6 +911,7 @@ static char **handle_switch(char *arg, c
 	case 'G': return handle_switch_G(arg, next);
 	case 'I': return handle_switch_I(arg, next);
 	case 'i': return handle_switch_i(arg, next);
+	case 'l': return handle_switch_l(arg, next);
 	case 'M': return handle_switch_M(arg, next);
 	case 'm': return handle_switch_m(arg, next);
 	case 'n': return handle_switch_n(arg, next);
--- orig/lib.h
+++ next/lib.h
@@ -151,6 +151,7 @@ extern int dump_macro_defs;
 extern int dbg_entry;
 extern int dbg_dead;
 
+extern int list_symbols;
 extern int fmem_report;
 extern int fdump_linearize;
 extern unsigned long long fmemcpy_max_count;
--- orig/sparse.1
+++ next/sparse.1
@@ -387,6 +387,11 @@ Set the distance between tab stops.  Thi
 column numbers in warnings or errors.  If the value is less than 1 or
 greater than 100, the option is ignored.  The default is 8.
 .
+.TP
+.B \-list-symbols
+Print all compound/composite global data symbols along with their
+compound size and alignment.
+.
 .SH SEE ALSO
 .BR cgcc (1)
 .

