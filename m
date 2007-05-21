From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] Beautify all & install Makefile targets
Date: Sun, 20 May 2007 17:35:16 -0700
Message-ID: <4650E944.1060506@freedesktop.org>
References: <11796983862564-git-send-email-damien.lespiau@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC8F22DA68C6A6654BECB0D54"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:58803 "EHLO
	mail2.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758370AbXEUAfa (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 20 May 2007 20:35:30 -0400
In-Reply-To: <11796983862564-git-send-email-damien.lespiau@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Damien Lespiau <damien.lespiau@gmail.com>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC8F22DA68C6A6654BECB0D54
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Damien Lespiau wrote:
> Beautify make's output like kbuild or git. The install
> target is especially much more readable.
> make V=3D1 (install) to get back to the old behaviour.

The Makefile currently doesn't require anything particularly special from=

make, and in theory should work with any reasonable make, not just GNU ma=
ke.
I hestitate to change that for purely aesthetic purposes.  The % rules se=
em
easy enough to replace with a suffix rule .c.o.  You can use substitution=
 to
check V, like this:

josh@josh-mobile:/tmp$ cat Makefile=20
V=3D@
Q=3D$(V:1=3D)
QUIET_SOMETHING=3D$(Q:@=3D@echo SOMETHING;)
#...

test:
        @echo V=3D$(V)
        @echo Q=3D$(Q)
        @echo QUIET_SOMETHING=3D$(QUIET_SOMETHING)
josh@josh-mobile:/tmp$ make
V=3D@
Q=3D@
QUIET_SOMETHING=3D@echo SOMETHING
josh@josh-mobile:/tmp$ make V=3D1
V=3D1
Q=3D
QUIET_SOMETHING=3D

You can write more rules of the form QUIET_SOMETHING=3D$(Q:@=3Dvalue if q=
uiet)

I'd also like to hear from other people on whether or not they prefer thi=
s
style of output.  It doesn't matter much to me either way.

> +	QUIET_LD       =3D @echo    '   ' LD'      '$@;

This always seems misleading to me, given that the corresponding rules ru=
n CC,
not LD.

> +	QUIET_INST_SH  =3D echo -n  '   ' INSTALL '';
> +	QUIET_INST     =3D @echo -n '   ' INSTALL '';

This doesn't appear to output the installed file; it took a minute to fig=
ure
out that install -v provides the output.  Could you add a comment about t=
hat?
Also, why not write these strings as (for example):

echo -n '    INSTALL '

? That seems cleaner than breaking the lines up into quoted whitespace an=
d
unquoted text.

> +%.o: %.c
> +	$(QUIET_CC)$(CC) -o $*.o -c $(CFLAGS) $<

I think you can use $@ here rather than $*.o .  Also, as mentioned above,=
 this
should become a suffix rule.

- Josh Triplett


--------------enigC8F22DA68C6A6654BECB0D54
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGUOlEGJuZRtD+evsRAga3AKCEYdfEMyi/6HE5qPbGOCpNTwzm/QCgmpgU
/o0Qmh/mJ0sTcMAZrJelIlo=
=K7NP
-----END PGP SIGNATURE-----

--------------enigC8F22DA68C6A6654BECB0D54--
