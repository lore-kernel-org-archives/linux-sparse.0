Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B8F45005
	for <linux-sparse@vger.kernel.org>; Sat,  7 Dec 2024 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733570399; cv=none; b=LmZ3DFw93IO6ANA/ad6Cbq3V/H9fXmO42lCokWQ1FVz2xntXdHaSsFsnAwGHOekPJedcj5OQ97mLvLzmyXk0UHh+3JHkqdUD5su/QgMtgk3cGd60Z57RFDge5JugsD7Z7ILxklvYWKsbeeIFq+PpDvGLu05r0G8BtSghGRqq2yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733570399; c=relaxed/simple;
	bh=Wt2ZHmxW6c/l0ZfetqXCLnlXK50FBLicV0IX1qwEeKI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=RxpLSrZuDJZ+h/mTkXdvqpv0bHKU71sbh1wT89LV5fGy+jud+E4i74wtzk6DYOE8woQ+Vw1nZgplwSK1HjZhUL4l9yjU9pcxFty0HyTLzbJesomL2yAPX2GP6JLUlvTq+9W0U44Ckj1Z5k5A1fCfQIeU2zNnNn/tx+y+CApdDTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-182-BmtRSwgZMaSkxWJpDbvf-w-1; Sat, 07 Dec 2024 11:19:55 +0000
X-MC-Unique: BmtRSwgZMaSkxWJpDbvf-w-1
X-Mimecast-MFC-AGG-ID: BmtRSwgZMaSkxWJpDbvf-w
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 7 Dec
 2024 11:19:05 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 7 Dec 2024 11:19:05 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Vincent Mailhol' <vincent.mailhol@gmail.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, "w@1wt.eu" <w@1wt.eu>
CC: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, "Bill
 Wendling" <morbo@google.com>, Justin Stitt <justinstitt@google.com>, "Yury
 Norov" <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
	<joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Rikard Falkeborn
	<rikard.falkeborn@gmail.com>, "linux-sparse@vger.kernel.org"
	<linux-sparse@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "coresight@lists.linaro.org"
	<coresight@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "uecker@tugraz.at" <uecker@tugraz.at>
Subject: RE: [PATCH 02/10] compiler.h: add is_const() as a replacement of
 __is_constexpr()
Thread-Topic: [PATCH 02/10] compiler.h: add is_const() as a replacement of
 __is_constexpr()
Thread-Index: AQHbROFPJXcuwP9wN0+yRzIQ2cx/pbLWa+gggAFf14CAACMqUIABpzoGgAAClHCAAAPoAIAAAwjggAANnsCAAMAogIAAM0Zw
Date: Sat, 7 Dec 2024 11:19:05 +0000
Message-ID: <b1ff4a65594a4d39b2e9b8b44770214e@AcuMS.aculab.com>
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
 <e806dd51b1ac4e289131297fbf30fc37@AcuMS.aculab.com>
 <CAMZ6RqLOR3aCRW_js2agV+VFiHdazb4S2+NdT5G4=WbDKNB8bA@mail.gmail.com>
