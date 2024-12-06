Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6E0198A06
	for <linux-sparse@vger.kernel.org>; Fri,  6 Dec 2024 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733512030; cv=none; b=rLpJb7i5F/3kTaSq/I1nKTg9ka2feymuO7GkzKkMfCFxT7+vD4WYg7Z6iuovlP7LpVbjRhuPeBAjCP0Ld/1oRVPmhT6TERx/NWKcAIAIwgNhJ02kOEvfVxsA93Z/iORITT+hTarqFs8N3ulsGASLBkzXYoEurcIunFzM4p5B7NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733512030; c=relaxed/simple;
	bh=ggbwORZnlwc8YN3DJB21zCsxZm15lFShrMeQG41rm18=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=FMx0D8/VCszKihK4uBYvgSkah4ZMfU11sR7DTxzr5uEdYb9R5qzn1kCIyKmGaxDJAjbIkGAsDUWeVeL5veZkmIrWh1dGKGJS3MFYY+ylCSo+5zYgv6+B33x5y0x/Rr2GsNTRLbPhU7g0cptQF5lHIxqDtve3ZIp1PN5AkCepuFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-203-g62EFoMcPseEjHbllHyR1Q-1; Fri, 06 Dec 2024 19:07:06 +0000
X-MC-Unique: g62EFoMcPseEjHbllHyR1Q-1
X-Mimecast-MFC-AGG-ID: g62EFoMcPseEjHbllHyR1Q
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 6 Dec
 2024 19:06:18 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 6 Dec 2024 19:06:18 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, Vincent Mailhol
	<vincent.mailhol@gmail.com>
CC: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, "Bill
 Wendling" <morbo@google.com>, Justin Stitt <justinstitt@google.com>, "Yury
 Norov" <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
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
Thread-Index: AQHbROFPJXcuwP9wN0+yRzIQ2cx/pbLWa+gggAFf14CAACMqUIABpzoGgAAClHA=
Date: Fri, 6 Dec 2024 19:06:18 +0000
Message-ID: <d23fe8a5dbe84bfeb18097fdef7aa4c4@AcuMS.aculab.com>
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr>
 <1d807c7471b9434aa8807e6e86c964ec@AcuMS.aculab.com>
 <CAMZ6RqLJLP+4d8f5gLfBdFeDVgqy23O+Eo8HRgKCthqBjSHaaw@mail.gmail.com>
 <9ef03cebb4dd406885d8fdf79aaef043@AcuMS.aculab.com>
 <CAHk-=wjmeU6ahyuwAymqkSpxX-gCNa3Qc70UXjgnxNiC8eiyOw@mail.gmail.com>
 <CAMZ6Rq+SzTA25XcMZnMnOJcrrq1VZpeT1xceinarqbXgDDo8VA@mail.gmail.com>
 <CAHk-=wiP8111QZZJNbcDNsYQ_JC-xvwRKr0qV9UdKn3HKK+-4Q@mail.gmail.com>
