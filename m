From: Pavel Roskin <proski@gnu.org>
Subject: Re: =?utf-8?b?77u/d2FybmluZzo=?= cast adds address space to
	expression
Date: Sat, 12 Jul 2008 11:17:03 -0400
Message-ID: <20080712111703.gjlzw6ns0k88844w-cebfxv@webmail.spamcop.net>
References: <1215853026.19076.32.camel@jaswinder.satnam>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:28131 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753115AbYGLPRE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 12 Jul 2008 11:17:04 -0400
In-Reply-To: <1215853026.19076.32.camel@jaswinder.satnam>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jaswinder Singh <jaswinder@infradead.org>
Cc: linux-sparse@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, davej@redhat.com

Quoting Jaswinder Singh <jaswinder@infradead.org>:

> Hello all,
>
> I am trying to solve sparse warnings in kernel.
>
> =EF=BB=BFPlease let me know how can I solve following sparse warning =
:-
>
> =EF=BB=BFwarning: cast adds address space to expression
>
> Is this a warning or a Info.

It's a warning.  The code must be doing something like this:

void *addr1;
void __iomem *addr2;

addr2 =3D (void __iomem *) addr1;

> If any sparse documentation is available, please let me know.

I don't think you need sparse documentation to resolve it.  Sparse =20
only detected a bad cast, but fixing it requires deeper understanding =20
of the code, not of the warning.

You should look at the expression and see if the value before cast =20
needs the attribute, or the value after the cast doesn't need the =20
attribute.

The meanings of attributes in Linux are:

__user - pointer to data that came from the userspace
__iomem - pointer to a device I/O area (ports or I/O memory)

There are functions that deal with such pointers.  The code you are =20
dealing with may be trying to circumvent those functions.

=46urther questions are better asked in Linux specific lists with more =
=20
details of the code.  Please note that you should understand the code =20
to fix it.  Just fixing the warning without understanding the problem =20
is defeating the whole purpose of sparse.

--=20
Regards,
Pavel Roskin
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
