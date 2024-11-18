Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BE318B47E
	for <linux-sparse@vger.kernel.org>; Mon, 18 Nov 2024 09:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731922042; cv=none; b=sXFDPxQMWcivDVNDr8ApN6rz6raFaoKvggcaD1dNuwDnxH+1AeHpwYfdd6vPRPho1KaLrsIT6IuMOyxwFFNUgsGAyS2tunoPlRpn57qg0QkzDrR40pXo2aZdcPvKMk6ZwEVK84myVbHLLWuaUvJQOCKZWdWIFe2Kggt5CWXvqkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731922042; c=relaxed/simple;
	bh=dCCdQD6c9JHMs8dqZRqRQboZUW3fsM/GJ2kNZhzY8sA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=hWxLYgMVZBspbXDce3tHEQdvSBITq/E1tkKAAxb5EFL/pXYsP/7ycpmAmT9+G5CK13rrboRcLDXIl8Re9PNvW4gN3a+QrzaEZlewsyoS+osyVoGOl9qiE7do03omjoqxZZTiC3ImzpxtMbLWVwrY2CoExT+j4kzn6JrBITQKQjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-286-JJNqEPiRP5mr16F-M4gs8w-1; Mon, 18 Nov 2024 09:27:18 +0000
X-MC-Unique: JJNqEPiRP5mr16F-M4gs8w-1
X-Mimecast-MFC-AGG-ID: JJNqEPiRP5mr16F-M4gs8w
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 18 Nov
 2024 09:27:17 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 18 Nov 2024 09:27:17 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Vincent Mailhol' <mailhol.vincent@wanadoo.fr>, Linus Torvalds
	<torvalds@linux-foundation.org>
CC: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, "Rikard
 Falkeborn" <rikard.falkeborn@gmail.com>
Subject: RE: [PATCH v4 1/2] compiler.h: add const_true()
Thread-Topic: [PATCH v4 1/2] compiler.h: add const_true()
Thread-Index: AQHbNfHJErTnWAqww06zGCD7FdQ1jLK7v5ZAgAAJngCAAAybIIAABtuAgAABLjCAABBOAIAAHt5QgABZWomAAGEx4A==
Date: Mon, 18 Nov 2024 09:27:17 +0000
Message-ID: <fea4cc244f2f4f1a8cde7c49548e74eb@AcuMS.aculab.com>
References: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
 <20241113172939.747686-5-mailhol.vincent@wanadoo.fr>
 <8bf6922f4bb143d1bc699aadd1c84607@AcuMS.aculab.com>
 <CAHk-=wiq=GUNWJwWh1CRAYchW73UmOaSkaCovLatfDKeveZctA@mail.gmail.com>
 <c2eabf2786c2498eae5772e5af3c456f@AcuMS.aculab.com>
 <CAHk-=whaUtqsgLGk3a+1+SJ2+KGK+GK-WbSK0dX2JpVN3bs0hQ@mail.gmail.com>
 <fab10eb9e70041c0a034f4945a978e00@AcuMS.aculab.com>
 <CAHk-=wgfpLdt7SFFGcByTfHdkvv7AEa3MDu_s_W1kfOxQs49pw@mail.gmail.com>
 <2b5282038b1f46bc9a658fb2b6d78350@AcuMS.aculab.com>
 <CAHk-=wiV+yL5qhm5FbeKz3FV6Zdi4oRv7rr3b_=16tfmwUMWFA@mail.gmail.com>
 <CAMZ6RqJ=ze66FuOrWvuY26T6p+9GftrAeVApbTLnT_HgRWJL_Q@mail.gmail.com>
