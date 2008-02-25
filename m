From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: feature-request
Date: Mon, 25 Feb 2008 09:54:09 +0100
Message-ID: <20080225085408.GA9390@artemis.madism.org>
References: <20080223133945.GB10967@artemis.madism.org> <1203907725.25518.17.camel@dv>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="ikeVEW9yuYc//A+q";
	protocol="application/pgp-signature"; micalg=SHA1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from pan.madism.org ([88.191.52.104]:32824 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866AbYBYIyL (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Feb 2008 03:54:11 -0500
Content-Disposition: inline
In-Reply-To: <1203907725.25518.17.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 25, 2008 at 02:48:45AM +0000, Pavel Roskin wrote:
>=20
> On Sat, 2008-02-23 at 14:39 +0100, Pierre Habouzit wrote:
> > While I'm at it, there is this feature I'd like to see in sparse: I'd
> > love to be able to ask it to ignore errors that are located in some
> > specific paths (like /usr/include e.g.). For now I'm doing that through
> > a custom script, but it'd be simpler for me if it does it natively.  The
> > reason is that I don't want to patch third party libraries headers.
>=20
> We probably don't want to ignore _errors_, as they can indicate that the
> parser doesn't understand the code correctly.  Ignoring warnings would
> be a good idea.

  Of course it's what I meant.

> Perhaps a simpler approach would be to turn off warnings in any files
> included using angle brackets.

  Nope, that's not good, because I use angle brackets to #include files
=66rom my projects when I use internally in-tree headers that will in the
end be public.

  I'd rather like to ask to ignore warnings for example, for file under
/usr/include and /usr/lib/gcc/

> gcc doesn't report warnings in system files by default, but it can be
> enabled with -Wsystem-headers.  Since sparse is primarily for the
> kernel, I think the default should be to check the headers (as they are
> part of the kernel), but sparse could support -Wno-system-headers.

  yeah, that'd be really great.

> Alternatively, sparse could have a userspace mode that would disable
> warnings in system headers by default (unless -Wsystem-headers is used).
> The kernel mode could be made stricter for the kernel without affecting
> the userspace.

  I don't really mind this way or the other, really :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHwoIwvGr7W6HudhwRAmy9AJ9p72MXLrmSU598gKPGsRTQKLUwswCghIPk
jGdeptpplaoDVgMzkTBf6Hg=
=dZmA
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
