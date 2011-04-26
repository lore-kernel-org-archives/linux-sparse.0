From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] fix sparse happy borkage when including gfp.h
Date: Tue, 26 Apr 2011 02:24:01 -0700
Message-ID: <BANLkTi=rCPgGp6E6L1diGczQrnky4CoCtg@mail.gmail.com>
References: <20110415121424.F7A6.A69D9226@jp.fujitsu.com>
	<1302844066.16562.1953.camel@nimitz>
	<20110415143259.F7BD.A69D9226@jp.fujitsu.com>
	<1302877674.16562.3089.camel@nimitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62354 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424Ab1DZJYD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 26 Apr 2011 05:24:03 -0400
Received: by wwa36 with SMTP id 36so463208wwa.1
        for <linux-sparse@vger.kernel.org>; Tue, 26 Apr 2011 02:24:01 -0700 (PDT)
In-Reply-To: <1302877674.16562.3089.camel@nimitz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dave Hansen <dave@linux.vnet.ibm.com>
Cc: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Andrew Morton <akpm@linux-foundation.org>, linux-sparse@vger.kernel.org

On Fri, Apr 15, 2011 at 7:27 AM, Dave Hansen <dave@linux.vnet.ibm.com> =
wrote:
> Those both look sane to me. =A0Those weren't biting me in particular,=
 and
> they don't fix the issue I was seeing. =A0But, they do seem necessary=
 to
> reduce some of the noise.
>
> CC'ing the sparse mailing list. =A0We're seeing a couple of cases whe=
re
> some gcc-isms are either stopping sparse from finding real bugs:
>
> =A0 =A0 =A0 =A0http://marc.info/?l=3Dlinux-mm&m=3D130282454732689&w=3D=
2

I take a look at this problem. The bug can be simplify as the following=
 source:

typedef unsigned __attribute__((bitwise)) gfp_t;

void foo ( gfp_t flags)
{
	int bit =3D (__attribute__((force)) int) (flags &
(((__attribute__((force)) gfp_t)0x01u)|((__attribute__((force))
gfp_t)0x02u)|((__attribute__((force))
gfp_t)0x04u)|((__attribute__((force)) gfp_t)0x08u)));

	if (__builtin_constant_p(bit))
			((void)sizeof(char[1 - 2 * !!((( 1 << (0x01u | 0x02u) | 1 << (0x01u
| 0x04u) | 1 << (0x04u | 0x02u) | 1 << (0x01u | 0x04u | 0x02u) | 1 <<
(0x08u | 0x02u | 0x01u) | 1 << (0x08u | 0x04u | 0x01u) | 1 << (0x08u |
0x04u | 0x02u) | 1 << (0x08u | 0x04u | 0x01u | 0x02u) ) >> bit) &
1)]));
}

Sparse chock on variable length array. It is nothing new. It was
useful to warn about
the variable length array usage in the kernel, because it might
overflow the kernel stack.
In this case, it is just a clever trick to issue assert on compile time=
=2E

We should bite the bullet and just parse the variable length array as
expression. We can still issue
warning for non constant usage, without the early bail out from sparse.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
