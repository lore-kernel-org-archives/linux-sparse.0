From: Christopher Li <sparse@chrisli.org>
Subject: Re: Defect in linearization of short circuit &&
Date: Mon, 15 Feb 2010 11:41:11 -0800
Message-ID: <70318cbf1002151141p35e49f92l73510d09452f56ee@mail.gmail.com>
References: <4B77FD0F.50401@googlemail.com> <4B78655D.2080007@googlemail.com>
	 <70318cbf1002141509u4ebc4ef5x51ec41f5f1452a7a@mail.gmail.com>
	 <4B799CA6.70807@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:64250 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756114Ab0BOTlM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 15 Feb 2010 14:41:12 -0500
Received: by qw-out-2122.google.com with SMTP id 5so562923qwi.37
        for <linux-sparse@vger.kernel.org>; Mon, 15 Feb 2010 11:41:12 -0800 (PST)
In-Reply-To: <4B799CA6.70807@googlemail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-2?Q?Jacek_=A6liwerski?= <sliwers@googlemail.com>
Cc: linux-sparse@vger.kernel.org

2010/2/15 Jacek =C5=9Aliwerski <sliwers@googlemail.com>:
> Christopher Li pisze:
> =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 * If the right side is safe and cheaper than a b=
ranch,
> =C2=A0 =C2=A0 =C2=A0 * just avoid the branch and turn it into a regul=
ar binop
> =C2=A0 =C2=A0 =C2=A0 * style SAFELOGICAL.
> =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0if (rcost < BRANCH_COST) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0expr->type =3D EXPR_B=
INOP;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rcost -=3D BRANCH_COS=
T - 1;
> =C2=A0 =C2=A0 =C2=A0}
>
> After removing these lines, everything works fine.
>
> But I guess that there must have been a reason to add them in the fir=
st
> place. =C2=A0I see it checking the cost of the operation, but I don't=
 know why
> somebody assumes that it would be safe not to make a branch. Does any=
body
> know how to fix it without simply removing these lines?

That is an optimization from Linus. It basically find out the simple va=
riable
case comparing variable and turn it into binary operations and avoiding=
 the
branch. It is cheaper to use "setne" than "cmp; jne; mov;".

It is safe because all the unsafe operations, e.g. dereferencing memory=
,
should have set the cost high enough to avoid this optimization.
e.g. all local variable dereferencing should be safe, because the addre=
ss
is in the stack.

Deferencing a pointer is not, so sparse will not optimize it.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
