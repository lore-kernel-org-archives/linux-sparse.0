Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2612DC433EF
	for <linux-sparse@archiver.kernel.org>; Wed, 29 Sep 2021 21:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D0C61368
	for <linux-sparse@archiver.kernel.org>; Wed, 29 Sep 2021 21:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346755AbhI2Vha (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 29 Sep 2021 17:37:30 -0400
Received: from avasout07.plus.net ([84.93.230.235]:59950 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346769AbhI2Vha (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 29 Sep 2021 17:37:30 -0400
Received: from [10.0.2.15] ([147.147.167.109])
        by smtp with ESMTPA
        id VhEqmiRCJdY2SVhErm77GG; Wed, 29 Sep 2021 22:35:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1632951347; bh=mVpBaMfuqZh5dRFtJqlRkwXJ6/bgJbvi+wh3XFanpGw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=c6dGbzj5mp6E66OClM9QU7vyNhlvbmRElIm5gyYseSmhHQn46fYZdaporrLdFF57j
         dWpiVBJkCr6mmlQERa4rSiN7JFdhmSoDPv5wj/KmE1JiQ2/t5h+YZsmBa1zVy0hW2U
         VyIyi0hsEjKCAemHGVmRq4qUGG08cHPSkbUZiKGnrRklaCGOchrom6NTlC+BPG6cSd
         rR3r95mkhO/Ut/fp0JhreZBW/FoVaQoywnnyAznoKR/Uzu496bGO6nAQ+Xq173DY7J
         QByfvGJbdfa67hbv2OshRvMrHnI17LdckevRUnq2QS+5AO3gRw0YVd8BSeQzq3wIje
         eUhDjIQBaZzuQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=NP5OB3yg c=1 sm=1 tr=0
 a=QdS5mZX/VJYKMdXaSBaSIA==:117 a=QdS5mZX/VJYKMdXaSBaSIA==:17
 a=IkcTkHD0fZMA:10 a=xNf9USuDAAAA:8 a=yGySPTTHkQnENoXuAmsA:9 a=QEXdDO2ut3YA:10
 a=jYJgLHWX644A:10 a=SEwjQc04WA-l_NiBhQ7s:22
X-AUTH: ramsayjones@:2500
Subject: Re: [ANNOUNCE] Sparse v0.6.4
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
Cc:     Jeff Layton <jlayton@redhat.com>
References: <20210906042111.lhoq7egtpmw3jcv6@mail>
 <5bfca92e-1eb0-ab7d-80b5-5ea2134ae928@kleine-koenig.org>
 <73f07821-4abe-2194-96a2-296c54c47074@ramsayjones.plus.com>
 <d1eadca6-2c2c-b4af-7c0a-e49698a17b12@kleine-koenig.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <ff8b358e-fd8a-9fc3-2ed9-2a85b6872560@ramsayjones.plus.com>
Date:   Wed, 29 Sep 2021 22:35:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d1eadca6-2c2c-b4af-7c0a-e49698a17b12@kleine-koenig.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGwNYHwxrqDWljorQuM56XncVE0NwYzMmpIaH/pOn/IqQHBVThGYBWvr8a7OeI/ZgUUjbsFz5KFGuNtsc4mclx8b3dKXih85tRcauNhr2D74Enz4RpLG
 qrP6v2tcSXiQr5ybovbvHN1aaMtDwiD/YXECvO30CsM421BAsgRChratXtazpz6xyJRXVkXRbzp8lA==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 29/09/2021 07:54, Uwe Kleine-König wrote:
> Hello,
> 
> On 9/29/21 12:43 AM, Ramsay Jones wrote:
>> On 28/09/2021 20:56, Uwe Kleine-König wrote:
>>> On 9/6/21 6:21 AM, Luc Van Oostenryck wrote:
>>>> Sparse v0.6.4 is now out.
>>>
>>> I finally came around to update the Debian packaging. There is just a (non-critical) problem on x32 where some tests fail. I didn't look deeply, but if you care, now you know :-)
>>>
>>> https://buildd.debian.org/status/fetch.php?pkg=sparse&arch=x32&ver=0.6.4-1&stamp=1632795062&raw=0
>>
>> Hmm, interesting. I tested on Linux Mint 19 32-bit and didn't see any
>> failures. As far as I can tell, only the 'validation/builtin-objsize0.c'
>> test is failing (squinting hard at the above!).
> 
> Note that the "normal" 32-bit build was just fine[1]. It's "only" x32[2] that is affected.

Ah, I missed that small detail. :)

Thanks for putting me right (before booting up my 32-bit system).

ATB,
Ramsay Jones

