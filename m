From: Blue Swirl <blauwirbel@gmail.com>
Subject: [PATCH 2/2] Subject: Add a few GCC builtins
Date: Sat, 1 Aug 2009 12:28:50 +0300
Message-ID: <f43fc5580908010228k6760baa7j506fd674a0510307@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:43934 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbZHAJ3J (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 1 Aug 2009 05:29:09 -0400
Received: by fg-out-1718.google.com with SMTP id e12so210976fga.17
        for <linux-sparse@vger.kernel.org>; Sat, 01 Aug 2009 02:29:10 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Add c{l,t}z{,l,ll}, ffsl{,l}, popcountll and floating point comparison
builtins.

Signed-off-by: Blue Swirl <blauwirbel@gmail.com>
---
 lib.c |   25 ++++++++++++++++++++++---
 1 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/lib.c b/lib.c
index 42affcd..600939b 100644
--- a/lib.c
+++ b/lib.c
@@ -685,15 +685,26 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern char * __builtin_strpbrk(const char *, const
char *);\n");
 	add_pre_buffer("extern __SIZE_TYPE__ __builtin_strlen(const char *);\n");

+	/* And bitwise operations.. */
+	add_pre_buffer("extern int __builtin_clz(int);\n");
+	add_pre_buffer("extern int __builtin_clzl(long);\n");
+	add_pre_buffer("extern int __builtin_clzll(long long);\n");
+	add_pre_buffer("extern int __builtin_ctz(int);\n");
+	add_pre_buffer("extern int __builtin_ctzl(long);\n");
+	add_pre_buffer("extern int __builtin_ctzll(long long);\n");
+	add_pre_buffer("extern int __builtin_ffs(int);\n");
+	add_pre_buffer("extern int __builtin_ffsl(long);\n");
+	add_pre_buffer("extern int __builtin_ffsll(long long);\n");
+	add_pre_buffer("extern int __builtin_popcount(unsigned int);\n");
+	add_pre_buffer("extern int __builtin_popcountl(unsigned long);\n");
+	add_pre_buffer("extern int __builtin_popcountll(unsigned long long);\n");
+
 	/* And some random ones.. */
 	add_pre_buffer("extern void *__builtin_return_address(unsigned int);\n");
 	add_pre_buffer("extern void *__builtin_extract_return_addr(void *);\n");
 	add_pre_buffer("extern void *__builtin_frame_address(unsigned int);\n");
 	add_pre_buffer("extern void __builtin_trap(void);\n");
-	add_pre_buffer("extern int __builtin_ffs(int);\n");
 	add_pre_buffer("extern void *__builtin_alloca(__SIZE_TYPE__);\n");
-	add_pre_buffer("extern int __builtin_popcount(unsigned int);\n");
-	add_pre_buffer("extern int __builtin_popcountl(unsigned long);\n");
 	add_pre_buffer("extern void __builtin_prefetch (const void *, ...);\n");
 	add_pre_buffer("extern long __builtin_alpha_extbl(long, long);\n");
 	add_pre_buffer("extern long __builtin_alpha_extwl(long, long);\n");
@@ -704,6 +715,14 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern long __builtin_alpha_cmpbge(long, long);\n");
 	add_pre_buffer("extern long __builtin_labs(long);\n");

+	/* And some floating point stuff.. */
+	add_pre_buffer("extern int __builtin_isgreater(float, float);\n");
+	add_pre_buffer("extern int __builtin_isgreaterequal(float, float);\n");
+	add_pre_buffer("extern int __builtin_isless(float, float);\n");
+	add_pre_buffer("extern int __builtin_islessequal(float, float);\n");
+	add_pre_buffer("extern int __builtin_islessgreater(float, float);\n");
+	add_pre_buffer("extern int __builtin_isunordered(float, float);\n");
+
 	/* And some __FORTIFY_SOURCE ones.. */
 	add_pre_buffer ("extern __SIZE_TYPE__ __builtin_object_size(void *, int);\n");
 	add_pre_buffer ("extern void * __builtin___memcpy_chk(void *, const
void *, __SIZE_TYPE__, __SIZE_TYPE__);\n");
-- 
1.6.2.4
