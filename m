Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923861A8F79
	for <linux-sparse@vger.kernel.org>; Wed,  4 Dec 2024 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733338162; cv=none; b=A5CCJJNALEl28WZQWNddQRBxL2jtyVu4mjaakCvX7bSJTMyuNwSos4FD+nvH0Nx+EPOIt4B4aWMCFusLbogaFgZnXNQWHU8MPAewAOWf4Imr4Q2fwJsg5kTFy5dmIg728b3C6ZFTlhgd04BH2X0+bZ8R27iHCsB+TVPxZ1vWF88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733338162; c=relaxed/simple;
	bh=8kNR7wx9SoA3w4uCzjxTkCS8MqZlJJ5RdFh0jamtqfc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=WiQfQ1DwAEqcfKWnpIrG0i4nb8XapoG74vfDsdX/kWoWnTTcQ4Y0h6qdmcSC6e6bn6B5sTxoBeESc2ASlFSzbTwXZ4u6IlkJaxK8Fo9QfsukTEBe1N9kwHLKk0RMXkVaBYJ5dgCq2wAvRDilJU1oDQ3TttKN06JDiroKo3zMqII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-24-y41QAgtzMnCcqJaZd1lbLg-1; Wed, 04 Dec 2024 18:49:17 +0000
X-MC-Unique: y41QAgtzMnCcqJaZd1lbLg-1
X-Mimecast-MFC-AGG-ID: y41QAgtzMnCcqJaZd1lbLg
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 4 Dec
 2024 18:48:38 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 4 Dec 2024 18:48:38 +0000
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
Subject: RE: [PATCH 03/10] compiler.h: add is_const_true() and
 is_const_false()
Thread-Topic: [PATCH 03/10] compiler.h: add is_const_true() and
 is_const_false()
