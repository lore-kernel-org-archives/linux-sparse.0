Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A60AC433E0
	for <linux-sparse@archiver.kernel.org>; Fri,  5 Mar 2021 09:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A473F64F70
	for <linux-sparse@archiver.kernel.org>; Fri,  5 Mar 2021 09:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhCEJUH (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 5 Mar 2021 04:20:07 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:43024 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229829AbhCEJTs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 5 Mar 2021 04:19:48 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-241-o-O4hVraMoOIN9IEJ4mUjA-1; Fri, 05 Mar 2021 09:19:44 +0000
X-MC-Unique: o-O4hVraMoOIN9IEJ4mUjA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 5 Mar 2021 09:19:42 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 5 Mar 2021 09:19:42 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     Tom Tromey <tom@tromey.com>, Alexey Dobriyan <adobriyan@gmail.com>,
        "Luc Van Oostenryck" <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: RE: [PATCH 00/11] pragma once: treewide conversion
Thread-Topic: [PATCH 00/11] pragma once: treewide conversion
Thread-Index: AQHXEGou8CaNkZlisESRa9kfHm2udapz2QHwgABsngCAANnZIA==
Date:   Fri, 5 Mar 2021 09:19:42 +0000
Message-ID: <44a0cc9cb5344add8ee4d91bffbf958f@AcuMS.aculab.com>
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain>
 <CAHk-=wjFWZMVWTbvUMVxQqGKvGMC_BNrahCtTkpEjxoC0k-T=A@mail.gmail.com>
 <YDvwVlG/fqVxVYlQ@localhost.localdomain>
 <CAHk-=wi54DEScexxpMrO+Q2Nag_Tup+Y5YBHc_9_xGLeRfP8pA@mail.gmail.com>
 <877dmo10m3.fsf@tromey.com>
 <CAHk-=wi13+FLcRo4zmnRUmmY=AAns-Yd5NR_mVdcAd6ZrPq2fA@mail.gmail.com>
 <4835ec1d2ecc40b285596288a0df4f47@AcuMS.aculab.com>
 <CAHk-=wh8PptzH-=ak1D7C5Zp6EJ8eurYqVqGdQauupAFaNuG4g@mail.gmail.com>
In-Reply-To: <CAHk-=wh8PptzH-=ak1D7C5Zp6EJ8eurYqVqGdQauupAFaNuG4g@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDQgTWFyY2ggMjAyMSAyMDoxNg0KPiANCj4g
T24gVGh1LCBNYXIgNCwgMjAyMSBhdCA1OjU1IEFNIERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0
QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPiAgKGEpIHRoZSB0cmFkaXRpb25hbCBpbmNs
dWRlIGd1YXJkIG9wdGltaXphdGlvbiBIQVMgTk8gSElEREVOIFNFTUFOVElDDQo+ID4gPiBNRUFO
SU5HLiBJdCdzIGEgcHVyZSBvcHRpbWl6YXRpb24gdGhhdCBkb2Vzbid0IGFjdHVhbGx5IGNoYW5n
ZQ0KPiA+ID4gYW55dGhpbmcgZWxzZS4gSWYgeW91IGRvbid0IGRvIHRoZSBvcHRpbWl6YXRpb24s
IGFic29sdXRlbHkgbm90aGluZw0KPiA+ID4gY2hhbmdlcy4NCj4gPg0KPiA+IEFuZCBpZiB0aGUg
cGFyc2VyIGlzIHdlbGwgd3JpdHRlbiB0aGUgb3B0aW1pc2F0aW9uIGlzIHByb2JhYmx5DQo+ID4g
aXJyZWxldmFudCBjb21wYXJlZCB0byB0aGUgY29tcGlsZSB0aW1lLg0KPiANCj4gVGhhdCdzIGFj
dHVhbGx5IHN1cnByaXNpbmdseSBub3QgZXZlbiByZW1vdGVseSB0cnVlLg0KDQpUaGUgcG9pbnQg
aXMgdGhhdCB5b3UgY2FuIHNraXAgdGhlIHVud2FudGVkIHBhcnRzIG9mDQojaWYgd2l0aG91dCBo
YXZpbmcgdG8gcGFyc2UgdGhlIGZpbGUgYXQgYWxsLg0KWW91IGp1c3QgbmVlZCB0byBkZXRlY3Qg
dGhlIGxpbmUgYnJlYWtzLg0KDQpTbyB5ZXMsIHlvdSBuZWVkIHRvIHJlYWQgdGhlIGZpbGUgYW5k
IGxvb2sgYXQgZXZlcnkgYnl0ZS4NCkJ1dCB5b3UgZG9uJ3QgbmVlZCB0byBldmVuIHN0YXJ0IHRv
a2VuaXNpbmcgaXQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUs
IEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJl
Z2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

