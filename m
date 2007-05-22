From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 3/5] Add (more) support for WIN32 attribute names
Date: Tue, 22 May 2007 15:50:57 -0700
Message-ID: <465373D1.9060303@freedesktop.org>
References: <46532FD5.6000307@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0C92E01C6FB1A3A7CA659B0A"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:36736 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756869AbXEVWvj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 May 2007 18:51:39 -0400
In-Reply-To: <46532FD5.6000307@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0C92E01C6FB1A3A7CA659B0A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ramsay Jones wrote:
> In particular, the following identifiers (along with their __X__ varian=
ts)
> are now accepted as attribute names: fastcall, dllimport and dllexport.=

> (cdecl and stdcall were added in baf2c5a84e by Michael Stefaniuc).
> For now, at least, these attributes are just ignored.

Your patch seems to have some whitespace damage in the form of extra lead=
ing
spaces.  I've manually modified it to apply this time, but please figure =
out
what causes these patches to break and fix it.  You may want to test by
sending patches to yourself and trying to apply them.  I notice that you =
use
Thunderbird; format=3Dflowed may cause the problem, so try turning it off=
 by
disabling the preference mailnews.send_plaintext_flowed .  You can do so
either via Edit -> Preferences -> Advanced -> Config Editor; alternativel=
y, if
you have Enigmail installed, it offers a checkbox to turn off format=3Dfl=
owed in
its preferneces.

- Josh Triplett



--------------enig0C92E01C6FB1A3A7CA659B0A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGU3PRGJuZRtD+evsRAvcJAKCIWuWA/LZakE3EqqNtNQ4eBrjR1ACgtlzZ
w61+4k2RCEppxaR69Cz0k9U=
=flOr
-----END PGP SIGNATURE-----

--------------enig0C92E01C6FB1A3A7CA659B0A--
