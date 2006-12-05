From: Josh Triplett <josh@freedesktop.org>
Subject: [ANNOUNCE] Sparse 0.2 released
Date: Tue, 05 Dec 2006 04:20:38 -0800
Message-ID: <45756416.3020800@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2BACAF26407F1CFAF7E845DD"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:55476 "EHLO
	mail2.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967636AbWLEMUp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 5 Dec 2006 07:20:45 -0500
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.121]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail2.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <linux-sparse@vger.kernel.org>; 5 Dec 2006 12:20:43 -0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2BACAF26407F1CFAF7E845DD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I have tagged and tarballed a 0.2 release of Sparse, now available from
<http://kernel.org/pub/linux/kernel/people/josh/sparse/dist/sparse-0.2.ta=
r.gz>,
with sha1sum `1762fc609fe436e74b87356a52690b5f7bb40c81`.

In addition to plenty of bug fixes, this release includes several notable=
 new
features:

* -Wall, thanks to Pavel Roskin
* `#strong_define` and `#strong_undef`, thanks to Oleg Nesterov
* Argument parsing functions no longer mangle the argv passed to them, th=
anks
  to Christopher Li
* static library and header files now installed, along with a pkg-config =
file
  to find them
* Makefile now supports DESTDIR, useful for packagers

Full changelog:

    Christopher Li (4):
          trivial fix for seg fault.
          Fix warning on self check.
          delay removing file scope
          cleanup write to argument array hack
    =20
    Damien Lespiau (1):
          trivial: more .gitignore stuff
    =20
    Josh Triplett (5):
          Update the FAQ: add sparse website and gitweb, update git URL, =
remove old BK url
          Rename "check.c" to "sparse.c" to match program name; update .g=
itignore
          Install static library and header files
          Generate and install a pkg-config file.  Add DESTDIR support to=
 Makefile.
          Remove old SCCS target from Makefile.
    =20
    Nicolas Kaiser (1):
          double inclusions
    =20
    Oleg Nesterov (7):
          use lookup_macro() in handle_undef()
          kill NS_INVISIBLEMACRO, introduce NS_UNDEF
          fix redefine of #weak_define
          fix 'weak' attribute loss
          prepare for #strong_{define,undef}
          implement #strong_define
          implement #strong_undef
    =20
    Pavel Roskin (1):
          Support -Wall flag

-- Josh Triplett


--------------enig2BACAF26407F1CFAF7E845DD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFdWQWGJuZRtD+evsRAhURAJ9g3+BW2XbVWoqhiBtqvmHRJqRzTACgq5Hk
lDQ6r6czMMTGue/vcAzQxaw=
=YXp7
-----END PGP SIGNATURE-----

--------------enig2BACAF26407F1CFAF7E845DD--
