From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH RFC 1/4] include/linux/compiler*.h: fix OPTIMIZER_HIDE_VAR
Date: Tue, 8 Jan 2019 09:44:28 -0800
Message-ID: <CAKwvOdk3b6mnpTEEyY-JFrej8K12w9oTMLqi7q5aNiRMyJo6Ow@mail.gmail.com>
References: <20190102205715.14054-1-mst@redhat.com> <20190102205715.14054-2-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190102205715.14054-2-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Jason Wang <jasowang@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <andrea.parri@amarulasolutions.com>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Eli Friedman <efriedma@codeaurora.org>, Joe Perches <joe@perches.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-sparse@vger.kernel.org

Thanks for the patch and sorry for the delay; was totally unplugged
for the holidays.

On Wed, Jan 2, 2019 at 12:57 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Since commit 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h
> mutually exclusive") clang no longer reuses the OPTIMIZER_HIDE_VAR macro
> from compiler-gcc - instead it gets the version in
> include/linux/compiler.h.  Unfortunately that version doesn't actually
> prevent compiler from optimizing out the variable.

Good catch. Did you find this via eyeballing the code, a test, or some
other way?

>
> Fix up by moving the macro out from compiler-gcc.h to compiler.h.
> Compilers without incline asm support will keep working
> since it's protected by an ifdef.
>
> Also fix up comments to match reality since we are no longer overriding
> any macros.
>
> Build-tested with gcc and clang.
>
> Fixes: 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
> Cc: Eli Friedman <efriedma@codeaurora.org>
> Cc: Joe Perches <joe@perches.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Also for more context, see:
commit 7829fb09a2b4 ("lib: make memzero_explicit more robust against
dead store elimination")

> ---
>  include/linux/compiler-clang.h | 5 ++---
>  include/linux/compiler-gcc.h   | 4 ----
>  include/linux/compiler-intel.h | 4 +---
>  include/linux/compiler.h       | 4 +++-
>  4 files changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index 3e7dafb3ea80..7ddaeb5182e3 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -3,9 +3,8 @@
>  #error "Please don't include <linux/compiler-clang.h> directly, include <linux/compiler.h> instead."
>  #endif
>
> -/* Some compiler specific definitions are overwritten here
> - * for Clang compiler
> - */
> +/* Compiler specific definitions for Clang compiler */
> +
>  #define uninitialized_var(x) x = *(&(x))
>
>  /* same as gcc, this was present in clang-2.6 so we can assume it works
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 2010493e1040..72054d9f0eaa 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -58,10 +58,6 @@
>         (typeof(ptr)) (__ptr + (off));                                  \
>  })
>
> -/* Make the optimizer believe the variable can be manipulated arbitrarily. */
> -#define OPTIMIZER_HIDE_VAR(var)                                                \
> -       __asm__ ("" : "=r" (var) : "0" (var))
> -
>  /*
>   * A trick to suppress uninitialized variable warning without generating any
>   * code
> diff --git a/include/linux/compiler-intel.h b/include/linux/compiler-intel.h
> index 517bd14e1222..b17f3cd18334 100644
> --- a/include/linux/compiler-intel.h
> +++ b/include/linux/compiler-intel.h
> @@ -5,9 +5,7 @@
>
>  #ifdef __ECC
>
> -/* Some compiler specific definitions are overwritten here
> - * for Intel ECC compiler
> - */
> +/* Compiler specific definitions for Intel ECC compiler */
>
>  #include <asm/intrinsics.h>
>
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 06396c1cf127..1ad367b4cd8d 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -152,7 +152,9 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  #endif
>
>  #ifndef OPTIMIZER_HIDE_VAR
> -#define OPTIMIZER_HIDE_VAR(var) barrier()
> +/* Make the optimizer believe the variable can be manipulated arbitrarily. */
> +#define OPTIMIZER_HIDE_VAR(var)                                                \
> +       __asm__ ("" : "=r" (var) : "0" (var))
>  #endif

This should be fine, thanks for the cleanup!  For now, we're not yet
confident to turn on Clang's integrated assembler for the kernel, but
I'll make sure to revisit this should we, in case Clang is then able
to optimize this out.
+ Eric, who might know of a better trick for what we're trying to
accomplish with this macro.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

+ Miguel
Miguel, would you mind taking this into your compiler-attributes tree?
-- 
Thanks,
~Nick Desaulniers
