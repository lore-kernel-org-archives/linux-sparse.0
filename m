Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE98618DF86
	for <linux-sparse@vger.kernel.org>; Fri,  6 Dec 2024 03:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733456448; cv=none; b=bprvDEG01s5pM+/FASJVBo43rGRjQ7+4QrHYQnWK2LREyZan90jBF3TKjkG48Tdw91Xq/ZGFic7kE9ieY2L4BJUxMHa6iK5h0cLSgZbfsHDm/czIrKHkbkiqDrA6ynyzxloxgvTnSxV5QnQH3jpm8O3sxLiUrBLhFDDP8ABEip8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733456448; c=relaxed/simple;
	bh=EDdmm0DHzlfUIVjgSjHafTsxqy+4Kuy7LBa8PuA68Ug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=dZAN4MhFmN8G4uHhAuuBbnvDDApVriVobvbNfh3O+/1d0Z7CqRgBqBrsJJAftaMQqZvfVtXTba3E/F02xV9rqrDrWl9IdzaEeFOabOIa9Z198cdqndlcdaoSeV3XEatit/4qZQxro3G6P57xYlGuE69lbYM7FfMGqjfx5D8H+kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-280-C8E4fnSMOAGX_JjFtXp91A-1; Fri, 06 Dec 2024 03:40:43 +0000
X-MC-Unique: C8E4fnSMOAGX_JjFtXp91A-1
X-Mimecast-MFC-AGG-ID: C8E4fnSMOAGX_JjFtXp91A
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 6 Dec
 2024 03:39:59 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 6 Dec 2024 03:39:59 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Vincent Mailhol' <mailhol.vincent@wanadoo.fr>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck
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
	<Martin.Uecker@med.uni-goettingen.de>, "linux-sparse@vger.kernel.org"
	<linux-sparse@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "coresight@lists.linaro.org"
	<coresight@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 01/10] compiler.h: add statically_false()
Thread-Topic: [PATCH 01/10] compiler.h: add statically_false()
Thread-Index: AQHbROCIk5mOE+KmUE+HEr8z57N8IbLWaz+wgAFe2gCAALnCYA==
Date: Fri, 6 Dec 2024 03:39:59 +0000
Message-ID: <b48e2f5dd8d64cbab471629ae03c7511@AcuMS.aculab.com>
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-1-4e4cbaecc216@wanadoo.fr>
 <e115a4245e5342a994a7e596cc6357fa@AcuMS.aculab.com>
 <CAMZ6Rq+n0vG9zObF-kY-Xo+iP_Y3P8A6_nEfB8F=UhqeQBepRw@mail.gmail.com>
In-Reply-To: <CAMZ6Rq+n0vG9zObF-kY-Xo+iP_Y3P8A6_nEfB8F=UhqeQBepRw@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: Rf6Y7P9F0YZgZwMhIiHgpg2n9tHcMgToeSBehNjkXrI_1733456442
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogVmluY2VudCBNYWlsaG9sDQo+IFNlbnQ6IDA1IERlY2VtYmVyIDIwMjQgMTU6MjYNCj4g
DQo+IE9uIFRodS4gNSBEZWMgMjAyNCBhdCAwMzozMCwgRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWln
aHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4gRnJvbTogVmluY2VudCBNYWlsaG9sDQo+ID4gPiBT
ZW50OiAwMiBEZWNlbWJlciAyMDI0IDE3OjMzDQo+ID4gPg0KPiA+ID4gRnJvbTogVmluY2VudCBN
YWlsaG9sIDxtYWlsaG9sLnZpbmNlbnRAd2FuYWRvby5mcj4NCj4gPiA+DQo+ID4gPiBGb3IgY29t
cGxldGlvbiwgYWRkIHN0YXRpY2FsbHlfZmFsc2UoKSB3aGljaCBpcyB0aGUgZXF1aXZhbGVudCBv
Zg0KPiA+ID4gc3RhdGljYWxseV90cnVlKCkgZXhjZXB0IHRoYXQgaXQgd2lsbCByZXR1cm4gdHJ1
ZSBvbmx5IGlmIHRoZSBpbnB1dCBpcw0KPiA+ID4ga25vd24gdG8gYmUgZmFsc2UgYXQgY29tcGls
ZSB0aW1lLg0KPiA+DQo+ID4gVGhpcyBpcyBwcmV0dHkgbXVjaCBwb2ludGxlc3MuDQo+ID4gSXQg
aXMganVzdCBhcyBlYXN5IHRvIGludmVydCB0aGUgY29uZGl0aW9uIGF0IHRoZSBjYWxsIHNpdGUu
DQo+IA0KPiBUbyBzdGFydCB3aXRoLCBJIHdpbGwgYXJndWUgdGhhdDoNCj4gDQo+ICAgc3RhdGlj
YWxseV9mYWxzZShmb28pDQo+IA0KPiBpcyBtb3JlIHByZXR0eSB0aGFuDQo+IA0KPiAgIHN0YXRp
Y2FsbHlfdHJ1ZSghKGZvbykpDQoNCkV4Y2VwdCB0aGF0IHRoZSB0ZXN0IGlzIG1vcmUgbGlrZWx5
IHRvIGJlOg0KCXN0YXRpY2FsbHlfZmFsc2UoeCA+IHkpDQphbmQgdGhlIGludmVydCBpcyB0aGVu
DQoJc3RhdGljYWxseV90cnVlKHggPD0geSkNCg0KTm8gZGlmZmVyZW50IGZyb20gQyBpdHNlbGYs
IHRoZXJlIGlzIG5vICdpZm5vdCAoY29uZGl0aW9uKSB7Li4ufScNCihkb24ndCB0YWxrIHRvIG1l
IGFib3V0IHBlcmwuLi4pDQoNCkkgc3VzcGVjdCB5b3UgbmVlZCB0byBwcmV0dHkgbXVjaCByZW1v
dmUgYWxsIHRoZSBjb21tZW50cyB0aGF0DQpjcm9zcy1yZWZlciB0byBzdGF0aWNhbGx5X3RydWUo
KSBmcm9tIHRoZSBvdGhlciBwYXRjaGVzLg0KDQpTbyBpc19jb25zdF90cnVlKCkgaXMganVzdCAn
cmV0dXJuIHRydWUgaWYgdGhlIGV4cHJlc3Npb24NCmlzIGEgJ25vbi16ZXJvIGNvbnN0YW50IGlu
dGVnZXIgZXhwcmVzc2lvbicuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFr
ZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwg
VUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