Thread-Index: AQHbROCNH2oL4ROFokuIurb/JJa5EbLWblXw
Date: Wed, 4 Dec 2024 18:48:38 +0000
Message-ID: <c617483816b54096ba4b30bea595da49@AcuMS.aculab.com>
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-3-4e4cbaecc216@wanadoo.fr>
In-Reply-To: <20241203-is_constexpr-refactor-v1-3-4e4cbaecc216@wanadoo.fr>
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
X-Mimecast-MFC-PROC-ID: Hr2dlZUs_q6J845kxZqKzhOCAAEmv7SK2hRjlfNoaWw_1733338155
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogVmluY2VudCBNYWlsaG9sDQo+IFNlbnQ6IDAyIERlY2VtYmVyIDIwMjQgMTc6MzMNCj4N
Cj4gX19idWlsdGluX2NvbnN0YW50X3AoKSBpcyBrbm93biBmb3Igbm90IGFsd2F5cyBiZWluZyBh
YmxlIHRvIHByb2R1Y2UNCj4gY29uc3RhbnQgZXhwcmVzc2lvbiBbMV0gd2hpY2ggbGVkIHRvIHRo
ZSBpbnRyb2R1Y3Rpb24gb2YNCj4gX19pc19jb25zdGV4cHIoKSBbMl0uIEJlY2F1c2Ugb2YgaXRz
IGRlcGVuZGVuY3kgb24NCj4gX19idWlsdGluX2NvbnN0YW50X3AoKSwgc3RhdGljYWxseV90cnVl
KCkgc3VmZmVycyBmcm9tIHRoZSBzYW1lDQo+IGlzc3Vlcy4NCg0KTm8sIHRoZXkgYXJlIHRlc3Rp
bmcgZGlmZmVyZW50IHRoaW5ncy4NCg0KDQo+IA0KPiBGb3IgZXhhbXBsZToNCj4gDQo+ICAgdm9p
ZCBmb28oaW50IGEpDQo+ICAgew0KPiAgIAkgLyogZmFpbCBvbiBHQ0MgKi8NCj4gICAJQlVJTERf
QlVHX09OX1pFUk8oc3RhdGljYWxseV90cnVlKGEpKTsNCj4gDQo+ICAgCSAvKiBmYWlsIG9uIGJv
dGggY2xhbmcgYW5kIEdDQyAqLw0KPiAgIAlzdGF0aWMgY2hhciBhcnJbc3RhdGljYWxseV90cnVl
KGEpID8gMSA6IDJdOw0KPiAgIH0NCj4gDQo+IERlZmluZSBhIG5ldyBpc19jb25zdF90cnVlKCkg
YW5kIGlzX2NvbnN0X2ZhbHNlKCkgcGFpciBvZiBtYWNyb3MNCj4gd2hpY2gsIGJ5IG1ha2luZyB1
c2Ugb2YgX19pc19jb25zdF96ZXJvKCksIGFsd2F5cyBwcm9kdWNlcyBhIGNvbnN0YW50DQo+IGV4
cHJlc3Npb24uDQo+IA0KPiBOb3RlIHRoYXQgaXNfY29uc3RfZmFsc2UoKSBjYW4gbm90IGJlIGRp
cmVjdGx5IGRlZmluZWQgYXMgYW4gYWxpYXMgdG8NCj4gX19pc19jb25zdF96ZXJvKCkuIE90aGVy
d2lzZSwgaXQgY291bGQgeWllbGQgc29tZSBmYWxzZSBwb3NpdGl2ZXMgb24NCj4gaHVnZSBudW1i
ZXJzIGJlY2F1c2Ugb2YgYSBsb3N0IG9mIHByZWNpc2lvbiB3aGVuIGRvaW5nIHRoZSAobG9uZykg
Y2FzdA0KPiBpbiBfX2lzX2NvbnN0X3plcm8oKS4gRXhhbXBsZToNCj4gDQo+ICAgaXNfY29uc3Rf
ZmFsc2UoKHUxMjgpVUxPTkdfTUFYIDw8IEJJVFNfUEVSX0xPTkcpDQo+IA0KPiBGdXJ0aGVybW9y
ZSwgdXNpbmcgdGhlICEgb3BlcmF0b3IgbGlrZSB0aGlzOg0KPiANCj4gICAjZGVmaW5lIGlzX2Nv
bnN0X3RydWUoeCkgX19pc19jb25zdF96ZXJvKCEoeCkpDQo+ICAgI2RlZmluZSBpc19jb25zdF9m
YWxzZSh4KSBfX2lzX2NvbnN0X3plcm8oISEoeCkpDQo+IA0KPiB3b3VsZCB5aWVsZCBhIC1XaW50
LWluLWJvb2wtY29udGV4dCBjb21waWxlciB3YXJuaW5nIGlmIHRoZSBhcmd1bWVudA0KPiBpcyBu
b3QgYSBib29sZWFuLiBVc2UgdGhlID09IGFuZCAhPSBvcGVyYXRvcnMgaW5zdGVhZC4NCj4gDQo+
IEl0IHNob3VsZCBiZSBub3RlZCB0aGF0IHN0YXRpY2FsbHlfdHJ1ZS9mYWxzZSgpIGFyZSB0aGUg
b25seSBvbmVzDQo+IGNhcGFibGUgb2YgZm9sZGluZyB0YXV0b2xvZ2ljIGV4cHJlc3Npb25zIGlu
IHdoaWNoIGF0IGxlYXN0IG9uZSBvbiB0aGUNCj4gb3BlcmFuZHMgaXMgbm90IGEgY29uc3RhbnQg
ZXhwcmVzc2lvbi4gRm9yIGV4YW1wbGU6DQo+IA0KPiAgIHN0YXRpY2FsbHlfdHJ1ZSh0cnVlIHx8
IHZhcikNCj4gICBzdGF0aWNhbGx5X3RydWUodmFyID09IHZhcikNCj4gICBzdGF0aWNhbGx5X2Zh
bHNlKHZhciAqIDApDQo+ICAgc3RhdGljYWxseV9mYWxzZSh2YXIgKiA4ICUgNCkNCj4gDQo+IGFs
d2F5cyBldmFsdWF0ZSB0byB0cnVlLCB3aGVyZWFzIGFsbCBvZiB0aGVzZSB3b3VsZCBiZSBmYWxz
ZSB1bmRlcg0KPiBpc19jb25zdF90cnVlL2ZhbHNlKCkgaWYgdmFyIGlzIG5vdCBhIGNvbnN0YW50
IGV4cHJlc3Npb24gWzNdLg0KPiANCj4gRm9yIHRoaXMgcmVhc29uLCB1c2FnZSBvZiBjb25zdF90
cnVlL2ZhbHNlKCkgc2hvdWxkIGJlIHRoZSBleGNlcHRpb24uDQo+IFJlZmxlY3QgaW4gdGhlIGRv
Y3VtZW50YXRpb24gdGhhdCBjb25zdF90cnVlKCkgaXMgbGVzcyBwb3dlcmZ1bCBhbmQNCj4gdGhh
dCBzdGF0aWNhbGx5X3RydWUoKSBpcyB0aGUgb3ZlcmFsbCBwcmVmZXJyZWQgc29sdXRpb24uDQo+
IA0KPiBbMV0gX19idWlsdGluX2NvbnN0YW50X3AgY2Fubm90IHJlc29sdmUgdG8gY29uc3Qgd2hl
biBvcHRpbWl6aW5nDQo+IExpbms6IGh0dHBzOi8vZ2NjLmdudS5vcmcvYnVnemlsbGEvc2hvd19i
dWcuY2dpP2lkPTE5NDQ5DQo+IA0KPiBbMl0gY29tbWl0IDNjOGJhMGQ2MWQwNCAoImtlcm5lbC5o
OiBSZXRhaW4gY29uc3RhbnQgZXhwcmVzc2lvbiBvdXRwdXQgZm9yIG1heCgpL21pbigpIikNCj4g
TGluazogaHR0cHM6Ly9naXQua2VybmVsLm9yZy90b3J2YWxkcy9jLzNjOGJhMGQ2MWQwNA0KPiAN
Cj4gWzNdIGh0dHBzOi8vZ29kYm9sdC5vcmcvei9FNHI3RWF4VzkNCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+DQo+IC0tLQ0K
PiAgaW5jbHVkZS9saW51eC9jb21waWxlci5oIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC9jb21waWxlci5oIGIvaW5jbHVkZS9saW51eC9jb21waWxlci5oDQo+IGlu
ZGV4IDMwY2UwNmRmNDE1M2NmZGMwZmFkOWJjN2JmZmFiOTA5N2Y4YjA0NTAuLjE2NWFhNWI5YmM0
ODQzNzYwODdhMTMwYTFhYzFmM2VkYjUwYzk4M2QgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGlu
dXgvY29tcGlsZXIuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyLmgNCj4gQEAgLTM1
Nyw2ICszNTcsMjkgQEAgc3RhdGljIGlubGluZSB2b2lkICpvZmZzZXRfdG9fcHRyKGNvbnN0IGlu
dCAqb2ZmKQ0KPiAgICovDQo+ICAjZGVmaW5lIGlzX2NvbnN0KHgpIF9faXNfY29uc3RfemVybygw
ICogKHgpKQ0KPiANCj4gKy8qDQo+ICsgKiBTaW1pbGFyIHRvIHN0YXRpY2FsbHlfdHJ1ZSgpIGJ1
dCBwcm9kdWNlcyBhIGNvbnN0YW50IGV4cHJlc3Npb24NCg0KTm8uDQpJdCB0ZXN0cyB3aGV0aGVy
IGEgdmFsdWUgaXMgYSAnY29uc3RhbnQgaW50ZWdlciBleHByZXNzaW9uJyBhbmQNCnRoZSByZXN1
bHQgaXMgYSAnY29uc3RhbnQgaW50ZWdlciBleHByZXNzaW9uJy4NCnN0YXRpY2FsbHlfdHJ1ZSgp
IGNoZWNrcyBmb3IgdGhlIHZhbHVlIGJlaW5nIGEgJ2NvbXBpbGUgdGltZSBjb25zdGFudCcuDQoN
Ck1vc3QgY29kZSByZWFsbHkgZG9lc24ndCBjYXJlLCBpdCBhbGwgZ290IGFkZGVkIHRvIG1pbigp
IHNvIHRoYXQNCmEgdmVyeSBmZXcgcGxhY2VzIGNvdWxkIGRvOg0KCWNoYXIgZm9vW21pbigxNiwg
c2l6ZW9mICh0eXBlKSldOw0Kd2l0aG91dCB0cmlnZ2VyaW5nIHRoZSAndmFyaWFibGUgbGVuZ3Ro
IGFycmF5JyB3YXJuaW5nLg0KQnV0IHRoYXQganVzdCBibG9hdGVkIGV2ZXJ5d2hlcmUgZWxzZSBh
bmQgKElJUkMpIExpbnVzIHJlcGxhY2VkDQp0aGVtIHdpdGggYSBNSU4oKSB0aGF0IHdhcyBqdXN0
IGFuIGV4cHJlc3Npb24uDQoNCj4gKyAqDQo+ICsgKiBUbyBiZSB1c2VkIGluIGNvbmp1bmN0aW9u
IHdpdGggbWFjcm9zLCBzdWNoIGFzIEJVSUxEX0JVR19PTl9aRVJPKCksDQo+ICsgKiB3aGljaCBy
ZXF1aXJlIHRoZWlyIGlucHV0IHRvIGJlIGEgY29uc3RhbnQgZXhwcmVzc2lvbiBhbmQgZm9yIHdo
aWNoDQo+ICsgKiBzdGF0aWNhbGx5X3RydWUoKSB3b3VsZCBvdGhlcndpc2UgZmFpbC4NCg0KVXNl
IGEgZGlmZmVyZW50IEJVSUxEX0JVRyBtYWNybyBpbnN0ZWFkLg0KTG9vayBhdCB0aGUgY3VycmVu
dCBkZWZpbml0aW9uIG9mIG1pbigpLg0KDQoJRGF2aWQNCg0KPiArICoNCj4gKyAqIFRoaXMgaXMg
YSB0cmFkZS1vZmY6IGlzX2NvbnN0X3RydWUoKSByZXF1aXJlcyBhbGwgaXRzIG9wZXJhbmRzIHRv
DQo+ICsgKiBiZSBjb21waWxlIHRpbWUgY29uc3RhbnRzLiBFbHNlLCBpdCB3b3VsZCBhbHdheXMg
cmV0dXJucyBmYWxzZSBldmVuDQo+ICsgKiBvbiB0aGUgbW9zdCB0cml2aWFsIGNhc2VzIGxpa2U6
DQo+ICsgKg0KPiArICogICB0cnVlIHx8IG5vbl9jb25zdF9leHByDQo+ICsgKg0KPiArICogT24g
dGhlIG9wcG9zaXRlLCBzdGF0aWNhbGx5X3RydWUoKSBpcyBhYmxlIHRvIGZvbGQgbW9yZSBjb21w
bGV4DQo+ICsgKiB0YXV0b2xvZ2llcyBhbmQgd2lsbCByZXR1cm4gdHJ1ZSBvbiBleHByZXNzaW9u
cyBzdWNoIGFzOg0KPiArICoNCj4gKyAqICAgIShub25fY29uc3RfZXhwciAqIDggJSA0KQ0KPiAr
ICoNCj4gKyAqIEZvciB0aGUgZ2VuZXJhbCBjYXNlLCBzdGF0aWNhbGx5X3RydWUoKSBpcyBiZXR0
ZXIuDQo+ICsgKi8NCj4gKyNkZWZpbmUgaXNfY29uc3RfdHJ1ZSh4KSBfX2lzX2NvbnN0X3plcm8o
KHgpID09IDApDQo+ICsjZGVmaW5lIGlzX2NvbnN0X2ZhbHNlKHgpIF9faXNfY29uc3RfemVybygo
eCkgIT0gMCkNCj4gKw0KPiAgLyoNCj4gICAqIFRoaXMgaXMgbmVlZGVkIGluIGZ1bmN0aW9ucyB3
aGljaCBnZW5lcmF0ZSB0aGUgc3RhY2sgY2FuYXJ5LCBzZWUNCj4gICAqIGFyY2gveDg2L2tlcm5l
bC9zbXBib290LmM6OnN0YXJ0X3NlY29uZGFyeSgpIGZvciBhbiBleGFtcGxlLg0KPiANCj4gLS0N
Cj4gMi40NS4yDQo+IA0KPiANCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFt
bGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3Ry
YXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

