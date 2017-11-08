From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH 29/36] build: use git-clean
Date: Wed, 8 Nov 2017 13:01:50 +0100
Message-ID: <c9026336-cf8a-d798-7da7-1aea1ff49776@kleine-koenig.org>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-29-luc.vanoostenryck@gmail.com>
 <1510141356.8401.1.camel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="4a0lagUeBsv0aBDLdWIXcioUFS3Nc6QTp"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from antares.kleine-koenig.org ([94.130.110.236]:34802 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752327AbdKHMB4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Nov 2017 07:01:56 -0500
In-Reply-To: <1510141356.8401.1.camel@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4a0lagUeBsv0aBDLdWIXcioUFS3Nc6QTp
Content-Type: multipart/mixed; boundary="jKior6fgM44WRScPlRs7lfqnvt9Jk29gR";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Jeff Layton <jlayton@redhat.com>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 linux-sparse@vger.kernel.org
Message-ID: <c9026336-cf8a-d798-7da7-1aea1ff49776@kleine-koenig.org>
Subject: Re: [PATCH 29/36] build: use git-clean
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-29-luc.vanoostenryck@gmail.com>
 <1510141356.8401.1.camel@redhat.com>
In-Reply-To: <1510141356.8401.1.camel@redhat.com>

--jKior6fgM44WRScPlRs7lfqnvt9Jk29gR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello,

On 11/08/2017 12:42 PM, Jeff Layton wrote:
>>  	@echo '     CLEAN'
>> -	@find validation/ \( -name "*.c.output.expected" \
>> -	                 -o -name "*.c.output.got" \
>> -	                 -o -name "*.c.output.diff" \
>> -	                 -o -name "*.c.error.expected" \
>> -	                 -o -name "*.c.error.got" \
>> -	                 -o -name "*.c.error.diff" \
>> -	                 \) -exec rm {} \;
>> +	@git clean -q -d -x -e .sparse.mk -e '*.[ch]'
>> =20
>>  .PHONY: FORCE
>=20
> This seems wrong. It's certainly possible to build sparse out of a
> tarball that was generated from (e.g.) git-archive. In fact that's
> generally how fedora (and I imagine Debian) build packages.
>=20
> This would break the ability to do "make clean" in that setup.

That was already discussed and Luc dropped this change for that reason
in his v2.

Best regards
Uwe


--jKior6fgM44WRScPlRs7lfqnvt9Jk29gR--

--4a0lagUeBsv0aBDLdWIXcioUFS3Nc6QTp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAloC8i4ACgkQwfwUeK3K
7AlptQf/QzHGZ2Hc3kybOXVZOoXqsZ4e0T4LHusIsxwQWnHHQqc9o+tk1VNorY4Y
zog5zh6Z9spNCJQ7fJbj4h5bBTrTrZ6b48zYegDeiydMLfsertcY9iFOlAfKzLcO
arGnFPMzd/wTmhutYdz4N36YjqD5PdRuiwWJcaZKLZ9gCgaNGGcmvCSJEb+Qbz40
j/PwnndgKpmELP4DrA4GxTTRTNM7FxBWTWcGQzerkrLo1h0jCjE684b6+0HyuOp4
ij3z4whdLleb7Rw0N2rmv8yArL2OCMwA0iGFgf18mYkzBapasC1ELduVAEZfi4ao
QCfaEITfeCt9k5+6Il7eJKyY3opGWw==
=QQ2e
-----END PGP SIGNATURE-----

--4a0lagUeBsv0aBDLdWIXcioUFS3Nc6QTp--