In-Reply-To: <CAHk-=wiP8111QZZJNbcDNsYQ_JC-xvwRKr0qV9UdKn3HKK+-4Q@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: FHJ184G_YXpZKMcsn6Jv7Hnb6VCsvzk8dpXBz6ALzTc_1733512024
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDYgRGVjZW1iZXIgMjAyNCAxODo1Mw0KPiAN
Cj4gT24gRnJpLCA2IERlYyAyMDI0IGF0IDEwOjMxLCBWaW5jZW50IE1haWxob2wgPHZpbmNlbnQu
bWFpbGhvbEBnbWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPiBjYXVzZXMgaXNzdWVzIHdoZW4g
J3gnIGlzIG5vdCBhbiBpbnRlZ2VyIGV4cHJlc3Npb24gKHRoaW5rDQo+ID4gPiAiaXNfY29uc3Qo
TlVMTCkiIG9yICJpc19jb25zdCgxID09IDIpIi4NCj4gPg0KPiA+IEJ1dCAxID09IDIgYWxyZWFk
eSBoYXMgYW4gaW50ZWdlciB0eXBlIGFzIHByb3ZlbiBieToNCj4gDQo+IFllYWgsIEkgd2FzIGNv
bmZ1c2VkIGFib3V0IGV4YWN0bHkgd2hhdCB0cmlnZ2VycyB0aGF0IG9kZA0KPiAnLVdpbnQtaW4t
Ym9vbC1jb250ZXh0Jy4NCj4gDQo+IEl0J3Mgbm90IGFib3V0IHNvbWUgYWN0dWFsIGJvb2wgdHlw
ZSwgaXQncyBsaXRlcmFsbHkgYSByYW5kb20NCj4gY29sbGVjdGlvbiBvZiBpbnRlZ2VyIG9wZXJh
dGlvbnMgdXNlZCB3aXRoIGxvZ2ljYWwgb3BzLg0KPiANCj4gU28gaXQncyB0aGluZ3MgbGlrZSAi
ISh2YXI8PDIpIiB0aGF0IGdlbmVyYXRlIHRoYXQgd2FybmluZywgYmVjYXVzZQ0KPiBzb21lIGNv
bXBpbGVyIHBlcnNvbiBhdCBzb21lIHBvaW50IHdlbnQgIm1heWJlIHRoYXQgbGVmdCBzaGlmdCBz
aG91bGQNCj4gaGF2ZSBiZWVuIGp1c3QgYSBjb21wYXJpc29uIGluc3RlYWQgJzwnIi4NCj4gDQo+
IEJ1dCBpdCB0dXJucyBvdXQgdGhhdCAiKHZhciA8PDIpPzA6MCIgX2Fsc29fIHRyaWdnZXJzIHRo
YXQgd2FybmluZy4NCj4gDQo+IEVuZCByZXN1bHQ6IEkgaGF2ZSAqbm8qIGlkZWEgaG93IHRvIHNo
dXQgdGhhdCBjcmF6eSB3YXJuaW5nIHVwIGZvcg0KPiB0aGlzIGNhc2UsIGlmIHdlIHdhbnQgdG8g
aGF2ZSBzb21lIGdlbmVyaWMgbWFjcm8gdGhhdCBzYXlzICJpcyB0aGlzDQo+IGNvbnN0YW50Ii4g
QmVjYXVzZSBpdCBkYW1uIHdlbGwgaXMgcGVyZmVjdGx5IHNhbmUgdG8gYXNrICJpcyAoYSA8PCAz
KQ0KPiBhIGNvbnN0YW50IGV4cHJlc3Npb24iLg0KDQpJJ20gbWlzc2luZyB0aGUgY29tcGlsZXIg
dmVyc2lvbiBhbmQgb3B0aW9ucyB0byBnZW5lcmF0ZSB0aGUgZXJyb3IuDQpEb2VzIGEgJysgMCcg
aGVscD8gICIodmFyIDw8IDIpICsgMCA/IDAgOiAwIg0KDQpJIHJlYWxpc2VkIHRoZToNCiNkZWZp
bmUgY29uc3RfTlVMTCh4KSBfR2VuZXJpYygwID8gKHgpIDogKGNoYXIgKikwLCBjaGFyICo6IDEs
IHZvaWQgKjogMCkNCiNkZWZpbmUgY29uc3RfdHJ1ZSh4KSBjb25zdF9OVUxMKCh4KSA/IE5VTEwg
OiAodm9pZCAqKTFMKSkNCiNkZWZpbmUgY29uc3RfZXhwcih4KSBjb25zdF9OVUxMKCh4KSA/IE5V
TEwgOiBOVUxMKSkNCkkgc2VuZCB0aGlzIG1vcm5pbmcuDQpOZWVkcyAncy9jaGFyL3N0cnVjdCBr
amtqa2pranVpLycgYXBwbGllZC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBM
YWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBU
LCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

