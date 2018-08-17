From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] linux/compiler.h: don't use bool
Date: Fri, 17 Aug 2018 12:10:35 +0200
Message-ID: <20180817101036.20969-1-linux@rasmusvillemoes.dk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

Appararently, it's possible to have a non-trivial TU include a few headers,
including linux/build_bug.h, without ending up with linux/types.h. So
the 0day bot sent me

config: um-x86_64_defconfig (attached as .config)

>> include/linux/compiler.h:316:3: error: unknown type name 'bool'; did you mean '_Bool'?
      bool __cond = !(condition);    \

for something I'm working on.

Rather than contributing to the #include madness and including
linux/types.h from compiler.h, just use int.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 42506e4d1f53..c8eab637a2a7 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -313,7 +313,7 @@ unsigned long read_word_at_a_time(const void *addr)
 #ifdef __OPTIMIZE__
 # define __compiletime_assert(condition, msg, prefix, suffix)		\
 	do {								\
-		bool __cond = !(condition);				\
+		int __cond = !(condition);				\
 		extern void prefix ## suffix(void) __compiletime_error(msg); \
 		if (__cond)						\
 			prefix ## suffix();				\
-- 
2.16.4
