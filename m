From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] Add more declarations for more builtin functions
Date: Wed, 22 Mar 2017 11:47:41 +0100
Message-ID: <20170322104741.82695-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32887 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758855AbdCVK4C (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Mar 2017 06:56:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11so8581902wma.0
        for <linux-sparse@vger.kernel.org>; Wed, 22 Mar 2017 03:56:01 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Those are used by GCC testsuite.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/lib.c b/lib.c
index 272d2c88a..fa9838ad2 100644
--- a/lib.c
+++ b/lib.c
@@ -841,23 +841,45 @@ static void predefined_macros(void)
 void declare_builtin_functions(void)
 {
 	/* Gaah. gcc knows tons of builtin <string.h> functions */
+	add_pre_buffer("extern void *__builtin_memchr(const void *, int, __SIZE_TYPE__);\n");
 	add_pre_buffer("extern void *__builtin_memcpy(void *, const void *, __SIZE_TYPE__);\n");
 	add_pre_buffer("extern void *__builtin_mempcpy(void *, const void *, __SIZE_TYPE__);\n");
+	add_pre_buffer("extern void *__builtin_memmove(void *, const void *, __SIZE_TYPE__);\n");
 	add_pre_buffer("extern void *__builtin_memset(void *, int, __SIZE_TYPE__);\n");
 	add_pre_buffer("extern int __builtin_memcmp(const void *, const void *, __SIZE_TYPE__);\n");
 	add_pre_buffer("extern char *__builtin_strcat(char *, const char *);\n");
 	add_pre_buffer("extern char *__builtin_strncat(char *, const char *, __SIZE_TYPE__);\n");
 	add_pre_buffer("extern int __builtin_strcmp(const char *, const char *);\n");
+	add_pre_buffer("extern int __builtin_strncmp(const char *, const char *, __SIZE_TYPE__);\n");
+	add_pre_buffer("extern int __builtin_strcasecmp(const char *, const char *);\n");
+	add_pre_buffer("extern int __builtin_strncasecmp(const char *, const char *, __SIZE_TYPE__);\n");
 	add_pre_buffer("extern char *__builtin_strchr(const char *, int);\n");
+	add_pre_buffer("extern char *__builtin_strrchr(const char *, int);\n");
 	add_pre_buffer("extern char *__builtin_strcpy(char *, const char *);\n");
 	add_pre_buffer("extern char *__builtin_strncpy(char *, const char *, __SIZE_TYPE__);\n");
+	add_pre_buffer("extern char *__builtin_strdup(const char *);\n");
+	add_pre_buffer("extern char *__builtin_strndup(const char *, __SIZE_TYPE__);\n");
 	add_pre_buffer("extern __SIZE_TYPE__ __builtin_strspn(const char *, const char *);\n");
 	add_pre_buffer("extern __SIZE_TYPE__ __builtin_strcspn(const char *, const char *);\n");
 	add_pre_buffer("extern char * __builtin_strpbrk(const char *, const char *);\n");
 	add_pre_buffer("extern char* __builtin_stpcpy(const char *, const char*);\n");
+	add_pre_buffer("extern char* __builtin_stpncpy(const char *, const char*, __SIZE_TYPE__);\n");
 	add_pre_buffer("extern __SIZE_TYPE__ __builtin_strlen(const char *);\n");
+	add_pre_buffer("extern char *__builtin_strstr(const char *, const char *);\n");
+	add_pre_buffer("extern char *__builtin_strcasestr(const char *, const char *);\n");
+	add_pre_buffer("extern char *__builtin_strnstr(const char *, const char *, __SIZE_TYPE__);\n");
+
+	/* And even some from <strings.h> */
+	add_pre_buffer("extern int  __builtin_bcmp(const void *, const void *, __SIZE_TYPE_);\n");
+	add_pre_buffer("extern void __builtin_bcopy(const void *, void *, __SIZE_TYPE__);\n");
+	add_pre_buffer("extern void __builtin_bzero(void *, __SIZE_TYPE__);\n");
+	add_pre_buffer("extern char*__builtin_index(const char *, int);\n");
+	add_pre_buffer("extern char*__builtin_rindex(const char *, int);\n");
 
 	/* And bitwise operations.. */
+	add_pre_buffer("extern int __builtin_clrsb(int);\n");
+	add_pre_buffer("extern int __builtin_clrsbl(long);\n");
+	add_pre_buffer("extern int __builtin_clrsbll(long long);\n");
 	add_pre_buffer("extern int __builtin_clz(int);\n");
 	add_pre_buffer("extern int __builtin_clzl(long);\n");
 	add_pre_buffer("extern int __builtin_clzll(long long);\n");
@@ -867,6 +889,9 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern int __builtin_ffs(int);\n");
 	add_pre_buffer("extern int __builtin_ffsl(long);\n");
 	add_pre_buffer("extern int __builtin_ffsll(long long);\n");
+	add_pre_buffer("extern int __builtin_parity(unsigned int);\n");
+	add_pre_buffer("extern int __builtin_parityl(unsigned long);\n");
+	add_pre_buffer("extern int __builtin_parityll(unsigned long long);\n");
 	add_pre_buffer("extern int __builtin_popcount(unsigned int);\n");
 	add_pre_buffer("extern int __builtin_popcountl(unsigned long);\n");
 	add_pre_buffer("extern int __builtin_popcountll(unsigned long long);\n");
@@ -909,7 +934,9 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern long __builtin_alpha_insql(long, long);\n");
 	add_pre_buffer("extern long __builtin_alpha_inslh(long, long);\n");
 	add_pre_buffer("extern long __builtin_alpha_cmpbge(long, long);\n");
+	add_pre_buffer("extern int  __builtin_abs(int);\n");
 	add_pre_buffer("extern long __builtin_labs(long);\n");
+	add_pre_buffer("extern long long __builtin_llabs(long long);\n");
 	add_pre_buffer("extern double __builtin_fabs(double);\n");
 	add_pre_buffer("extern __SIZE_TYPE__ __builtin_va_arg_pack_len(void);\n");
 
@@ -957,6 +984,23 @@ void declare_builtin_functions(void)
 	add_pre_buffer ("extern int __builtin___vsprintf_chk(char *, int, __SIZE_TYPE__, const char *, __builtin_va_list);\n");
 	add_pre_buffer ("extern int __builtin___vsnprintf_chk(char *, __SIZE_TYPE__, int, __SIZE_TYPE__, const char *, __builtin_va_list ap);\n");
 	add_pre_buffer ("extern void __builtin_unreachable(void);\n");
+
+	/* And some from <stdlib.h> */
+	add_pre_buffer("extern void __builtin_abort(void);\n");
+	add_pre_buffer("extern void *__builtin_calloc(__SIZE_TYPE__, __SIZE_TYPE__);\n");
+	add_pre_buffer("extern void __builtin_exit(int);\n");
+	add_pre_buffer("extern void *__builtin_malloc(__SIZE_TYPE__);\n");
+	add_pre_buffer("extern void *__builtin_realloc(void *, __SIZE_TYPE__);\n");
+	add_pre_buffer("extern void __builtin_free(void *);\n");
+
+	/* And some from <stdio.h> */
+	add_pre_buffer("extern int __builtin_printf(const char *, ...);\n");
+	add_pre_buffer("extern int __builtin_sprintf(char *, const char *, ...);\n");
+	add_pre_buffer("extern int __builtin_snprintf(char *, __SIZE_TYPE__, const char *, ...);\n");
+	add_pre_buffer("extern int __builtin_puts(const char *);\n");
+	add_pre_buffer("extern int __builtin_vprintf(const char *, __builtin_va_list);\n");
+	add_pre_buffer("extern int __builtin_vsprintf(char *, const char *, __builtin_va_list);\n");
+	add_pre_buffer("extern int __builtin_vsnprintf(char *, __SIZE_TYPE__, const char *, __builtin_va_list ap);\n");
 }
 
 void create_builtin_stream(void)
-- 
2.12.0

