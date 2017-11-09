From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH 28/36] build: use a dot file name instead of local.mk:
 .sparse.mk
Date: Thu, 9 Nov 2017 20:06:40 +0100
Message-ID: <120cc3cf-e27c-b5a3-0bb0-f56c2805608e@kleine-koenig.org>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-28-luc.vanoostenryck@gmail.com>
 <57a86c63-05ff-fcfc-41c0-e0a7b1ccc0cf@kleine-koenig.org>
 <20171106154333.a5v6bji5u4gbuhn6@ltop.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="1aTOKrjJAJk0B32nLIgLDFqKoHAdQ1dBT"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from antares.kleine-koenig.org ([94.130.110.236]:38790 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbdKITGv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 14:06:51 -0500
In-Reply-To: <20171106154333.a5v6bji5u4gbuhn6@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1aTOKrjJAJk0B32nLIgLDFqKoHAdQ1dBT
Content-Type: multipart/mixed; boundary="AWeslj24moTRPxVSS5lICI0xhDqrdFb7a";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org
Message-ID: <120cc3cf-e27c-b5a3-0bb0-f56c2805608e@kleine-koenig.org>
Subject: Re: [PATCH 28/36] build: use a dot file name instead of local.mk:
 .sparse.mk
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-28-luc.vanoostenryck@gmail.com>
 <57a86c63-05ff-fcfc-41c0-e0a7b1ccc0cf@kleine-koenig.org>
 <20171106154333.a5v6bji5u4gbuhn6@ltop.local>
In-Reply-To: <20171106154333.a5v6bji5u4gbuhn6@ltop.local>

--AWeslj24moTRPxVSS5lICI0xhDqrdFb7a
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello Luc,

On 11/06/2017 04:43 PM, Luc Van Oostenryck wrote:
> On Mon, Nov 06, 2017 at 09:57:23AM +0100, Uwe Kleine-K=C3=B6nig wrote:
>>> -local.mk
>>> +.sparse.mk
>>
>> what is the motivation to hide this file? IMHO it is better to be awar=
e
>> of eventual changes to the build system and so don't hide the file.
>>
>> Having said that I question if it is a good idea at all to provide a w=
ay
>> to change the build without dirtying the working copy.
>=20
> I confess that this change is just for my own confort.
> I often need to change change the CFLAGS while debugging or profiling.
> I want that to be in a file, the file must of course not be under
> version control and like .bashrc, kernel's .config or GCC's generated
> .*.o.d files, I don't need to see this file and so I prefer it's an=20
> hidden one.
>
> I understand your worries but since it's a file purposely changed
> so that files are compiled differently, there is no surprises.

<sarcasm>
We could also add

	#include ".sparse.c"

at the end of sparse.c (and touch this file in Makefile) in case you
want to add a function there without dirtying the working copy. This
could be used to overwrite weak functions for example.

Oh, and given that order in Makefile sometimes matter, we could add an
sinclude sparse-pre.mk at the start of Makefile.
</sarcasm>

IMHO these suggestions (that I hope you find absurd, too) are only
little worse than your justification above.

If I'd want to change CFLAGS, I'd do that directly in Makefile. git is
powerful enough that this isn't in the way of committing and I
personally like being remembered that I changed something. Of course
this is subjective.

> For dirtying the build ... yes, something could be done but really,
> personnaly, I don't need this, I know when I need to clean my tree

famous words. How often did it happen to you that you thought you'd
remember stuff when you need it and then only managed to do this after a
2 hour long debug session?

Best regards
Uwe


--AWeslj24moTRPxVSS5lICI0xhDqrdFb7a--

--1aTOKrjJAJk0B32nLIgLDFqKoHAdQ1dBT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAloEp0UACgkQwfwUeK3K
7AnqnQf/bJ9UU6VsRQL52gvYuVOoyziieuKsQD5r+7pWMMGqBBJBc9CO152IM6IX
uKydF0ibgz2dDpryN1+PCzmBkN9PM4e8pVNVPxcaZCm5+BsVtvmZmhoASB7Iif5H
CtezPPIy+ihPyOTDRwqSV5uCbHkZyBGYfP6KB3ipfBC7GdkG28G9ZHF7anmuvtoa
FFDRsFUEvMDCM0X1HZ50FwYGTYjxCYUMhvlh0CxYAU++eOTiNXkcWhyMAGLzRNyg
MQ2kxj/Tk/dZ3zfFaVPm/M72inZPqVK3Qy5BAPV7DWyu4eu81ZKmZMqjKXxCSCk+
/C/Eua6qULEP39I3aJAUto2Bplf6HA==
=fRMi
-----END PGP SIGNATURE-----

--1aTOKrjJAJk0B32nLIgLDFqKoHAdQ1dBT--
