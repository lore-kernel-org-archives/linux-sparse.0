From: Pekka Enberg <penberg@kernel.org>
Subject: Re: sparse-llvm: pseudo_to_value: Assertion `sym->ident == ((void
 *)0)' failed
Date: Mon, 13 Feb 2012 15:34:29 +0200
Message-ID: <CAOJsxLFnSKkfaeTKkoN-RM5iRfunmktwDUwDOtTjKQ-U_65SXg@mail.gmail.com>
References: <1329117459.2534.11.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:44064 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750835Ab2BMNea convert rfc822-to-8bit
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 13 Feb 2012 08:34:30 -0500
Received: by obcva7 with SMTP id va7so6614517obc.19
        for <linux-sparse@vger.kernel.org>; Mon, 13 Feb 2012 05:34:29 -0800 (PST)
In-Reply-To: <1329117459.2534.11.camel@pasglop>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-sparse@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

On Mon, Feb 13, 2012 at 9:17 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Hi folks !
>
> Haven't had a chance to investigate further today (and probably won't=
)
> so I'm shooting this here just in case ;-)
>
> I was tracking down what looks like an LLVM bug with sign extension f=
rom
> 1-bit integers while playing with llvmpipe (gallium llvm backend) and
> out of curiosity decided to look at what sparse generated when
> sign-extending a bool :-)
>
> So I added to my earlier hello.c some statements to that effect, and
> trying to compile it results in:
>
> sparse-llvm.c:311: pseudo_to_value: Assertion `sym->ident =3D=3D ((vo=
id *)0)' failed.
>
> The new hello.c is:
>
> #include <stdio.h>
> #include <stdbool.h>
>
> int main(void)
> {
> =A0 =A0 =A0 =A0int i;
> =A0 =A0 =A0 =A0double f1,f2;
> =A0 =A0 =A0 =A0bool eq;
>
> =A0 =A0 =A0 =A0printf("Hello World !\n");
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < 10; i ++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("I can count to %d\n", i);
>
> =A0 =A0 =A0 =A0printf("f1=3D");
> =A0 =A0 =A0 =A0scanf("%f",&f1);
> =A0 =A0 =A0 =A0printf("f2=3D");
> =A0 =A0 =A0 =A0scanf("%f",&f2);
>
> =A0 =A0 =A0 =A0eq =3D f1 =3D=3D f2;
>
> =A0 =A0 =A0 =A0printf("f1=3D=3Df2: %d\n", (int)eq);
> =A0 =A0 =A0 =A0return 0;
> }

I can reproduce the issue with this minimal test case:

#include <stdio.h>

int main(int argc, char *argv[])
{
	float f;

	scanf("%f", &f);

	return 0;
}

It looks like we need to teach pseudo_to_value() about ident symbols.

                        Pekka
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
