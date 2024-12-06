Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453D21FA172
	for <linux-sparse@vger.kernel.org>; Fri,  6 Dec 2024 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733477706; cv=none; b=oMymNDf8QDXDDrmR3UcnwjorvyHbOYcOK510PuSkJFbzpa8pch4oAj7PcNZ6TR331brzXdVcWVb4i9MQx3gWqJr7JrDkRhVdnBi821tLvqKYijU0nmm/G4nNw5pwAxsy25SChS6si6VRDyoFvZ433i7w7xdJVlTpIJrResR/7H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733477706; c=relaxed/simple;
	bh=SFQA6iOLYo0SCjZeL+gF6rG0AM1b70ICi54Jp/cd2fY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Fk6aFCpw7JVbncNcwyl0KY5yk7WrCkmCEe2Pzo4k/Hm81HcZPpIyNN08yBy54FITxa6heQUYRe3RguLqmy1oJCDOmzaWDnhfRMPU17sLYoSTHpjohQ5Ds23bWPn63LS5RaIdPoFz9v8o7mgxKud5UuJJWYetpx0d6mcyYHDPDbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-315-JT-U8hVaNj28TFwmYvvp_A-1; Fri, 06 Dec 2024 09:35:01 +0000
X-MC-Unique: JT-U8hVaNj28TFwmYvvp_A-1
X-Mimecast-MFC-AGG-ID: JT-U8hVaNj28TFwmYvvp_A
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 6 Dec
 2024 09:34:15 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 6 Dec 2024 09:34:15 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Vincent Mailhol' <mailhol.vincent@wanadoo.fr>, 'Martin Uecker'
	<muecker@gwdg.de>
CC: 'Linus Torvalds' <torvalds@linux-foundation.org>, 'Luc Van Oostenryck'
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
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 02/10] compiler.h: add is_const() as a replacement of
 __is_constexpr()
Thread-Topic: [PATCH 02/10] compiler.h: add is_const() as a replacement of
 __is_constexpr()
Thread-Index: AQHbROFPJXcuwP9wN0+yRzIQ2cx/pbLWa+gggAFf14CAACMqUIABAFYQ
Date: Fri, 6 Dec 2024 09:34:15 +0000
Message-ID: <6576cf10fc424eab874a31714e60474b@AcuMS.aculab.com>
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr>
 <1d807c7471b9434aa8807e6e86c964ec@AcuMS.aculab.com>
 <CAMZ6RqLJLP+4d8f5gLfBdFeDVgqy23O+Eo8HRgKCthqBjSHaaw@mail.gmail.com>
 <9ef03cebb4dd406885d8fdf79aaef043@AcuMS.aculab.com>
