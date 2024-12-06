Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0718E1714DF
	for <linux-sparse@vger.kernel.org>; Fri,  6 Dec 2024 20:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733516764; cv=none; b=Shcq0OMf0gT9gdu1IaILAMs1aNwDYy+ZoQRx5anf82NpWbnlaWdXDd/dZ9EHJuWwqkVib5yBlWn4E1cy6DeiuT441sVrjfYvMSv8li/dva23epxAISboLDb3X06xFYCsE71vcFJvoKGyPUaLjBU47YvIMniOudsRmaPTpVZ2LGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733516764; c=relaxed/simple;
	bh=Rbh5TWgsPQHCr8mZMQrSTFvQQ1zh/W5KLl3JgtcPfSk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=MU5g5kmPBKRGEUXCA5WS5SMPMgv9Xh/101LAhlikf0RCDw9q8nsSjXw0vRyyf554Akh3RsngNm9GAkLnFsn1kyxOd1oBvoxLDwBIdeTl5T1M1m66C+5XiDVX+bIDITDXw/Mc+UjtVR6Dm1OcbHZ1a8Qf1oKIISv1ddd/EkYc/WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-17-T5q5JrNWPoSE2npJYwkYcg-1; Fri, 06 Dec 2024 20:24:46 +0000
X-MC-Unique: T5q5JrNWPoSE2npJYwkYcg-1
X-Mimecast-MFC-AGG-ID: T5q5JrNWPoSE2npJYwkYcg
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 6 Dec
 2024 20:23:59 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 6 Dec 2024 20:23:59 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>
CC: 'Vincent Mailhol' <vincent.mailhol@gmail.com>, 'Luc Van Oostenryck'
	<luc.vanoostenryck@gmail.com>, 'Nathan Chancellor' <nathan@kernel.org>,
	"'Nick Desaulniers'" <ndesaulniers@google.com>, 'Bill Wendling'
	<morbo@google.com>, 'Justin Stitt' <justinstitt@google.com>, 'Yury Norov'
	<yury.norov@gmail.com>, 'Rasmus Villemoes' <linux@rasmusvillemoes.dk>, 'Kees
 Cook' <kees@kernel.org>, "'Gustavo A. R. Silva'" <gustavoars@kernel.org>,
	'Jani Nikula' <jani.nikula@linux.intel.com>, 'Joonas Lahtinen'
	<joonas.lahtinen@linux.intel.com>, 'Rodrigo Vivi' <rodrigo.vivi@intel.com>,
	'Tvrtko Ursulin' <tursulin@ursulin.net>, 'David Airlie' <airlied@gmail.com>,
	'Simona Vetter' <simona@ffwll.ch>, 'Suzuki K Poulose'
	<suzuki.poulose@arm.com>, 'Mike Leach' <mike.leach@linaro.org>, 'James Clark'
	<james.clark@linaro.org>, 'Alexander Shishkin'
	<alexander.shishkin@linux.intel.com>, 'Rikard Falkeborn'
	<rikard.falkeborn@gmail.com>, "'linux-sparse@vger.kernel.org'"
	<linux-sparse@vger.kernel.org>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>, "'llvm@lists.linux.dev'"
	<llvm@lists.linux.dev>, "'linux-hardening@vger.kernel.org'"
	<linux-hardening@vger.kernel.org>, "'intel-gfx@lists.freedesktop.org'"
	<intel-gfx@lists.freedesktop.org>, "'dri-devel@lists.freedesktop.org'"
	<dri-devel@lists.freedesktop.org>, "'coresight@lists.linaro.org'"
	<coresight@lists.linaro.org>, "'linux-arm-kernel@lists.infradead.org'"
	<linux-arm-kernel@lists.infradead.org>, "'uecker@tugraz.at'"
	<uecker@tugraz.at>
Subject: RE: [PATCH 02/10] compiler.h: add is_const() as a replacement of
 __is_constexpr()
Thread-Topic: [PATCH 02/10] compiler.h: add is_const() as a replacement of
 __is_constexpr()
Thread-Index: AQHbROFPJXcuwP9wN0+yRzIQ2cx/pbLWa+gggAFf14CAACMqUIABpzoGgAAClHCAAAPoAIAAAwjggAANnsA=
Date: Fri, 6 Dec 2024 20:23:59 +0000
Message-ID: <e806dd51b1ac4e289131297fbf30fc37@AcuMS.aculab.com>
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr>
 <1d807c7471b9434aa8807e6e86c964ec@AcuMS.aculab.com>
 <CAMZ6RqLJLP+4d8f5gLfBdFeDVgqy23O+Eo8HRgKCthqBjSHaaw@mail.gmail.com>
 <9ef03cebb4dd406885d8fdf79aaef043@AcuMS.aculab.com>
 <CAHk-=wjmeU6ahyuwAymqkSpxX-gCNa3Qc70UXjgnxNiC8eiyOw@mail.gmail.com>
 <CAMZ6Rq+SzTA25XcMZnMnOJcrrq1VZpeT1xceinarqbXgDDo8VA@mail.gmail.com>
 <CAHk-=wiP8111QZZJNbcDNsYQ_JC-xvwRKr0qV9UdKn3HKK+-4Q@mail.gmail.com>
 <d23fe8a5dbe84bfeb18097fdef7aa4c4@AcuMS.aculab.com>
 <CAHk-=win8afdcergvJ6f2=rRrff8giGUW62qmYs9Ae6aw=wcnA@mail.gmail.com>
 <0f5c07b827c3468c8fa3928a93a98bfa@AcuMS.aculab.com>
