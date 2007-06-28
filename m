From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 6/6] Add a simple test script,	embed expected results
 into test files
Date: Thu, 28 Jun 2007 00:20:09 -0700
Message-ID: <46836129.7050407@freedesktop.org>
References: <20070628053954.30704.66440.stgit@dv.roinet.com> <20070628054019.30704.64375.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF800E2418F0649685BD0F6DD"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:33934 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759486AbXF1HUM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Jun 2007 03:20:12 -0400
In-Reply-To: <20070628054019.30704.64375.stgit@dv.roinet.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF800E2418F0649685BD0F6DD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Awesome!  I plan to merge this tomorrow.

I did notice a few issues.  If you get to them before tomorrow then pleas=
e
submit an updated patch, but otherwise I will go ahead and fix them mysel=
f and
apply the patch; I really want to see this go into Sparse as soon as poss=
ible.

* The files starting with "preprocessor" shouldn't run through all of Spa=
rse,
  just the preprocessor (sparse -E).  I've moved them to a
  validation/preprocessor/ subdirectory to keep them separated.

* Ideally, the test suite should support a SPARSE_FLAGS comment, so you c=
an
  specify different -Wfoo options and the corresponding output.  This wou=
ld
  also handle the preprocessor tests.

Pavel Roskin wrote:
> diff --git a/validation/preprocessor1.c b/validation/preprocessor1.c
> index 5ae20aa..5e9f234 100644
> --- a/validation/preprocessor1.c
> +++ b/validation/preprocessor1.c
> @@ -12,3 +12,8 @@
>  #define bar func(
>  #define foo bar foo
>  foo )
> +
> +/* SPARSE
> +builtin:0:0: error: Expected ; at end of declaration
> +builtin:0:0: error: got end-of-input
> +   SPARSE */

Errors in builtin seem strange and probably broken.

> diff --git a/validation/preprocessor10.c b/validation/preprocessor10.c
> index 7fcac36..137bafd 100644
> --- a/validation/preprocessor10.c
> +++ b/validation/preprocessor10.c
> @@ -11,3 +11,8 @@ defined
>  #else
>  undefined
>  #endif
> +
> +/* SPARSE
> +builtin:0:0: error: Expected ; at end of declaration
> +builtin:0:0: error: got end-of-input
> +   SPARSE */

Ditto.

> diff --git a/validation/preprocessor4.c b/validation/preprocessor4.c
> index 8b8c4da..1620a8b 100644
> --- a/validation/preprocessor4.c
> +++ b/validation/preprocessor4.c
> @@ -8,3 +8,8 @@
> =20
>  mac(foo)
> =20
> +
> +/* SPARSE
> +builtin:0:0: error: Expected ; at end of declaration
> +builtin:0:0: error: got end-of-input
> +   SPARSE */

Ditto

> diff --git a/validation/run-tests b/validation/run-tests
> new file mode 100755
> index 0000000..ebe8ffc
> --- /dev/null
> +++ b/validation/run-tests
> @@ -0,0 +1,58 @@
> +#!/bin/sh
> +
> +: ${SPARSE=3D../sparse}
> +: ${SPARSE_FLAGS=3D}
> +
> +# Use "--update" to update test files with the actual output
> +update=3D
> +if test "$1" =3D "--update"; then
> +	update=3D1
> +	shift
> +fi
> +
> +if test -n "$1"; then
> +	tests=3D"$@"
> +else
> +	tests=3D`echo *.c`
> +fi
> +
> +bad=3D
> +for test in $tests; do
> +	base=3D"`basename $test .c`"
> +	exp=3D"$base.exp"
> +	res=3D"$base.res"
> +	diff=3D"$base.diff"
> +	$SPARSE $SPARSE_FLAGS "$test" 2>"$res"
> +	if test "$?" !=3D 0; then
> +		echo "FATAL: $test"
> +		bad=3D"$bad $test"
> +		continue
> +	fi
> +
> +	if test -n "$update"; then
> +		sed -i '/SPARSE/,/SPARSE/d' "$test"
> +		if test -s "$res"; then
> +			echo "/* SPARSE" >>"$test"
> +			cat "$res" >>"$test"
> +			echo "   SPARSE */" >>"$test"
> +		fi
> +	fi

Rather than treating the absence of a SPARSE comment as meaning that the =
test
has no output, I think I'd rather explicitly include an empty SPARSE comm=
ent
in such tests, and then make the absence of a SPARSE comment an error.

> +	sed -n '/SPARSE/,/SPARSE/p' "$test" |grep -v SPARSE >"$exp"
> +	diff -u "$exp" "$res" >"$diff"
> +	if test -s "$diff"; then
> +		echo "FAIL: $test"
> +		bad=3D"$bad $test"
> +		continue
> +	fi
> +
> +	rm -f "$exp" "$res" "$diff"
> +done
> +
> +if test -n "$bad"; then
> +	echo "Failed tests:$bad"
> +	exit 1
> +fi

How about a --verbose that prints the diffs?  I'd prefer that with automa=
ted
build systems, for example, so that I can immediately see the test suite
failure in the logs.  Also, --verbose --update should print the diffs it
applies.

- Josh Triplett


--------------enigF800E2418F0649685BD0F6DD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGg2EqGJuZRtD+evsRAlThAJ9vgTzHLeCwRmoxqRKaQ1vHARWUowCfT7Ag
GwTuctNzvpAwIKHttSjwerw=
=pIm5
-----END PGP SIGNATURE-----

--------------enigF800E2418F0649685BD0F6DD--
