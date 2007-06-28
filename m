From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 2/6] Hardcode actual type sizes, add -m32 support
Date: Wed, 27 Jun 2007 23:46:36 -0700
Message-ID: <4683594C.5070202@freedesktop.org>
References: <20070628053954.30704.66440.stgit@dv.roinet.com> <20070628053959.30704.91680.stgit@dv.roinet.com> <20070628055850.GE21478@ftp.linux.org.uk> <46834FA0.8010201@freedesktop.org> <20070628062355.GF21478@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD15B5547E42E6725D7DABE4B"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:50614 "EHLO
	mail3.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759490AbXF1Gqj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Jun 2007 02:46:39 -0400
In-Reply-To: <20070628062355.GF21478@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD15B5547E42E6725D7DABE4B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Al Viro wrote:
> On Wed, Jun 27, 2007 at 11:05:20PM -0700, Josh Triplett wrote:
>> Al Viro wrote:
>>> On Thu, Jun 28, 2007 at 01:39:59AM -0400, Pavel Roskin wrote:
>>>> Use the actual sizeof values at the compile time to describe the def=
ault
>>>> target.  If sparse is compiled on a 64-bit system, it will default t=
o a
>>>> 64-bit system now.
>>>>
>>>> To force 32-bit operation on 64-bit systems, recognize -m32.  Reject=

>>>> machine options other than -m32 and -m64.
>>> NAK.  That makes life very painful for cross-builds.
>> And the current approach of hard-coding all the sizes doesn't?
>>
>> While I agree that I'd like a better approach (specifically, I want an=
y Sparse
>> build to support any target arch), I don't yet have a solution for tha=
t, and
>> this patch does at least seem like an improvement over the current har=
dcoded
>> values.
>=20
> At least it guarantees behaviour that depends only on the arguments you=

> pass to sparse and is consistent between the boxen you run sparse _on_.=

[...]
> Having types based on the host sparse is built on is utter insanity -
> if anything, we need to be very careful about leaking them into
> sparse operations.  Just take a look at what portability nightmare
> binutils had become due to that approach...

Hmmm.  OK, I buy that argument.

> FWIW, one of the pending patches in my tree makes default size_t unsign=
ed
> int, switches it upon -m64 and adds explicit -msize-long for forcing th=
e
> same in absense of -m64 (i.e. for 32bit target that has size_t declared=

> as unsigned long).

Sounds good.

- Josh Triplett


--------------enigD15B5547E42E6725D7DABE4B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGg1lMGJuZRtD+evsRAgG9AJ95Wtv8K0eoUsNpLi2pt5CMVDAGyACghQsN
Y3YP4rqVyQ5nhy0yC0s+t0I=
=xfYr
-----END PGP SIGNATURE-----

--------------enigD15B5547E42E6725D7DABE4B--
