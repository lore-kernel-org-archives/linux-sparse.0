From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 0/2] fix missing evaluation when using '-include <file>'
Date: Wed, 14 Feb 2018 13:15:09 +0100
Message-ID: <CAHmME9r9xfzFb02H_E8Ri_tTY9mO-cWBFxrxifZLTYQ_KVvDgQ@mail.gmail.com>
References: <CAHmME9o02YNvfqV3RFofJE8FXwRaUACzq03TBADSYc74E02iBg@mail.gmail.com>
 <20170917100552.72288-1-luc.vanoostenryck@gmail.com> <CAHmME9ofqdqwUsjmk9TSutFMOFGqstJo1rLuO7VOiC-OCRErGA@mail.gmail.com>
 <CAExDi1Qwc7MSRdDNAURFZNp3SLhWHaC0PKMfgpjVxeC3ZP8S+A@mail.gmail.com>
 <CAExDi1ST5ddB5Ti4rTOCdXsihc=xsuZ6riPAqvFCotrNmjUrUQ@mail.gmail.com>
 <CAHmME9qREfXRQb3ORwd7nyN2E-OTANRKpyirc6FkMON6T8fLOw@mail.gmail.com>
 <20180210200237.a4xmiyppshy5bbbk@ltop.local> <CANeU7QkhZix7xj4_pskyPUXSsSLX1qpXU98rJTf1BBBbxvCnXg@mail.gmail.com>
 <20180214000243.263hmp3puro4h4q3@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from frisell.zx2c4.com ([192.95.5.64]:48709 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753264AbeBNMPL (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 14 Feb 2018 07:15:11 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id d926c565
        for <linux-sparse@vger.kernel.org>;
        Wed, 14 Feb 2018 11:59:28 +0000 (UTC)
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 74813deb (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-sparse@vger.kernel.org>;
        Wed, 14 Feb 2018 11:59:28 +0000 (UTC)
Received: by mail-oi0-f42.google.com with SMTP id 23so4255225oip.12
        for <linux-sparse@vger.kernel.org>; Wed, 14 Feb 2018 04:15:10 -0800 (PST)
In-Reply-To: <20180214000243.263hmp3puro4h4q3@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Christopher,

Could you apply those two patches, and then afterwards, cut a 0.5.2 release?

Thanks,
Jason
