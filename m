Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9501A8F9A
	for <linux-sparse@vger.kernel.org>; Wed,  4 Dec 2024 18:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733338759; cv=none; b=c0AuBSHD5hEvTyGiUHetNvN3aHLfYHspFOzIUDMY7znKEYDfN3R47AK9xFA7jx5BYjVIPrYJ6FU3H+i1La+XKTpq0pxO8dffRPkDcBFeqU57N3T5hzAvyvrLTgejdC1xLxTdgUMGbI0TpVbYcfShC8F8qsqGxLFQtz8aRYxIS2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733338759; c=relaxed/simple;
	bh=qHwjlkQR3ShY5K4tBiUFaFw+YpTmPQOJPvoRV0HZLBA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=k7M8Ihfj+RvaapOLpYF7jE3wvzcKzt6QeTkGEbgLy5apUTBJ/kdBXbBBw7NJes9f8picQXO2a8JRVcU0uynP0hJxRNnqnlT2jk4KA3qNeVUjyiXPy4q79nuI6smrSG7UGQA6g56BSyk9NKH8xwW5CNhWlfjVdUZ/1+yhAOzJayg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-94-4n0Sm6D0MO2WXn6s9TvfQw-1; Wed, 04 Dec 2024 18:59:14 +0000
X-MC-Unique: 4n0Sm6D0MO2WXn6s9TvfQw-1
X-Mimecast-MFC-AGG-ID: 4n0Sm6D0MO2WXn6s9TvfQw
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 4 Dec
 2024 18:58:36 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 4 Dec 2024 18:58:36 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Linus Torvalds
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
	<rikard.falkeborn@gmail.com>, Martin Uecker
	<Martin.Uecker@med.uni-goettingen.de>
CC: "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"coresight@lists.linaro.org" <coresight@lists.linaro.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 06/10] fortify: replace __is_constexpr() by is_const() in
 strlen()
Thread-Topic: [PATCH 06/10] fortify: replace __is_constexpr() by is_const() in
 strlen()
Thread-Index: AQHbROCtAolgstMk70q+qVJ51CWvhbLWcpEg
Date: Wed, 4 Dec 2024 18:58:35 +0000
Message-ID: <ad4482cc835543578862051431f5174f@AcuMS.aculab.com>
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-6-4e4cbaecc216@wanadoo.fr>
In-Reply-To: <20241203-is_constexpr-refactor-v1-6-4e4cbaecc216@wanadoo.fr>
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
X-Mimecast-MFC-PROC-ID: eTSyOnr4oQCPk-wFgPsZ7NbrwzOMARbBRH169S2orlw_1733338753
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogVmluY2VudCBNYWlsaG9sDQo+IFNlbnQ6IDAyIERlY2VtYmVyIDIwMjQgMTc6MzMNCj4g
DQo+IEZyb206IFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+DQo+
IA0KPiBpc19jb25zdCgpIGlzIGEgb25lIHRvIG9uZSByZXBsYWNlbWVudCBvZiBfX2lzX2NvbnN0
ZXhwcigpLiBEbyB0aGUNCj4gcmVwbGFjZW1lbnQgc28gdGhhdCBfX2lzX2NvbnN0ZXhwcigpIGNh
biBiZSByZW1vdmVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVmluY2VudCBNYWlsaG9sIDxtYWls
aG9sLnZpbmNlbnRAd2FuYWRvby5mcj4NCj4gLS0tDQo+ICBpbmNsdWRlL2xpbnV4L2ZvcnRpZnkt
c3RyaW5nLmggfCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9mb3J0aWZ5LXN0
cmluZy5oIGIvaW5jbHVkZS9saW51eC9mb3J0aWZ5LXN0cmluZy5oDQo+IGluZGV4IDBkOTliZjEx
ZDI2MGEzNDgyYmJlNDZlMzVjNzU1M2MwY2NmYjhiOTQuLmUzZjJmNzcyYzU0MzllZjcxZWI0YTkw
NGI0Y2UyNzk1NmJjNjk3NDMgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvZm9ydGlmeS1z
dHJpbmcuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L2ZvcnRpZnktc3RyaW5nLmgNCj4gQEAgLTI1
NCw4ICsyNTQsOCBAQCBfX0ZPUlRJRllfSU5MSU5FIF9fa2VybmVsX3NpemVfdCBzdHJubGVuKGNv
bnN0IGNoYXIgKiBjb25zdCBQT1MgcCwgX19rZXJuZWxfc2l6ZQ0KPiAgICogUmV0dXJucyBudW1i
ZXIgb2YgY2hhcmFjdGVycyBpbiBAcCAoTk9UIGluY2x1ZGluZyB0aGUgZmluYWwgTlVMKS4NCj4g
ICAqDQo+ICAgKi8NCj4gLSNkZWZpbmUgc3RybGVuKHApCQkJCQkJCVwNCj4gLQlfX2J1aWx0aW5f
Y2hvb3NlX2V4cHIoX19pc19jb25zdGV4cHIoX19idWlsdGluX3N0cmxlbihwKSksCVwNCj4gKyNk
ZWZpbmUgc3RybGVuKHApCQkJCQkJXA0KPiArCV9fYnVpbHRpbl9jaG9vc2VfZXhwcihpc19jb25z
dChfX2J1aWx0aW5fc3RybGVuKHApKSwJXA0KPiAgCQlfX2J1aWx0aW5fc3RybGVuKHApLCBfX2Zv
cnRpZnlfc3RybGVuKHApKQ0KDQpJJ20gc3VyZSBMaW51cyBzdWdnZXN0ZWQgYSB3YXkgb2YgZG9p
bmcgdGhhdCB3aXRob3V0IHJlcGxpY2F0aW5nDQp0aGUgX19idWlsdGluX3N0cmxlbigpLg0KDQpJ
bmRlZWQgaXQgbWF5IGJlIHZhbGlkIHRvIGRvOg0KCWxlbiA9IF9fYnVpbHRpbl9zdHJsZW4ocCk7
DQoJX19idWlsdGluX2NvbnN0YW50X3AobGVuKSA/IGxlbiA6IF9fZm9ydGlmeV9zdHJsZW4ocCk7
DQoNCglEYXZpZA0KDQo+ICBfX0ZPUlRJRllfSU5MSU5FIF9fZGlhZ25vc2VfYXMoX19idWlsdGlu
X3N0cmxlbiwgMSkNCj4gIF9fa2VybmVsX3NpemVfdCBfX2ZvcnRpZnlfc3RybGVuKGNvbnN0IGNo
YXIgKiBjb25zdCBQT1MgcCkNCj4gDQo+IC0tDQo+IDIuNDUuMg0KPiANCj4gDQoNCi0NClJlZ2lz
dGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24g
S2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

