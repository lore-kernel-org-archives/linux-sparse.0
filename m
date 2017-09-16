From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: sparse with 4.10?
Date: Sat, 16 Sep 2017 14:25:18 +0200
Message-ID: <CAHmME9o02YNvfqV3RFofJE8FXwRaUACzq03TBADSYc74E02iBg@mail.gmail.com>
References: <CAHmME9o--jumLrBbRn63ewKOE49+uYJ9B8V5FocptdwZ5Kd9Fw@mail.gmail.com>
 <CAMHZB6G2bQ9SUQLHxxmz0t5Cue73i+-U8bONyq0WMk_gikvyQg@mail.gmail.com> <CAHmME9qu6p344M_VnubGtRYvbM7+w4kDmHGJG_PZvLK0kaheOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="001a113dcf704932ea05594d9a2f"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from frisell.zx2c4.com ([192.95.5.64]:44347 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751185AbdIPMcC (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 16 Sep 2017 08:32:02 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 58bb7105
        for <linux-sparse@vger.kernel.org>;
        Sat, 16 Sep 2017 12:17:40 +0000 (UTC)
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 69c8ab7a (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-sparse@vger.kernel.org>;
        Sat, 16 Sep 2017 12:17:39 +0000 (UTC)
Received: by mail-oi0-f45.google.com with SMTP id r20so1488402oie.0
        for <linux-sparse@vger.kernel.org>; Sat, 16 Sep 2017 05:25:20 -0700 (PDT)
In-Reply-To: <CAHmME9qu6p344M_VnubGtRYvbM7+w4kDmHGJG_PZvLK0kaheOw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

--001a113dcf704932ea05594d9a2f
Content-Type: text/plain; charset="UTF-8"

Hey guys,

Sorry for the delay. I finally produced an extremely minimal test case
that can reproduce this bug. Please see the attached tarball. Hit
make, and you'll see the error:

./include/linux/mm.h:1766:47: warning: unknown expression (14 0)
./include/linux/mm.h:1767:16: warning: call with no type!

Regards,
Jason

--001a113dcf704932ea05594d9a2f
Content-Type: application/x-xz; name="sparse-bug.tar.xz"
Content-Disposition: attachment; filename="sparse-bug.tar.xz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j7nac9mn1

/Td6WFoAAATm1rRGAgAhARYAAAB0L+Wj4Cf/ActdADmcCEbpVd/N0LmaKnT8n5ShKJqS/3tnVIn8
eK8HnLl4ib2d+aBdKoRBUgUd/djKfCMT25JSyNKpIa9iknBn9wDDCevgQfxe9N1B00UMcfW7pG3+
4HflICLNpR+OaM61xXtQ8J55o4zVlapfu3sAUhLt6oOtrN460CTozRYA02HZPho+Gb1CATvGMLir
NJ3sVccNwPHoDsl+oUXuszyAQOEV1rDwoLUzT+sqaJVkVFrxbsAvY7z5mpmTT2kBejkpMdqt+U8m
t4rPgj155BmOBav8CR0w5ZpsmISdb8tWPkVSWxrC0ngSiUR8Cj4zBx4RHnxm623vXMqnl1uTTxIS
10gV0wjopP11i4UYyolalXZpMVaLfF0lLAEkQtJUh4JwQjAt1jLI9mlzNquWu3BoUKGbIeP0Jcwo
yekFhs92c0XtDtB0f9EcBAnCiD8pugrieVT0l7z05v1pquAA5eXNHDb849zSVO4yPPtwl12xQiMa
6o8JGhCgSd2/FTkzb/hgoGpfvMI27np5r+nLtGyWKnoCgEyZHdcm9EGAr+QRby3BSEvatRDz9CQu
K9C4qhbuPkn8vHOLUPG7CTXCMr8uH00WM/uqvgzTKxTPAAAA1OXvpkxTpjUAAecDgFAAALwdUQ6x
xGf7AgAAAAAEWVo=
--001a113dcf704932ea05594d9a2f--
