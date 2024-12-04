Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B5D185B54
	for <linux-sparse@vger.kernel.org>; Wed,  4 Dec 2024 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733337637; cv=none; b=MnhIUN6KvCL0p8eRyNRS2vbw7JdVU3aJnYcCYEoaZpLiBM/KEz3QgIATzuQPC0f7Dq7yGIJmXUmZo0D7NjJM1I+mt1Pp413q2tNpPfeBfXOSFZUrMUHrnNGLVISLUxUmzgU+lo6cOmUQLBjFt3f+oGkkk/nzw0KUyftzcOeldg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733337637; c=relaxed/simple;
	bh=MtCOK0HVkC7gUFMSIgVVL4Xc+Z55LO/CooQTrZpf8Mw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=s7ET6I0NOSFmtJO/KbaNs0y9MFtboyEhFrmF8t0ehDhkJi4L9v34f+MFakJGSYByuSMZEgB78wM5THBDdGrNlSHVJHSNFWkUR5Nn+tktOKLCrZylywto3BdhbQPb/El1TnOKU/yl0EoVGmsnFB+YMNrcBCOBWfpkBUsDVqp6Qk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-43--ru7XJDzPXaGunFvat9ayQ-1; Wed, 04 Dec 2024 18:40:33 +0000
X-MC-Unique: -ru7XJDzPXaGunFvat9ayQ-1
X-Mimecast-MFC-AGG-ID: -ru7XJDzPXaGunFvat9ayQ
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 4 Dec
 2024 18:39:53 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 4 Dec 2024 18:39:53 +0000
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
Subject: RE: [PATCH 02/10] compiler.h: add is_const() as a replacement of
 __is_constexpr()
Thread-Topic: [PATCH 02/10] compiler.h: add is_const() as a replacement of
 __is_constexpr()
