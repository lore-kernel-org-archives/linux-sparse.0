From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2] compiler.h: give up __compiletime_assert_fallback()
Date: Sun, 26 Aug 2018 03:16:29 +0900
Message-ID: <1535220989-27645-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, Daniel Santos <daniel.santos@pobox.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

__compiletime_assert_fallback() is supposed to stop building earlier
by using the negative-array-size method in case the compiler does not
support "error" attribute, but has never worked like that.

You can simply try:

    BUILD_BUG_ON(1);

GCC immediately terminates the build, but Clang does not report
anything because Clang does not support the "error" attribute now.
It will later fail at link time, but __compiletime_assert_fallback()
is not working at least.

The root cause is commit 1d6a0d19c855 ("bug.h: prevent double evaluation
of `condition' in BUILD_BUG_ON").  Prior to that commit, BUILD_BUG_ON()
was checked by the negative-array-size method *and* the link-time trick.
Since that commit, the negative-array-size is not effective because
'__cond' is no longer constant.  As the comment in <linux/build_bug.h>
says, GCC (and Clang as well) only emits the error for obvious cases.

When '__cond' is a variable,

    ((void)sizeof(char[1 - 2 * __cond]))

... is not obvious for the compiler to know the array size is negative.

Reverting that commit would break BUILD_BUG() because negative-size-array
is evaluated before the code is optimized out.

Let's give up __compiletime_assert_fallback().  This commit does not
change the current behavior since it just rips off the useless code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

Changes in v2:
  - Rebase

 include/linux/compiler.h | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 681d866..87c776c 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -314,29 +314,14 @@ static inline void *offset_to_ptr(const int *off)
 #endif
 #ifndef __compiletime_error
 # define __compiletime_error(message)
-/*
- * Sparse complains of variable sized arrays due to the temporary variable in
- * __compiletime_assert. Unfortunately we can't just expand it out to make
- * sparse see a constant array size without breaking compiletime_assert on old
- * versions of GCC (e.g. 4.2.4), so hide the array from sparse altogether.
- */
-# ifndef __CHECKER__
-#  define __compiletime_error_fallback(condition) \
-	do { ((void)sizeof(char[1 - 2 * condition])); } while (0)
-# endif
-#endif
-#ifndef __compiletime_error_fallback
-# define __compiletime_error_fallback(condition) do { } while (0)
 #endif
 
 #ifdef __OPTIMIZE__
 # define __compiletime_assert(condition, msg, prefix, suffix)		\
 	do {								\
-		int __cond = !(condition);				\
 		extern void prefix ## suffix(void) __compiletime_error(msg); \
-		if (__cond)						\
+		if (!(condition))					\
 			prefix ## suffix();				\
-		__compiletime_error_fallback(__cond);			\
 	} while (0)
 #else
 # define __compiletime_assert(condition, msg, prefix, suffix) do { } while (0)
-- 
2.7.4
