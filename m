Return-Path: <SRS0=NWui=DH=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6612AC4727F
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 08:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 326BC2184D
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 08:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgI3Id3 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 30 Sep 2020 04:33:29 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:31579 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725779AbgI3Id2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Sep 2020 04:33:28 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-83-EbugMQlIMW-FPsA0z6KcqA-1; Wed, 30 Sep 2020 09:33:21 +0100
X-MC-Unique: EbugMQlIMW-FPsA0z6KcqA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 30 Sep 2020 09:33:20 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 30 Sep 2020 09:33:20 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nick Desaulniers' <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: RE: [PATCH] compiler.h: avoid escaped section names
Thread-Topic: [PATCH] compiler.h: avoid escaped section names
Thread-Index: AQHWlpjOE9lfY6yt4U2SwZo4K9hqIKmA2qhg
Date:   Wed, 30 Sep 2020 08:33:20 +0000
Message-ID: <059f629fcf5a4fe0825287a44fd24f52@AcuMS.aculab.com>
References: <20200929194318.548707-1-ndesaulniers@google.com>
In-Reply-To: <20200929194318.548707-1-ndesaulniers@google.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

RnJvbTogTmljayBEZXNhdWxuaWVycw0KPiBTZW50OiAyOSBTZXB0ZW1iZXIgMjAyMCAyMDo0Mw0K
PiANCj4gVGhlIHN0cmluZ2lmaWNhdGlvbiBvcGVyYXRvciwgYCNgLCBpbiB0aGUgcHJlcHJvY2Vz
c29yIGVzY2FwZXMgc3RyaW5ncy4NCj4gRm9yIGV4YW1wbGUsIGAjICJmb28iYCBiZWNvbWVzIGAi
XCJmb29cIiJgLiAgR0NDIGFuZCBDbGFuZyBkaWZmZXIgaW4gaG93DQo+IHRoZXkgdHJlYXQgc2Vj
dGlvbiBuYW1lcyB0aGF0IGNvbnRhaW4gXCIuDQo+IA0KPiBUaGUgcG9ydGFibGUgc29sdXRpb24g
aXMgdG8gbm90IHVzZSBhIHN0cmluZyBsaXRlcmFsIHdpdGggdGhlDQo+IHByZXByb2Nlc3NvciBz
dHJpbmdpZmljYXRpb24gb3BlcmF0b3IuDQo+IA0KPiBJbiB0aGlzIGNhc2UsIHNpbmNlIF9fc2Vj
dGlvbiB1bmNvbmRpdGlvbmFsbHkgdXNlcyB0aGUgc3RyaW5naWZpY2F0aW9uDQo+IG9wZXJhdG9y
LCB3ZSBhY3R1YWxseSB3YW50IHRoZSBtb3JlIHZlcmJvc2UNCj4gX19hdHRyaWJ1dGVfXygoX19z
ZWN0aW9uX18oKSkpLg0KPiANCj4gTGluazogaHR0cHM6Ly9idWdzLmxsdm0ub3JnL3Nob3dfYnVn
LmNnaT9pZD00Mjk1MA0KPiBGaXhlczogY29tbWl0IGUwNDQ2MmZiODJmOCAoIkNvbXBpbGVyIEF0
dHJpYnV0ZXM6IHJlbW92ZSB1c2VzIG9mIF9fYXR0cmlidXRlX18gZnJvbSBjb21waWxlci5oIikN
Cj4gU2lnbmVkLW9mZi1ieTogTmljayBEZXNhdWxuaWVycyA8bmRlc2F1bG5pZXJzQGdvb2dsZS5j
b20+DQo+IC0tLQ0KPiAgaW5jbHVkZS9saW51eC9jb21waWxlci5oIHwgMiArLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9jb21waWxlci5oIGIvaW5jbHVkZS9saW51eC9jb21waWxlci5oDQo+
IGluZGV4IDkyZWYxNjNhNzQ3OS4uYWM0NWY2ZDQwZDM5IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRl
L2xpbnV4L2NvbXBpbGVyLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9jb21waWxlci5oDQo+IEBA
IC0xNTUsNyArMTU1LDcgQEAgdm9pZCBmdHJhY2VfbGlrZWx5X3VwZGF0ZShzdHJ1Y3QgZnRyYWNl
X2xpa2VseV9kYXRhICpmLCBpbnQgdmFsLA0KPiAgCWV4dGVybiB0eXBlb2Yoc3ltKSBzeW07CQkJ
CQlcDQo+ICAJc3RhdGljIGNvbnN0IHVuc2lnbmVkIGxvbmcgX19rZW50cnlfIyNzeW0JCVwNCj4g
IAlfX3VzZWQJCQkJCQkJXA0KPiAtCV9fc2VjdGlvbigiX19fa2VudHJ5IiAiKyIgI3N5bSApCQkJ
XA0KPiArCV9fYXR0cmlidXRlX18oKF9fc2VjdGlvbl9fKCJfX19rZW50cnkrIiAjc3ltKSkpCQlc
DQo+ICAJPSAodW5zaWduZWQgbG9uZykmc3ltOw0KPiAgI2VuZGlmDQoNCkkgZ3Vlc3Mgd2hhdCB0
aGlzIHJlYWxseSB3YW50cyBpczoNCglfX3NlY3Rpb24oX19rZW50cnkrIyNzeW0pDQpidXQgdGhh
dCBnZW5lcmF0ZXMgYW4gZXJyb3IgYmVjYXVzZSB5b3UgY2FuIG9ubHkgdXNlICMjIGJldHdlZW4N
CnZhcmlhYmxlIG5hbWVzLg0KDQpQZXJoYXBzIHNvbWVvbmUgc2hvdWxkbid0IGhhdmUgdHJpZXMg
dG8gYmUgY2xldmVyIGFuZCBub3QgcHV0DQphbiB1bnVzdWFsIGNoYXJhY3RlciBpbiB0aGUgc2Vj
dGlvbiBuYW1lLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBC
cmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdp
c3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

