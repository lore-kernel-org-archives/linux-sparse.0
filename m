From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2] add -Wpointer-arith sparse flag to toggle
 sizeof(void) warnings
Date: Sun, 8 Apr 2018 09:48:24 +0200
Message-ID: <20180408074823.fgrmtrjzzjb7dlt2@ltop.local>
References: <20180407215805.ze5rx4v3slbjngmo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180407215805.ze5rx4v3slbjngmo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: linux-sparse@vger.kernel.org, Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, Martin Uecker <Martin.Uecker@med.uni-goettingen.de>, Al Viro <viro@ZenIV.linux.org.uk>, Christopher Li <sparse@chrisli.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Sat, Apr 07, 2018 at 11:58:05AM -1000, Joey Pabalinas wrote:
> Recent changes to the min()/max() macros in include/linux/kernel.h
> have added a lot of noise when compiling the kernel with Sparse checking
> enabled. This mostly is due to the *huge* increase in the number of
> sizeof(void) warnings, a larger number of which can safely be ignored.
> 
> Add the -Wpointer-arith flag to enable/disable these warnings (along
> with the warning when applying sizeof to function types exactly like the
> GCC -Wpointer-arith flag) on demand; the warning itself has been disabled
> by default to reduce the large influx of noise which was inadvertently
> added by commit 3c8ba0d61d04ced9f8 (kernel.h: Retain constant expression
> output for max()/min()).

Thanks. 
It's good to me. I just have a few remarks/suggestions:
 
With the warning disabled by default (for the moment), I had to adapt
the testsuite with:

diff --git a/validation/sizeof-function.c b/validation/sizeof-function.c
index 27d535d4e..8ff67f214 100644
--- a/validation/sizeof-function.c
+++ b/validation/sizeof-function.c
@@ -35,7 +35,7 @@ int test(void)
 
 /*
  * check-name: sizeof-function
- * check-command: sparse -Wno-decl $file
+ * check-command: sparse -Wpointer-arith -Wno-decl $file
  *
  * check-error-start
 sizeof-function.c:22:14: warning: expression using sizeof on a function

> diff --git a/sparse.1 b/sparse.1
> index 88343f3170f195297a..4379406999c94b806e 100644
> --- a/sparse.1
> +++ b/sparse.1
> @@ -288,6 +288,25 @@ Standard C syntax does not permit a parenthesized string as an array
>  initializer.  GCC allows this syntax as an extension.  With
>  \fB\-Wparen\-string\fR, Sparse will warn about this syntax.
>  
> +Sparse does not issue these warnings by default.
> +.
> +.TP
> +.B \-Wpointer-arith
> +Warn about anything that depends on the \fBsizeof\fR a function type or of void.

Maybe it would be useful to add something along the line of "like directly using
the sizeof operator on void or doing pointer arithmetic on a void pointer" ?

> +Although non-standard (and somewhat illogical), constructs such as \fBsizeof(void)\fR
> +are often useful when the intent is to operate on an expression without evaluating
> +it, e.g. in the following integer constant expression predicate:
> +.nf
> +#define __is_constexpr(x) \\
> +	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
> +.fi

I think that pointer arithmetic is much more useful than taking the size of void
(being able to take the size of *any* thing is somewhere in the middle, IMO).
But in all case, I don't think this part should belong to the man page.

Cheers,
-- Luc