In-Reply-To: <9ef03cebb4dd406885d8fdf79aaef043@AcuMS.aculab.com>
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
X-Mimecast-MFC-PROC-ID: 96_JhvMop1GFG3GhsNuc6G7QjSq8iqhbr7J6ZiKHz4M_1733477699
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogRGF2aWQgTGFpZ2h0DQo+IFNlbnQ6IDA2IERlY2VtYmVyIDIwMjQgMDI6MjYNCg0KKG5v
dyBpdCBpcyBubyBsb25nZXIgMmFtLi4uKQ0KDQpMaW51cyBzdWdnZXN0ZWQgdGhpcyBhIHdoaWxl
IGJhY2s6DQoNCj4gIGluIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9DQUhrLT13aXE9R1VO
V0p3V2gxQ1JBWWNoVzczVW1PYVNrYUNvdkxhdGZES2V2ZVpjdEFAbWFpbC5nbWFpbC5jb20vDQo+
IA0KPiAgICAvKg0KPiAgICAgKiBpZmYgJ3gnIGlzIGEgbm9uLXplcm8gY29uc3RhbnQgaW50ZWdl
ciBleHByZXNzaW9uLA0KPiAgICAgKiB0aGVuICchKHgpJyB3aWxsIGJlIGEgemVybyBjb25zdGFu
dCBpbnRlZ2VyIGV4cHJlc3Npb24sDQo+ICAgICAqIGFuZCBjYXN0aW5nIHRoYXQgdG8gJ3ZvaWQg
Kicgd2lsbCByZXN1bHQgaW4gYSBOVUxMIHBvaW50ZXIuDQo+ICAgICAqIE90aGVyd2lzZSBjYXN0
aW5nIGl0IHRvICd2b2lkIConIHdpbGwgYmUganVzdCBhIHJlZ3VsYXIgJ3ZvaWQgKicuDQo+ICAg
ICAqDQo+ICAgICAqIFRoZSB0eXBlIG9mICcwID8gTlVMTCA6IChjaGFyICopJyBpcyAnY2hhciAq
Jw0KPiAgICAgKiBUaGUgdHlwZSBvZiAnMCA/ICh2b2lkICopIDogKGNoYXIgKikgaXMgJ3ZvaWQg
KicNCj4gICAgICovDQo+ICAgICAjZGVmaW5lIGNvbnN0X3RydWUoeCkgXA0KPiAgICAgICAgIF9H
ZW5lcmljKDAgPyAodm9pZCAqKSgobG9uZykhKHgpKSA6IChjaGFyICopMCwgY2hhciAqOiAxLCB2
b2lkICo6IDApDQoNCkJ1dCBzb21lIG9mIHRoZSB0aGluZ3MgYnVpbHQgb24gaXQgaGFzIGlzc3Vl
cyB3aXRoIGNvbXBpbGVyIHdhcm5pbmdzLg0KSSB0aGluayB0aGVyZSBoYXZlIHNldmVyYWwgdmFy
aWF0aW9ucyBiZWZvcmUgYW5kIHNpbmNlIHdpdGggc3VidGxlIGRpZmZlcmVuY2VzLg0KUHJvYmFi
bHkgY29uc3RfemVybygpIGNvbnN0X3RydWUoKSBjb25zdF9mYWxzZSgpIGFuZCBjb25zdF9leHBy
KCkuDQoNCldoaWxlIHRoZSAnYmFzZScgZGVmaW5lIGlzIHJlYWxseSBjb25zdF96ZXJvKCkgd2l0
aCBqdXN0IChsb25nKSh4KSB0aGF0DQp3aWxsIG1hc2sgaGlnaCBiaXRzIG9mZiAnbG9uZyBsb25n
Jy4gDQpBIGNvbnN0X2ZhbHNlKCkgY291bGQgJ2ZpeCcgdGhhdCB1c2luZyAobG9uZykhISh4KSBi
dXQgZXZlbiAhKHgpIHN0YXJ0cw0KZ2l2aW5nIGNvbXBpbGUgZXJyb3JzLg0KDQpJZiBjYWxsZWQg
Zm9yIHBvaW50ZXJzIChsb25nKSgoeCkgPT0gMCkgaXMgYWxzbyBwcm9ibGVtYXRpYy4NCihQZXJo
YXBzIHRoaXMgaXMgbGVzcyBsaWtlbHkgbm93IHRoYXQgbWluL21heCBkb24ndCB1c2UgaXQuKQ0K
DQpTbyB3ZSBtYXkgZW5kIHVwIHdpdGggKGxvbmcpKCh4KSA/IDAgOiAxKSB3aGljaCByZWFsbHkg
bWlnaHQgYXMNCndlbGwgYmUgd3JpdHRlbiAoKHgpID8gMEwgOiAxTCkuDQoNClRoZSB1c2UgaXMg
bGlrZWx5IHRvIGJlIGNvbnN0X3RydWUoeCA+IHkpIHNvIHBlcmhhcHMgdGhlcmUgaXNuJ3QgYQ0K
cmVhc29uIHRvIGhhdmUgY29uc3RfZmFsc2UoKSBzaW5jZSB0aGUgYm9vbGVhbiBvcGVyYXRvciBj
YW4gYmUgaW52ZXJ0ZWQuDQoNCmNvbnN0X2V4cHIoKSBoYXMgcmVsaWVkIG9uICcqIDAnIHRvIG1h
a2UgYWxsIGNvbnN0YW50IGV4cHJlc3Npb25zIHplcm8uDQpCdXQgaXQgaGFzIHRvIGhhbmRsZSBw
b2ludGVycyAtIHNvIG5lZWRzIGEgY29uZGl0aW9uYWwuDQpTaW5jZSBpdCBpcyBvbmx5IG9uZSBs
aW5lLCBtYXliZSBqdXN0IHJlcGxpY2F0ZSB0aGUgd2hvbGUgdGhpbmcgYXM6DQoNCiNkZWZpbmUg
Y29uc3RfdHJ1ZSh4KSBfR2VuZXJpYygwID8gKHZvaWQgKikoKHgpID8gMEwgOiAxTCkgOiAoY2hh
ciAqKTAsIGNoYXIgKjogMSwgdm9pZCAqOiAwKQ0KI2RlZmluZSBjb25zdF9leHByKHgpIF9HZW5l
cmljKDAgPyAodm9pZCAqKSgoeCkgPyAwTCA6IDBMKSA6IChjaGFyICopMCwgY2hhciAqOiAxLCB2
b2lkICo6IDApDQoNCk9yIG1heWJlIChtb3N0bHkgYmVjYXVzZSB0aGUgbGluZXMgYXJlIHNob3J0
ZXIpOg0KI2RlZmluZSBjb25zdF9OVUxMKHgpIF9HZW5lcmljKDAgPyAoeCkgOiAoY2hhciAqKTAs
IGNoYXIgKjogMSwgdm9pZCAqOiAwKQ0KI2RlZmluZSBjb25zdF90cnVlKHgpIGNvbnN0X05VTEwo
KHZvaWQgKikoeCkgPyAwTCA6IDFMKSkNCiNkZWZpbmUgY29uc3RfZXhwcih4KSBjb25zdF9OVUxM
KCh2b2lkICopKHgpID8gMEwgOiAwTCkpDQoNCk9yIGV2ZW46DQojZGVmaW5lIGNvbnN0X3RydWUo
eCkgY29uc3RfTlVMTCgoeCkgPyBOVUxMIDogKHZvaWQgKikxTCkpDQojZGVmaW5lIGNvbnN0X2V4
cHIoeCkgY29uc3RfTlVMTCgoeCkgPyBOVUxMIDogTlVMTCkpDQoNCglEYXZpZA0KDQotDQpSZWdp
c3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9u
IEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

