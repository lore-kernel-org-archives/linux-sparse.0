Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BED80C0C
	for <linux-sparse@vger.kernel.org>; Sun, 17 Nov 2024 19:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731872763; cv=none; b=jKfZeHGSy8/P1Y9NhIFhrAwac0wcN411KPwlQ7qzwXX9mTJBWK2spR/UnnDQXGkL6XxtOsZY/xsOEJ0n9HrI/fsVN3X1NIeiwEYQoQ/N++Ujb95Ik4f5s/BPK5PXZyJsbtfMufZU5kggUWPUlliPzYGb14yvi7zk1l4VseppaJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731872763; c=relaxed/simple;
	bh=TRO7U3X0J9wMVAhm4yfPtvutQOYWakyy3QJHpWDppbo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=jWaV3ajR0YBl7ElcrA5QhwRZN3cgMR0t6aMeaZMBUcxXg/Mw5PBG+/McnjcoyUozghI2NQdVWlXdYbaKs376wD2LuD00JXlGUvBQzT+Yq4SErLGPqlwO4kQ/tBzxOvQ0hLfsb7GlHvYbv+gxIZTXPtO+taGPFbAHNpQHTedb2KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-53-_P1VEAMNOva3eicHEWbyxg-1; Sun, 17 Nov 2024 19:45:57 +0000
X-MC-Unique: _P1VEAMNOva3eicHEWbyxg-1
X-Mimecast-MFC-AGG-ID: _P1VEAMNOva3eicHEWbyxg
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 17 Nov
 2024 19:45:56 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 17 Nov 2024 19:45:56 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Vincent Mailhol' <mailhol.vincent@wanadoo.fr>, 'Linus Torvalds'
	<torvalds@linux-foundation.org>, 'Yury Norov' <yury.norov@gmail.com>,
	"'Rasmus Villemoes'" <linux@rasmusvillemoes.dk>, 'Luc Van Oostenryck'
	<luc.vanoostenryck@gmail.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'linux-sparse@vger.kernel.org'" <linux-sparse@vger.kernel.org>, "'Rikard
 Falkeborn'" <rikard.falkeborn@gmail.com>
Subject: RE: [PATCH v4 2/2] linux/bits.h: simplify GENMASK_INPUT_CHECK()
Thread-Topic: [PATCH v4 2/2] linux/bits.h: simplify GENMASK_INPUT_CHECK()
Thread-Index: AQHbNfVbqmtUi60kGE6/zbkAvTDGArK7vYpQgAAm/5A=
Date: Sun, 17 Nov 2024 19:45:56 +0000
Message-ID: <f5692429eb4b43738f562e5fc402ead2@AcuMS.aculab.com>
References: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
 <20241113172939.747686-6-mailhol.vincent@wanadoo.fr>
 <8bf9eb4434104a3b960d52bd1d38caea@AcuMS.aculab.com>
In-Reply-To: <8bf9eb4434104a3b960d52bd1d38caea@AcuMS.aculab.com>
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
X-Mimecast-MFC-PROC-ID: xyNm_-djqd-k7bEdxSN8Yg5fKSkIMvg_v3m9GTF7zNM_1731872756
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: David Laight
> Sent: 17 November 2024 17:25
>=20
> From: Vincent Mailhol
> > Sent: 13 November 2024 17:19
> >
> > In GENMASK_INPUT_CHECK(),
> >
> >   __builtin_choose_expr(__is_constexpr((l) > (h)), (l) > (h), 0)
> >
> > is the exact expansion of:
> >
> >   const_true((l) > (h))
> >
> > Apply const_true() to simplify GENMASK_INPUT_CHECK().
>=20
> Wouldn't statically_true() give better coverage ?
> I wouldn't have though that GENMASK() got used anywhere where a constant
> integer expression was needed.

If it is, maybe add a GENMASK_CONST() that uses BUILD_BUG_ON_ZERO_MSG()
(recently proposed) and so validates that the values are constants.
And then use statically_true() in the normal case to pick up more errors.

(Or just remove the check because coders really aren't that stupid!)

The interesting cases are the ones using variables.
And they'd need run-time checks of some form.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

