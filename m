Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC0D433B1;
	Sat,  7 Dec 2024 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733584239; cv=none; b=Jnwm6/SUlmJ3bRKcLMRiYctQRKlB+vTa/Y2+5FEBn5IAaha6ea6EWpzSYeFthnb72YFK8G6DTiJRMEW2l64fUIzb3mmjjwcQatN+u5CB9Zy00HOcE//+HDuDpOMdFNv/EMVNpEC6ERY2sg6lF/SgXfMSgHuIsc/nLxNdtKiPn7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733584239; c=relaxed/simple;
	bh=9zSMATOiqkvNthQAcnjGV0PH4lqkQEbU2UaufD3546E=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hkWWjZrs9Mn0rZHisBecfTfDfm0SIaZB11rQpiMWwOUlmRPFbhG4cqOmG7edwcLQRUuy10xroQPCh3G7c9U9fy5xbl0yS/5pvaGL+KKVZQ066ChjIQrZIVFpSga1z5doj0k/2LjUTHiyGGq2tJ8v5iSlQCKpAM2B51SpnDMO2qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gwdg.de; spf=pass smtp.mailfrom=gwdg.de; dkim=pass (2048-bit key) header.d=gwdg.de header.i=@gwdg.de header.b=NxJqX4GH; arc=none smtp.client-ip=134.76.10.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gwdg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gwdg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gwdg.de header.i=@gwdg.de header.b="NxJqX4GH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gwdg.de;
	s=2023-rsa; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:CC:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DjAsF8rGOz50pw9dHufxGpGm6fT/5+Pfxa1ngA4zURE=; b=NxJqX4GHTHAkvVvqWRYSblHpNx
	xRORMBuWj52AYsJt7hsl+bNsLSbMJbQftZCU0GGaC/ggwlUkADRTL4RycoNy8UbRQXowZd8XTuKVH
	A6g5k+b2fpGBmaekFaf47URPQJf9agf48U0FbAFTfwKhYvl21khhPJdAHlyLqGrDIWQenvNXnjmDi
	4DzHK8DSoxEy32pR6/UzxeXJcSQf0Vzjgho5v3bqB8+DU/IHvQ4qUG0xALZPJVKaMmYT5kg/j0wx0
	chjZmLJvxLvtY/Gz1TGkZ8JYqUocH+ZxNnOgZQ69jfYiCxSoRKspMST9B/0ORsfFRfWlsI6yA5Usp
	VmhKOsLQ==;
Received: from xmailer.gwdg.de ([134.76.10.29]:55546)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <muecker@gwdg.de>)
	id 1tJwS1-004NGV-2v;
	Sat, 07 Dec 2024 16:10:33 +0100
Received: from mbx19-fmz-06.um.gwdg.de ([10.108.142.65] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(GWDG Mailer)
	(envelope-from <muecker@gwdg.de>)
	id 1tJwS1-000BiJ-2a;
	Sat, 07 Dec 2024 16:10:33 +0100
Received: from [192.168.0.221] (10.250.9.200) by MBX19-FMZ-06.um.gwdg.de
 (10.108.142.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.14; Sat, 7 Dec
 2024 16:10:32 +0100
Message-ID: <b3bd6d4ef485dbb5db4c784f4e42f76adce502dc.camel@gwdg.de>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of
 __is_constexpr()
From: Martin Uecker <muecker@gwdg.de>
To: Vincent Mailhol <vincent.mailhol@gmail.com>
CC: David Laight <David.Laight@aculab.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, Luc Van Oostenryck
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
	<linux-arm-kernel@lists.infradead.org>
Date: Sat, 7 Dec 2024 16:10:31 +0100
In-Reply-To: <CAMZ6RqL+iS6GVsY20=O6GdQakRpp7XdewZJsUbmE5OCsKaHR6Q@mail.gmail.com>
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
	 <20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr>
	 <1d807c7471b9434aa8807e6e86c964ec@AcuMS.aculab.com>
	 <CAMZ6RqLJLP+4d8f5gLfBdFeDVgqy23O+Eo8HRgKCthqBjSHaaw@mail.gmail.com>
	 <9ef03cebb4dd406885d8fdf79aaef043@AcuMS.aculab.com>
	 <abdd7862f136aa676b2d2c324369f4a43ff9909c.camel@gwdg.de>
	 <CAMZ6RqKzGiRNMeLsQKRNrxvW_bXB-kEi11udQ82kKX6tGCrqcg@mail.gmail.com>
	 <9607300dfca5d71ca9570b1e1de0864e524f356b.camel@gwdg.de>
	 <CAMZ6RqJGqBqvgxzp5yPFY1pk0WkkwEMM34qU-dZ3kXfsnKaqEg@mail.gmail.com>
	 <429e7c6713ecc94494d9107e5f5a1f0c8e854f23.camel@gwdg.de>
	 <CAMZ6RqL+iS6GVsY20=O6GdQakRpp7XdewZJsUbmE5OCsKaHR6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: MBX19-GWD-04.um.gwdg.de (10.108.142.57) To
 MBX19-FMZ-06.um.gwdg.de (10.108.142.65)
X-EndpointSecurity-0xde81-EV: v:7.9.17.458, d:out, a:y, w:t, t:9, sv:1733541190, ts:1733584233
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

Am Samstag, dem 07.12.2024 um 22:50 +0900 schrieb Vincent Mailhol:
> On Sat. 7 Dec. 2024 =C3=A0 22:19, Martin Uecker <muecker@gwdg.de> wrote:
> >=20
...

>=20
> I was invited to WG14 this September. For now, I am only lurking. The
> thing I have in mind right now is to write a paper to allow the use of
> static_assert() in expressions (i.e. make it return 0 on success).
> That should be a relatively small change, but would bring a nice
> quality of life improvement.
>=20
> For context, look at this:
>=20
>   https://lore.kernel.org/all/CAHk-=3DwjLSEcZ5LdW+3C+9rtjvNPHZT6zdk0POj67=
T5k2ZpDbgA@mail.gmail.com/T/#m1ba33a804b4041154b72a1d0333f90ec7204c461

What one can do is put it into a structure.

#define const_assert(x) \
    (sizeof(struct { _Static_assert(x, ""); }))

but yeah, also a hack to work around a limitation of the standard
feature.

Martin
