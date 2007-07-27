From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: Finding all typedefs
Date: Fri, 27 Jul 2007 16:01:47 -0700
Message-ID: <20070727160147.6ecbfd86.rdunlap@xenotime.net>
References: <1185574111.2029.10.camel@dv>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__27_Jul_2007_16_01_47_-0700_BHwt=.kyYmHUU=YN"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:38129 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1765082AbXG0W4i (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 27 Jul 2007 18:56:38 -0400
Received: from midway.site ([71.245.96.223]) by xenotime.net for <linux-sparse@vger.kernel.org>; Fri, 27 Jul 2007 15:56:34 -0700
In-Reply-To: <1185574111.2029.10.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Fri__27_Jul_2007_16_01_47_-0700_BHwt=.kyYmHUU=YN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Jul 2007 18:08:31 -0400 Pavel Roskin wrote:

> Hello!
> 
> I'm trying to write a wrapper around GNU indent to make the output
> result satisfy checkpatch.pl.  Unfortunately, GNU indent is bad at
> recognizing types if they are just bare words defined by typedef.  Such
> types should be supplied using the "-T" option to indent.
> 
> I would prefer to rely on sparse for finding all typedefs, since it's
> better at parsing C code than any script I could write.
> 
> Is there any way to make sparse dump all type names declared with a
> typedef?  I don't see any of the programs in sparse sources do anything
> like that.  I think c2xml could be a good candidate, as it outputs the
> symbol, but it doesn't give any indication that it's a typedef-defined
> type:
> 
> $ make C=2 CHECK=/home/proski/src/sparse/c2xml |grep foo_t
>   <symbol type="node" id="_29" ident="foo_t"
> file="/home/proski/src/at76/at76_usb.c" start-line="41" start-col="13"
> end-line="41" end-col="18" bit-size="32" alignment="4" offset="0"
> base-type-builtin="int"/>
> 
> Another nice thing would be to have a list of labels.  Although they are
> easier to find by scripts, I would prefer to find them in the same run.

I asked Linus about 3 years ago for something that would dump
global data sizes.  It's attached (updated to recent sparse;
it also has '-keywords' to warn about using C++ keywords, but you
can ignore/delete that part).  It may be fixable to do what you want,
although I have no info on sparse symbol struct contents.
Or maybe Josh et al can do what you want rather easily... :)


use:
make C=2 CF=-list-symbols arch/i386/kernel/smp.o

gives:
arch/i386/kernel/smp.c:107:1: struct tlb_state [addressable] [toplevel] per_cpu__cpu_tlbstate: compound size 128, alignment 128
arch/i386/kernel/smp.c:247:18: struct cpumask_t static [addressable] [toplevel] [usertype] flush_cpumask: compound size 4, alignment 4
arch/i386/kernel/smp.c:248:25: struct mm_struct *static [toplevel] [assigned] flush_mm: compound size 4, alignment 4
arch/i386/kernel/smp.c:250:8: struct spinlock_t static [addressable] [toplevel] [usertype] tlbstate_lock: compound size 8, alignment 4
arch/i386/kernel/smp.c:450:1: char static const [toplevel] __kstrtab_flush_tlb_page[0]: compound size 15, alignment 1
arch/i386/kernel/smp.c:450:1: struct kernel_symbol static const [toplevel] __ksymtab_flush_tlb_page: compound size 8, alignment 4
arch/i386/kernel/smp.c:481:8: struct spinlock_t static [addressable] [toplevel] [usertype] call_lock: compound size 8, alignment 4
arch/i386/kernel/smp.c:501:32: struct call_data_struct *static [toplevel] [assigned] call_data: compound size 4, alignment 4
arch/i386/kernel/smp.c:698:16: struct smp_ops [addressable] [toplevel] smp_ops: compound size 28, alignment 4


---
~Randy

--Multipart=_Fri__27_Jul_2007_16_01_47_-0700_BHwt=.kyYmHUU=YN
Content-Type: text/x-patch;
 name="sparse-keywords-sizes.patch"
Content-Disposition: attachment;
 filename="sparse-keywords-sizes.patch"
Content-Transfer-Encoding: 7bit

From: Randy Dunlap <rdunlap@xenotime.net>
with help from Linus.

sparse additions to:
- check for C/C++ keywords: usage: -keywords
- print all global data symbols and their sizes: usage: -list-symbols
  Example of -list-symbols:
  make C=2 CF="-list-symbols" arch/x86_64/kernel/smpboot.o
  arch/x86_64/kernel/smpboot.c:90:20: struct cpuinfo_x86 [addressable] [toplevel] [assigned] cpu_data[8]: compound size 1344, alignment 64

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 lib.c    |   31 +++++++++++++++++++++++++++++++
 sparse.c |   47 ++++++++++++++++++++++++++++++++++++++++++++++-
 symbol.c |   33 ++++++++++++++++++++++++++++++---
 3 files changed, 107 insertions(+), 4 deletions(-)

--- sparse-2007-07-24.orig/sparse.c
+++ sparse-2007-07-24/sparse.c
@@ -20,6 +20,7 @@
 #include "allocate.h"
 #include "token.h"
 #include "parse.h"
+#include "scope.h"
 #include "symbol.h"
 #include "expression.h"
 #include "linearize.h"
