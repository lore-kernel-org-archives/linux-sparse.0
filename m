From: ndesaulniers@google.com
Subject: [PATCH] compiler.h: update definition of unreachable()
Date: Mon, 15 Oct 2018 10:22:21 -0700
Message-ID: <20181015172221.35709-1-ndesaulniers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: miguel.ojeda.sandonis@gmail.com
Cc: luto@amacapital.net, jpoimboe@redhat.com, natechancellor@gmail.com, Nick Desaulniers <ndesaulniers@google.com>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

Fixes the objtool warning seen with Clang:
arch/x86/mm/fault.o: warning: objtool: no_context()+0x220: unreachable
instruction

Fixes commit 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h
mutually exclusive")

Josh noted that the fallback definition was meant to work around a
pre-gcc-4.6 bug. GCC still needs to work around
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82365, so compiler-gcc.h
defines its own version of unreachable().  Clang and ICC can use this
shared definition.

Link: https://github.com/ClangBuiltLinux/linux/issues/204
Suggested-by: Andy Lutomirski <luto@amacapital.net>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Miguel, would you mind taking this up in your new compiler attributes
tree?

 include/linux/compiler.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 681d866efb1e..8875fd3243fd 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -124,7 +124,10 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 # define ASM_UNREACHABLE
 #endif
 #ifndef unreachable
-# define unreachable() do { annotate_reachable(); do { } while (1); } while (0)
+# define unreachable() do {		\
+	annotate_unreachable();		\
+	__builtin_unreachable();	\
+} while (0)
 #endif
 
 /*
-- 
2.19.0.605.g01d371f741-goog
