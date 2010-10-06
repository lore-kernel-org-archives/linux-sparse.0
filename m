From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] parser: add Blackfin gcc info
Date: Wed, 6 Oct 2010 10:52:49 -0400
Message-ID: <201010061052.50958.vapier@gentoo.org>
References: <1286267670-20974-1-git-send-email-vapier@gentoo.org> <20101006071018.GB2320@feather> <AANLkTim=hG4BQ2fxy-_LKR1z-NZOqJYffaOJw+0yJvYK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1379503.nFIMnxHk52";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:54817 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932630Ab0JFOyQ (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 6 Oct 2010 10:54:16 -0400
In-Reply-To: <AANLkTim=hG4BQ2fxy-_LKR1z-NZOqJYffaOJw+0yJvYK@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org, michael.hennerich@analog.com

--nextPart1379503.nFIMnxHk52
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday, October 06, 2010 04:40:09 Christopher Li wrote:
> On Wed, Oct 6, 2010 at 12:10 AM, Josh Triplett wrote:
> >> > Can we have some "ifdef" for the blackfin architecture in the pre
> >> > buffer? I agree with Josh, that do look like very much blackfin
> >> > specific. We can leave the ignore attribute alone for now.
> >>=20
> >> how would #ifdefs help ?  i'm not building sparse for a Blackfin arch,
> >> host or target wise.  if there's something more, you'd have to be
> >> specific as to what you mean, otherwise i wont be able to send an
> >> updated patch.
> >=20
> > I suspect that Chris meant that you could add_pre_buffer an #ifdef and
> > #endif surrounding the #define, so that the #define would only take
> > effect if Sparse (or the command-line options passed by cgcc or Linux)
> > defined some appropriate architecture-specific symbol for Blackfin.
>=20
> Thanks for the clarification. The pre buffer is just a build in piece of
> the header file. You can still use #ifdef inside the pre buffer. I just
> don't want those blackfin specific declare show up in every other platform
>=20
> >> yes, these things are completely Blackfin specific, but i dont see how
> >> that's a barrier for entry when both attributes and the builtin ignore
> >> lists contain completely architecture specific stuff without any #ifdef
> >> logic.  using sparse on the Linux kernel for the Blackfin port is
> >> pretty useless atm because of these missing pieces.
>=20
> No, I don't mean that is a deal breaker. That is some thing nice to have.
> Do you know any typical architecture defined symbol to identify the
> blackfin port? Some thing similar to __x86_64__. How does gcc know it is
> compiling for a Blackfin port?

Blackfin's gcc always outputs __bfin__.  i'll send an updated patch once i=
=20
test it out.
=2Dmike

--nextPart1379503.nFIMnxHk52
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJMrI1CAAoJEEFjO5/oN/WB6FIP/i704ccdy4HvQh1rDmEZiLjl
RYy5nObrZyPYAZ2g+7v8w3V3xudYhIbf3MFEGcYbTkpgQyld56sy4gF0Sq7+6PUh
4k3lS89zE/rEB8qrZaEFz0/NzTt0qMIBmNp7IdGbaWq9KSAoQbduXghMveAUj7+U
8ufw+Vqj9b76SQnxWhDzThkvR1WUNB1KHQLzZiKPtxwu6RV6DikLW2R6Ks6VFmRL
cUK0WAN+wG5Y8Cx3RhPG+iUPX289SroJ3pEETAMPST4sO+Hz86SOCeKIXDKLKvCk
VrE6pf4uH21szGKCHG6uEbF0BZqA0iryECJRpLZvg4mH7yyhujT6P2LSIBdl0bO5
d5dYoBfHcOkuWQT+CaKi27447g+KUrZlCky1IPTp4H4yXsGg2eUOySZDgRQImhBI
f3VK2WbkWnAKb+pqdfdcVYUQRmzZyDx0fOwaSXCCWbEbAKhmK2NSPtW2Kof27QbS
FShhTGU3Z+relOjfaHr2qiCH1g+10x+zqvL2CBWoGgvO4SpwsbnKNZZxeJ44L0f8
jjS6cS5fPTdA6NlieDIHIux4vItlGKJlDtZWl3KUjdKh36meLQTa2r5oi4yYpEoM
ZhVJNb9A01uZQSwDXsTLlJ7bPaFk6IdwPdHumczsCKhDdZHYhHiy1Hw/CsCRZ0Ld
55KUHhslfnWr/z1LEhJL
=eD1O
-----END PGP SIGNATURE-----

--nextPart1379503.nFIMnxHk52--
