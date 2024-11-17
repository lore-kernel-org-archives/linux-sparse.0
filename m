Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F851DA619
	for <linux-sparse@vger.kernel.org>; Sun, 17 Nov 2024 19:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731870315; cv=none; b=sZVocGP5uqxDgu7I2S5oIEGpI12sZM+RR9QNU8bmIZCXDyooSNk20OLfDRB3Jyal6tnin9TGNJdI5gwk0RwMlWDlPjcVEQVn9LhIbC0ef4u45bwnU0us7MnyoObFNxD+G6NQ6InW4rinkRM/sPs2PRoiMZPasz0ZsLIKcr1JGJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731870315; c=relaxed/simple;
	bh=bZeTtVPWrKMiBY9ZaVPnyEG7Qzr/B4KOlBJxv7OYkH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=WIGn7gx2p88NOkSeN26a43DZwO2/EZ4xWlydU8JrZXGydDpZMQiDay1etAuKLBVnkrTXqM1/1kFbLt7P0EBH5DA2vRODEPoVomXWByq7y9cm1qZjKQxNddwNy1dA3emefp5DuxY78zMs7618XhzWMeBrMCfylXHcIAw3s/bee+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-96-M8_XOVZIOyO7IbkIatoGpg-1; Sun, 17 Nov 2024 19:05:08 +0000
X-MC-Unique: M8_XOVZIOyO7IbkIatoGpg-1
X-Mimecast-MFC-AGG-ID: M8_XOVZIOyO7IbkIatoGpg
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 17 Nov
 2024 19:05:07 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 17 Nov 2024 19:05:07 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>
CC: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Yury Norov
	<yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Luc Van
 Oostenryck" <luc.vanoostenryck@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-sparse@vger.kernel.org"
	<linux-sparse@vger.kernel.org>, Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: RE: [PATCH v4 1/2] compiler.h: add const_true()
Thread-Topic: [PATCH v4 1/2] compiler.h: add const_true()
Thread-Index: AQHbNfHJErTnWAqww06zGCD7FdQ1jLK7v5ZAgAAJngCAAAybIA==
Date: Sun, 17 Nov 2024 19:05:07 +0000
Message-ID: <c2eabf2786c2498eae5772e5af3c456f@AcuMS.aculab.com>
References: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
 <20241113172939.747686-5-mailhol.vincent@wanadoo.fr>
 <8bf6922f4bb143d1bc699aadd1c84607@AcuMS.aculab.com>
 <CAHk-=wiq=GUNWJwWh1CRAYchW73UmOaSkaCovLatfDKeveZctA@mail.gmail.com>
