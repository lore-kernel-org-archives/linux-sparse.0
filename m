Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39441A8F95
	for <linux-sparse@vger.kernel.org>; Wed,  4 Dec 2024 18:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733338374; cv=none; b=a4Zr9ztw9ZlPkgWIXi9DawnKVRzJDE+S4oWyd+VXgmMR9hNJkUHu1oFhz87mJbBzioje2aiUcAA+lR9IvD/v2DQNqjvVqAvezoevDeIC5T5yekFtTN3rkrhPbDQ3FJ0Y2/yRey8UyppGgR7mkUBJvEGsQTqtHxocTECJNmC/h5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733338374; c=relaxed/simple;
	bh=YwY9xHZHGpEHtbkNcyeJTSKGNlyl22M9/V3vuq7ghwA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=PrPRaO7IS22VVkGCnkSoPpwqLDIdIDSJxc7eJSMcqbe9gavPEMA1H25Fe1hGiPIgEXaUG2uuqCUJvS1PlxZgvqWTZ8u9edKVB1LkMxFaLd/jKffYB42ALfmycndt4t5o+uc8dC1bbJ1MYBdb23xg29CgQfZ0+02bLg8utbeDPsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-232-Fo2j8UHqOR6f0adwkoLvrA-1; Wed, 04 Dec 2024 18:52:49 +0000
X-MC-Unique: Fo2j8UHqOR6f0adwkoLvrA-1
X-Mimecast-MFC-AGG-ID: Fo2j8UHqOR6f0adwkoLvrA
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 4 Dec
 2024 18:52:10 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 4 Dec 2024 18:52:10 +0000
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
Subject: RE: [PATCH 04/10] linux/bits.h: simplify GENMASK_INPUT_CHECK() by
 using is_const_true()
Thread-Topic: [PATCH 04/10] linux/bits.h: simplify GENMASK_INPUT_CHECK() by
 using is_const_true()
Thread-Index: AQHbROFQQHprgo51TES1ijsBCX2RL7LWcP7w
Date: Wed, 4 Dec 2024 18:52:10 +0000
Message-ID: <dff4cdd543104e3792e4856375f310c1@AcuMS.aculab.com>
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-4-4e4cbaecc216@wanadoo.fr>
In-Reply-To: <20241203-is_constexpr-refactor-v1-4-4e4cbaecc216@wanadoo.fr>
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
X-Mimecast-MFC-PROC-ID: E7XPTlYSJhO-uXWW-kA4dd_d6r6S66hY1_zacVIe1oc_1733338368
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogVmluY2VudCBNYWlsaG9sDQo+IFNlbnQ6IDAyIERlY2VtYmVyIDIwMjQgMTc6MzMNCj4g
DQo+ICAgX19idWlsdGluX2Nob29zZV9leHByKF9faXNfY29uc3RleHByKChsKSA+IChoKSksIChs
KSA+IChoKSwgMCkNCj4gDQo+IGlzIGVxdWl2YWxlbnQgdG86DQo+IA0KPiAgIGlzX2NvbnN0X3Ry
dWUoKGwpID4gKGgpKQ0KDQpDaGFuZ2UgaXQgdG8gQlVJTERfQlVHX09OX01TRyhzdGF0aWNhbGx5
X3RydWUoKGwpIDwgKGgpKSwgImVycm9yIG1lc3NhZ2UiKQ0KDQphbmQgdGhlbiBmaXggYWxsIHRo
ZSBmYWxsb3V0IDotKQ0KDQoJRGF2aWQNCg0KPiANCj4gQXBwbHkgaXNfY29uc3RfdHJ1ZSgpIHRv
IHNpbXBsaWZ5IEdFTk1BU0tfSU5QVVRfQ0hFQ0soKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFZp
bmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+DQo+IC0tLQ0KPiBUaGlz
IGNoYW5nZSBwYXNzZXMgdGhlIHVuaXQgdGVzdHMgZnJvbSBDT05GSUdfQklUU19URVNULCBpbmNs
dWRpbmcgdGhlDQo+IGV4dHJhIG5lZ2F0aXZlIHRlc3RzIHByb3ZpZGVkIHVuZGVyICNpZmRlZiBU
RVNUX0dFTk1BU0tfRkFJTFVSRVMgWzFdLg0KPiANCj4gWzFdIGNvbW1pdCA2ZDUxMTAyMGUxM2Qg
KCJsaWIvdGVzdF9iaXRzLmM6IGFkZCB0ZXN0cyBvZiBHRU5NQVNLIikNCj4gTGluazogaHR0cHM6
Ly9naXQua2VybmVsLm9yZy90b3J2YWxkcy9jLzZkNTExMDIwZTEzZA0KPiAtLS0NCj4gIGluY2x1
ZGUvbGludXgvYml0cy5oIHwgNSArKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2Jp
dHMuaCBiL2luY2x1ZGUvbGludXgvYml0cy5oDQo+IGluZGV4IDYwMDQ0YjYwODgxNzJiM2YyNmFh
M2YxN2NkYWVkZTk3ODY4NjNkYWUuLmVmMDExOWU2MTc5ZTFjYTk1MzQ1YTNkNGQzMzI3YmExOTYz
MzAyOGUgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvYml0cy5oDQo+ICsrKyBiL2luY2x1
ZGUvbGludXgvYml0cy5oDQo+IEBAIC0yMCw5ICsyMCw4IEBADQo+ICAgKi8NCj4gICNpZiAhZGVm
aW5lZChfX0FTU0VNQkxZX18pDQo+ICAjaW5jbHVkZSA8bGludXgvYnVpbGRfYnVnLmg+DQo+IC0j
ZGVmaW5lIEdFTk1BU0tfSU5QVVRfQ0hFQ0soaCwgbCkgXA0KPiAtCShCVUlMRF9CVUdfT05fWkVS
TyhfX2J1aWx0aW5fY2hvb3NlX2V4cHIoIFwNCj4gLQkJX19pc19jb25zdGV4cHIoKGwpID4gKGgp
KSwgKGwpID4gKGgpLCAwKSkpDQo+ICsjaW5jbHVkZSA8bGludXgvY29tcGlsZXIuaD4NCj4gKyNk
ZWZpbmUgR0VOTUFTS19JTlBVVF9DSEVDSyhoLCBsKSBCVUlMRF9CVUdfT05fWkVSTyhpc19jb25z
dF90cnVlKChsKSA+IChoKSkpDQo+ICAjZWxzZQ0KPiAgLyoNCj4gICAqIEJVSUxEX0JVR19PTl9a
RVJPIGlzIG5vdCBhdmFpbGFibGUgaW4gaCBmaWxlcyBpbmNsdWRlZCBmcm9tIGFzbSBmaWxlcywN
Cj4gDQo+IC0tDQo+IDIuNDUuMg0KPiANCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRl
LCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpS
ZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