Thread-Index: AQHbROFPJXcuwP9wN0+yRzIQ2cx/pbLWa+gg
Date: Wed, 4 Dec 2024 18:39:53 +0000
Message-ID: <1d807c7471b9434aa8807e6e86c964ec@AcuMS.aculab.com>
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr>
In-Reply-To: <20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr>
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
X-Mimecast-MFC-PROC-ID: e0X_928SK2ZLP-dBZIpkHdQxJbcJUgcneR5t3vrI_Is_1733337631
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogVmluY2VudCBNYWlsaG9sDQo+IFNlbnQ6IDAyIERlY2VtYmVyIDIwMjQgMTc6MzMNCj4g
DQo+IEZyb206IFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+DQo+
IA0KPiBfX2lzX2NvbnN0ZXhwcigpLCB3aGlsZSBiZWluZyBvbmUgb2YgdGhlIG1vc3QgZ2xvcmlv
dXMgb25lIGxpbmVyIGhhY2sNCj4gZXZlciB3aXRuZXNzZWQgYnkgbWFua2luZCwgaXMgb3Zlcmx5
IGNvbXBsZXguIEZvbGxvd2luZyB0aGUgYWRvcHRpb24NCj4gb2YgQzExIGluIHRoZSBrZXJuZWws
IHRoaXMgbWFjcm8gY2FuIGJlIHNpbXBsaWZpZWQgdGhyb3VnaCB0aGUgdXNlIG9mDQo+IGEgX0dl
bmVyaWMoKSBzZWxlY3Rpb24uDQoNCllvdSBzaG91bGQgZ2l2ZSBjcmVkaXQgdG8gc29tZSBvZiB0
aGUgZWFybGllciBwYXRjaGVzIHRoYXQgZG8gdGhlIHNhbWUuDQpJJ20gc3VyZSB0aGVyZSB3ZXJl
IHNvbWUgcmVsYXRlZCBvbmVzIGZyb20gTGludXMgLSBub3QgYXBwbGllZCB5ZXQuDQoNCj4gDQo+
IEZpcnN0LCBzcGxpdCB0aGUgbWFjcm8gaW4gdHdvOg0KPiANCj4gICAtIF9faXNfY29uc3RfemVy
byh4KTogYW4gaGVscGVyIG1hY3JvOyB0ZWxscyB3aGV0aGVyIHggaXMgdGhlDQo+ICAgICBpbnRl
Z2VyIGNvbnN0YW50IGV4cHJlc3Npb24gMCBvciBzb21ldGhpbmcgZWxzZS4NCj4gDQo+ICAgLSBp
c19jb25zdCh4KTogcmVwbGFjZW1lbnQgb2YgX19pc19jb25zdGV4cHIoKTsgdGVsbHMgd2hldGhl
ciB4IGlzIGENCj4gICAgIGludGVnZXIgY29uc3RhbnQgZXhwcmVzc2lvbi4NCj4gDQo+IFRoZSBz
cGxpdCBzZXJ2ZXMgdHdvIHB1cnBvc2VzOiBmaXJzdCBtYWtlIGl0IGVhc2llciB0byB1bmRlcnN0
YW5kOw0KPiBzZWNvbmQsIF9faXNfY29uc3RfemVybygpIHdpbGwgYmUgcmV1c2VkIGFzIGEgYnVp
bGRpbmcgYmxvY2sgZm9yIG90aGVyDQo+IGlzX2NvbnN0XyooKSBtYWNyb3MgdGhhdCB3aWxsIGJl
IGludHJvZHVjZWQgbGF0ZXIgb24uDQo+IA0KPiBUaGUgY29yZSBwcmluY2lwbGUgb2YgX19pc19j
b25zdGV4cHIoKSB0byBhYnVzZSB0aGUgcmV0dXJuIHR5cGUgb2YgdGhlDQo+IHRlcm5hcnkgb3Bl
cmF0b3IgcmVtYWlucywgYnV0IGFsbCB0aGUgc3Vycm91bmRpbmcgc2l6ZW9mKCkgaGFjaw0KPiBk
aXNhcHBlYXIuDQo+IA0KPiBPbiBhIHNpZGUgbm90ZSwgd2hpbGUgbm90IHJlbGV2YW50IHRvIHRo
ZSBrZXJuZWwsIF9faXNfY29uc3RleHByKCkNCj4gcmVsaWVkIG9uIHRoZSBHTlUgZXh0ZW5zaW9u
IHRoYXQgc2l6ZW9mKHZvaWQpIGlzIDEuIGNvbnN0X2V4cHIoKSBkb2VzDQo+IG5vdCB1c2UgYW55
IEdOVSBleHRlbnNpb25zLCBtYWtpbmcgaXQgSVNPIEMgY29tcGxpYW50Lg0KPiANCj4gX19pc19j
b25zdGV4cHIoKSBpcyB0ZW1wb3JhcmlseSBrZXB0IGFuZCB3aWxsIGJlIHJlbW92ZWQgb25jZSBh
bGwgaXRzDQo+IHVzZXJzIGdldCBtaWdyYXRlZCB0byBpc19jb25zdCgpIChvciBvbmUgb2YgaXRz
IGZyaWVuZCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBWaW5jZW50IE1haWxob2wgPG1haWxob2wu
dmluY2VudEB3YW5hZG9vLmZyPg0KPiAtLS0NCj4gIGluY2x1ZGUvbGludXgvY29tcGlsZXIuaCB8
IDQxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvY29tcGlsZXIuaCBiL2luY2x1ZGUvbGludXgvY29tcGlsZXIuaA0KPiBpbmRleCBhMmE1NmE1
MGRkODUyMjdhNGZkYzYyMjM2YTI3MTBjYTM3YzViYTUyLi4zMGNlMDZkZjQxNTNjZmRjMGZhZDli
YzdiZmZhYjkwOTdmOGIwNDUwIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2NvbXBpbGVy
LmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9jb21waWxlci5oDQo+IEBAIC0zMTYsNiArMzE2LDQ3
IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCAqb2Zmc2V0X3RvX3B0cihjb25zdCBpbnQgKm9mZikNCj4g
ICNkZWZpbmUgc3RhdGljYWxseV90cnVlKHgpIChfX2J1aWx0aW5fY29uc3RhbnRfcCh4KSAmJiAo
eCkpDQo+ICAjZGVmaW5lIHN0YXRpY2FsbHlfZmFsc2UoeCkgKF9fYnVpbHRpbl9jb25zdGFudF9w
KHgpICYmICh4KSA9PSAwKQ0KPiANCj4gKy8qDQo+ICsgKiBXaGV0aGVyIHggaXMgdGhlIGludGVn
ZXIgY29uc3RhbnQgZXhwcmVzc2lvbiAwIG9yIHNvbWV0aGluZyBlbHNlLg0KPiArICoNCj4gKyAq
IERldGFpbHM6DQo+ICsgKiAgIC0gVGhlIEMxMSBzdGFuZGFyZCBkZWZpbmVzIGluIMKnNi4zLjIu
My4zDQo+ICsgKiAgICAgICAodm9pZCAqKTxpbnRlZ2VyIGNvbnN0YW50IGV4cHJlc3Npb24gd2l0
aCB0aGUgdmFsdWUgMD4NCj4gKyAqICAgICBhcyBhIG51bGwgcG9pbnRlciBjb25zdGFudCAoYy5m
LiB0aGUgTlVMTCBtYWNybykuDQo+ICsgKiAgIC0gSWYgeCBldmFsdWF0ZXMgdG8gdGhlIGludGVn
ZXIgY29uc3RhbnQgZXhwcmVzc2lvbiAwLA0KPiArICogICAgICAgKHZvaWQgKikoeCkNCj4gKyAq
ICAgICBpcyBhIG51bGwgcG9pbnRlciBjb25zdGFudC4gRWxzZSwgaXQgaXMgYSB2b2lkICogZXhw
cmVzc2lvbi4NCj4gKyAqICAgLSBJbiBhIHRlcm5hcnkgZXhwcmVzc2lvbjoNCj4gKyAqICAgICAg
IGNvbmRpdGlvbiA/IG9wZXJhbmQxIDogb3BlcmFuZDINCj4gKyAqICAgICBpZiBvbmUgb2YgdGhl
IHR3byBvcGVyYW5kcyBpcyBvZiB0eXBlIHZvaWQgKiBhbmQgdGhlIG90aGVyIG9uZQ0KPiArICog
ICAgIHNvbWUgb3RoZXIgcG9pbnRlciB0eXBlLCB0aGUgQzExIHN0YW5kYXJkIGRlZmluZXMgaW4g
wqc2LjUuMTUuNg0KPiArICogICAgIHRoZSByZXN1bHRpbmcgdHlwZSBhcyBiZWxvdzoNCj4gKyAq
ICAgICAgIGlmIG9uZSBvcGVyYW5kIGlzIGEgbnVsbCBwb2ludGVyIGNvbnN0YW50LCB0aGUgcmVz
dWx0IGhhcyB0aGUNCj4gKyAqICAgICAgIHR5cGUgb2YgdGhlIG90aGVyIG9wZXJhbmQ7IG90aGVy
d2lzZSBbLi4uXSB0aGUgcmVzdWx0IHR5cGUgaXMNCj4gKyAqICAgICAgIGEgcG9pbnRlciB0byBh
biBhcHByb3ByaWF0ZWx5IHF1YWxpZmllZCB2ZXJzaW9uIG9mIHZvaWQuDQo+ICsgKiAgIC0gQXMg
c3VjaCwgaW4NCj4gKyAqICAgICAgIDAgPyAodm9pZCAqKSh4KSA6IChjaGFyICopMA0KPiArICog
ICAgIGlmIHggaXMgdGhlIGludGVnZXIgY29uc3RhbnQgZXhwcmVzc2lvbiAwLCBvcGVyYW5kMSBp
cyBhIG51bGwNCj4gKyAqICAgICBwb2ludGVyIGNvbnN0YW50IGFuZCB0aGUgcmVzdWx0aW5nIHR5
cGUgaXMgdGhhdCBvZiBvcGVyYW5kMjoNCj4gKyAqICAgICBjaGFyICouIElmIHggaXMgYW55dGhp
bmcgZWxzZSwgdGhlIHR5cGUgaXMgdm9pZCAqLg0KPiArICogICAtIFRoZSAobG9uZykgY2FzdCBz
aWxlbmNlcyBhIGNvbXBpbGVyIHdhcm5pbmcgZm9yIHdoZW4geCBpcyBub3QgMC4NCj4gKyAqICAg
LSBGaW5hbGx5LCB0aGUgX0dlbmVyaWMoKSBkaXNwYXRjaGVzIHRoZSByZXN1bHRpbmcgdHlwZSBp
bnRvIGENCj4gKyAqICAgICBCb29sZWFuLg0KDQpUaGUgY29tbWVudCBpcyBhYnNvbHV0ZWx5IGV4
Y2Vzc2l2ZS4NCkknbSBzdXJlIEkgbWFuYWdlZCBhYm91dCAyIGxpbmVzIGluIG9uZSBvZiB0aGUg
cGF0Y2hlcyBJIGRpZC4NCg0KPiArICoNCj4gKyAqIEdsb3J5IHRvIE1hcnRpbiBVZWNrZXIgPE1h
cnRpbi5VZWNrZXJAbWVkLnVuaS1nb2V0dGluZ2VuLmRlPg0KDQpJSVJDIE1hcnRpbiBoYXMgYWdy
ZWVkIGluIHRoZSBwYXN0IHRoYXQgdGhlIGFjY3JlZGl0YXRpb24gY2FuDQpiZSByZW1vdmVkIC0g
ZXNwZWNpYWxseSBzaW5jZSBpdCByZWZlcnMgdG8gdGhlICdzaXplb2YgKHZvaWQpJyB0cmljay4N
Cg0KPiArICovDQo+ICsjZGVmaW5lIF9faXNfY29uc3RfemVybyh4KSBcDQo+ICsJX0dlbmVyaWMo
MCA/ICh2b2lkICopKGxvbmcpKHgpIDogKGNoYXIgKikwLCBjaGFyICo6IDEsIHZvaWQgKjogMCkN
Cj4gKw0KPiArLyoNCj4gKyAqIFJldHVybnMgYSBjb25zdGFudCBleHByZXNzaW9uIHdoaWxlIGRl
dGVybWluaW5nIGlmIGl0cyBhcmd1bWVudCBpcyBhDQo+ICsgKiBjb25zdGFudCBleHByZXNzaW9u
LCBtb3N0IGltcG9ydGFudGx5IHdpdGhvdXQgZXZhbHVhdGluZyB0aGUgYXJndW1lbnQuDQoNCllv
dSBuZWVkIHRvIGRpZmZlcmVudGlhdGUgYmV0d2VlbiBhICdjb25zdGFudCBpbnRlZ2VyIGV4cHJl
c3Npb24nDQphbmQgYSAnY29tcGlsZSB0aW1lIGNvbnN0YW50Jy4NCiANCj4gKyAqDQo+ICsgKiBJ
ZiBnZXR0aW5nIGEgY29uc3RhbnQgZXhwcmVzc2lvbiBpcyBub3QgcmVsZXZhbnQgdG8geW91LCB1
c2UgdGhlIG1vcmUNCj4gKyAqIHBvd2VyZnVsIF9fYnVpbHRpbl9jb25zdGFudF9wKCkgaW5zdGVh
ZC4NCg0KX19idWlsdGluX2NvbnN0YW50X3AoKSBpcyBub3QgJ21vcmUgcG93ZXJmdWwnIGl0IGlz
IHRlc3RpbmcgZm9yDQpzb21ldGhpbmcgZGlmZmVyZW50Lg0KDQoJRGF2aWQNCg0KPiArICovDQo+
ICsjZGVmaW5lIGlzX2NvbnN0KHgpIF9faXNfY29uc3RfemVybygwICogKHgpKQ0KPiArDQo+ICAv
Kg0KPiAgICogVGhpcyBpcyBuZWVkZWQgaW4gZnVuY3Rpb25zIHdoaWNoIGdlbmVyYXRlIHRoZSBz
dGFjayBjYW5hcnksIHNlZQ0KPiAgICogYXJjaC94ODYva2VybmVsL3NtcGJvb3QuYzo6c3RhcnRf
c2Vjb25kYXJ5KCkgZm9yIGFuIGV4YW1wbGUuDQo+IA0KPiAtLQ0KPiAyLjQ1LjINCj4gDQoNCi0N
ClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBN
aWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxl
cykNCg==

