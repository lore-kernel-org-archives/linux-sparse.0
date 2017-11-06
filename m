From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] builtin: make builtins more builtin
Date: Mon,  6 Nov 2017 21:16:28 +0100
Message-ID: <20171106201628.98470-3-luc.vanoostenryck@gmail.com>
References: <20171106201628.98470-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50413 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932463AbdKFUSn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Nov 2017 15:18:43 -0500
Received: by mail-wm0-f65.google.com with SMTP id s66so16119567wmf.5
        for <linux-sparse@vger.kernel.org>; Mon, 06 Nov 2017 12:18:43 -0800 (PST)
In-Reply-To: <20171106201628.98470-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, (most) builtin functions are declared like
a normal function prototype. Furthermore, these declarations
is done via the pre-buffer mechanism and thus need to be
tokenized & parsed like normal code.
This is far from being 'builtin'.

Change this by skipping this pre-buffer phase and directly creating
the appropriate symbol for them.

Note: the correct mechanism to be used to make them really builtin
      is via init_builtins(), used when we have a real semantic
      action for the builtin.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c | 165 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib.c     | 157 ++---------------------------------------------------------
 symbol.h  |   1 +
 3 files changed, 171 insertions(+), 152 deletions(-)

diff --git a/builtin.c b/builtin.c
index 9f90926cb..987ca9b3a 100644
--- a/builtin.c
+++ b/builtin.c
@@ -27,6 +27,7 @@
 #include "expand.h"
 #include "symbol.h"
 #include "compat/bswap.h"
+#include <stdarg.h>
 
 static int evaluate_to_int_const_expr(struct expression *expr)
 {
@@ -259,3 +260,167 @@ void init_builtins(int stream)
 		sym->op = ptr->op;
 	}
 }