@@ -273,6 +274,42 @@ static void check_symbols(struct symbol_
 	} END_FOR_EACH_PTR(sym);
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
+		///printf("%s: size %u, alignment %lu\n",
+		///info(sym->pos, "%s (0x%x:base 0x%x): compound size %u, alignment %lu",
+		info(sym->pos, "%s: compound size %u, alignment %lu",
+			show_typename(sym), ///sym->type,
+			///sym->ctype.base_type->type,
+			sym->bit_size >> 3,
+			sym->ctype.alignment);
+	} END_FOR_EACH_PTR(sym);
+}
+
 int main(int argc, char **argv)
 {
 	struct string_list *filelist = NULL;
@@ -281,7 +318,15 @@ int main(int argc, char **argv)
 	// Expand, linearize and show it.
 	check_symbols(sparse_initialize(argc, argv, &filelist));
 	FOR_EACH_PTR_NOTAG(filelist, file) {
-		check_symbols(sparse(file));
+		struct symbol_list *res = sparse(file);
+
+		check_symbols(res);
+
+		// List all symbols...
+		if (list_symbols)
+			///list_all_symbols(block_scope->symbols);
+			list_all_symbols(res);
 	} END_FOR_EACH_PTR_NOTAG(file);
+
 	return 0;
 }
--- sparse-2007-07-24.orig/lib.c
+++ sparse-2007-07-24/lib.c
@@ -213,6 +213,8 @@ int dbg_entry = 0;
 int dbg_dead = 0;
 
 int preprocess_only;
+int list_symbols = 0;
+int keywords_all = 0;
 
 #define CMDLINE_INCLUDE 20
 int cmdline_include_nr = 0;
@@ -308,6 +310,31 @@ static char **handle_switch_i(char *arg,
 	return next;
 }
 
+void handle_switch_pre(int argc, char **argv)
+{
+	char **args = argv;
+
+	for (;;) {
+		char *arg = *++args;
+		if (!arg)
+			break;
+
+		if (arg[0] == '-' && arg[1]) {
+			if (!strcmp(arg + 1, "keywords")) {
+				keywords_all = 1;
+				continue;
+			}
+		}
+	}
+}
+
+char **handle_switch_l(char *arg, char **next)
+{
+	if (!strcmp(arg, "list-symbols"))
+		list_symbols = 1;
+	return next;
+}
+
 static char **handle_switch_M(char *arg, char **next)
 {
 	if (!strcmp(arg, "MF") || !strcmp(arg,"MQ") || !strcmp(arg,"MT")) {
@@ -529,6 +556,7 @@ char **handle_switch(char *arg, char **n
 	case 'E': return handle_switch_E(arg, next);
 	case 'I': return handle_switch_I(arg, next);
 	case 'i': return handle_switch_i(arg, next);
+	case 'l': return handle_switch_l(arg, next);
 	case 'M': return handle_switch_M(arg, next);
 	case 'm': return handle_switch_m(arg, next);
 	case 'o': return handle_switch_o(arg, next);
@@ -710,6 +738,9 @@ struct symbol_list *sparse_initialize(in
 	char **args;
 	struct symbol_list *list;
 
+	// allow some switches (like "keywords") before init_symbols();
+	handle_switch_pre(argc, argv);
+
 	// Initialize symbol stream first, so that we can add defines etc
 	init_symbols();
 
--- sparse-2007-07-24.orig/symbol.c
+++ sparse-2007-07-24/symbol.c
@@ -545,7 +545,7 @@ void bind_symbol(struct symbol *sym, str
 	}
 	if (ident->reserved && (ns & (NS_TYPEDEF | NS_STRUCT | NS_LABEL | NS_SYMBOL))) {
 		sparse_error(sym->pos, "Trying to use reserved word '%s' as identifier", show_ident(ident));
-		return;
+		///return;
 	}
 	sym->namespace = ns;
 	sym->next_id = ident->symbols;
@@ -694,12 +694,13 @@ out:
  *
  * "double" == "long float", "long double" == "long long float"
  */
-static struct sym_init {
+struct sym_init {
 	const char *name;
 	struct symbol *base_type;
 	unsigned int modifiers;
 	struct symbol_op *op;
-} symbol_init_table[] = {
+};
+static struct sym_init symbol_init_table[] = {
 	/* Storage class */
 	{ "auto",	NULL,		MOD_AUTO },
 	{ "register",	NULL,		MOD_REGISTER },
@@ -727,6 +728,24 @@ static struct sym_init {
 	{ NULL,		NULL,		0 }
 };
 
+extern int keywords_all;
+const char * all_keywords[] = {
+/* more c_keywords[] */
+	"_Complex", "_Imaginary", "__thread",
+/* and cpp_keywords[] */
+	"bool", "catch", "class",
+	"complex", "__complex__", "const_cast",
+	"delete", "dynamic_cast",
+	"explicit", "export",
+	"false", "friend",
+	"mutable", "namespace", "new",
+	"operator", "private", "protected", "public",
+	"reinterpret_cast", "static_cast",
+	"template", "this", "throw",
+	"true", "try", "typeid", "typename",
+	"using", "virtual", "wchar_t",
+};
+
 static struct symbol_op constant_p_op = {
 	.evaluate = evaluate_to_integer,
 	.expand = expand_constant_p
@@ -812,6 +831,14 @@ void init_symbols(void)
 		sym->ctype.base_type = ptr->base_type;
 		sym->ctype.modifiers = ptr->modifiers;
 	}
+	if (keywords_all) {
+		int kx;
+
+		for (kx = 0; kx < sizeof(all_keywords) / sizeof(char *); kx++) {
+			struct ident *ident = built_in_ident(all_keywords [kx]);
+			ident->reserved = 1;
+		}
+	}
 
 	builtin_fn_type.variadic = 1;
 	for (ptr = eval_init_table; ptr->name; ptr++) {

--Multipart=_Fri__27_Jul_2007_16_01_47_-0700_BHwt=.kyYmHUU=YN--