In-Reply-To: <0f5c07b827c3468c8fa3928a93a98bfa@AcuMS.aculab.com>
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
X-Mimecast-MFC-PROC-ID: n7jGz-HPjpDjr1iQRt7uPLeE-QQRtK1BH9suUX_1tAw_1733516685
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

Li4uDQo+ID4gPiAjZGVmaW5lIGNvbnN0X05VTEwoeCkgX0dlbmVyaWMoMCA/ICh4KSA6IChjaGFy
ICopMCwgY2hhciAqOiAxLCB2b2lkICo6IDApDQo+ID4gPiAjZGVmaW5lIGNvbnN0X3RydWUoeCkg
Y29uc3RfTlVMTCgoeCkgPyBOVUxMIDogKHZvaWQgKikxTCkpDQo+ID4gPiAjZGVmaW5lIGNvbnN0
X2V4cHIoeCkgY29uc3RfTlVMTCgoeCkgPyBOVUxMIDogTlVMTCkpDQo+ID4gPiBJIHNlbmQgdGhp
cyBtb3JuaW5nLg0KPiA+ID4gTmVlZHMgJ3MvY2hhci9zdHJ1Y3Qga2pramtqa2p1aS8nIGFwcGxp
ZWQuDQo+ID4NCj4gPiBPaCBDaHJpc3QuIFlvdSByZWFsbHkgYXJlIHRha2luZyB0aGlzIHdob2xl
IHVnbHkgdG8gYW5vdGhlciBsZXZlbC4NCj4gDQo+IEkgc29ydCBvZiBsaWtlZCB0aGF0IHZlcnNp
b24gaW4gYSBwZXJ2ZXJzZSBzb3J0IG9mIHdheS4NCj4gSXQgZG9lcyBnaXZlIHlvdSBhIHNpbXBs
ZSB0ZXN0IGZvciBOVUxMICh1bmxlc3MgeW91J3ZlIHVzZWQgJ3N0cnVjdCBramtqa2pranVpJyku
DQoNCkV4Y2VwdCBjb25zdF9OVUxMKCkgcmVhbGx5IGRvZXNuJ3Qgd29yayBhdCBhbGwgLSBzbyB5
b3UgYXJlIGx1Y2t5IDotKQ0KDQpTbyBtYXliZSB0aGUgc2xpZ2h0bHkgbG9uZyBsaW5lczoNCiNk
ZWZpbmUgY29uc3RfdHJ1ZSh4KSBfR2VuZXJpYygwID8gKHZvaWQgKikoKHgpICsgMCA/IDBMIDog
MUwpIDogKGNoYXIgKikwLCBjaGFyICo6IDEsIHZvaWQgKjogMCkNCiNkZWZpbmUgY29uc3RfZXhw
cih4KSBfR2VuZXJpYygwID8gKHZvaWQgKikoKHgpICsgMCA/IDBMIDogMEwpIDogKGNoYXIgKikw
LCBjaGFyICo6IDEsIHZvaWQgKjogMCkNCg0KSSBtYWtlIHRoYXQgOTggY2hhcmFjdGVycy4NCk9m
IGNvdXJzZSwgeW91IGNhbiByZW1vdmUgYWxsIHRoZSBzcGFjZXMsIG9ubHkgb25lIG9mIHRoZSBj
b25zdGFudHMgbmVlZCB0aGUgTCBzdWZmaXgNCmFuZCAnaW50JyBpcyBhIHNob3J0ZXIgdHlwZSBu
YW1lLg0KVGhhdCBjdXRzIGlzIGRvd24gdG8gNzY6DQojZGVmaW5lIGNvbnN0X2V4cHIoeCkgX0dl
bmVyaWMoMD8odm9pZCopKCh4KSswPzBMOjApOihpbnQqKTAsaW50KjoxLHZvaWQqOjApDQp3aGlj
aCBzdGFydHMgbG9va2luZyBsaWtlIHRoZSBURUNPIGNvbW1hbmRzIHRvIHBhcnNlIGl0cyBjb21t
YW5kIGxpbmUhDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJy
YW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lz
dHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