+
+static void declare_builtin(const char *name, struct symbol *rtype, int variadic, ...)
+{
+	int stream = 0;			// FIXME
+	struct symbol *sym = create_symbol(stream, name, SYM_NODE, NS_SYMBOL);
+	struct symbol *fun = alloc_symbol(sym->pos, SYM_FN);
+	struct symbol *arg;
+	va_list args;
+
+	sym->ident->reserved = 1;
+	sym->ctype.base_type = fun;
+	sym->ctype.modifiers = MOD_TOPLEVEL;
+
+	fun->ctype.base_type = rtype;
+	fun->variadic = variadic;
+
+	va_start(args, variadic);
+	while ((arg = va_arg(args, struct symbol *))) {
+		struct symbol *anode = alloc_symbol(sym->pos, SYM_NODE);
+		anode->ctype.base_type = arg;
+		add_symbol(&fun->arguments, anode);
+	}
+	va_end(args);
+}
+
+void declare_builtins(void)
+{
+	struct symbol *va_list_ctype = &ptr_ctype;
+
+	declare_builtin("__builtin_abort", &void_ctype, 0, NULL);
+	declare_builtin("__builtin_abs", &int_ctype , 0, &int_ctype, NULL);
+	declare_builtin("__builtin_alloca", &ptr_ctype, 0, size_t_ctype, NULL);
+	declare_builtin("__builtin_alpha_cmpbge", &long_ctype, 0, &long_ctype, &long_ctype, NULL);
+	declare_builtin("__builtin_alpha_extbl", &long_ctype, 0, &long_ctype, &long_ctype, NULL);
+	declare_builtin("__builtin_alpha_extwl", &long_ctype, 0, &long_ctype, &long_ctype, NULL);
+	declare_builtin("__builtin_alpha_insbl", &long_ctype, 0, &long_ctype, &long_ctype, NULL);
+	declare_builtin("__builtin_alpha_inslh", &long_ctype, 0, &long_ctype, &long_ctype, NULL);
+	declare_builtin("__builtin_alpha_insql", &long_ctype, 0, &long_ctype, &long_ctype, NULL);
+	declare_builtin("__builtin_alpha_inswl", &long_ctype, 0, &long_ctype, &long_ctype, NULL);
+	declare_builtin("__builtin_bcmp", &int_ctype , 0, &const_ptr_ctype, &const_ptr_ctype, size_t_ctype, NULL);
+	declare_builtin("__builtin_bcopy", &void_ctype, 0, &const_ptr_ctype, &ptr_ctype, size_t_ctype, NULL);
+	declare_builtin("__builtin_bswap16", &ushort_ctype, 0, &ushort_ctype, NULL);
+	declare_builtin("__builtin_bswap32", &uint_ctype, 0, &uint_ctype, NULL);
+	declare_builtin("__builtin_bswap64", &ullong_ctype, 0, &ullong_ctype, NULL);
+
+	declare_builtin("__builtin_bzero", &void_ctype, 0, &ptr_ctype, size_t_ctype, NULL);
+	declare_builtin("__builtin_calloc", &ptr_ctype, 0, size_t_ctype, size_t_ctype, NULL);
+	declare_builtin("__builtin_clrsb", &int_ctype, 0, &int_ctype, NULL);
+	declare_builtin("__builtin_clrsbl", &int_ctype, 0, &long_ctype, NULL);
+	declare_builtin("__builtin_clrsbll", &int_ctype, 0, &llong_ctype, NULL);
+	declare_builtin("__builtin_clz", &int_ctype, 0, &int_ctype, NULL);
+	declare_builtin("__builtin_clzl", &int_ctype, 0, &long_ctype, NULL);
+	declare_builtin("__builtin_clzll", &int_ctype, 0, &llong_ctype, NULL);
+	declare_builtin("__builtin_ctz", &int_ctype, 0, &int_ctype, NULL);
+	declare_builtin("__builtin_ctzl", &int_ctype, 0, &long_ctype, NULL);
+	declare_builtin("__builtin_ctzll", &int_ctype, 0, &llong_ctype, NULL);
+	declare_builtin("__builtin_exit", &void_ctype, 0, &int_ctype, NULL);
+	declare_builtin("__builtin_extract_return_addr", &ptr_ctype, 0, &ptr_ctype, NULL);
+	declare_builtin("__builtin_fabs", &double_ctype, 0, &double_ctype, NULL);
+	declare_builtin("__builtin_ffs", &int_ctype, 0, &int_ctype, NULL);
+	declare_builtin("__builtin_ffsl", &int_ctype, 0, &long_ctype, NULL);
+	declare_builtin("__builtin_ffsll", &int_ctype, 0, &llong_ctype, NULL);
+	declare_builtin("__builtin_frame_address", &ptr_ctype, 0, &uint_ctype, NULL);
+	declare_builtin("__builtin_free", &void_ctype, 0, &ptr_ctype, NULL);
+	declare_builtin("__builtin_huge_val", &double_ctype, 0, NULL);
+	declare_builtin("__builtin_huge_valf", &float_ctype, 0, NULL);
+	declare_builtin("__builtin_huge_vall", &ldouble_ctype, 0, NULL);
+	declare_builtin("__builtin_index", &string_ctype, 0, &const_string_ctype, &int_ctype, NULL);
+	declare_builtin("__builtin_inf", &double_ctype, 0, NULL);
+	declare_builtin("__builtin_inff", &float_ctype, 0, NULL);
+	declare_builtin("__builtin_infl", &ldouble_ctype, 0, NULL);
+	declare_builtin("__builtin_isgreater", &int_ctype, 0, &float_ctype, &float_ctype, NULL);
+	declare_builtin("__builtin_isgreaterequal", &int_ctype, 0, &float_ctype, &float_ctype, NULL);
+	declare_builtin("__builtin_isless", &int_ctype, 0, &float_ctype, &float_ctype, NULL);
+	declare_builtin("__builtin_islessequal", &int_ctype, 0, &float_ctype, &float_ctype, NULL);
+	declare_builtin("__builtin_islessgreater", &int_ctype, 0, &float_ctype, &float_ctype, NULL);
+	declare_builtin("__builtin_isunordered", &int_ctype, 0, &float_ctype, &float_ctype, NULL);
+	declare_builtin("__builtin_labs", &long_ctype, 0, &long_ctype, NULL);
+	declare_builtin("__builtin_llabs", &llong_ctype, 0, &llong_ctype, NULL);
+	declare_builtin("__builtin_malloc", &ptr_ctype, 0, size_t_ctype, NULL);
+	declare_builtin("__builtin_memchr", &ptr_ctype, 0, &const_ptr_ctype, &int_ctype, size_t_ctype, NULL);
+	declare_builtin("__builtin_memcmp", &int_ctype, 0, &const_ptr_ctype, &const_ptr_ctype, size_t_ctype, NULL);
+	declare_builtin("__builtin_memcpy", &ptr_ctype, 0, &ptr_ctype, &const_ptr_ctype, size_t_ctype, NULL);
+	declare_builtin("__builtin_memmove", &ptr_ctype, 0, &ptr_ctype, &const_ptr_ctype, size_t_ctype, NULL);
+	declare_builtin("__builtin_mempcpy", &ptr_ctype, 0, &ptr_ctype, &const_ptr_ctype, size_t_ctype, NULL);
+	declare_builtin("__builtin_memset", &ptr_ctype, 0, &ptr_ctype, &int_ctype, size_t_ctype, NULL);
+	declare_builtin("__builtin_nan", &double_ctype, 0, &const_string_ctype, NULL);
+	declare_builtin("__builtin_nanf", &float_ctype, 0, &const_string_ctype, NULL);
+	declare_builtin("__builtin_nanl", &ldouble_ctype, 0, &const_string_ctype, NULL);
+	declare_builtin("__builtin_object_size", size_t_ctype, 0, &const_ptr_ctype, &int_ctype, NULL);
+	declare_builtin("__builtin_parity", &int_ctype, 0, &uint_ctype, NULL);
+	declare_builtin("__builtin_parityl", &int_ctype, 0, &ulong_ctype, NULL);
+	declare_builtin("__builtin_parityll", &int_ctype, 0, &ullong_ctype, NULL);
+	declare_builtin("__builtin_popcount", &int_ctype, 0, &uint_ctype, NULL);
+	declare_builtin("__builtin_popcountl", &int_ctype, 0, &ulong_ctype, NULL);
+	declare_builtin("__builtin_popcountll", &int_ctype, 0, &ullong_ctype, NULL);
+	declare_builtin("__builtin_prefetch", &void_ctype, 1, &const_ptr_ctype, NULL);
+	declare_builtin("__builtin_printf", &int_ctype, 1, &const_string_ctype, NULL);
+	declare_builtin("__builtin_puts", &int_ctype, 0, &const_string_ctype, NULL);
+	declare_builtin("__builtin_realloc", &ptr_ctype, 0, &ptr_ctype, size_t_ctype, NULL);
+	declare_builtin("__builtin_return_address", &ptr_ctype, 0, &uint_ctype, NULL);
+	declare_builtin("__builtin_rindex", &string_ctype, 0, &const_string_ctype, &int_ctype, NULL);
+	declare_builtin("__builtin_snprintf", &int_ctype, 1, &string_ctype, size_t_ctype, &const_string_ctype, NULL);
+	declare_builtin("__builtin_sprintf", &int_ctype, 1, &string_ctype, &const_string_ctype, NULL);
+	declare_builtin("__builtin_stpcpy", &string_ctype, 0, &const_string_ctype, &const_string_ctype, NULL);
+	declare_builtin("__builtin_stpncpy", &string_ctype, 0, &const_string_ctype, &const_string_ctype, size_t_ctype, NULL);
+	declare_builtin("__builtin_strcasecmp", &int_ctype, 0, &const_string_ctype, &const_string_ctype, NULL);
+	declare_builtin("__builtin_strcasestr", &string_ctype, 0, &const_string_ctype, &const_string_ctype, NULL);
+	declare_builtin("__builtin_strcat", &string_ctype, 0, &string_ctype, &const_string_ctype, NULL);
+	declare_builtin("__builtin_strchr", &string_ctype, 0, &const_string_ctype, &int_ctype, NULL);
+	declare_builtin("__builtin_strcmp", &int_ctype, 0, &const_string_ctype, &const_string_ctype, NULL);
+	declare_builtin("__builtin_strcpy", &string_ctype, 0, &string_ctype, &const_string_ctype, NULL);
+	declare_builtin("__builtin_strcspn", size_t_ctype, 0, &const_string_ctype, &const_string_ctype, NULL);
+	declare_builtin("__builtin_strdup", &string_ctype, 0, &const_string_ctype, NULL);
+	declare_builtin("__builtin_strlen", size_t_ctype, 0, &const_string_ctype, NULL);
+	declare_builtin("__builtin_strncasecmp", &int_ctype, 0, &const_string_ctype, &const_string_ctype, size_t_ctype, NULL);
+	declare_builtin("__builtin_strncat", &string_ctype, 0, &string_ctype, &const_string_ctype, size_t_ctype, NULL);
+	declare_builtin("__builtin_strncmp", &int_ctype, 0, &const_string_ctype, &const_string_ctype, size_t_ctype, NULL);
+	declare_builtin("__builtin_strncpy", &string_ctype, 0, &string_ctype, &const_string_ctype, size_t_ctype, NULL);
+	declare_builtin("__builtin_strndup", &string_ctype, 0, &const_string_ctype, size_t_ctype, NULL);
+	declare_builtin("__builtin_strnstr", &string_ctype, 0, &const_string_ctype, &const_string_ctype, size_t_ctype, NULL);
+	declare_builtin("__builtin_strpbrk", &string_ctype, 0, &const_string_ctype, &const_string_ctype, NULL);
+	declare_builtin("__builtin_strrchr", &string_ctype, 0, &const_string_ctype, &int_ctype, NULL);
+	declare_builtin("__builtin_strspn", size_t_ctype, 0, &const_string_ctype, &const_string_ctype, NULL);
+	declare_builtin("__builtin_strstr", &string_ctype, 0, &const_string_ctype, &const_string_ctype, NULL);
+	declare_builtin("__builtin_trap", &void_ctype, 0, NULL);
+	declare_builtin("__builtin_unreachable", &void_ctype, 0, NULL);
+	declare_builtin("__builtin_va_arg_pack_len", size_t_ctype, 0, NULL);
+	declare_builtin("__builtin_vprintf", &int_ctype, 0, &const_string_ctype, va_list_ctype, NULL);
+	declare_builtin("__builtin_vsnprintf", &int_ctype, 0, &string_ctype, size_t_ctype, &const_string_ctype, va_list_ctype, NULL);
+	declare_builtin("__builtin_vsprintf", &int_ctype, 0, &string_ctype, &const_string_ctype, va_list_ctype, NULL);
+
+	declare_builtin("__builtin___memcpy_chk", &ptr_ctype, 0, &ptr_ctype, &const_ptr_ctype, size_t_ctype, size_t_ctype, NULL);
+	declare_builtin("__builtin___memmove_chk", &ptr_ctype, 0, &ptr_ctype, &const_ptr_ctype, size_t_ctype, size_t_ctype, NULL);
+	declare_builtin("__builtin___mempcpy_chk", &ptr_ctype, 0, &ptr_ctype, &const_ptr_ctype, size_t_ctype, size_t_ctype, NULL);
+	declare_builtin("__builtin___memset_chk", &ptr_ctype, 0, &ptr_ctype, &int_ctype, size_t_ctype, size_t_ctype, NULL);
+	declare_builtin("__builtin___snprintf_chk", &int_ctype, 1, &string_ctype, size_t_ctype, &int_ctype , size_t_ctype, &const_string_ctype, NULL);
+	declare_builtin("__builtin___sprintf_chk", &int_ctype, 1, &string_ctype, &int_ctype, size_t_ctype, &const_string_ctype, NULL);
+	declare_builtin("__builtin___stpcpy_chk", &string_ctype, 0, &string_ctype, &const_string_ctype, size_t_ctype, NULL);
+	declare_builtin("__builtin___strcat_chk", &string_ctype, 0, &string_ctype, &const_string_ctype, size_t_ctype, NULL);
+	declare_builtin("__builtin___strcpy_chk", &string_ctype, 0, &string_ctype, &const_string_ctype, size_t_ctype, NULL);
+	declare_builtin("__builtin___strncat_chk", &string_ctype, 0, &string_ctype, &const_string_ctype, size_t_ctype, size_t_ctype, NULL);
+	declare_builtin("__builtin___strncpy_chk", &string_ctype, 0, &string_ctype, &const_string_ctype, size_t_ctype, size_t_ctype, NULL);
+	declare_builtin("__builtin___vsnprintf_chk", &int_ctype, 0, &string_ctype, size_t_ctype, &int_ctype, size_t_ctype, &const_string_ctype, va_list_ctype, NULL);
+	declare_builtin("__builtin___vsprintf_chk", &int_ctype, 0, &string_ctype, &int_ctype, size_t_ctype, &const_string_ctype, va_list_ctype, NULL);
+
+	declare_builtin("__sync_add_and_fetch", &int_ctype, 1, &ptr_ctype, NULL);
+	declare_builtin("__sync_and_and_fetch", &int_ctype, 1, &ptr_ctype, NULL);
+	declare_builtin("__sync_bool_compare_and_swap", &int_ctype, 1, &ptr_ctype, NULL);
+	declare_builtin("__sync_fetch_and_add", &int_ctype, 1, &ptr_ctype, NULL);
+	declare_builtin("__sync_fetch_and_and", &int_ctype, 1, &ptr_ctype, NULL);
+	declare_builtin("__sync_fetch_and_nand", &int_ctype, 1, &ptr_ctype, NULL);
+	declare_builtin("__sync_fetch_and_or", &int_ctype, 1, &ptr_ctype, NULL);
+	declare_builtin("__sync_fetch_and_sub", &int_ctype, 1, &ptr_ctype, NULL);
+	declare_builtin("__sync_fetch_and_xor", &int_ctype, 1, &ptr_ctype, NULL);
+	declare_builtin("__sync_lock_release", &void_ctype, 1, &ptr_ctype, NULL);
+	declare_builtin("__sync_lock_test_and_set", &int_ctype, 1, &ptr_ctype, NULL);
+	declare_builtin("__sync_nand_and_fetch", &int_ctype, 1, &ptr_ctype, NULL);
+	declare_builtin("__sync_or_and_fetch", &int_ctype, 1, &ptr_ctype, NULL);
+	declare_builtin("__sync_sub_and_fetch", &int_ctype, 1, &ptr_ctype, NULL);
+	declare_builtin("__sync_synchronize", &void_ctype, 0, NULL);
+	declare_builtin("__sync_val_compare_and_swap", &int_ctype, 1, &ptr_ctype, NULL);
+	declare_builtin("__sync_xor_and_fetch", &int_ctype, 1, &ptr_ctype, NULL);
+}
diff --git a/lib.c b/lib.c
index 4602cf85d..088c4d2b9 100644
--- a/lib.c
+++ b/lib.c
@@ -978,105 +978,10 @@ static void predefined_macros(void)
 
 void declare_builtin_functions(void)
 {
-	/* Gaah. gcc knows tons of builtin <string.h> functions */
-	add_pre_buffer("extern void *__builtin_memchr(const void *, int, __SIZE_TYPE__);\n");
-	add_pre_buffer("extern void *__builtin_memcpy(void *, const void *, __SIZE_TYPE__);\n");
-	add_pre_buffer("extern void *__builtin_mempcpy(void *, const void *, __SIZE_TYPE__);\n");
-	add_pre_buffer("extern void *__builtin_memmove(void *, const void *, __SIZE_TYPE__);\n");
-	add_pre_buffer("extern void *__builtin_memset(void *, int, __SIZE_TYPE__);\n");
-	add_pre_buffer("extern int __builtin_memcmp(const void *, const void *, __SIZE_TYPE__);\n");
-	add_pre_buffer("extern char *__builtin_strcat(char *, const char *);\n");
-	add_pre_buffer("extern char *__builtin_strncat(char *, const char *, __SIZE_TYPE__);\n");
-	add_pre_buffer("extern int __builtin_strcmp(const char *, const char *);\n");
-	add_pre_buffer("extern int __builtin_strncmp(const char *, const char *, __SIZE_TYPE__);\n");
-	add_pre_buffer("extern int __builtin_strcasecmp(const char *, const char *);\n");
-	add_pre_buffer("extern int __builtin_strncasecmp(const char *, const char *, __SIZE_TYPE__);\n");
-	add_pre_buffer("extern char *__builtin_strchr(const char *, int);\n");
-	add_pre_buffer("extern char *__builtin_strrchr(const char *, int);\n");
-	add_pre_buffer("extern char *__builtin_strcpy(char *, const char *);\n");
-	add_pre_buffer("extern char *__builtin_strncpy(char *, const char *, __SIZE_TYPE__);\n");
-	add_pre_buffer("extern char *__builtin_strdup(const char *);\n");
-	add_pre_buffer("extern char *__builtin_strndup(const char *, __SIZE_TYPE__);\n");
-	add_pre_buffer("extern __SIZE_TYPE__ __builtin_strspn(const char *, const char *);\n");
-	add_pre_buffer("extern __SIZE_TYPE__ __builtin_strcspn(const char *, const char *);\n");
-	add_pre_buffer("extern char * __builtin_strpbrk(const char *, const char *);\n");
-	add_pre_buffer("extern char* __builtin_stpcpy(const char *, const char*);\n");
-	add_pre_buffer("extern char* __builtin_stpncpy(const char *, const char*, __SIZE_TYPE__);\n");
-	add_pre_buffer("extern __SIZE_TYPE__ __builtin_strlen(const char *);\n");
-	add_pre_buffer("extern char *__builtin_strstr(const char *, const char *);\n");
-	add_pre_buffer("extern char *__builtin_strcasestr(const char *, const char *);\n");
-	add_pre_buffer("extern char *__builtin_strnstr(const char *, const char *, __SIZE_TYPE__);\n");
-
-	/* And even some from <strings.h> */
-	add_pre_buffer("extern int  __builtin_bcmp(const void *, const void *, __SIZE_TYPE__);\n");
-	add_pre_buffer("extern void __builtin_bcopy(const void *, void *, __SIZE_TYPE__);\n");
-	add_pre_buffer("extern void __builtin_bzero(void *, __SIZE_TYPE__);\n");
-	add_pre_buffer("extern char*__builtin_index(const char *, int);\n");
-	add_pre_buffer("extern char*__builtin_rindex(const char *, int);\n");
-
-	/* And bitwise operations.. */
-	add_pre_buffer("extern int __builtin_clrsb(int);\n");
-	add_pre_buffer("extern int __builtin_clrsbl(long);\n");
-	add_pre_buffer("extern int __builtin_clrsbll(long long);\n");
-	add_pre_buffer("extern int __builtin_clz(int);\n");
-	add_pre_buffer("extern int __builtin_clzl(long);\n");
-	add_pre_buffer("extern int __builtin_clzll(long long);\n");
-	add_pre_buffer("extern int __builtin_ctz(int);\n");
-	add_pre_buffer("extern int __builtin_ctzl(long);\n");
-	add_pre_buffer("extern int __builtin_ctzll(long long);\n");
-	add_pre_buffer("extern int __builtin_ffs(int);\n");
-	add_pre_buffer("extern int __builtin_ffsl(long);\n");
-	add_pre_buffer("extern int __builtin_ffsll(long long);\n");
-	add_pre_buffer("extern int __builtin_parity(unsigned int);\n");
-	add_pre_buffer("extern int __builtin_parityl(unsigned long);\n");
-	add_pre_buffer("extern int __builtin_parityll(unsigned long long);\n");
-	add_pre_buffer("extern int __builtin_popcount(unsigned int);\n");
-	add_pre_buffer("extern int __builtin_popcountl(unsigned long);\n");
-	add_pre_buffer("extern int __builtin_popcountll(unsigned long long);\n");
-
-	/* And byte swaps.. */
-	add_pre_buffer("extern unsigned short __builtin_bswap16(unsigned short);\n");
-	add_pre_buffer("extern unsigned int __builtin_bswap32(unsigned int);\n");
-	add_pre_buffer("extern unsigned long long __builtin_bswap64(unsigned long long);\n");
-
-	/* And atomic memory access functions.. */
-	add_pre_buffer("extern int __sync_fetch_and_add(void *, ...);\n");
-	add_pre_buffer("extern int __sync_fetch_and_sub(void *, ...);\n");
-	add_pre_buffer("extern int __sync_fetch_and_or(void *, ...);\n");
-	add_pre_buffer("extern int __sync_fetch_and_and(void *, ...);\n");
-	add_pre_buffer("extern int __sync_fetch_and_xor(void *, ...);\n");
-	add_pre_buffer("extern int __sync_fetch_and_nand(void *, ...);\n");
-	add_pre_buffer("extern int __sync_add_and_fetch(void *, ...);\n");
-	add_pre_buffer("extern int __sync_sub_and_fetch(void *, ...);\n");
-	add_pre_buffer("extern int __sync_or_and_fetch(void *, ...);\n");
-	add_pre_buffer("extern int __sync_and_and_fetch(void *, ...);\n");
-	add_pre_buffer("extern int __sync_xor_and_fetch(void *, ...);\n");
-	add_pre_buffer("extern int __sync_nand_and_fetch(void *, ...);\n");
-	add_pre_buffer("extern int __sync_bool_compare_and_swap(void *, ...);\n");
-	add_pre_buffer("extern int __sync_val_compare_and_swap(void *, ...);\n");
-	add_pre_buffer("extern void __sync_synchronize();\n");
-	add_pre_buffer("extern int __sync_lock_test_and_set(void *, ...);\n");
-	add_pre_buffer("extern void __sync_lock_release(void *, ...);\n");
-
-	/* And some random ones.. */
-	add_pre_buffer("extern void *__builtin_return_address(unsigned int);\n");
-	add_pre_buffer("extern void *__builtin_extract_return_addr(void *);\n");
-	add_pre_buffer("extern void *__builtin_frame_address(unsigned int);\n");
-	add_pre_buffer("extern void __builtin_trap(void);\n");
-	add_pre_buffer("extern void *__builtin_alloca(__SIZE_TYPE__);\n");
-	add_pre_buffer("extern void __builtin_prefetch (const void *, ...);\n");
-	add_pre_buffer("extern long __builtin_alpha_extbl(long, long);\n");
-	add_pre_buffer("extern long __builtin_alpha_extwl(long, long);\n");
-	add_pre_buffer("extern long __builtin_alpha_insbl(long, long);\n");
-	add_pre_buffer("extern long __builtin_alpha_inswl(long, long);\n");
-	add_pre_buffer("extern long __builtin_alpha_insql(long, long);\n");
-	add_pre_buffer("extern long __builtin_alpha_inslh(long, long);\n");
-	add_pre_buffer("extern long __builtin_alpha_cmpbge(long, long);\n");
-	add_pre_buffer("extern int  __builtin_abs(int);\n");
-	add_pre_buffer("extern long __builtin_labs(long);\n");
-	add_pre_buffer("extern long long __builtin_llabs(long long);\n");
-	add_pre_buffer("extern double __builtin_fabs(double);\n");
-	add_pre_buffer("extern __SIZE_TYPE__ __builtin_va_arg_pack_len(void);\n");
+	/* Note:
+	 * Most builtin functions are declared in builtin.c:declare_builtins().
+	 * Some are also defined in builtin:init_builtins().
+	 */
 
 	/* Add Blackfin-specific stuff */
 	add_pre_buffer(
@@ -1086,59 +991,6 @@ void declare_builtin_functions(void)
 		"extern int __builtin_bfin_norm_fr1x32(int);\n"
 		"#endif\n"
 	);
-
-	/* And some floating point stuff.. */
-	add_pre_buffer("extern int __builtin_isgreater(float, float);\n");
-	add_pre_buffer("extern int __builtin_isgreaterequal(float, float);\n");
-	add_pre_buffer("extern int __builtin_isless(float, float);\n");
-	add_pre_buffer("extern int __builtin_islessequal(float, float);\n");
-	add_pre_buffer("extern int __builtin_islessgreater(float, float);\n");
-	add_pre_buffer("extern int __builtin_isunordered(float, float);\n");
-
-	/* And some INFINITY / NAN stuff.. */
-	add_pre_buffer("extern double __builtin_huge_val(void);\n");
-	add_pre_buffer("extern float __builtin_huge_valf(void);\n");
-	add_pre_buffer("extern long double __builtin_huge_vall(void);\n");
-	add_pre_buffer("extern double __builtin_inf(void);\n");
-	add_pre_buffer("extern float __builtin_inff(void);\n");
-	add_pre_buffer("extern long double __builtin_infl(void);\n");
-	add_pre_buffer("extern double __builtin_nan(const char *);\n");
-	add_pre_buffer("extern float __builtin_nanf(const char *);\n");
-	add_pre_buffer("extern long double __builtin_nanl(const char *);\n");
-
-	/* And some __FORTIFY_SOURCE ones.. */
-	add_pre_buffer ("extern __SIZE_TYPE__ __builtin_object_size(const void *, int);\n");
-	add_pre_buffer ("extern void * __builtin___memcpy_chk(void *, const void *, __SIZE_TYPE__, __SIZE_TYPE__);\n");
-	add_pre_buffer ("extern void * __builtin___memmove_chk(void *, const void *, __SIZE_TYPE__, __SIZE_TYPE__);\n");
-	add_pre_buffer ("extern void * __builtin___mempcpy_chk(void *, const void *, __SIZE_TYPE__, __SIZE_TYPE__);\n");
-	add_pre_buffer ("extern void * __builtin___memset_chk(void *, int, __SIZE_TYPE__, __SIZE_TYPE__);\n");
-	add_pre_buffer ("extern int __builtin___sprintf_chk(char *, int, __SIZE_TYPE__, const char *, ...);\n");
-	add_pre_buffer ("extern int __builtin___snprintf_chk(char *, __SIZE_TYPE__, int , __SIZE_TYPE__, const char *, ...);\n");
-	add_pre_buffer ("extern char * __builtin___stpcpy_chk(char *, const char *, __SIZE_TYPE__);\n");
-	add_pre_buffer ("extern char * __builtin___strcat_chk(char *, const char *, __SIZE_TYPE__);\n");
-	add_pre_buffer ("extern char * __builtin___strcpy_chk(char *, const char *, __SIZE_TYPE__);\n");
-	add_pre_buffer ("extern char * __builtin___strncat_chk(char *, const char *, __SIZE_TYPE__, __SIZE_TYPE__);\n");
-	add_pre_buffer ("extern char * __builtin___strncpy_chk(char *, const char *, __SIZE_TYPE__, __SIZE_TYPE__);\n");
-	add_pre_buffer ("extern int __builtin___vsprintf_chk(char *, int, __SIZE_TYPE__, const char *, __builtin_va_list);\n");
-	add_pre_buffer ("extern int __builtin___vsnprintf_chk(char *, __SIZE_TYPE__, int, __SIZE_TYPE__, const char *, __builtin_va_list ap);\n");
-	add_pre_buffer ("extern void __builtin_unreachable(void);\n");
-
-	/* And some from <stdlib.h> */
-	add_pre_buffer("extern void __builtin_abort(void);\n");
-	add_pre_buffer("extern void *__builtin_calloc(__SIZE_TYPE__, __SIZE_TYPE__);\n");
-	add_pre_buffer("extern void __builtin_exit(int);\n");
-	add_pre_buffer("extern void *__builtin_malloc(__SIZE_TYPE__);\n");
-	add_pre_buffer("extern void *__builtin_realloc(void *, __SIZE_TYPE__);\n");
-	add_pre_buffer("extern void __builtin_free(void *);\n");
-
-	/* And some from <stdio.h> */
-	add_pre_buffer("extern int __builtin_printf(const char *, ...);\n");
-	add_pre_buffer("extern int __builtin_sprintf(char *, const char *, ...);\n");
-	add_pre_buffer("extern int __builtin_snprintf(char *, __SIZE_TYPE__, const char *, ...);\n");
-	add_pre_buffer("extern int __builtin_puts(const char *);\n");
-	add_pre_buffer("extern int __builtin_vprintf(const char *, __builtin_va_list);\n");
-	add_pre_buffer("extern int __builtin_vsprintf(char *, const char *, __builtin_va_list);\n");
-	add_pre_buffer("extern int __builtin_vsnprintf(char *, __SIZE_TYPE__, const char *, __builtin_va_list ap);\n");
 }
 
 void create_builtin_stream(void)
@@ -1338,6 +1190,7 @@ struct symbol_list *sparse_initialize(int argc, char **argv, struct string_list
 		// Initialize type system
 		init_ctype();
 
+		declare_builtins();
 		create_builtin_stream();
 		predefined_macros();
 		if (!preprocess_only)
diff --git a/symbol.h b/symbol.h
index c1ef447ac..0eba37b95 100644
--- a/symbol.h
+++ b/symbol.h
@@ -291,6 +291,7 @@ extern struct symbol *lookup_symbol(struct ident *, enum namespace);
 extern struct symbol *create_symbol(int stream, const char *name, int type, int namespace);
 extern void init_symbols(void);
 extern void init_builtins(int stream);
+extern void declare_builtins(void);
 extern void init_ctype(void);
 extern struct symbol *alloc_symbol(struct position, int type);
 extern void show_type(struct symbol *);
-- 
2.14.0

