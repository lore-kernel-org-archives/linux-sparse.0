Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ABA3A1CD
	for <linux-sparse@vger.kernel.org>; Sun, 17 Nov 2024 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731864301; cv=none; b=GtOuoJHWCHTiAlCjMvJPzUPH6Xnto+DMihTqEgGCvqmh83FJI7RERZR0p5kHzs+OWgbvzsWNxvuXJp7b4/wQ/sOG7gylsebsQsEbMmM/FoZW+FlFycxEBpEdLrf4GXVBzr1pIfJzkXAKvoNKLek0VFEsM/3h6/cPqutjkYral/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731864301; c=relaxed/simple;
	bh=WXgXmjEkeVkaqXh0v1ISBXOrG2oE+R4HdXb950Jipxk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=iczjK2oWyueDrhp5dNHkr4bLMT/SyVxbhMQxf33Y65IF4Qmm2N+TW2o4YGt+gNe2WNQw44AWtWlHlVbGuX17a6aHCQe5QI1FvBuOOY8ai5sr498phMvz6ssPbmUAgN03wFZtr2yNUQCAjrtVjMPhTGwl8cA52PMl/QJH31+6Jds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-65-aYQSyGLCMVmxdIscXjtVLw-1; Sun, 17 Nov 2024 17:24:55 +0000
X-MC-Unique: aYQSyGLCMVmxdIscXjtVLw-1
X-Mimecast-MFC-AGG-ID: aYQSyGLCMVmxdIscXjtVLw
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 17 Nov
 2024 17:24:54 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 17 Nov 2024 17:24:54 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Vincent Mailhol' <mailhol.vincent@wanadoo.fr>, Linus Torvalds
	<torvalds@linux-foundation.org>, Yury Norov <yury.norov@gmail.com>, "Rasmus
 Villemoes" <linux@rasmusvillemoes.dk>, Luc Van Oostenryck
	<luc.vanoostenryck@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, "Rikard
 Falkeborn" <rikard.falkeborn@gmail.com>
Subject: RE: [PATCH v4 2/2] linux/bits.h: simplify GENMASK_INPUT_CHECK()
Thread-Topic: [PATCH v4 2/2] linux/bits.h: simplify GENMASK_INPUT_CHECK()
Thread-Index: AQHbNfVbqmtUi60kGE6/zbkAvTDGArK7vYpQ
Date: Sun, 17 Nov 2024 17:24:54 +0000
Message-ID: <8bf9eb4434104a3b960d52bd1d38caea@AcuMS.aculab.com>
References: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
 <20241113172939.747686-6-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20241113172939.747686-6-mailhol.vincent@wanadoo.fr>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jXRB0NTiDWmNnuhH7L30gLk9NUo2Bjxv1uSDD4aCXM8_1731864295
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Vincent Mailhol
> Sent: 13 November 2024 17:19
>=20
> In GENMASK_INPUT_CHECK(),
>=20
>   __builtin_choose_expr(__is_constexpr((l) > (h)), (l) > (h), 0)
>=20
> is the exact expansion of:
>=20
>   const_true((l) > (h))
>=20
> Apply const_true() to simplify GENMASK_INPUT_CHECK().

Wouldn't statically_true() give better coverage ?
I wouldn't have though that GENMASK() got used anywhere where a constant
integer expression was needed.

More interesting would be to get it to pass a W=3D1 build for
any place where 'l' is 0u.

=09David

>=20
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
> This change passes the unit tests from CONFIG_BITS_TEST, including the
> extra negative tests provided under #ifdef TEST_GENMASK_FAILURES [1].
>=20
> [1] commit 6d511020e13d ("lib/test_bits.c: add tests of GENMASK")
> Link: https://git.kernel.org/torvalds/c/6d511020e13d
> ---
>  include/linux/bits.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/bits.h b/include/linux/bits.h
> index 60044b608817..61a75d3f294b 100644
> --- a/include/linux/bits.h
> +++ b/include/linux/bits.h
> @@ -20,9 +20,8 @@
>   */
>  #if !defined(__ASSEMBLY__)
>  #include <linux/build_bug.h>
> -#define GENMASK_INPUT_CHECK(h, l) \
> -=09(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> -=09=09__is_constexpr((l) > (h)), (l) > (h), 0)))
> +#include <linux/compiler.h>
> +#define GENMASK_INPUT_CHECK(h, l) BUILD_BUG_ON_ZERO(const_true((l) > (h)=
))
>  #else
>  /*
>   * BUILD_BUG_ON_ZERO is not available in h files included from asm files=
,
> --
> 2.45.2
>=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

