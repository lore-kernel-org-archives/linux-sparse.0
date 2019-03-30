From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 15/37] compiler.h: update definition of unreachable()
Date: Fri, 29 Mar 2019 21:29:58 -0400
Message-ID: <20190330013020.379-15-sashal@kernel.org>
References: <20190330013020.379-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190330013020.379-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: "ndesaulniers@google.com" <ndesaulniers@google.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Sasha Levin <sashal@kernel.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

From: "ndesaulniers@google.com" <ndesaulniers@google.com>

[ Upstream commit fe0640eb30b7da261ae84d252ed9ed3c7e68dfd8 ]

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
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/compiler.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index a704d032713b..67c3934fb9ed 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -119,7 +119,10 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
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
2.19.1