In-Reply-To: <CAHk-=wiq=GUNWJwWh1CRAYchW73UmOaSkaCovLatfDKeveZctA@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: V5FvxqJCm0Ld_5dD2KFEhytlORjyXDbwilViekv3Scw_1731870307
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTcgTm92ZW1iZXIgMjAyNCAxODowMA0KPiAN
Cj4gT24gU3VuLCAxNyBOb3YgMjAyNCBhdCAwOTo0MiwgRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWln
aHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiAjZGVmaW5lIGNvbnN0X3RydWUoeCkgX19p
Zl9jb25zdGV4cHIoeCwgeCwgMCkNCj4gDQo+IE5vLCBsZXQncyBub3QgZG8gdGhpcyAiZG91Ymxl
IGV4cGFuc2lvbiIgdGhpbmcgYWdhaW4uDQoNCkl0IHdvdWxkIGJlIGJldHRlciB0aGF0IHRoZSBw
cm9wb3NlZCBkZWZpbmUgOi0pDQoNCj4gSWYgd2UgYWN0dWFsbHkgd2FudCB0byBtYWtlIHRoaW5n
cyBzbWFydGVyLCB0aGUgdHJpY2sgdG8gdXNlIGlzIHRvDQo+IGtub3cgdGhhdCBvbmx5IGEgY29u
c3RhbnQgX3plcm9fIHR1cm5zIGludG8gYSB2b2lkIHBvaW50ZXIgKGFrYSBOVUxMKS4NCj4gDQo+
IElPVywgc29tZXRoaW5nIGxpa2UgdGhpczoNCj4gDQo+ICAgIC8qDQo+ICAgICAqIGlmZiAneCcg
aXMgYSBub24temVybyBjb25zdGFudCBpbnRlZ2VyIGV4cHJlc3Npb24sDQo+ICAgICAqIHRoZW4g
JyEoeCknIHdpbGwgYmUgYSB6ZXJvIGNvbnN0YW50IGludGVnZXIgZXhwcmVzc2lvbiwNCj4gICAg
ICogYW5kIGNhc3RpbmcgdGhhdCB0byAndm9pZCAqJyB3aWxsIHJlc3VsdCBpbiBhIE5VTEwNCj4g
ICAgICogcG9pbnRlci4gT3RoZXJ3aXNlIGNhc3RpbmcgaXQgdG8gJ3ZvaWQgKicgd2lsbCBiZSBq
dXN0DQo+ICAgICAqIGEgcmVndWxhciAndm9pZCAqJy4NCj4gICAgICoNCj4gICAgICogVGhlIHR5
cGUgb2YgJzAgPyBOVUxMIDogKGNoYXIgKiknIGlzICdjaGFyIConDQo+ICAgICAqIFRoZSB0eXBl
IG9mICcwID8gKHZvaWQgKikgOiAoY2hhciAqKSBpcyAndm9pZCAqJw0KPiAgICAgKi8NCj4gICAg
ICNkZWZpbmUgY29uc3RfdHJ1ZSh4KSBcDQo+ICAgICAgICAgX0dlbmVyaWMoMCA/ICh2b2lkICop
KChsb25nKSEoeCkpIDogKGNoYXIgKikwLCBjaGFyICo6IDEsIHZvaWQgKjogMCkNCj4gDQo+IHNo
b3VsZCB3b3JrLCBhbmQgZG9lc24ndCBkbyBhbnkgZG91YmxlIGV4cGFuc2lvbiBvZiBjb21wbGV4
IGFyZ3VtZW50cy4NCg0KSSdtIHN1cmUgSSBoYXZlIG9uZSBwbGFjZSB3aGVyZSBJIGRpZCB3YW50
IG90aGVyIHRoYW4gMSBvciAwLg0KSSBkbyByZW1lbWJlciBtb3ZpbmcgdGhlICcqIDAnIGludG8g
dGhlIHdyYXBwZXIgZm9yIF9faXNfY29uc3RleHByKCkuDQoNCk5vdyB0aGFuIG1pbi9tYXggZG9u
J3QgdXNlIF9faXNfY29uc3RleHByKCkgSSB3b25kZXIgaWYgaXQgc3RpbGwgaGFzDQp0byBiZSBz
YW5lIGZvciBwb2ludGVycz8NClN1cHBvcnRpbmcgcG9pbnRlcnMganVzdCBtYWtlcyBsaWZlIGhh
cmQgLSBlc3BlY2lhbGx5IHNpbmNlICh2b2lkICopMSBpc24ndA0KY29uc3RhbnQuDQoNCkkgdGhp
bmsgZXZlcnl0aGluZyBjYW4gYmUgYnVpbHQgb24gYSBiYXNlIGlmX2NvbnN0X3plcm8oeCwgaWZf
eiwgaWZfbnopDQojZGVmaW5lIGNvbnN0X3RydWUoeCkgaWZfY29uc3RfemVybyghKHgpLCAxLCAw
KQ0KI2RlZmluZSBpc19jb25zdGV4cHIoeCkgaWZfY29uc3RfemVybygoeCkgKiAwKSwgMSwgMCkN
CndoaWNoIGdpdmVzIGEgYml0IG1vcmUgZmxleGliaWxpdHkuDQoNCglEYXZpZA0KDQotDQpSZWdp
c3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9u
IEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

