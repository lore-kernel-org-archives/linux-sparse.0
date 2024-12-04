Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E7917E8F7
	for <linux-sparse@vger.kernel.org>; Wed,  4 Dec 2024 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733338500; cv=none; b=Qp5b998IOTcq1UgbPQxETsLvWjgOLJFm/t0FF0V+D/VU/2e2tRa7ubZwIfekZn5ALXEpsND/2A/dIBBBCxV99hylJKC5DT6loj+rC0A/G3TqwWhKyn9YGL5CC+f/50NJ0lluJLeOZMOa62TZejQn+W1lm2/m6iuHm1PjVG6wF34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733338500; c=relaxed/simple;
	bh=LKozLljYC5dwM4f9mxbC4dRaR9C7foO3ChfzLSA4OII=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=MYTAuCpPSy5J43ApWtrLiQRZr24CAVoUAcD0Qrq1O3wZpOHII5xkMg3Vydzvd+VzlqhUF3gEKmjMb08jW42m4SAp71vx/1KjjIS2xeEqzMxqD3pxn4r5VC84aHXLx8dNzXx7NoBHIWNAmfNkerMaX3qUWY36b4MuNmzTA9SKqAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-319-leywlU3sMBaz14PRQ0B5Ew-1; Wed, 04 Dec 2024 18:54:56 +0000
X-MC-Unique: leywlU3sMBaz14PRQ0B5Ew-1
X-Mimecast-MFC-AGG-ID: leywlU3sMBaz14PRQ0B5Ew
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 4 Dec
 2024 18:54:16 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 4 Dec 2024 18:54:16 +0000
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
Subject: RE: [PATCH 05/10] minmax: simplify __clamp_once() by using
 is_const_false()
Thread-Topic: [PATCH 05/10] minmax: simplify __clamp_once() by using
 is_const_false()
Thread-Index: AQHbROFQNBaBI/FNyUSmwK0ugw/OHbLWccOg
Date: Wed, 4 Dec 2024 18:54:16 +0000
Message-ID: <8b8262389bd6484586007d749132346f@AcuMS.aculab.com>
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-5-4e4cbaecc216@wanadoo.fr>
In-Reply-To: <20241203-is_constexpr-refactor-v1-5-4e4cbaecc216@wanadoo.fr>
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
X-Mimecast-MFC-PROC-ID: rNF1Jp9vIGrsRnVE2uLvwbmjqw6M8EFExoeQ9whPeTc_1733338494
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogVmluY2VudCBNYWlsaG9sDQo+IFNlbnQ6IDAyIERlY2VtYmVyIDIwMjQgMTc6MzMNCj4g
DQo+IEluIF9fY2xhbXBfb25jZSgpLA0KPiANCj4gICBfX2J1aWx0aW5fY2hvb3NlX2V4cHIoX19p
c19jb25zdGV4cHIoKGxvKSA+IChoaSkpLCAobG8pIDw9IChoaSksIHRydWUpDQo+IA0KPiBpcyBl
cXVpdmFsZW50IHRvOg0KPiANCj4gICAhaXNfY29uc3RfZmFsc2UoKGxvKSA8PSAoaGkpKQ0KPiAN
Cj4gQXBwbHkgaXNfY29uc3RfZmFsc2UoKSB0byBzaW1wbGlmeSBfX2NsYW1wX29uY2UoKS4NCg0K
VGhlcmUgaXMgYWxyZWFkeSBhIHBhdGNoICdmb3IgbmV4dCcgdGhhdCBjaGFuZ2VzIGl0IHVzZSBC
VUlMRF9CVUdfT05fTVNHKCkNCmFuZCBzdGF0aWNhbGx5X3RydWUoKS4NCg0KSXQgaGFzIGZvdW5k
IHNvbWUgJ2ludGVyZXN0aW5nJyBjb2RlLg0KDQoJRGF2aWQNCg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogVmluY2VudCBNYWlsaG9sIDxtYWlsaG9sLnZpbmNlbnRAd2FuYWRvby5mcj4NCj4gLS0tDQo+
ICBpbmNsdWRlL2xpbnV4L21pbm1heC5oIHwgMyArLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L21pbm1heC5oIGIvaW5jbHVkZS9saW51eC9taW5tYXguaA0KPiBpbmRleCA5ODAwOGRkOTIx
NTNkYjEwYzY3MjE1NWJjYTkzMjAxZmZhYmVlOTk0Li40MzFiZjc2YWM0NjBhMTFhMmU0YWYyM2Fj
ZDkwYzBkMjZlOTljODYyIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21pbm1heC5oDQo+
ICsrKyBiL2luY2x1ZGUvbGludXgvbWlubWF4LmgNCj4gQEAgLTExMSw4ICsxMTEsNyBAQA0KPiAg
CV9fYXV0b190eXBlIHV2YWwgPSAodmFsKTsJCQkJCQlcDQo+ICAJX19hdXRvX3R5cGUgdWxvID0g
KGxvKTsJCQkJCQkJXA0KPiAgCV9fYXV0b190eXBlIHVoaSA9IChoaSk7CQkJCQkJCVwNCj4gLQlz
dGF0aWNfYXNzZXJ0KF9fYnVpbHRpbl9jaG9vc2VfZXhwcihfX2lzX2NvbnN0ZXhwcigobG8pID4g
KGhpKSksIAlcDQo+IC0JCQkobG8pIDw9IChoaSksIHRydWUpLAkJCQkJXA0KPiArCXN0YXRpY19h
c3NlcnQoIWlzX2NvbnN0X2ZhbHNlKChsbykgPD0gKGhpKSksCQkJCVwNCj4gIAkJImNsYW1wKCkg
bG93IGxpbWl0ICIgI2xvICIgZ3JlYXRlciB0aGFuIGhpZ2ggbGltaXQgIiAjaGkpOwlcDQo+ICAJ
QlVJTERfQlVHX09OX01TRyghX190eXBlc19vazModmFsLGxvLGhpLHV2YWwsdWxvLHVoaSksCQkJ
XA0KPiAgCQkiY2xhbXAoIiN2YWwiLCAiI2xvIiwgIiNoaSIpIHNpZ25lZG5lc3MgZXJyb3IiKTsJ
CVwNCj4gDQo+IC0tDQo+IDIuNDUuMg0KPiANCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

