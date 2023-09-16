Return-Path: <linux-sparse-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5173ACD37BF
	for <linux-sparse@archiver.kernel.org>; Sat, 16 Sep 2023 15:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjIPP5l (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 16 Sep 2023 11:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237068AbjIPP5a (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 16 Sep 2023 11:57:30 -0400
X-Greylist: delayed 467 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 16 Sep 2023 08:57:22 PDT
Received: from algol.kleine-koenig.org (algol.kleine-koenig.org [IPv6:2a01:4f8:c010:8611::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E701213E
        for <linux-sparse@vger.kernel.org>; Sat, 16 Sep 2023 08:57:22 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by algol.kleine-koenig.org (Postfix) with ESMTP id 91EFCAA953D
        for <linux-sparse@vger.kernel.org>; Sat, 16 Sep 2023 17:49:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kleine-koenig.org;
        s=2022; t=1694879373;
        bh=SiCNzjnJLAQ0U9sDHp/kFuvF9TSg205fW/23yLRuDtM=;
        h=Date:To:From:Subject:From;
        b=kg72qEs3itxT+wFC45L2KegmriS3EErMxlXvWOnFTvsvdVbB/sK5VFZ9yO0ySTgew
         k/RRask36998zKyoh8UylI/CgGEZBvzJPJezpqyvedtKtZJ1Xw2g5PFuUKUdlTceks
         F8VEXBy2LRiZPenMBkhpDJ9LLj883KBpacIOjWiXFThulDv2ZuxRG5/RebXTzxWLem
         nI/GrZkNLnw1pHRAspS0gvO0JjSzib0ooqDmsMQEjjU3H1YWiB1sHtQL4nBEwTqjD9
         NOxORQcfeJirSiWDc3hwQlomFO9csptFpEgcYibFtjLbVVfoffB6uPRlzEA/cZ2Wwp
         73r1LTFlOd43w==
Received: from algol.kleine-koenig.org ([IPv6:::1])
        by localhost (algol.kleine-koenig.org [IPv6:::1]) (amavisd-new, port 10024)
        with ESMTP id mPR7fD73RSh6 for <linux-sparse@vger.kernel.org>;
        Sat, 16 Sep 2023 17:49:33 +0200 (CEST)
Received: from taurus.defre.kleine-koenig.org (unknown [IPv6:2a02:8071:b783:6940:725c:297:eb88:6c8f])
        by algol.kleine-koenig.org (Postfix) with ESMTPSA
        for <linux-sparse@vger.kernel.org>; Sat, 16 Sep 2023 17:49:33 +0200 (CEST)
Message-ID: <e482a4de-55f3-25bd-4938-af05ad553b7d@kleine-koenig.org>
Date:   Sat, 16 Sep 2023 17:49:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
To:     linux-sparse@vger.kernel.org
Content-Language: en-US, de-DE
From:   =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Subject: sparse fails to build against llvm16
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------7rjyt0HJPJaHf6vVyyhztts0"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------7rjyt0HJPJaHf6vVyyhztts0
Content-Type: multipart/mixed; boundary="------------fvt0RQHdDjbr0zwWBGdoNrt3";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: linux-sparse@vger.kernel.org
Message-ID: <e482a4de-55f3-25bd-4938-af05ad553b7d@kleine-koenig.org>
Subject: sparse fails to build against llvm16

--------------fvt0RQHdDjbr0zwWBGdoNrt3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCkRlYmlhbiB1cGdyYWRlZCBsbHZtIHRvIHZlcnNpb24gMTYgYW5kIHNwYXJz
ZSBmYWlscyB0byBidWlsZCBhZ2FpbnN0IA0KdGhpcyB3aXRoOg0KDQpnKysgLUwvdXNyL2xp
Yi9sbHZtLTE2L2xpYiAgLVdsLC16LHJlbHJvIC1XbCwteixub3cgLVdsLC0tYXMtbmVlZGVk
IA0Kc3BhcnNlLWxsdm0ubyBsaWJzcGFyc2UuYSAtbExMVk0tMTYgICAtbyBzcGFyc2UtbGx2
bQ0KL3Vzci9iaW4vbGQ6IHNwYXJzZS1sbHZtLm86IGluIGZ1bmN0aW9uIGBnZXRfc3ltX3Zh
bHVlJzoNCi4vLi9zcGFyc2UtbGx2bS5jOjMwNTooLnRleHQrMHg3YjIpOiB1bmRlZmluZWQg
cmVmZXJlbmNlIHRvIGBMTFZNQ29uc3RHRVAnDQovdXNyL2Jpbi9sZDogc3BhcnNlLWxsdm0u
bzogaW4gZnVuY3Rpb24gYGNhbGNfZ2VwJzoNCi4vLi9zcGFyc2UtbGx2bS5jOjQ4ODooLnRl
eHQrMHhlMzcpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIA0KYExMVk1CdWlsZEluQm91bmRz
R0VQJw0KL3Vzci9iaW4vbGQ6IHNwYXJzZS1sbHZtLm86IGluIGZ1bmN0aW9uIGBvdXRwdXRf
b3BfbG9hZCc6DQouLy4vc3BhcnNlLWxsdm0uYzo3MTQ6KC50ZXh0KzB4MjRhOSk6IHVuZGVm
aW5lZCByZWZlcmVuY2UgdG8gYExMVk1CdWlsZExvYWQnDQovdXNyL2Jpbi9sZDogc3BhcnNl
LWxsdm0ubzogaW4gZnVuY3Rpb24gYG91dHB1dF9vcF9jYWxsJzoNCi4vLi9zcGFyc2UtbGx2
bS5jOjgyMjooLnRleHQrMHgyNjJlKTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgTExWTUJ1
aWxkQ2FsbCcNCmNvbGxlY3QyOiBlcnJvcjogbGQgcmV0dXJuZWQgMSBleGl0IHN0YXR1cw0K
DQooU2VlIGh0dHBzOi8vYnVncy5kZWJpYW4ub3JnLzEwNTE4NjQgZm9yIHRoZSBjb3JyZXNw
b25kaW5nIGJ1ZyByZXBvcnQuIEEgDQpxdWljayB3b3JrYXJvdW5kIGNvdWxkIGJlIHRvIGRp
c2FibGUgbGx2bS1zdXBwb3J0IGluIHNwYXJzZSB0byBwcmV2ZW50IA0Kc3BhcnNlIGZyb20g
YmVpbmcgZHJvcHBlZCBmcm9tIERlYmlhbiB1bnN0YWJsZS4pDQoNCkFmdGVyIGEgcXVpY2sg
aW50ZXJuZXQgc2VhcmNoIEkgZGlkbid0IGZpbmQgdGhlIG9idmlvdXMgZml4IGZvciB0aGF0
LiANCkFueSBoaW50cz8NCg0KQmVzdCByZWdhcmRzDQpVd2UNCg==

--------------fvt0RQHdDjbr0zwWBGdoNrt3--

--------------7rjyt0HJPJaHf6vVyyhztts0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUFzosACgkQj4D7WH0S
/k6n7Qf+KVdTBpGBphyxWlMKJl1puPKo2sFlovUt/wjUMFXps2R49yPUUi4juNlj
6+WBUu0F//wvUZ7XfQhIokVVrJNF/7imrYUJG9VqLAP/UIA/Me0qs6C3k1pCyktl
eUZHGAIozsFSFc2+LUqcUpGk82+avsQwb+8pEeZDruAUq4uaqef+hor6Fu36MY2P
y3Q0FPLLfPVSC7wf0avx1boPEg39LQwtDSEZ1+RT11rzrZHS9cuBQp48rT2itp90
RP/YBSYPPrnrjusHxXC0AHBYsg3msgD24MXgyfQNEpnvyqEUHrLQN/OdcxEURsKD
k4eZ0R6GUUPJxPf4P5PbOYa19gGXNg==
=dgSL
-----END PGP SIGNATURE-----

--------------7rjyt0HJPJaHf6vVyyhztts0--
