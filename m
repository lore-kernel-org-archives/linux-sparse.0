Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3748C433DB
	for <linux-sparse@archiver.kernel.org>; Thu,  4 Mar 2021 13:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 815BD64EBB
	for <linux-sparse@archiver.kernel.org>; Thu,  4 Mar 2021 13:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239520AbhCDN5H (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 4 Mar 2021 08:57:07 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:29529 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239304AbhCDN4u (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 4 Mar 2021 08:56:50 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-284-gD3OTIPsPC6vR-QWqianTw-1; Thu, 04 Mar 2021 13:55:11 +0000
X-MC-Unique: gD3OTIPsPC6vR-QWqianTw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 4 Mar 2021 13:55:12 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 4 Mar 2021 13:55:12 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Tom Tromey <tom@tromey.com>
CC:     Alexey Dobriyan <adobriyan@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: RE: [PATCH 00/11] pragma once: treewide conversion
Thread-Topic: [PATCH 00/11] pragma once: treewide conversion
Thread-Index: AQHXEGou8CaNkZlisESRa9kfHm2udapz2QHw
Date:   Thu, 4 Mar 2021 13:55:12 +0000
Message-ID: <4835ec1d2ecc40b285596288a0df4f47@AcuMS.aculab.com>
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain>
 <CAHk-=wjFWZMVWTbvUMVxQqGKvGMC_BNrahCtTkpEjxoC0k-T=A@mail.gmail.com>
 <YDvwVlG/fqVxVYlQ@localhost.localdomain>
 <CAHk-=wi54DEScexxpMrO+Q2Nag_Tup+Y5YBHc_9_xGLeRfP8pA@mail.gmail.com>
 <877dmo10m3.fsf@tromey.com>
 <CAHk-=wi13+FLcRo4zmnRUmmY=AAns-Yd5NR_mVdcAd6ZrPq2fA@mail.gmail.com>
In-Reply-To: <CAHk-=wi13+FLcRo4zmnRUmmY=AAns-Yd5NR_mVdcAd6ZrPq2fA@mail.gmail.com>
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

PiAgKGEpIHRoZSB0cmFkaXRpb25hbCBpbmNsdWRlIGd1YXJkIG9wdGltaXphdGlvbiBIQVMgTk8g
SElEREVOIFNFTUFOVElDDQo+IE1FQU5JTkcuIEl0J3MgYSBwdXJlIG9wdGltaXphdGlvbiB0aGF0
IGRvZXNuJ3QgYWN0dWFsbHkgY2hhbmdlDQo+IGFueXRoaW5nIGVsc2UuIElmIHlvdSBkb24ndCBk
byB0aGUgb3B0aW1pemF0aW9uLCBhYnNvbHV0ZWx5IG5vdGhpbmcNCj4gY2hhbmdlcy4NCg0KQW5k
IGlmIHRoZSBwYXJzZXIgaXMgd2VsbCB3cml0dGVuIHRoZSBvcHRpbWlzYXRpb24gaXMgcHJvYmFi
bHkNCmlycmVsZXZhbnQgY29tcGFyZWQgdG8gdGhlIGNvbXBpbGUgdGltZS4NCg0KT1RPSCB0aGF0
IHByb2JhYmx5IHJlcXVpcmVzIHVzaW5nIG1tYXAoKSwgbWVtY2hyKCdcbicpIHRvIGxvb2sNCmZv
ciBsaW5lIHN0YXJ0cywgYSBmYXN0IHNlYXJjaCBmb3IgJ1sgXSojJyBmb2xsb3dlZCBieSBlbHNl
L2VuZGlmDQphbmQgYSBmaW5hbCBob3JyaWQgYmFja3dhcmRzIGNoZWNrIGZvciBhIGNvbnRpbnVh
dGlvbiBsaW5lLg0KDQpUaGF0IG9wdGltaXNhdGlvbiB3aWxsIGdlbmVyYWxseSBzcGVlZCB1cCBo
ZWFkZXIgZmlsZSBwcm9jZXNzaW5nLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

