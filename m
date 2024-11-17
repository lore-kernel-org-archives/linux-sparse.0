Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0E81DA61B
	for <linux-sparse@vger.kernel.org>; Sun, 17 Nov 2024 19:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731871406; cv=none; b=XVnzrz328toh0Y7nVT/bo7a5OFenjBgFu78Z5T/FeCGCkRGx/txPiCScx9piWucxmVhPkxbCeMM7/qZNanjngG4trLbBRBCFl5ej+InAu40vPVoPJOAjpfpSvMB7QdB+bbOe3C/yrm768g2AT6PI3loMEuwRNuEFzzzxt68qJkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731871406; c=relaxed/simple;
	bh=0kDBzHy4Z3zCX3m3Wqf3QqCh8+QMdVY5KxEOrrON/1A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=SepFLKJ+wOGZtnyo5DVQ10VqgJqZ/P5Tg/+CcgxR7Gyb6Te64NwPFX7liosDAtSoj2bjMmAkWWyf+k/ukaN1T3bQAivQlLBisvofd4uyLo9NmzBNE/nf32QTg+GttJ5M8htaAujewujRdrxCJA1jQrhEvk2oWQFznxcEcrUKBtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-33-DPMEbQEGOSq-2p63680f8w-1; Sun, 17 Nov 2024 19:23:21 +0000
X-MC-Unique: DPMEbQEGOSq-2p63680f8w-1
X-Mimecast-MFC-AGG-ID: DPMEbQEGOSq-2p63680f8w
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 17 Nov
 2024 19:23:20 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 17 Nov 2024 19:23:20 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>
CC: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Yury Norov
	<yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Luc Van
 Oostenryck" <luc.vanoostenryck@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-sparse@vger.kernel.org"
	<linux-sparse@vger.kernel.org>, Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: RE: [PATCH v4 1/2] compiler.h: add const_true()
Thread-Topic: [PATCH v4 1/2] compiler.h: add const_true()
Thread-Index: AQHbNfHJErTnWAqww06zGCD7FdQ1jLK7v5ZAgAAJngCAAAybIIAABtuAgAABLjA=
Date: Sun, 17 Nov 2024 19:23:20 +0000
Message-ID: <fab10eb9e70041c0a034f4945a978e00@AcuMS.aculab.com>
References: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
 <20241113172939.747686-5-mailhol.vincent@wanadoo.fr>
 <8bf6922f4bb143d1bc699aadd1c84607@AcuMS.aculab.com>
 <CAHk-=wiq=GUNWJwWh1CRAYchW73UmOaSkaCovLatfDKeveZctA@mail.gmail.com>
 <c2eabf2786c2498eae5772e5af3c456f@AcuMS.aculab.com>
 <CAHk-=whaUtqsgLGk3a+1+SJ2+KGK+GK-WbSK0dX2JpVN3bs0hQ@mail.gmail.com>
In-Reply-To: <CAHk-=whaUtqsgLGk3a+1+SJ2+KGK+GK-WbSK0dX2JpVN3bs0hQ@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: TMT5mZChX7bAs6r66yO3wz-nH03phbIa2YuwTAEUb_4_1731871401
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTcgTm92ZW1iZXIgMjAyNCAxOToxMA0KPiAN
Cj4gT24gU3VuLCAxNyBOb3YgMjAyNCBhdCAxMTowNSwgRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWln
aHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBJIHRoaW5rIGV2ZXJ5dGhpbmcgY2FuIGJl
IGJ1aWx0IG9uIGEgYmFzZSBpZl9jb25zdF96ZXJvKHgsIGlmX3osIGlmX256KQ0KPiA+ICNkZWZp
bmUgY29uc3RfdHJ1ZSh4KSBpZl9jb25zdF96ZXJvKCEoeCksIDEsIDApDQo+ID4gI2RlZmluZSBp
c19jb25zdGV4cHIoeCkgaWZfY29uc3RfemVybygoeCkgKiAwLCAxLCAwKQ0KPiA+IHdoaWNoIGdp
dmVzIGEgYml0IG1vcmUgZmxleGliaWxpdHkuDQo+IA0KPiBUaGUgaXNfY29uc3RleHByKCkgc2hv
dWxkIHByb2JhYmx5IGJlIGlmX2NvbnN0X3plcm8oMCohKHgpLDEsMCkgdG8gYmUNCj4gb2sgd2l0
aCBwb2ludGVycyBhbmQgd2l0aCAibG9uZyBsb25nIiBjb25zdGFudHMuDQo+IA0KPiBBbmQgdGhl
ICIxLDAiIGFyZ3VtZW50cyBzaG91bGQgaGF2ZSBhIHJlYWwgcmVhc29uIGZvciBleGlzdGluZy4g
SSdtDQo+IG5vdCBlbnRpcmVseSBjb252aW5jZWQgYW55IG90aGVyIGNhc2VzIG1ha2UgbXVjaCBz
ZW5zZS4NCg0KSSBtaWdodCBoYXZlIHVzZWQgdGhlbSB3aGVuIHRyeWluZyB0byBnZXQgKGhpZ2gg
Pj0gMHUpIHRocm91Z2ggYSAtVzEgYnVpbGQuDQooZm9yIGV4YW1wbGUgaW4gR0VOTUFTSygpKS4N
CkNhbid0IHF1aXRlIHJlbWVtYmVyIHRoZSBob3JyaWQgc29sdXRpb24gdGhvdWdoLg0KDQpTaW5j
ZSA5OSUgd2lsbCBiZSAxLDAgbWF5YmUgc2F2aW5nIHRoZSBleHRyYSBleHBhbnNpb24gaXMgYmVz
dCBhbnl3YXkuDQpTbyBoYXZlIGlzX2NvbnN0X3plcm8oeCkgYW5kIGFkZCBpZl9jb25zdF96ZXJv
KHgsIGlmX3osIGlmX256KSBsYXRlci4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVz
cyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEg
MVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