In-Reply-To: <CAMZ6RqLOR3aCRW_js2agV+VFiHdazb4S2+NdT5G4=WbDKNB8bA@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: h25O9PF5Fe_hLbjsU7sIkHfIYvSFndb1-w-DsCxVniQ_1733570393
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogVmluY2VudCBNYWlsaG9sDQo+IFNlbnQ6IDA3IERlY2VtYmVyIDIwMjQgMDc6NDMNCi4u
Lg0KPiA+IFNvIG1heWJlIHRoZSBzbGlnaHRseSBsb25nIGxpbmVzOg0KPiA+ICNkZWZpbmUgY29u
c3RfdHJ1ZSh4KSBfR2VuZXJpYygwID8gKHZvaWQgKikoKHgpICsgMCA/IDBMIDogMUwpIDogKGNo
YXIgKikwLCBjaGFyICo6IDEsIHZvaWQgKjogMCkNCj4gPiAjZGVmaW5lIGNvbnN0X2V4cHIoeCkg
X0dlbmVyaWMoMCA/ICh2b2lkICopKCh4KSArIDAgPyAwTCA6IDBMKSA6IChjaGFyICopMCwgY2hh
ciAqOiAxLCB2b2lkICo6IDApDQoNCkNsZWFybHkgdGhleSBjYW4gYmUgaW1wbGVtZW50ZWQgaW4g
dGVybXMgb2YgYSBjb21tb24gZGVmaW5lLg0KQnV0IEkgZG9uJ3Qgc2VlIGEgbmVlZCBmb3IgYSBj
b25zdF96ZXJvKCkgYW5kIG5lc3RlZCBleHBhbnNpb25zIG1ha2UgZXh0cmENCndvcmsgZm9yIHRo
ZSBjb21waWxlci4NCg0KPiANCj4gVGhpcyBzdGlsbCB0aHJvd3MgYSAtV251bGwtcG9pbnRlci1h
cml0aG1ldGljIG9uIGNsYW5nIG9uIGNvbnN0X2V4cHIoTlVMTCk6DQo+ICAgaHR0cHM6Ly9nb2Ri
b2x0Lm9yZy96L3ZvNVc3ZWZkRQ0KDQpJIHdhcyB3b3JyaWVkIGFib3V0IHRoYXQgb25lLg0KDQo+
IEkganVzdCBkbyBub3Qgc2VlIGEgbWV0aG9kIHRvIHNpbGVuY2UgdGhhdCBvbmUuIFNvIHRocmVl
IG9wdGlvbnM6DQo+IA0KPiAgIDEuIGlzX2NvbnN0KCkgZG9lcyBub3QgYWNjZXB0IHBvaW50ZXJz
IGFuZCB0aHJvd3MgYSBjb25zdHJhaW50IHZpb2xhdGlvbjoNCj4gICAgICAgICNkZWZpbmUgaXNf
Y29uc3QoeCkgX19pc19jb25zdF96ZXJvKDAgKiAoeCkpDQo+ICAgICAgVGhpcyBpcyBteSBjdXJy
ZW50IHBhdGNoLg0KDQpJcyB0aGF0IGdvaW5nIHRvIGFmZmVjdCB0aGluZ3MgbGlrZSBjb25zdF90
cnVlKHggPDwgeSk/DQpEaXNhbGxvd2luZyB0aGF0IHNlZW1zIGNvdW50ZXItcHJvZHVjdGl2ZS4N
CihSZW1lbWJlciBpdCBtaWdodCBiZSBwYXNzZWQgaW50byBhICNkZWZpbmUgdGhhdCBpcyB0aGVu
DQpjaGVja2luZyBpdHMgYXJndW1lbnQgZm9yIGJlaW5nIGNvbnN0YW50LikNCg0KPiAgIDIuIGlz
X2NvbnN0KCkgYWNjZXB0IHBvaW50ZXJzIGJ1dCBpc19jb25zdChOVUxMKSByZXR1cm5zIGZhbHNl
Og0KPiAgICAgICAgI2RlZmluZSBpc19jb25zdCh4KSBfX2lzX2NvbnN0X3plcm8oKHgpICE9ICh4
KSkNCj4gICAgICBUaGlzIGtlZXBzIHRoZSBjdXJyZW50IF9faXNfY29uc3RleHByKCkgYmVoYXZp
b3VyLg0KDQpObyBnb29kIC0gZXhwYW5kcyBldmVyeXRoaW5nIHR3aWNlLg0KDQo+ICAgMy4gaXNf
Y29uc3QoKSBhY2NlcHRzIHBvaW50ZXJzIGFuZCBpc19jb25zdChOVUxMKSByZXR1cm4gdHJ1ZToN
Cj4gDQo+ICAgICAgICAjZGVmaW5lIGNvbnN0X2V4cHIoeCkgX0dlbmVyaWMoMCA/ICh2b2lkICop
KCh4KSArIDAgPyAwTCA6IDBMKQ0KPiA6IChjaGFyICopMCwgY2hhciAqOiAxLCB2b2lkICo6IDAp
DQo+IA0KPiAgICAgIERhdmlkJ3MgbGF0ZXN0IHByb3Bvc2FsLCBpdCByZXF1aXJlcyB0byByZW1v
dmUgdGhlDQo+ICAgICAgLVdudWxsLXBvaW50ZXItYXJpdGhtZXRpYyBjbGFuZyB3YXJuaW5nLg0K
DQpPbmx5IGZvciBjb25zdF9leHByKE5VTEwpIC0gYW5kIHNpbmNlIGNsYW5nIGdldHMgdGhhdCB3
cm9uZw0KbWF5YmUgdGhlIHdhcm5pbmcgaXMgYSBnb29kIHRoaW5nLg0KDQpZb3UgY2FuIGp1c3Qg
YWRkOg0KI2RlZmluZSBjb25zdF9OVUxMKHB0cikgY29uc3RfdHJ1ZSghKHB0cikpDQpQcm9iYWJs
eSB0aGUgb25seSBwbGFjZSB3aGVyZSB5b3UgYWN0dWFsbHkgd2FudCB0byB0ZXN0IGZvciB6ZXJv
Lg0KDQo+IA0KPiBJIHZvdGUgZm9yIDEuIG9yIDIuICh3aXRoIGEgcHJlZmVyZW5jZSBmb3IgMS4p
LiBJTUhPLCB3ZSBhcmUganVzdA0KPiBhZGRpbmcgYW4gdW5yZWFzb25hYmxlIGxldmVsIG9mIGNv
bXBsZXhpdHkgZm9yIG1ha2luZyB0aGUgbWFjcm8gdHJlYXQNCj4gTlVMTCBhcyBhbiBpbnRlZ2Vy
LiBXb3VsZCBzb21lb25lIGZpbmQgYSBzb2x1dGlvbiBmb3IgMy4gdGhhdCBkb2VzIG5vdA0KPiB5
aWVsZCBhIHdhcm5pbmcsIHRoZW4gd2h5IG5vdC4gQnV0IGlmIHdlIGhhdmUgdG8gcmVtb3ZlIGEg
Y29tcGlsZXINCj4gY2hlY2sgZm9yIGEgdGhlb3JldGljYWwgdXNlIGNhc2UgdGhhdCBkb2VzIG5v
dCBldmVuIGV4aXN0IGluIHRoZQ0KPiBrZXJuZWwsIHRoZW4gaXQgaXMgbm90IHdvcnRoIHRoZSB0
cmFkZSBvZmYuDQo+IA0KPiBDb25jZXJuaW5nIGlzX2NvbnN0KHZhciA8PCAyKSwgdGhlIHBhdGNo
IEkgc3VibWl0dGVkIHdvcmtzIGZpbmUgYXMtaXMNCj4gd2l0aCBhbGwgc2NhbGFycyBpbmNsdWRp
bmcgdGhhdCAodmFyIDw8IDIpOg0KPiANCj4gICBodHRwczovL2dvZGJvbHQub3JnL3oveGVyNGFN
ZWVzDQo+IA0KPiBBbmQgY2FuIHdlIGlnbm9yZSB0aGUgY2FzZSAoISh2YXIgPDwgMikpPyBUaGlz
IGlzIG5vdCBhIHdhcm5pbmcNCj4gYmVjYXVzZSBvZiB0aGUgbWFjcm8sIGJ1dCBiZWNhdXNlIG9m
IHRoZSBjYWxsZXIhIElmIEkgZG8gYW55IG9mOg0KPiANCj4gICAgICAgICAgIGlmICghKHZhciA8
PCAyKSkge30NCj4gICAgICAgICAgICh2b2lkKV9fYnVpbHRpbl9jb25zdGFudF9wKCEodmFyIDw8
IDIpKTsNCj4gDQo+IEkgYWxzbyBnb3QgdGhlIHdhcm5pbmcuIFRoZSBwb2ludCBpcyB0aGF0IHRo
ZSBtYWNybyBzaG91bGQgbm90DQo+IGdlbmVyYXRlICpuZXcqIHdhcm5pbmdzLiBJZiB0aGUgZ2l2
ZW4gYXJndW1lbnQgYWxyZWFkeSByYWlzZXMgYQ0KPiB3YXJuaW5nLCBpdCBpcyB0aGUgY2FsbGVy
J3MgcmVzcG9uc2liaWxpdHkgdG8gZml4Lg0KDQpFeGNlcHQgaXQgY291bGQgZWFzaWx5IGhhcHBl
biB3YXkgaW5zaWRlIHNvbWUgb3RoZXIgZXhwYW5zaW9uLg0KUGVyaGFwcyBzb21lb25lIG9wdGlt
aXNlcyBmcm9ibmljYXRlKHgpIGZvciBjb25zdGFudCBpbnB1dC4NClN1ZGRlbmx5IGZyb2JuaWNh
dGUoISh2YXIgPDwgMikpIGdlbmVyYXRlcyBhIGNvbXBpbGUgZXJyb3IuDQoNCglEYXZpZA0KDQo+
IA0KPiANCj4gWW91cnMgc2luY2VyZWx5LA0KPiBWaW5jZW50IE1haWxob2wNCg0KLQ0KUmVnaXN0
ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBL
ZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

