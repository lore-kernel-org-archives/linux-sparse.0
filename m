Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2268ECA64
	for <linux-sparse@vger.kernel.org>; Sun, 17 Nov 2024 17:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731865444; cv=none; b=DeJpngDJc7HXbWa1UxfeU/FTPA7i9nGYJtS7Xg02jzRTyhdZZRSTTI+YabQuj7UW5ba2jLtPoaaREcaiH5785st8pKNfRYrWVKJHMVbLBnS4yNwtOUCw1Bk4VTmrwj/cEkgHCm6sU+4AWn59bXCP2rxTyJ2R2ATg+nmlOXW4D44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731865444; c=relaxed/simple;
	bh=tl4TXTqkdYOf4gM4Q46JtvbrBcbW6ngLygbVVNgS7AY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=gVNVnW0Wiw30VPrEFCu6X/RBgdXqaDK3YwXP5fji1rgyanct3aq0ZOViWMxoUyDZEHHJyzYlL5R/EpgCGzlgHMHxlLaib3VYfCV94m+v0wBXUYYolgzDu1/bjxlN5tJ50WAe4KJ5yXsKsAyqdWOuF45atF9FUE9OKOoRh2Wlr10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-146-yU9yEEzTNeKHqlfqjEofxQ-1; Sun, 17 Nov 2024 17:42:21 +0000
X-MC-Unique: yU9yEEzTNeKHqlfqjEofxQ-1
X-Mimecast-MFC-AGG-ID: yU9yEEzTNeKHqlfqjEofxQ
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 17 Nov
 2024 17:42:20 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 17 Nov 2024 17:42:20 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Vincent Mailhol' <mailhol.vincent@wanadoo.fr>, Linus Torvalds
	<torvalds@linux-foundation.org>, Yury Norov <yury.norov@gmail.com>, "Rasmus
 Villemoes" <linux@rasmusvillemoes.dk>, Luc Van Oostenryck
	<luc.vanoostenryck@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, "Rikard
 Falkeborn" <rikard.falkeborn@gmail.com>
Subject: RE: [PATCH v4 1/2] compiler.h: add const_true()
Thread-Topic: [PATCH v4 1/2] compiler.h: add const_true()
Thread-Index: AQHbNfHJErTnWAqww06zGCD7FdQ1jLK7v5ZA
Date: Sun, 17 Nov 2024 17:42:20 +0000
Message-ID: <8bf6922f4bb143d1bc699aadd1c84607@AcuMS.aculab.com>
References: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
 <20241113172939.747686-5-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20241113172939.747686-5-mailhol.vincent@wanadoo.fr>
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
X-Mimecast-MFC-PROC-ID: 6g4s8x177n4Z4u-YNkDaS9k1gEO1S_qNKuHFd-WIrNc_1731865341
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Vincent Mailhol
> Sent: 13 November 2024 17:19
>=20
> __builtin_constant_p() is known for not always being able to produce
> constant expression [1] which led to the introduction of
> __is_constexpr() [2]. Because of its dependency on
> __builtin_constant_p(), statically_true() suffers from the same
> issues.

Chalk and cheese.
Personally I don't think any of the text below is really needed.

You might want the final short form - but it is a short form.

OTOH the implementation is horrid.

You probably want to start with this (posted a while back in a minmax patch=
 set:

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 2594553bb30b..35d5b2fa4786 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -242,6 +242,23 @@ static inline void *offset_to_ptr(const int *off)
 /* &a[0] degrades to a pointer: a different type from an array */
 #define __must_be_array(a)     BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0])=
)

+/**
+ * __if_constexpr - Check whether an expression is an 'integer
+ *             constant expression'
+ * @expr: Expression to test, not evaluated, can be a pointer
+ * @if_const: return value if constant
+ * @if_not_const: return value if not constant
+ *
+ * The return values @if_const and @if_not_const can have different types.
+ *
+ * Relies on typeof(x ? NULL : ptr_type) being ptr_type and
+ * typeof(x ? (void *)y : ptr_type) being 'void *'.
+ */
+#define __if_constexpr(expr, if_const, if_not_const)           \
+       _Generic(0 ? ((void *)((long)(expr) * 0l)) : (char *)0, \
+               char *: (if_const),                             \
+               void *: (if_not_const))
+
 /*
  * This returns a constant expression while determining if an argument is
  * a constant expression, most importantly without evaluating the argument=
.
--

Then have:

#define __is_constexpr(x) __if_constexpr(x, 1, 0)

#define const_true(x) __if_constexpr(x, x, 0)

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

