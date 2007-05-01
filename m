From: Josh Triplett <josh@freedesktop.org>
Subject: Re: 0.3 ?
Date: Tue, 01 May 2007 11:39:41 -0700
Message-ID: <4637896D.6090700@freedesktop.org>
References: <20070417162947.GA15753@redhat.com> <1176863474.3631.58.camel@dv>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig04144877F9B029962D8AAB8E"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:37012 "EHLO
	mail5.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031273AbXEASjo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 May 2007 14:39:44 -0400
In-Reply-To: <1176863474.3631.58.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: Dave Jones <davej@redhat.com>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig04144877F9B029962D8AAB8E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Pavel Roskin wrote:
> On Tue, 2007-04-17 at 12:29 -0400, Dave Jones wrote:
>> Any plans to do another release sometime soon?
>> I'm hitting a segfault with 0.2, that seems to be
>> fixed in the current git tree.
>=20
> Absolutely.  It would be very welcome.
[...]
> I'm using sparse from git a lot, and whenever I have any issues, they
> are in the sources sparse is checking, not in sparse itself.  It looks
> quite stable to me.  It would be great to see sparse 0.3 released soon.=


Your mails made me realize that because Sparse doesn't have a pre-release=
 or
release-candidate process (not yet needed, in my opinion), people don't
necessarily know when I prep for a release and when I just take random
patches.  (Also, most of the most recent patches to Sparse have provided
bugfixes, so it likely still looked like "taking all patches".)  In the
future, I will try to remember to mail the list when I start going into
"process bugfixes and release" mode.

After 0.2, several major chages occurred, such as the impressive new feat=
ures
from Christopher Li; these patches needed some time to stabilize.  In
addition, I noticed some embarrassing self-warnings and an issue with gli=
bc
2.5.

> I actually developed a habit of never loading any kernel code that
> doesn't pass sparse checks on any system I don't want to hang, e.g. if
> it's remote, it lacks a reset button or I'm writing an e-mail on it :)

Nice to hear. :)

- Josh Triplett


--------------enig04144877F9B029962D8AAB8E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGN4ltGJuZRtD+evsRAmL/AJ94f6vmLcl4h/jJwBIdzejEYW3U7gCfR4On
QzM3nMnkju0TpOnp0MmCUrc=
=a7Bh
-----END PGP SIGNATURE-----

--------------enig04144877F9B029962D8AAB8E--
