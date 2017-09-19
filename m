From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH] build: only generate version.h when needed and remove it
 in clean target
Date: Tue, 19 Sep 2017 16:50:00 +0200
Message-ID: <8d555c9d-6eb0-85a2-5f78-999aaf0b12e7@kleine-koenig.org>
References: <20170914184540.26650-1-uwe@kleine-koenig.org>
 <CANeU7QnQ-fFvvUfqjCjXfUT5Dn-+vEY-u0KxnNPML3G3iuNBZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="r2ikxPjIXpmvSGEguUpS1VDt5CX2knoaR"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:51337 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751165AbdISOuJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 19 Sep 2017 10:50:09 -0400
In-Reply-To: <CANeU7QnQ-fFvvUfqjCjXfUT5Dn-+vEY-u0KxnNPML3G3iuNBZw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r2ikxPjIXpmvSGEguUpS1VDt5CX2knoaR
Content-Type: multipart/mixed; boundary="g1Ktx3tAlQ32Ov9iTbeXhODu2XXrAM2eW";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>
Message-ID: <8d555c9d-6eb0-85a2-5f78-999aaf0b12e7@kleine-koenig.org>
Subject: Re: [PATCH] build: only generate version.h when needed and remove it
 in clean target
References: <20170914184540.26650-1-uwe@kleine-koenig.org>
 <CANeU7QnQ-fFvvUfqjCjXfUT5Dn-+vEY-u0KxnNPML3G3iuNBZw@mail.gmail.com>
In-Reply-To: <CANeU7QnQ-fFvvUfqjCjXfUT5Dn-+vEY-u0KxnNPML3G3iuNBZw@mail.gmail.com>

--g1Ktx3tAlQ32Ov9iTbeXhODu2XXrAM2eW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09/15/2017 06:52 PM, Christopher Li wrote:
> On Thu, Sep 14, 2017 at 2:45 PM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koen=
ig.org> wrote:
>>
>> -# Generating file version.h if current version has changed
>>  SPARSE_VERSION:=3D$(shell git describe 2>/dev/null || echo '$(VERSION=
)')
>> -VERSION_H :=3D $(shell cat version.h 2>/dev/null)
>> -ifneq ($(lastword $(VERSION_H)),"$(SPARSE_VERSION)")
>> -$(info $(shell echo '     GEN      'version.h))
>> -$(shell echo '#define SPARSE_VERSION "$(SPARSE_VERSION)"' > version.h=
)
>> -endif
>=20
> You don't need to move them to into a rule section.
>=20
> You can use "ifneq ($(MAKECMDGOALS),clean)"

So it still triggers when doing

	make clean all

Also you don't want to generate it for $(make check).

IMHO that's hardly manageable to get done consistently this way and the
easiest is a separate rule for version.h that is triggered by make
dependencies as I suggested

> to wrap it. GNU make document even show that as examples
> of using $(MAKECMDGOALS).

IMHO that is no prove that the idea is sane.

>> +version.h: FORCE
>> +       $(QUIET_GEN)echo '#define SPARSE_VERSION "$(SPARSE_VERSION)"' =
> version.h.tmp; \
>> +       if cmp -s version.h version.h.tmp; then \
>> +               rm version.h.tmp; \
>> +       else \
>> +               mv version.h.tmp version.h; \
>> +       fi
>> +
>> +.PHONY: FORCE
>> +
>> +lib.o: version.h
>> +
>=20
> The above section is not needed if you use the ifneq test on $(MAKECMDG=
OALS).> I also test it and found the problem that, the version.h was forc=
e
> to obsolete. Two consequent make will always show "GEN version.h"
> line.

Then maybe split it into

	CHECK version.h
	GEN   version.h

? The GEN would be skipped if version.h doesn't need an update.

Best regards
Uwe


--g1Ktx3tAlQ32Ov9iTbeXhODu2XXrAM2eW--

--r2ikxPjIXpmvSGEguUpS1VDt5CX2knoaR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlnBLpgACgkQwfwUeK3K
7Ak5vwf/ee+G9MIceNmNIBAm7Bba/UsIjAaGtZ/T+uYMYDlCVPzu6x/DFkA6Xdsq
kqALKDwlCS7EyIaPvrSzcNR3q3P0Tj3+BGyJOVWU39YOQ4mOO3MpmYZbOzNJp1lH
LrGAX+tdiqAhcTm+duwT7x1oAjjdsBVBLKM7QRBZDsr75YdK37zu4NuEhUYO9I1G
P8onHgggUKE/8PE1CjeQd5jQWVhB2hIgGk7WJ1YeAFdmM8r8plQeFR7kLy70PMjI
KMsFNKg/00+NDK1eKru8v/sQv+MF7Ww3C22k6Ha5UtjKOcMOevvwZ1xGZK67MeQR
6xCkXddy1M1RzW8iLksXKBzSh0H9DQ==
=rBvY
-----END PGP SIGNATURE-----

--r2ikxPjIXpmvSGEguUpS1VDt5CX2knoaR--
