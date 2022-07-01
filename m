Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B034AC433EF
	for <linux-sparse@archiver.kernel.org>; Fri,  1 Jul 2022 13:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiGANlM (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 1 Jul 2022 09:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiGANlL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 1 Jul 2022 09:41:11 -0400
X-Greylist: delayed 557 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Jul 2022 06:41:09 PDT
Received: from algol.kleine-koenig.org (algol.kleine-koenig.org [162.55.41.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6D615829
        for <linux-sparse@vger.kernel.org>; Fri,  1 Jul 2022 06:41:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by algol.kleine-koenig.org (Postfix) with ESMTP id 48BD44999B8;
        Fri,  1 Jul 2022 15:31:50 +0200 (CEST)
Received: from algol.kleine-koenig.org ([IPv6:::1])
        by localhost (algol.kleine-koenig.org [IPv6:::1]) (amavisd-new, port 10024)
        with ESMTP id 7k6TRpVWmYGB; Fri,  1 Jul 2022 15:31:49 +0200 (CEST)
Received: from taurus.defre.kleine-koenig.org (unknown [IPv6:2a02:8071:b7c0:8100:725c:297:eb88:6c8f])
        by algol.kleine-koenig.org (Postfix) with ESMTPSA;
        Fri,  1 Jul 2022 15:31:49 +0200 (CEST)
Message-ID: <e91d351c-3c16-e48d-7e9d-9f096c4acbc9@debian.org>
Date:   Fri, 1 Jul 2022 15:31:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] fix "unreplaced" warnings caused by using typeof() on
 inline functions
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Luc Van Oostenryck <lucvoo@kernel.org>
Cc:     linux-sparse@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        kernel test robot <lkp@intel.com>
References: <20220624164601.99527-1-lucvoo@kernel.org>
 <Yr7kPM1wLZnOqxOA@smile.fi.intel.com>
From:   =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <ukleinek@debian.org>
In-Reply-To: <Yr7kPM1wLZnOqxOA@smile.fi.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ecAb6Que8oWvZLd314m8sL3j"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ecAb6Que8oWvZLd314m8sL3j
Content-Type: multipart/mixed; boundary="------------hxAW5scPIQ0CuKuoz0y59Ljw";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <ukleinek@debian.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Luc Van Oostenryck <lucvoo@kernel.org>
Cc: linux-sparse@vger.kernel.org,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 kernel test robot <lkp@intel.com>
Message-ID: <e91d351c-3c16-e48d-7e9d-9f096c4acbc9@debian.org>
Subject: Re: [PATCH] fix "unreplaced" warnings caused by using typeof() on
 inline functions
References: <20220624164601.99527-1-lucvoo@kernel.org>
 <Yr7kPM1wLZnOqxOA@smile.fi.intel.com>
In-Reply-To: <Yr7kPM1wLZnOqxOA@smile.fi.intel.com>

--------------hxAW5scPIQ0CuKuoz0y59Ljw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNy8xLzIyIDE0OjEwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+IE9uIEZyaSwgSnVu
IDI0LCAyMDIyIGF0IDA2OjQ2OjAxUE0gKzAyMDAsIEx1YyBWYW4gT29zdGVucnljayB3cm90
ZToNCj4+IEZyb206IEx1YyBWYW4gT29zdGVucnljayA8bHVjLnZhbm9vc3RlbnJ5Y2tAZ21h
aWwuY29tPg0KPj4NCj4+IEN1cnJlbnRseSwgc3BhcnNlIGRvIGFsbCBpdHMgaW5saW5pbmcg
YXQgdGhlIHRyZWUgbGV2ZWwsIGR1cmluZw0KPj4gY29uc3RhbnQgZXhwYW5zaW9uLiBUbyBu
b3QgbWl4LXVwIHRoZSBldmFsdWF0aW9uIG9mIHRoZSBvcmlnaW5hbA0KPj4gZnVuY3Rpb24g
Ym9keSBpbiBjYXNlIHRoZSBhZGRyZXNzIG9mIGFuIGlubGluZSBmdW5jdGlvbiBpcyB0YWtl
biBvcg0KPj4gd2hlbiB0aGUgZnVuY3Rpb24gY2FuJ3Qgb3RoZXJ3aXNlIGJlIGlubGluZWQs
IHRoZSBzdGF0ZW1lbnRzIGFuZA0KPj4gc3ltYm9scyBsaXN0cyBvZiBpbmxpbmUgZnVuY3Rp
b25zIGFyZSBrZXB0IGluIHNlcGFyYXRlZCBmaWVsZHMuDQo+PiBUaGVuLCBpZiB0aGUgb3Jp
Z2luYWwgYm9keSBtdXN0IGJlIGV2YWx1YXRlZCBpdCBtdXN0IGZpcnN0IGJlDQo+PiAndW5p
bmxpbmVkJyB0byBoYXZlIGEgY29weSBpbiB0aGUgdXN1YWwgZmllbGRzLg0KPj4NCj4+IFRo
aXMgbWFrZSBzZW5zZSB3aGVuIGRlYWxpbmcgd2l0aCB0aGUgZGVmaW5pdGlvbiBvZiB0aGUg
ZnVuY3Rpb24uDQo+PiBCdXQsIHdoZW4gdXNpbmcgdHlwZW9mKCkgb24gZnVuY3Rpb25zLCB0
aGUgcmVzdWx0aW5nIHR5cGUgZG9lc24ndA0KPj4gcmVmZXIgdG8gdGhpcyBkZWZpbml0aW9u
LCBpdCdzIGp1c3QgYSBjb3B5IG9mIHRoZSB0eXBlIGFuZCBvbmx5DQo+PiBvZiB0aGUgdHlw
ZS4gVGhlcmUgc2hvdWxkbid0IGJlIGFueSByZWFzb25zIHRvIHVuaW5saW5lIGFueXRoaW5n
Lg0KPj4gSG93ZXZlciwgdGhlIGRpc3RpbmN0aW9uIGJldHdlZW4gJ2Z1bGwgZnVuY3Rpb24n
IGFuZCAndHlwZSBvbmx5Jw0KPj4gaXMgbm90IG1hZGUgZHVyaW5nIGV2YWx1YXRpb24gYW5k
IHRoZSB1bmlubGluaW5nIGF0dGVtcHQgcHJvZHVjZQ0KPj4gYSBsb3Qgb2YgIndhcm5pbmc6
IHVucmVwbGFjZWQgc3ltYm9sICcuLi4nIiBiZWNhdXNlIG9mIHRoZSBsYWNrDQo+PiBvZiBh
IGNvcnJlc3BvbmRpbmcgZGVmaW5pdGlvbi4NCj4+DQo+PiBGaXggdGhpcyBieSBub3QgZG9p
bmcgdGhlIHVuaW5saW5pbmcgaWYgdGhlIHN5bWJvbCBsYWNrIGEgZGVmaW5pdGlvbi4NCj4+
DQo+PiBOb3RlOiBJdCB3b3VsZCBtYXliZSBiZSBtb3JlIGFwcHJvcHJpYXRlIGZvciBFWFBS
X1RZUEUgdG8gdXNlDQo+PiAgICAgICAgYSBzdHJpcHBlZC1vd24gdmVyc2lvbiBvZiBldmFs
dWF0ZV9zeW1ib2woKSBkb2luZyBvbmx5IHRoZQ0KPj4gICAgICAgIGV4YW1pbmF0aW9uIG9m
IHRoZSByZXR1cm4gYW5kIGFyZ3VtZW50IHR5cGVzLCBieXBhc3NpbmcgdGhlDQo+PiAgICAg
ICAgYXR0ZW1wdCB0byB1bmlubGluZSB0aGUgYm9keSBhbmQgZXZhbHVhdGUgdGhlIGluaXRp
YWxpemVyIGFuZA0KPj4gICAgICAgIHRoZSBzdGF0ZW1lbnRzIHNpbmNlIHRoZXJlIGlzIG5v
bmUgb2YgdGhvc2UgZm9yIGFuIEVYUFJfVFlQRS4NCj4gDQo+IFV3ZSwgY2FuIHdlIGdldCBh
IERlYmlhbiBwYWNrYWdlIHdpdGggdGhpcyBmaXgsIGl0J3MgcmVhbGx5IGEgdG9ucyBvZiBz
dWNoDQo+IG1lc3NhZ2VzIHdoZW4gY29tcGlsZSBrZXJuZWwgd2l0aCBDPTE/DQoNCkx1Yywg
ZG8geW91IGNvbnNpZGVyIGl0IHNlbnNpYmxlIHRvIGNyZWF0ZSBhIDAuNi40IHZhcmlhbnQg
b2Ygc3BhcnNlIA0KdGhhdCBpbmNsdWRlcyB0aGlzIGZpeD8gQXJlIHRoZXJlIGFueSBtb3Jl
IHBhdGNoZXMgdGhhdCB5b3UnZCBkZWVtIA0Kc2Vuc2libGUgdG8gaW5sdWNkZT8gRG9lcyB0
aGF0IG1lYW4gaXQncyB0aW1lIGZvciBhIDAuNi41IHJlbGVhc2U/DQoNCkJlc3QgcmVnYXJk
cw0KVXdlDQo=

--------------hxAW5scPIQ0CuKuoz0y59Ljw--

--------------ecAb6Que8oWvZLd314m8sL3j
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmK+90IACgkQwfwUeK3K
7Al/6gf/RC9n3O0mGytyiZaSrWtKl+4VIMXxT9ipNyrAcHxGS1mcSSGteBZKuroy
OVFh48+1d3caf3BNPGVIGSfOPnof+ud+EyV8D6uv1qWK6tSlJeNn+f65ZXJYjank
ieJA5B2XRoXF/uQGGtooIcdXVCvMPSleRE2Yhp4Scce+rOvx8g9JH2b946h5XC/x
vPk6GPbfVthGY37Newm5zGuWzgcc0HkrexXNOmiclydpbwQsEXxzAUBeWhus5439
s49imbTcGk1/dJ3ltVfa6UJr2TjKfeQBN43ktQT3O3fwjkmcRcAsBqrGJ3OeRP0j
KY/WjQstcAw14/OsIM5HRRNCD8Z76g==
=ppG2
-----END PGP SIGNATURE-----

--------------ecAb6Que8oWvZLd314m8sL3j--
