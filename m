Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B449D1C5486
	for <linux-sparse@vger.kernel.org>; Fri,  6 Dec 2024 19:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733514271; cv=none; b=C8udzEFyx6y7gUiY7bAWaviOsHnCfb0Xq+wg9ow5UIowxcFXADGzd9X6C4+QXtF5s0BCzMKlnKj6Ioh0l5f76UlX0y0C8ydCXyncyXKSOF+eKw7pZEyBq8erVwqB3wCeNdGKqWcp4YpqI6gv4i02VnjNhGFz2o0OlXWcu1zmHUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733514271; c=relaxed/simple;
	bh=CBjR+8wmuRcN1mnDNGDirE0hhPKkyw5iUutIghxZPV0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=ps6tjMRkh+i7XuA7DEYuGDWl4zENuq9wswSzeWR7+4oTQW+1zFj5j04xhdQ3qIOxC1/Iz7lbE1SAJbzjCsaw/a8aOVDR5610bpL5INP/5Gvf+wwks+mAeTxf3iDUkNijcWoR0ghEemjUjkPIzKfjAbRxfIjMsEkkodW+3nAbhfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-117-WxcFF2J0PnutzUqsQ_ZSew-1; Fri, 06 Dec 2024 19:44:26 +0000
X-MC-Unique: WxcFF2J0PnutzUqsQ_ZSew-1
X-Mimecast-MFC-AGG-ID: WxcFF2J0PnutzUqsQ_ZSew
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 6 Dec
 2024 19:43:39 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 6 Dec 2024 19:43:39 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Willy Tarreau' <w@1wt.eu>, Linus Torvalds <torvalds@linux-foundation.org>
CC: Vincent Mailhol <vincent.mailhol@gmail.com>, Luc Van Oostenryck
	<luc.vanoostenryck@gmail.com>, Nathan Chancellor <nathan@kernel.org>, "Nick
 Desaulniers" <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Jani Nikula
	<jani.nikula@linux.intel.com>, Joonas Lahtinen
	<joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Rikard Falkeborn
	<rikard.falkeborn@gmail.com>, "linux-sparse@vger.kernel.org"
	<linux-sparse@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "coresight@lists.linaro.org"
	<coresight@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "uecker@tugraz.at" <uecker@tugraz.at>
Subject: RE: [PATCH 02/10] compiler.h: add is_const() as a replacement of
 __is_constexpr()
Thread-Topic: [PATCH 02/10] compiler.h: add is_const() as a replacement of
 __is_constexpr()
Thread-Index: AQHbROFPJXcuwP9wN0+yRzIQ2cx/pbLWa+gggAFf14CAACMqUIABpzoGgAAClHCAAAo1Y4AAAKpg
Date: Fri, 6 Dec 2024 19:43:39 +0000
Message-ID: <8f4b7d1bfbd84885bddf4cc1dfb9ce43@AcuMS.aculab.com>
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr>
 <1d807c7471b9434aa8807e6e86c964ec@AcuMS.aculab.com>
 <CAMZ6RqLJLP+4d8f5gLfBdFeDVgqy23O+Eo8HRgKCthqBjSHaaw@mail.gmail.com>
 <9ef03cebb4dd406885d8fdf79aaef043@AcuMS.aculab.com>
 <CAHk-=wjmeU6ahyuwAymqkSpxX-gCNa3Qc70UXjgnxNiC8eiyOw@mail.gmail.com>
 <CAMZ6Rq+SzTA25XcMZnMnOJcrrq1VZpeT1xceinarqbXgDDo8VA@mail.gmail.com>
 <CAHk-=wiP8111QZZJNbcDNsYQ_JC-xvwRKr0qV9UdKn3HKK+-4Q@mail.gmail.com>
 <d23fe8a5dbe84bfeb18097fdef7aa4c4@AcuMS.aculab.com>
 <CAHk-=win8afdcergvJ6f2=rRrff8giGUW62qmYs9Ae6aw=wcnA@mail.gmail.com>
 <20241206193836.GA26860@1wt.eu>
In-Reply-To: <20241206193836.GA26860@1wt.eu>
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
X-Mimecast-MFC-PROC-ID: 01jjSvqtGSn4-pp8TdqV3xr83MPFSqA0YVkXyjL9i08_1733514265
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Willy Tarreau
> Sent: 06 December 2024 19:39
> On Fri, Dec 06, 2024 at 11:15:20AM -0800, Linus Torvalds wrote:
> > On Fri, 6 Dec 2024 at 11:07, David Laight <David.Laight@aculab.com> wro=
te:
> > >
> > > I'm missing the compiler version and options to generate the error.
> >
> > Just -Wall with most recent gcc versions seems to do it. At least I
> > can repro it with gcc-14.2.1 and something silly like this:
> >
> >   $ cat t.c
> >   int fn(int a) { return (a<<2)?1:2; }
> >   $ gcc -Wall -S t.c
> >   t.c: In function 'fn':
> >   t.c:1:26: warning: '<<' in boolean context, did you mean '<'?
> > [-Wint-in-bool-context]
> >
> > > Does a '+ 0' help?  "(var << 2) + 0 ? 0 : 0"
> >
> > Yeah, that actually works.
> >
> > And "+0" is nice in that it should work in any context.
>=20
> I've already used "+0" to shut certain warnings, I don't really remember
> which one, but also remember it was OK everywhere I needed.

I've often used +0u when -Wsign-compare is enabled.
Much safer than a cast.

>=20
> Another trick I've been using to shut up the compiler is a cast via typeo=
f
> and an intermediary variable:
>=20
>   #define shut_up(expr)                           \
>           ({                                      \
>                   typeof(expr) _expr_ =3D expr;     \
>                   _expr_;                         \
>                   })

That is like OPTIMISER_HIDE_VAR() and can't be used in a 'constant integer =
expression'.

I suspect it also has the same nasty habit of adding an extra register move=
.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