In-Reply-To: <CAMZ6RqJ=ze66FuOrWvuY26T6p+9GftrAeVApbTLnT_HgRWJL_Q@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: AAzFNcx7hAT2yYYhANhE_5RIqFGiv-t2kRqR_WbNfrM_1731922037
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogVmluY2VudCBNYWlsaG9sDQo+IFNlbnQ6IDE4IE5vdmVtYmVyIDIwMjQgMDM6MjINCj4g
DQo+IE9uIE1vbi4gMTggbm92LiAyMDI0IMOgIDA3OjU4LCBMaW51cyBUb3J2YWxkcw0KPiA8dG9y
dmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiA+IFRoZSAiMCohKHgpIiBpcyBh
ZG1pdHRlZGx5IGtpbmQgb2YgdWdseSwgYW5kIG1pZ2h0IGJlIHByZXR0aWVyIGFzDQo+ID4gIjAm
Jih4KSIuIFNhbWUgbnVtYmVyIG9mIGNoYXJhY3RlcnMsIGJ1dCB0ZWNobmljYWxseSBvbmUgb3Ag
bGVzcyBhbmQNCj4gPiBub3QgbWl4aW5nIGJvb2xlYW5zIGFuZCBpbnRlZ2VyIG9wcy4NCj4gDQo+
IEkgZGlkIGEgdHJlZSB3aWRlIHJlcGxhY2VtZW50IG9mIF9faXNfY29uc3RleHByKCkgd2l0aCBp
c19jb25zdCgpIGFuZA0KPiBkaWQgYW4gYWxseWVzY29uZmlnIGJ1aWxkIHRlc3QuIEl0IHlpZWxk
cyBhIC1XaW50LWluLWJvb2wtY29udGV4dA0KPiB3YXJuaW5nIGluIEdDQyBmb3IgYm90aCB0aGUg
IjAqISh4KSIgYW5kIHRoZSAiMCYmKHgpIiBlYWNoIHRpbWUgdGhlDQo+IGV4cHJlc3Npb24gY29u
dGFpbnMgbm9uLWJvb2xlYW4gb3BlcmF0b3JzLCBmb3IgZXhhbXBsZTogKiBvciA8PC4NCj4gDQo+
IEkgcmVwcm9kdWNlZCBpdCBpbiBnb2Rib2x0IGhlcmU6DQo+IA0KPiAgIGh0dHBzOi8vZ29kYm9s
dC5vcmcvei81V2NidmFucTMNCg0KQXBwbGllcyB0byBwcmV0dHkgbXVjaCBhbGwgdGhlIHZhcmlh
bnRzLg0KTmVlZHMgdG8gYmUgKHgpID09IDAgKG9yICh4KSAhPSAwKSByYXRoZXIgdGhhbiAhKHgp
DQoNCkZvcnR1bmF0ZWx5IGNvbXBhcmlzb24gb3BlcmF0b3JzIChhbmQgPzopIGFyZSBhbGwgdmFs
aWQgaW4NCmNvbnN0YW50IGludGVnZXIgZXhwcmVzc2lvbnMuDQoNCk9oLCBvbmUgYWR2YW50YWdl
IG9mIHN0YXRpY2FsbHlfY29uc3QoKSBpcyB0aGF0IHlvdSBjYW4gZ2l2ZQ0KaXQgYSAnbG9jYWwn
IHZhcmlhYmxlIHRoYXQgY29udGFpbnMgdGhlIHZhbHVlLg0KU28gdGhpcyB3b3JrczoNCiNkZWZp
bmUgY2hlY2tfbG9faG8obG8sIGhpKSBkbyB7IFwNCglfX2F1dG9fdHlwZSBfbG8gPSBsbzsgXA0K
CV9fYXV0b190eXBlIF9oaSA9IGhpOyBcDQoJQlVJTERfQlVHX09OX01TRyhfbG8gPiBfaGksICJp
bnZlcnRlZCBib3VuZHMiKTsgXA0KfSB3aGlsZSAoMCkNCg0KSSdtIHRyeWluZyB0byBmaW5hbGlz
ZSBhIHBhdGNoIGZvciBtaW4oKSBhbmQgbWF4KCkuDQoNCglEYXZpZA0KDQoJDQoNCi0NClJlZ2lz
dGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24g
S2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

