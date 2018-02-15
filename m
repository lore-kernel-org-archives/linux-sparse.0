From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 0/2] fix missing evaluation when using '-include <file>'
Date: Wed, 14 Feb 2018 16:00:42 -0800
Message-ID: <c4fc5ede-354e-e8db-92a6-232431c764d9@infradead.org>
References: <CAHmME9o02YNvfqV3RFofJE8FXwRaUACzq03TBADSYc74E02iBg@mail.gmail.com>
 <20170917100552.72288-1-luc.vanoostenryck@gmail.com>
 <CAHmME9ofqdqwUsjmk9TSutFMOFGqstJo1rLuO7VOiC-OCRErGA@mail.gmail.com>
 <CAExDi1Qwc7MSRdDNAURFZNp3SLhWHaC0PKMfgpjVxeC3ZP8S+A@mail.gmail.com>
 <CAExDi1ST5ddB5Ti4rTOCdXsihc=xsuZ6riPAqvFCotrNmjUrUQ@mail.gmail.com>
 <CAHmME9qREfXRQb3ORwd7nyN2E-OTANRKpyirc6FkMON6T8fLOw@mail.gmail.com>
 <20180210200237.a4xmiyppshy5bbbk@ltop.local>
 <CANeU7QkhZix7xj4_pskyPUXSsSLX1qpXU98rJTf1BBBbxvCnXg@mail.gmail.com>
 <20180214000243.263hmp3puro4h4q3@ltop.local>
 <CAHmME9r9xfzFb02H_E8Ri_tTY9mO-cWBFxrxifZLTYQ_KVvDgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:39878 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031901AbeBOAAp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 14 Feb 2018 19:00:45 -0500
In-Reply-To: <CAHmME9r9xfzFb02H_E8Ri_tTY9mO-cWBFxrxifZLTYQ_KVvDgQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On 02/14/2018 04:15 AM, Jason A. Donenfeld wrote:
> Hi Christopher,
> 
> Could you apply those two patches, and then afterwards, cut a 0.5.2 release?
> 
> Thanks,
> Jason

It would be useful for continuous kernel build bots to have the
"ignore indirect_branch attribute" patch as well.

thanks,
-- 
~Randy
