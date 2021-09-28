Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CB1C433EF
	for <linux-sparse@archiver.kernel.org>; Tue, 28 Sep 2021 20:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FB216044F
	for <linux-sparse@archiver.kernel.org>; Tue, 28 Sep 2021 20:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242595AbhI1UFa (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 28 Sep 2021 16:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242603AbhI1UFa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Sep 2021 16:05:30 -0400
X-Greylist: delayed 448 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Sep 2021 13:03:50 PDT
Received: from algol.kleine-koenig.org (algol.kleine-koenig.org [IPv6:2a01:4f8:c010:8611::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFD9C06161C
        for <linux-sparse@vger.kernel.org>; Tue, 28 Sep 2021 13:03:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by algol.kleine-koenig.org (Postfix) with ESMTP id 3B25CDAFE1;
        Tue, 28 Sep 2021 21:56:18 +0200 (CEST)
Received: from algol.kleine-koenig.org ([IPv6:::1])
        by localhost (algol.kleine-koenig.org [IPv6:::1]) (amavisd-new, port 10024)
        with ESMTP id 0aV1sFUeAkkH; Tue, 28 Sep 2021 21:56:18 +0200 (CEST)
Received: from taurus.defre.kleine-koenig.org (unknown [IPv6:2a02:8071:b5c8:7bfc:f270:5eb7:2fb1:f48a])
        by algol.kleine-koenig.org (Postfix) with ESMTPSA;
        Tue, 28 Sep 2021 21:56:18 +0200 (CEST)
Subject: Re: [ANNOUNCE] Sparse v0.6.4
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
Cc:     Jeff Layton <jlayton@redhat.com>
References: <20210906042111.lhoq7egtpmw3jcv6@mail>
From:   =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Message-ID: <5bfca92e-1eb0-ab7d-80b5-5ea2134ae928@kleine-koenig.org>
Date:   Tue, 28 Sep 2021 21:56:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210906042111.lhoq7egtpmw3jcv6@mail>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VUlTjGirINgDu8FNITwDeGEfP7qNOU8JH"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VUlTjGirINgDu8FNITwDeGEfP7qNOU8JH
Content-Type: multipart/mixed; boundary="iApAXnZO9XL4Sfa3n5jkhtqSjeTi6TeFA";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 linux-sparse@vger.kernel.org
Cc: Jeff Layton <jlayton@redhat.com>
Message-ID: <5bfca92e-1eb0-ab7d-80b5-5ea2134ae928@kleine-koenig.org>
Subject: Re: [ANNOUNCE] Sparse v0.6.4
References: <20210906042111.lhoq7egtpmw3jcv6@mail>
In-Reply-To: <20210906042111.lhoq7egtpmw3jcv6@mail>

--iApAXnZO9XL4Sfa3n5jkhtqSjeTi6TeFA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Luc,

On 9/6/21 6:21 AM, Luc Van Oostenryck wrote:
> Sparse v0.6.4 is now out.

I finally came around to update the Debian packaging. There is just a=20
(non-critical) problem on x32 where some tests fail. I didn't look=20
deeply, but if you care, now you know :-)

https://buildd.debian.org/status/fetch.php?pkg=3Dsparse&arch=3Dx32&ver=3D=
0.6.4-1&stamp=3D1632795062&raw=3D0

Best regards
Uwe


--iApAXnZO9XL4Sfa3n5jkhtqSjeTi6TeFA--

--VUlTjGirINgDu8FNITwDeGEfP7qNOU8JH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFTc1YACgkQwfwUeK3K
7AlwWwgAmGPhTXTfQAx8tXPpnj8xHtdzlUP7+ScQLjO8W3UAbVNqoaaHE0tCC7AO
S3kw6S3jKx+HCea2/wYe7s1xAzwGlpPMC69U4idD1ssQRKt6BpwpsfUSPAvaKTKQ
2yV8MHotcfag7vMNwNUKybwjoLCs0+k2ab2d5EjBGW7P4xrxHqf8UgFcM2WlQAVg
bBJWHvnjqnm24l0Y0xwsMLrInX379lCROQOH8FZh9uFoyEf6mQ2HLBop1XMxaYCn
Xj31kpZXMbSnkw7Rid8vcXE9psLeCpdIxYYM8nWmYFfA6blnVb7LJHXs0Hvdeuio
Oo79Q1iKZ21QjRBv7snk1/xmtYDzoQ==
=NTIB
-----END PGP SIGNATURE-----

--VUlTjGirINgDu8FNITwDeGEfP7qNOU8JH--
