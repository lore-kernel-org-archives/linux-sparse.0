From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 09/10] bug.h: Add BUILD_BUG_ON_MSG &
 BUILD_BUG_INTERNAL{,2}
Date: Fri, 5 Oct 2012 22:58:58 +0200
Message-ID: <20121005205858.GB28452@liondog.tnic>
References: <1349465759-20524-1-git-send-email-daniel.santos@pobox.com>
 <1349466169-20637-9-git-send-email-daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:42565 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964786Ab2JEU7D (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 5 Oct 2012 16:59:03 -0400
Content-Disposition: inline
In-Reply-To: <1349466169-20637-9-git-send-email-daniel.santos@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: danielfsantos@att.net
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, David Rientjes <rientjes@google.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, Daniel Santos <daniel.santos@pobox.com>

On Fri, Oct 05, 2012 at 02:42:48PM -0500, danielfsantos@att.net wrote:
> Add BUILD_BUG_ON_MSG which behaves like BUILD_BUG_ON (with optimizati=
ons
> turned enabled), except that it allows you to specify the error messa=
ge
> you want emitted as the third parameter.  Under the hood, this relies=
 on
> BUILD_BUG_INTERNAL{,2}, which does the actual work and is pretty-much
> identical to BUILD_BUG_ON.
>=20
> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
> ---
>  include/linux/bug.h |   26 ++++++++++++++++++++++++++
>  1 files changed, 26 insertions(+), 0 deletions(-)
>=20
> diff --git a/include/linux/bug.h b/include/linux/bug.h
> index 1b43ea2..91bd9d5 100644
> --- a/include/linux/bug.h
> +++ b/include/linux/bug.h
> @@ -16,6 +16,7 @@ struct pt_regs;
>  #define BUILD_BUG_ON_NOT_POWER_OF_2(n)
>  #define BUILD_BUG_ON_ZERO(e) (0)
>  #define BUILD_BUG_ON_NULL(e) ((void*)0)
> +#define BUILD_BUG_ON_MSG(cond, msg) (0)
>  #define BUILD_BUG_ON(condition) (0)
>  #define BUILD_BUG() (0)
>  #else /* __CHECKER__ */
> @@ -38,6 +39,31 @@ struct pt_regs;
>   */
>  #define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e))))
> =20
> +#define _CONCAT1(a, b) a##b
> +#define CONCAT(a, b) _CONCAT1(a, b)

Let's call the indirection _CONCAT without the "1".

> +#define UNIQUIFY(prefix) CONCAT(prefix, __LINE__)
> +
> +#define BUILD_BUG_INTERNAL2(condition, msg, fn)			\
> +	do {							\
> +		extern void fn (void) __compiletime_error(msg);	\
> +		__compiletime_error_fallback(condition);	\
> +		if (condition)					\
> +			fn();					\
> +	} while (0)
> +
> +#define BUILD_BUG_INTERNAL(condition, msg, fn) \
> +	BUILD_BUG_INTERNAL2(condition, msg, fn)

Ditto. BUILD_BUG_INTERNAL2 should be __BUILD_BUG_INTERNAL and the one
calling it _BUILD_BUG_INTERNAL (with one underscore).

> +
> +/**
> + * BUILD_BUG_ON_MSG - break compile if a condition is true & emit su=
pplied
> + * 		      error message.
> + * @condition: the condition which the compiler should know is false=
=2E
> + *
> + * See BUILD_BUG_ON for description.
> + */
> +#define BUILD_BUG_ON_MSG(cond, msg) \
> +	BUILD_BUG_INTERNAL(cond, msg, UNIQUIFY(__build_bug_on_failed_))

Btw, why are we adding the line at all? It is issued by gcc anyway:

cc -Wall    macros.c   -o macros
macros.c: In function =E2=80=98main=E2=80=99:
macros.c:22:1: error: =E2=80=98__build_bug_on_failed_22=E2=80=99 undecl=
ared (first use in this function)
	^^^^

It is in front of the filename here.

macros.c:22:1: note: each undeclared identifier is reported only once f=
or each function it appears in
make: *** [macros] Error 1

Thanks.

--=20
Regards/Gruss,
    Boris.
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
