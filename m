Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907EB144D1A
	for <linux-sparse@vger.kernel.org>; Sun, 17 Nov 2024 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731883111; cv=none; b=C/8znUBH+DAfLr+AYkfhCQedlY0fk2+R0zne24vPo5KkrV5s4aLXOjP6dl7+5aHPuDxM41NfOPx+3C37ZjNZFyLutPwRSQdImJPFrmYk3eIgoWY2Br4Zb3Qh+33b/zlOYdLCtPzP/5Bws4lht0IcJUskMBHi+X2wdCasGwn2aEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731883111; c=relaxed/simple;
	bh=2l9mQSwUstwUuLUzwIPuOARQ5ev1wuJCPXnNgx4NN7w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=G+dc0W3K66fgxYSdrBcj9qKytrBM2wDmjcj/T1dqyoSu7W0J7ruOhUWtXRd+81DvgMnEGHtcydO5U+5cP6ZLECPLkKXGHIP/40ZcBMGvvD3ZmS667Q/HS0JpfF4c6hd/8nEWD1hkR0DkSqGZnPy3qFJYNG90jkWw8kFgRAPp2eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-29-2rHpzjVKOP-ixmiiFv3v0A-1; Sun, 17 Nov 2024 22:38:20 +0000
X-MC-Unique: 2rHpzjVKOP-ixmiiFv3v0A-1
X-Mimecast-MFC-AGG-ID: 2rHpzjVKOP-ixmiiFv3v0A
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 17 Nov
 2024 22:38:19 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 17 Nov 2024 22:38:19 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>
CC: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Yury Norov
	<yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Luc Van
 Oostenryck" <luc.vanoostenryck@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-sparse@vger.kernel.org"
	<linux-sparse@vger.kernel.org>, Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: RE: [PATCH v4 1/2] compiler.h: add const_true()
Thread-Topic: [PATCH v4 1/2] compiler.h: add const_true()
Thread-Index: AQHbNfHJErTnWAqww06zGCD7FdQ1jLK7v5ZAgAAJngCAAAybIIAABtuAgAABLjCAABBOAIAAHt5Q
Date: Sun, 17 Nov 2024 22:38:19 +0000
Message-ID: <2b5282038b1f46bc9a658fb2b6d78350@AcuMS.aculab.com>
References: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
 <20241113172939.747686-5-mailhol.vincent@wanadoo.fr>
 <8bf6922f4bb143d1bc699aadd1c84607@AcuMS.aculab.com>
 <CAHk-=wiq=GUNWJwWh1CRAYchW73UmOaSkaCovLatfDKeveZctA@mail.gmail.com>
 <c2eabf2786c2498eae5772e5af3c456f@AcuMS.aculab.com>
 <CAHk-=whaUtqsgLGk3a+1+SJ2+KGK+GK-WbSK0dX2JpVN3bs0hQ@mail.gmail.com>
 <fab10eb9e70041c0a034f4945a978e00@AcuMS.aculab.com>
 <CAHk-=wgfpLdt7SFFGcByTfHdkvv7AEa3MDu_s_W1kfOxQs49pw@mail.gmail.com>
