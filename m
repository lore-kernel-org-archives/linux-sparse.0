From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 03/10] compiler-gcc{3,4}.h: Use GCC_VERSION macro
Date: Sun, 7 Oct 2012 01:10:41 +0200
Message-ID: <20121006231041.GB3278@liondog.tnic>
References: <1349465759-20524-1-git-send-email-daniel.santos@pobox.com>
 <1349466169-20637-3-git-send-email-daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:56552 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749Ab2JFXKo (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 6 Oct 2012 19:10:44 -0400
Content-Disposition: inline
In-Reply-To: <1349466169-20637-3-git-send-email-daniel.santos@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: danielfsantos@att.net
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, David Rientjes <rientjes@google.com>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-sparse@vger.kernel.org, Michel Lespinasse <walken@google.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, Daniel Santos <daniel.santos@pobox.com>

On Fri, Oct 05, 2012 at 02:42:42PM -0500, danielfsantos@att.net wrote:
> Using GCC_VERSION reduces complexity, is easier to read and is GCC's
> recommended mechanism for doing version checks. (Just don't ask me wh=
y
> they didn't define it in the first place.)  This also makes it easy t=
o
> merge compiler-gcc{,3,4}.h should somebody want to.
>=20
> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
> Acked-by: David Rientjes <rientjes@google.com>
> ---

[ =E2=80=A6 ]

> diff --git a/include/linux/compiler-gcc4.h b/include/linux/compiler-g=
cc4.h
> index 4506d65..bbfeb13 100644
> --- a/include/linux/compiler-gcc4.h
> +++ b/include/linux/compiler-gcc4.h
> @@ -4,7 +4,7 @@
> =20
>  /* GCC 4.1.[01] miscompiles __weak */
>  #ifdef __KERNEL__
> -# if __GNUC_MINOR__ =3D=3D 1 && __GNUC_PATCHLEVEL__ <=3D 1
> +# if GCC_VERSION >=3D 40100 &&  GCC_VERSION <=3D 40101
>  //#  error Your version of gcc miscompiles the __weak directive

Did I miss something again? This "error" preprocessor function is
commented out here? Why?

--=20
Regards/Gruss,
    Boris.
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
