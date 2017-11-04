From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Subject: Re: [SPARSE] Questions for distros
Date: Sat, 4 Nov 2017 18:56:29 +0100
Message-ID: <13e9688b-0643-0a87-a87b-6c72192669b6@kleine-koenig.org>
References: <20171104172528.35tzbeh4k6kp6bbg@ltop.local>
 <1509817409.29302.14.camel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="pIkVB9PBqel5dnQeBMsPU0a3sFhnsOR8O"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from antares.kleine-koenig.org ([94.130.110.236]:59482 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932111AbdKDR4f (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 4 Nov 2017 13:56:35 -0400
In-Reply-To: <1509817409.29302.14.camel@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Jeff Layton <jlayton@redhat.com>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pIkVB9PBqel5dnQeBMsPU0a3sFhnsOR8O
Content-Type: multipart/mixed; boundary="N9AOQJsUA2vluRwm8lMl9n81vW4cCs3gA";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Jeff Layton <jlayton@redhat.com>, linux-sparse@vger.kernel.org
Message-ID: <13e9688b-0643-0a87-a87b-6c72192669b6@kleine-koenig.org>
Subject: Re: [SPARSE] Questions for distros
References: <20171104172528.35tzbeh4k6kp6bbg@ltop.local>
 <1509817409.29302.14.camel@redhat.com>
In-Reply-To: <1509817409.29302.14.camel@redhat.com>

--N9AOQJsUA2vluRwm8lMl9n81vW4cCs3gA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Luc,

On 11/04/2017 06:43 PM, Jeff Layton wrote:
> On Sat, 2017-11-04 at 18:25 +0100, Luc Van Oostenryck wrote:
>> Hi,
>>
>> I'm making some cleanup in my dev tree and there are a few things
>> I'm curious about concerning what distros are doing.
>>
>> I hope you don't mind to answer to those questions.
>>
>> 1) Do the distros use sparse's shared lib?
>>    I remember there was a mail about it months ago but=20
>>    I can't find it anymore.
>>
>=20
> The Fedora and EPEL packages do not. I'm not opposed to adding it, but =
I
> don't really need it and no one has asked for it.
>=20
>> 2) Do the distros use sparse's install rule?
>>
>=20
> Yes. rpmbuild basically does a make install in a chrooted dir, and then=

> installs the files that end up in there.
>=20
>> 3) Do the distros install sparse with its pkconfig?
>=20
> No. Since we aren't packaging the shared lib, we don't bother.
>=20

The answers for Debian are exactly the same. Ubuntu uses the Debian
packages as is.

https://packages.debian.org/sid/sparse (and
https://packages.debian.org/sid/sparse-test-inspect) have "list of
files" links for each architecture which might be quicker to answer
similar questions for you. (But I don't mind your questions.)

Best regards
Uwe


--N9AOQJsUA2vluRwm8lMl9n81vW4cCs3gA--

--pIkVB9PBqel5dnQeBMsPU0a3sFhnsOR8O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAln9/00ACgkQwfwUeK3K
7Alsfwf8D43TZiftW4qxKx7wvdc2v9pQrj7SpBGthe9YLfllbxe9IO2BF5HyrgU7
JWqka5fybfW+wHrh+7BBQ1uz3kzBeA2FId2eLJGocXuIR2XvpEgsGDsg7ylJzA4R
EPgRL7iu7pt0Bczc+F8RdjbDno8LbHjGjpyGaSL7cH0kzv/5PPc5G+x2zE1H5KU7
fnlwwPt/W7tG5sN66C0eA5pNWYfqucdgymq3NYht9q0gHZdv98e1Xb4JiwMSUhvQ
SE2UgrZl7zI5PC2cdyjv7slMODzvoysvX3OJOrJ6n2QNS9XI6WiZ/oH9P7oQCc4A
fUjOyPDjRMdQ80Y7S6zbJAtC8lwnrQ==
=4GlN
-----END PGP SIGNATURE-----

--pIkVB9PBqel5dnQeBMsPU0a3sFhnsOR8O--
