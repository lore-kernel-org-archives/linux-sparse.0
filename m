Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0290C07D5B
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 23:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9816C2222A
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 23:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgL1Wzw (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 28 Dec 2020 17:55:52 -0500
Received: from avasout03.plus.net ([84.93.230.244]:39285 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbgL1Wb3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 28 Dec 2020 17:31:29 -0500
Received: from [10.0.2.15] ([80.189.83.3])
        by smtp with ESMTPA
        id u125kgPVC99nqu126k5rUV; Mon, 28 Dec 2020 22:30:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1609194643; bh=aIuSFS23woRVQq24pvX11bRKtAaL7Sn4ZTDFFQk8UWo=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To;
        b=Pu2rdxndXZt/B5eSBxXJwnqNWcEyzijxRcKr1ZDmbsgwY5geMYC6PLuyT3V2ksPFD
         l7XeOwaAsjHIGCWfqS5aKqOVXszmdiJ92Nn/yKdM/ZtqNHnB0uT3FW4oTDy5WChofc
         WReZQMRCe/13mezCvnP0qyCB8jszzwxvyK8/04B9mA+KET6dQTkrbdkxnj/76i1/jd
         yXUkVEEfN7WHzTGQKViU4IOXPkhLF/2ZN1i2B5qZG2cNRK8n6Ha10vfEuBo6myZy2+
         OKjB/y/wgdh5jHgVR3rJwUPYSadZJEhcQin8tkO0WgzWTo+06VUZoTDQ1cucwI1Uaw
         w5SWmT/+Z9mMA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Uoz4y94B c=1 sm=1 tr=0
 a=HN+d/rRCB1WM0IHjUF19mA==:117 a=HN+d/rRCB1WM0IHjUF19mA==:17
 a=IkcTkHD0fZMA:10 a=K5W_TNiRU95GKBIsSrsA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/2] fix rem_usage()
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-sparse@vger.kernel.org
References: <20201227092759.30999-1-luc.vanoostenryck@gmail.com>
 <20201227092759.30999-3-luc.vanoostenryck@gmail.com>
 <52a111f5-aea4-d705-f0c3-d71ecb2226dc@ramsayjones.plus.com>
 <20201228213943.honhyxpk6apd23tg@ltop.local>
 <f8b3a7fe-e4b3-a83f-7d2a-71ec8e79b3de@ramsayjones.plus.com>
Message-ID: <25740e62-2357-0a87-5a8a-07d6278ca1de@ramsayjones.plus.com>
Date:   Mon, 28 Dec 2020 22:30:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f8b3a7fe-e4b3-a83f-7d2a-71ec8e79b3de@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPH84n5OfN6XijWXG0f0LetbcPOeLBZ82Lu7I0B1pgSvY1FXAYxB3Tf64k8Kdmot0B6+AEWYZJ374b5abBTXwbI6ynzup1y8461t29ekx2ZajrgDvs4w
 Yw5Y2bNVscqs0PScpEse3oNYeYfO0pQ2jK8veVTbtt60UZaqGhFMFzUJNJFWNFWxzvreI57FiyYyAg==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 28/12/2020 22:09, Ramsay Jones wrote:
> 
> 
> On 28/12/2020 21:39, Luc Van Oostenryck wrote:
>> On Mon, Dec 28, 2020 at 05:22:36PM +0000, Ramsay Jones wrote:
>>>
>>>
>>> On 27/12/2020 09:27, Luc Van Oostenryck wrote:
>>>> rem_usage() is used to remove an element from a def-use chain. Optionally,
>>>
>>> Hmm, rename this to 'remove_usage()' at the same time?
>>
>> It can't, 'remove_usage()' is already taken and 'rem_usage()' is more
>> for internal uses than 'remove_usage()'.
> 
> Ugh! I just took a quick look. Ugly. ;-)
> 
> Well, I think I would rename it 'remove_use()' or somesuch instead.

Ahem, except you can't, because it is already used ... (facepalm).

Ho Hum. ;-)

ATB,
Ramsay Jones

