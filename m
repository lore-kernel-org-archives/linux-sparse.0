From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Subject: Re: [GIT PULL] debug build of sparse v4
Date: Thu, 19 Oct 2017 14:42:07 +0200
Message-ID: <8f1174fe-6d7c-e640-d0cf-db7000658570@kleine-koenig.org>
References: <CANeU7QmUzmvhTVpiKmET76qgoZf60yxM3_URAt-auiR12trh4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="G5RrnNAWmLFH5g2QNFXV8cQ7o60JhRSS7"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:36290 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752713AbdJSMmO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 19 Oct 2017 08:42:14 -0400
In-Reply-To: <CANeU7QmUzmvhTVpiKmET76qgoZf60yxM3_URAt-auiR12trh4A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G5RrnNAWmLFH5g2QNFXV8cQ7o60JhRSS7
Content-Type: multipart/mixed; boundary="U2Glc9nt2DajUKA7dsJvjkqIqUPLWkkWo";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Christopher Li <sparse@chrisli.org>,
 Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Jeff Layton <jlayton@redhat.com>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Message-ID: <8f1174fe-6d7c-e640-d0cf-db7000658570@kleine-koenig.org>
Subject: Re: [GIT PULL] debug build of sparse v4
References: <CANeU7QmUzmvhTVpiKmET76qgoZf60yxM3_URAt-auiR12trh4A@mail.gmail.com>
In-Reply-To: <CANeU7QmUzmvhTVpiKmET76qgoZf60yxM3_URAt-auiR12trh4A@mail.gmail.com>

--U2Glc9nt2DajUKA7dsJvjkqIqUPLWkkWo
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello,

On 10/18/2017 11:26 PM, Christopher Li wrote:
> This change allow sparse to build debug version of sparse
> along side of the release version. The debug build of sparse
> can be used by patches like ptrlist ref count to check the nest
> loop modify usage. The debug build can add other verification feature
> that might slow down sparse.

I wonder about the name. From a debug build (in contrast to a release
build) I would expect that it allows to debug sparse itself (Think: add
-g to gcc, or (not) -DNODEBUG for assert(3)), but I understand you use
that term differently here.

Why not do the the extra tests when called as (say)

	sparse --aggressive

=2E Then there is no need for an extra binary at all keeping the build
system simple and that also makes it it easier to understand for users
(but I might judge others by my own standards here?) For gcc this flag
is -Wall, there isn't an extra binary either.

Best regards
Uwe


--U2Glc9nt2DajUKA7dsJvjkqIqUPLWkkWo--

--G5RrnNAWmLFH5g2QNFXV8cQ7o60JhRSS7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlnonZ8ACgkQwfwUeK3K
7AnBAAf7BgBn1LQGgDABT2owwoliYBRzE7vvdpTGjwWzzMiNjkkN/JTf8bxGdrws
gnbAVSQO/JRyC7XjwgXg8sqFV+4F1gErj3W+xpNgxF6B0FL/70bca6CmGzyIZK1W
SvOABnWw4qYScCMqGt/of+lvzUHnvbKuWzgEaNjqVz6wPi/ebGAilFWLfOxJr9SK
0hNm5K8+ejXRiDpj5I2cQKx6fasGpVAkWXwSvOJM9qUrDI987XhZcAA0JctrKmqw
XyHtZQNiIrqoMbpawPNsUVwNkB9TgxiwGObwq+fUqHF47R2UI9bl6Gjiqd+ileRg
XLCym9FRU8w8l59Hgt5HFxlbD0omNw==
=KKWe
-----END PGP SIGNATURE-----

--G5RrnNAWmLFH5g2QNFXV8cQ7o60JhRSS7--
