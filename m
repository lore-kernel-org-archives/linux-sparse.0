Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E577F179A7;
	Sat,  7 Dec 2024 21:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733605576; cv=none; b=rL67dJLjIhTr4SGMADit3OcHO+oypkgDF++skM811eEy+GduQIzPRlav5rB7LdgCfFtUnSfJL9J8yNQAB8R9A66xbDv9Uc0qCswm1jqIgoCohAU9xuShqxjb923dpHB6bq03Q1PgOqKk+pcXl+IHcB6tHt3TqivHnT/enP29Hq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733605576; c=relaxed/simple;
	bh=1er9ita0uF+ZxTC/2Qa8K5Vu+hTMyzU3spem1d6AtRw=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XjEa/7GW8mHCQh7KB9I4uf5M+ANuLpU0l1iMNloFvO8RRsA8kyio7+zQqqJtPvniiEPL5tOjqXvOEicLQb0DAEy9kHVMyDwSLNgiOLABVimquhOBzRv24RoYamQ7u8aQHtQpWp8HHKd4ANzXoM9y8ZbiZlaR1d2Zn6TIeOAlWys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gwdg.de; spf=pass smtp.mailfrom=gwdg.de; dkim=pass (2048-bit key) header.d=gwdg.de header.i=@gwdg.de header.b=fda2tSvM; arc=none smtp.client-ip=134.76.10.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gwdg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gwdg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gwdg.de header.i=@gwdg.de header.b="fda2tSvM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gwdg.de;
	s=2023-rsa; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:CC:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1er9ita0uF+ZxTC/2Qa8K5Vu+hTMyzU3spem1d6AtRw=; b=fda2tSvMRD3BwYxUoCwB+YEEPo
	g+VKwjR5vd9U2ZtDlnsITBWsaOKNDt/Q4WX93BbbdZhMPTSrMNV5kOpA3veIHmJH1E8l8U5k5ma8B
	hlkR5bXEfP4X4KusDw+yLASsDFg1et6G3tN/WP6EsgUMYENyZnqN88qWyhn5l+KrEM/a0eENplXp5
	+DnmmEgOaa5dzc9R1VrkDR+MbkDhP5TL5wir/kkNdOLOxy2wjFouXqA9Q+FVzPqvAxP7JMJNEqmUm
	DfhL1RYpA/0+Y0ShTDWyR8h8AKivDfmXpwzmua74AF+S5m+q3S3/QzcS1uxqtY7zGcqmL3aTIauFJ
	iwEiM+CQ==;
Received: from xmailer.gwdg.de ([134.76.10.29]:49876)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <muecker@gwdg.de>)
	id 1tK206-004QAt-21;
	Sat, 07 Dec 2024 22:06:06 +0100
Received: from mbx19-fmz-06.um.gwdg.de ([10.108.142.65] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(GWDG Mailer)
	(envelope-from <muecker@gwdg.de>)
	id 1tK206-000BwM-1c;
	Sat, 07 Dec 2024 22:06:06 +0100
Received: from [192.168.0.221] (10.250.9.200) by MBX19-FMZ-06.um.gwdg.de
 (10.108.142.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.14; Sat, 7 Dec
 2024 22:06:04 +0100
Message-ID: <63f538fceadf4e2ba93cdcaae9fab266e5a000ac.camel@gwdg.de>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of
 __is_constexpr()
From: Martin Uecker <muecker@gwdg.de>
To: David Laight <David.Laight@ACULAB.COM>, Linus Torvalds
	<torvalds@linux-foundation.org>, Vincent Mailhol <vincent.mailhol@gmail.com>
CC: "w@1wt.eu" <w@1wt.eu>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
	<justinstitt@google.com>, Yury Norov <yury.norov@gmail.com>, "Rasmus
 Villemoes" <linux@rasmusvillemoes.dk>, Kees Cook <kees@kernel.org>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, Jani Nikula
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
Date: Sat, 7 Dec 2024 22:06:04 +0100
In-Reply-To: <20362fe79d494bd59471a9c0f002b2ef@AcuMS.aculab.com>
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
	 <0f5c07b827c3468c8fa3928a93a98bfa@AcuMS.aculab.com>
	 <e806dd51b1ac4e289131297fbf30fc37@AcuMS.aculab.com>
	 <CAMZ6RqLOR3aCRW_js2agV+VFiHdazb4S2+NdT5G4=WbDKNB8bA@mail.gmail.com>
	 <b1ff4a65594a4d39b2e9b8b44770214e@AcuMS.aculab.com>
	 <CAMZ6RqJFReLJTd-O8s02oQNeB0SPQh3C-Mg+Nif5vMB9gFtQww@mail.gmail.com>
	 <CAHk-=wjpN4GWtnsWQ8XJvf=gBQ3UvBk512xK1S35=nGXA6yTiw@mail.gmail.com>
	 <6b8c9b942ba6e85a3f1e4eef65a9916333502881.camel@gwdg.de>
	 <20362fe79d494bd59471a9c0f002b2ef@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: MBX19-SUB-07.um.gwdg.de (10.108.142.72) To
 MBX19-FMZ-06.um.gwdg.de (10.108.142.65)
X-EndpointSecurity-0xde81-EV: v:7.9.17.458, d:out, a:y, w:t, t:5, sv:1733591783, ts:1733605566
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

Am Samstag, dem 07.12.2024 um 21:00 +0000 schrieb David Laight:
> From: Martin Uecker
> > Sent: 07 December 2024 19:52
...

>=20
> > There exist proposals along those lines for C2Y.
> >=20
> > From a more near-term solution, I wonder if making it possible (or
> > easier) to return integer constant expressions from statement
> > expressions and allowing a restricted form of statement expressions
> > at file scope would help?
>=20
> It would help a lot if a #define that just used local variables
> to avoid arguments being re-expanded and for CSE could still
> generate a constant value.
> Does need to be a #define - to get token pasting and 'stringify'.
> Although you would need something for reporting detected errors,
> and builtin compiler support for const_true() for the detection
> itself.

We are super close:

https://godbolt.org/z/Tarq89bha

(if we ignore the grotesque hacks to get there, but this would go
away if the compiler does it internally)

Martin