In-Reply-To: <CAHk-=wgfpLdt7SFFGcByTfHdkvv7AEa3MDu_s_W1kfOxQs49pw@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: oM2cnRPf-ZOH1OJs8SQ6r2GW8QGGG95jP63pAo9Rw_M_1731883100
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTcgTm92ZW1iZXIgMjAyNCAyMDoxMg0KPiAN
Cj4gT24gU3VuLCAxNyBOb3YgMjAyNCBhdCAxMToyMywgRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWln
aHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBTaW5jZSA5OSUgd2lsbCBiZSAxLDAgbWF5
YmUgc2F2aW5nIHRoZSBleHRyYSBleHBhbnNpb24gaXMgYmVzdCBhbnl3YXkuDQo+ID4gU28gaGF2
ZSBpc19jb25zdF96ZXJvKHgpIGFuZCBhZGQgaWZfY29uc3RfemVybyh4LCBpZl96LCBpZl9ueikg
bGF0ZXIuDQo+IA0KPiBPay4gU28gc29tZXRoaW5nIGxpa2UgdGhpcyBzZWVtcyB0byBnaXZlIHVz
IHRoZSByZWxldmFudCBjYXNlczoNCj4gDQo+ICAgI2RlZmluZSBfX2lzX2NvbnN0X3plcm8oeCkg
XA0KPiAgICAgICAgIF9HZW5lcmljKDA/KHZvaWQgKikobG9uZykoeCk6KGNoYXIgKikwLCBjaGFy
ICo6MSwgdm9pZCAqOjApDQo+IA0KPiAgICNkZWZpbmUgaXNfY29uc3RfemVybyh4KSBfX2lzX2Nv
bnN0X3plcm8oISEoeCkpDQo+ICAgI2RlZmluZSBpc19jb25zdF90cnVlKHgpIF9faXNfY29uc3Rf
emVybyghKHgpKQ0KPiAgICNkZWZpbmUgaXNfY29uc3QoeCkgX19pc19jb25zdF96ZXJvKDAqISh4
KSkNCj4gDQo+IGFuZCBzaG91bGQgd29yayB3aXRoIGFsbCBzY2FsYXIgZXhwcmVzc2lvbnMgdGhh
dCBJIGNhbiB0aGluayBvZiAob2ssDQo+IHRlY2huaWNhbGx5ICd2b2lkJyBpcyBhIHNjYWxhciB0
eXBlIGFuZCBpdCBvYnZpb3VzbHkgd29uJ3Qgd29yayB3aXRoDQo+IHRoYXQpLiBBbmQgc2hvdWxk
IHdvcmsgaW4gYWxsIGNvbnRleHRzLg0KDQpTZWVtcyBhIHJlYXNvbmFibGUgc2V0Lg0KDQpNYXli
ZSB0aGV5IG5lZWQgYSBzZXQgdGhhdCBhcmUgcGFpcmVkIHdpdGggX19CVUlMRF9CVUdfT05fWkVS
T19NU0coKQ0KdG8gZ2VuZXJhdGUgYW4gZXJyb3IgbWVzc2FnZSBvbiBmYWlsdXJlLg0KDQpBbHRo
b3VnaCBJIHdvdWxkIGFkZCBhIGZldyBtb3JlICcgJyBjaGFyYWN0ZXJzIGZvciByZWFkYWJpbGl0
eS4NCg0KPiBJdCBkb2VzIHdhbnQgYSBjb21tZW50IChpbiBhZGRpdGlvbiB0byB0aGUgY29tbWVu
dCBhYm91dCBob3cgTlVMTCBpcw0KPiBzcGVjaWFsIGZvciB0aGUgdGVybmFyeSBvcCB0aGF0IG1h
a2VzIGl0IHdvcmspOiB0aGUgJyhsb25nKScgY2FzdCBpcw0KPiBzbyB0aGF0IHRoZXJlIGFyZSBu
byB3YXJuaW5ncyBmb3IgY2FzdGluZyB0byAndm9pZCAqJyB3aGVuIGl0J3MgKm5vdCoNCj4gYSBj
b25zdGFudCB6ZXJvIGV4cHJlc3Npb24sIGFuZCB0aGUgJyEnIHBhdHRlcm4gaXMgdG8gdHVybiBw
b2ludGVycw0KPiBhbmQgaHVnZSBjb25zdGFudHMgaW50byAnaW50JyB3aXRob3V0IGxvc3Mgb2Yg
aW5mb3JtYXRpb24gYW5kIHdpdGhvdXQNCj4gd2FybmluZ3MuDQoNClRoZSBjb21tZW50cyB3b3Vs
ZCBuZWVkIHRvIGJlIHRlcnNlIG9uZS1saW5lcnMuDQoNCkkgd29uZGVyIGlmIGl0IHJlYWRzIGJl
dHRlciAoYW5kIHdpdGhvdXQgZXh0cmEgY29tbWVudHMpIGlmIHRoZSAobG9uZykNCmNhc3QgaXMg
cmVtb3ZlZCBhbmQgdGhlICdjYWxsZXJzJyBhcmUgcmVxdWlyZWQgdG8gZ2VuZXJhdGUgJ2xvbmcn
IGFyZ3MuDQpTbyB5b3UgaGF2ZToNCg0KI2RlZmluZSBfX2lzX2NvbnN0X3plcm8oeCkgXA0KCV9H
ZW5lcmljKDAgPyAodm9pZCAqKSh4KSA6IChjaGFyICopMCwgY2hhciAqOiAxLCB2b2lkICo6IDAp
DQogDQojZGVmaW5lIGlzX2NvbnN0X3plcm8oeCkgX19pc19jb25zdF96ZXJvKCh4KSA/IDFMIDog
MEwpDQojZGVmaW5lIGlzX2NvbnN0X3RydWUoeCkgX19pc19jb25zdF96ZXJvKCh4KSA/IDBMIDog
MUwpDQojZGVmaW5lIGlzX2NvbnN0KHgpIF9faXNfY29uc3RfemVybygoeCkgPyAwTCA6IDBMKQ0K
DQpJJ3ZlIGRvbmUgYSBxdWljayB0ZXN0IG9mIHRoZSBsYXN0IG9uZSBpbiBnb2Rib2x0Lg0KDQoJ
RGF2aWQNCg0KPiANCj4gQ29tcG91bmQgdHlwZXMgb2J2aW91c2x5IHdpbGwgZ2VuZXJhdGUgYSB3
YXJuaW5nLiBBcyB0aGV5IHNob3VsZC4NCj4gDQo+IFRoZSBhYm92ZSBsb29rcyByZWFzb25hYmxl
IHRvIG1lLCBidXQgSSBkaWRuJ3QgYWN0dWFsbHkgdGVzdCBhbnkgb2YgaXQNCj4gaW4gdGhlIGFj
dHVhbCBrZXJuZWwgYnVpbGQuDQo+IA0KPiAgICAgICAgICAgICAgTGludXMNCg0KLQ0KUmVnaXN0
ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBL
ZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

