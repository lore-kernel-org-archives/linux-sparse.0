Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18E7C433C1
	for <linux-sparse@archiver.kernel.org>; Tue, 23 Mar 2021 10:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F290619BB
	for <linux-sparse@archiver.kernel.org>; Tue, 23 Mar 2021 10:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhCWKEM (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 23 Mar 2021 06:04:12 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:38454 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhCWKEA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 23 Mar 2021 06:04:00 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C58E71C0B81; Tue, 23 Mar 2021 11:03:57 +0100 (CET)
Date:   Tue, 23 Mar 2021 11:03:56 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Tom Tromey <tom@tromey.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH 00/11] pragma once: treewide conversion
Message-ID: <20210323100356.GA20449@amd>
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain>
 <CAHk-=wjFWZMVWTbvUMVxQqGKvGMC_BNrahCtTkpEjxoC0k-T=A@mail.gmail.com>
 <YDvwVlG/fqVxVYlQ@localhost.localdomain>
 <CAHk-=wi54DEScexxpMrO+Q2Nag_Tup+Y5YBHc_9_xGLeRfP8pA@mail.gmail.com>
 <877dmo10m3.fsf@tromey.com>
 <CAHk-=wi13+FLcRo4zmnRUmmY=AAns-Yd5NR_mVdcAd6ZrPq2fA@mail.gmail.com>
 <4835ec1d2ecc40b285596288a0df4f47@AcuMS.aculab.com>
 <CAHk-=wh8PptzH-=ak1D7C5Zp6EJ8eurYqVqGdQauupAFaNuG4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <CAHk-=wh8PptzH-=ak1D7C5Zp6EJ8eurYqVqGdQauupAFaNuG4g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > >  (a) the traditional include guard optimization HAS NO HIDDEN SEMANTIC
> > > MEANING. It's a pure optimization that doesn't actually change
> > > anything else. If you don't do the optimization, absolutely nothing
> > > changes.
> >
> > And if the parser is well written the optimisation is probably
> > irrelevant compared to the compile time.
>=20
> That's actually surprisingly not even remotely true.
>=20
> People always think that the optimization phases of a compiler are the
> expensive ones. And yes, there are certain optimizations that can be
> *really* expensive, and people just don't even do them because they
> are _so_ expensive and are exponential in time.

Well, linux kernel can be compiled in two _seconds_ if you take
compiler optimized for fast parsing... and quick code generation.

See "SUSE Labs Conference 2018 - Compiling the Linux kernel in a
second (give or take)" on youtube.

So yes, gcc's frontend may be slow, but that does not mean job can not
be done quickly by suitable compiler.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmBZvQwACgkQMOfwapXb+vLR0ACfatm3DVUfTM8cgSE0Pni4q3eV
rVUAn1gfH3rymd+a8lNl/5Rdelsy0u78
=qraN
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
