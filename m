From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] implement constant-folding in __builtin_bswap*()
Date: Thu, 11 Aug 2016 12:39:39 +0200
Message-ID: <1470911979-15068-1-git-send-email-johannes@sipsolutions.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

Since gcc does this, it's apparently valid to write

 switch (x) {
 case __builtin_bswap16(12):
   break;
 }

but sparse will flag it as an error today.

The constant folding used to be done in the kernel's htons() and
friends, but due to gcc bugs that isn't done anymore since
commit 7322dd755e7d ("byteswap: try to avoid __builtin_constant_p
gcc bug").

To get rid of the sparse errors on every such instance now, just
add constant folding to __builtin_bswap*() in sparse.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 lib.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/lib.c b/lib.c
index 8dc5bcf9dc18..7cab95ede318 100644
--- a/lib.c
+++ b/lib.c
@@ -818,9 +818,38 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern int __builtin_popcountll(unsigned long long);\n");
 
 	/* And byte swaps.. */
-	add_pre_buffer("extern unsigned short __builtin_bswap16(unsigned short);\n");
-	add_pre_buffer("extern unsigned int __builtin_bswap32(unsigned int);\n");
-	add_pre_buffer("extern unsigned long long __builtin_bswap64(unsigned long long);\n");
+	add_pre_buffer("extern unsigned short ____builtin_bswap16(unsigned short);\n");
+	add_pre_buffer("extern unsigned int ____builtin_bswap32(unsigned int);\n");
+	add_pre_buffer("extern unsigned long long ____builtin_bswap64(unsigned long long);\n");
+	add_pre_buffer("#define __sparse_constant_swab16(x) ((unsigned short)("
+		       "	(((unsigned short)(x) & (unsigned short)0x00ffU) << 8) |"
+		       "	(((unsigned short)(x) & (unsigned short)0xff00U) >> 8)))\n");
+	add_pre_buffer("#define __sparse_constant_swab32(x) ((unsigned int)("
+		       "	(((unsigned int)(x) & (unsigned int)0x000000ffUL) << 24) |"
+		       "	(((unsigned int)(x) & (unsigned int)0x0000ff00UL) <<  8) |"
+		       "	(((unsigned int)(x) & (unsigned int)0x00ff0000UL) >>  8) |"
+		       "	(((unsigned int)(x) & (unsigned int)0xff000000UL) >> 24)))\n");
+	add_pre_buffer("#define __sparse_constant_swab64(x) ((unsigned long long)("
+		       "	(((unsigned long long)(x) & (unsigned long long)0x00000000000000ffULL) << 56) |"
+		       "	(((unsigned long long)(x) & (unsigned long long)0x000000000000ff00ULL) << 40) |"
+		       "	(((unsigned long long)(x) & (unsigned long long)0x0000000000ff0000ULL) << 24) |"
+		       "	(((unsigned long long)(x) & (unsigned long long)0x00000000ff000000ULL) <<  8) |"
+		       "	(((unsigned long long)(x) & (unsigned long long)0x000000ff00000000ULL) >>  8) |"
+		       "	(((unsigned long long)(x) & (unsigned long long)0x0000ff0000000000ULL) >> 24) |"
+		       "	(((unsigned long long)(x) & (unsigned long long)0x00ff000000000000ULL) >> 40) |"
+		       "	(((unsigned long long)(x) & (unsigned long long)0xff00000000000000ULL) >> 56)))\n");
+	add_pre_buffer("#define __builtin_bswap16(x)"
+		       "	(__builtin_constant_p((unsigned short)(x)) ?"
+		       "	__sparse_constant_swab16(x) :"
+		       "	____builtin_bswap16(x))\n");
+	add_pre_buffer("#define __builtin_bswap32(x)"
+		       "	(__builtin_constant_p((unsigned int)(x)) ?"
+		       "	__sparse_constant_swab32(x) :"
+		       "	____builtin_bswap32(x))\n");
+	add_pre_buffer("#define __builtin_bswap64(x)"
+		       "	(__builtin_constant_p((unsigned long long)(x)) ?"
+		       "	__sparse_constant_swab64(x) :"
+		       "	____builtin_bswap64(x))\n");
 
 	/* And atomic memory access functions.. */
 	add_pre_buffer("extern int __sync_fetch_and_add(void *, ...);\n");
-- 
2.8.1
