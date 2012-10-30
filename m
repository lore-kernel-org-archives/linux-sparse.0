From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 6/9] compiler.h, bug.h: Prevent double error messages
 with BUILD_BUG{,_ON}
Date: Tue, 30 Oct 2012 17:19:33 +0100
Message-ID: <20121030161933.GD28499@liondog.tnic>
References: <1351457648-7453-1-git-send-email-daniel.santos@pobox.com>
 <1351457835-7553-6-git-send-email-daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:34702 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753423Ab2J3QTj (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 30 Oct 2012 12:19:39 -0400
Content-Disposition: inline
In-Reply-To: <1351457835-7553-6-git-send-email-daniel.santos@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Daniel Santos <daniel.santos@pobox.com>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, Joe Perches <joe@perches.com>, Josh Triplett <josh@joshtriplett.org>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, David Rientjes <rientjes@google.com>

On Sun, Oct 28, 2012 at 03:57:12PM -0500, danielfsantos@att.net wrote:
> Prior to the introduction of __attribute__((error("msg"))) in gcc 4.3=
,
> creating compile-time errors required a little trickery.
> BUILD_BUG{,_ON} uses this attribute when available to generate
> compile-time errors, but also uses the negative-sized array trick for
> older compilers, resulting in two error messages in some cases.  The
> reason it's "some" cases is that as of gcc 4.4, the negative-sized ar=
ray
> will not create an error in some situations, like inline functions.
>=20
> This patch replaces the negative-sized array code with the new
> __compiletime_error_fallback() macro which expands to the same thing
> unless the the error attribute is available, in which case it expands=
 to
> do{}while(0), resulting in exactly one compile-time error on all
> versions of gcc.
>=20
> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
> ---
>  include/linux/bug.h      |    4 ++--
>  include/linux/compiler.h |    7 +++++++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/bug.h b/include/linux/bug.h
> index 03259d7..da03dc1 100644
> --- a/include/linux/bug.h
> +++ b/include/linux/bug.h
> @@ -57,13 +57,13 @@ struct pt_regs;
>   * track down.
>   */
>  #ifndef __OPTIMIZE__
> -#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(conditio=
n)]))
> +#define BUILD_BUG_ON(condition) __compiletime_error_fallback(conditi=
on)
>  #else
>  #define BUILD_BUG_ON(condition)						\
>  	do {								\
>  		extern void __build_bug_on_failed(void)			\
>  			__compiletime_error("BUILD_BUG_ON failed");	\
> -		((void)sizeof(char[1 - 2*!!(condition)]));		\
> +		__compiletime_error_fallback(condition);		\
>  		if (condition)						\
>  			__build_bug_on_failed();			\

If we're defining a fallback, shouldn't it come second? I.e.:

		if (condition)
			__build_bug_on_failed();
		__compiletime_error_fallback(condition);

Also, the error message from __build_bug_on_failed is much more
informative:

arch/x86/kernel/cpu/amd.c: In function =E2=80=98early_init_amd=E2=80=99=
:
arch/x86/kernel/cpu/amd.c:486:2: error: call to =E2=80=98__build_bug_on=
_failed=E2=80=99 declared with attribute error: BUILD_BUG_ON failed
make[1]: *** [arch/x86/kernel/cpu/amd.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [arch/x86/kernel/cpu/] Error 2

than

arch/x86/kernel/cpu/amd.c: In function =E2=80=98early_init_amd=E2=80=99=
:
arch/x86/kernel/cpu/amd.c:486:2: error: size of unnamed array is negati=
ve
make[1]: *** [arch/x86/kernel/cpu/amd.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [arch/x86/kernel/cpu/] Error 2

=46inally, you need to do:

	bool __cond =3D !!(condition);

and use __cond so that condition doesn't get evaluated multiple times
(possibly with side effects).

Thanks.

--=20
Regards/Gruss,
    Boris.
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
