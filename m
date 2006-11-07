From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] Add a testsuite, call it on "make check"
Date: Mon, 06 Nov 2006 16:46:23 -0800
Message-ID: <454FD75F.7020600@freedesktop.org>
References: <20061106235142.27050.95901.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2FB12FF3EA81FF9ECC11FA95"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:44418 "EHLO
	mail6.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1753802AbWKGAq0 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 6 Nov 2006 19:46:26 -0500
In-Reply-To: <20061106235142.27050.95901.stgit@dv.roinet.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2FB12FF3EA81FF9ECC11FA95
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

You rock.  A few comments:

In the long run, I'd like to check that the expected output matches the a=
ctual
output, rather than just checking for the presence of output; we could do=
 this
by storing expected warning/error output in a file matching the test but =
with
a .err extension.  That won't stop me from committing this test suite
implementation in the meantime, though.

I don't know for sure, since many of the test suite files don't include
documentation, but I believe that some of them (like the preprocessor tes=
ts)
only run as far as sparse -E, and they don't actually compile as C.  Thus=
,
they shouldn't get listed under BAD_EXP_OK.  For these, I'd eventually li=
ke to
check both the preprocessed output and the warning/error output against t=
he
expected values.

Several tests appear miscategorized in this test suite.  For example,
struct-ns2.c includes a comment saying "This is not in scope and should b=
arf
loudly.", and includes code which should indeed cause sparse to barf loud=
ly,
but sparse does not output anything when run on that file, even with -Wal=
l.
Conversely, on initializer-entry-defined-twice.c, sparse actually *should=
*
report a problem here (two problems, in fact), and it does; it just shoul=
dn't
report a problem on the third.  Also, builtin_safe1.c falls in the catego=
ry of
"doesn't currently pass", as it warns in two places it shouldn't, in addi=
tion
to the various places it should; however, this would require checking the=

actual warning/error output.  Figuring out which of these various tests s=
hould
pass and which should fail will require a fair bit of work.

Ideally, I'd love to see the test suite find new tests automatically, rat=
her
than needing to list them explicitly; with a warning/error output file fo=
r
each test, the only difference between an OK_EXP_OK and a BAD_EXP_BAD bec=
omes
"does the .err file have any content", so that just leaves the known fail=
ures,
which we can list explicitly since we don't need to make it easy to add m=
ore.

Pavel Roskin wrote:
> --- /dev/null
> +++ b/validation/testsuite
> @@ -0,0 +1,118 @@
> +#! /bin/sh
> +
> +set -e

At first, this seemed wrong, since sparse should exit with a non-zero exi=
t
code if it emits any errors; however, I then realized that sparse doesn't=

actually *do* this, which seems like a bug.

> +: ${SPARSE=3D../sparse}
> +: ${SPARSE_FLAGS=3D}

I don't think the test suite should allow setting sparse flags, partly si=
nce
changing the flags may well cause a test to pass or fail when it shouldn'=
t,
and partly since at some point different parts of the test suite might ne=
ed
different flags.

> +for t in $BAD_EXP_OK; do
> +	$SPARSE $SPARSE_FLAGS $t 2>test-err
> +	if test -s test-err; then
> +		echo "UNEXPECTED PASS: $t"
> +		unexp=3D1
> +	else
> +		echo "(known) FAIL: $t"
> +	fi
> +done
> +
> +for t in $OK_EXP_BAD; do
> +	$SPARSE $SPARSE_FLAGS $t 2>test-err
> +	if test -s test-err; then
> +		echo "(known) FAIL: $t"
> +	else
> +		echo "UNEXPECTED PASS: $t"
> +		unexp=3D1
> +	fi
> +done

At first I balked a bit at the idea of having the test suite succeed whil=
e
some tests don't actually pass, but more I thought about it, I started to=

agree that it seems like the right approach.  It means that we can ensure=
 that
the test suite passes in every single Git revision of sparse.  Once all t=
he
tests run as expected, we can dump this part of the test suite code.

- Josh Triplett


--------------enig2FB12FF3EA81FF9ECC11FA95
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFT9dfGJuZRtD+evsRAmPNAKCUYmfQiR3tphgeE4UKCI/9WGvCTwCeNaVp
NdTLcawg6GJSDylmaORfYQY=
=trgD
-----END PGP SIGNATURE-----

--------------enig2FB12FF3EA81FF9ECC11FA95--
