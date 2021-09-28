Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391EFC433F5
	for <linux-sparse@archiver.kernel.org>; Tue, 28 Sep 2021 21:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15D1460230
	for <linux-sparse@archiver.kernel.org>; Tue, 28 Sep 2021 21:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242836AbhI1VHv (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 28 Sep 2021 17:07:51 -0400
Received: from imap3.hz.codethink.co.uk ([176.9.8.87]:37832 "EHLO
        imap3.hz.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242797AbhI1VHu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Sep 2021 17:07:50 -0400
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net ([86.15.83.122] helo=[192.168.0.21])
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1mVKIg-0004bl-Ht; Tue, 28 Sep 2021 22:06:06 +0100
Subject: Re: [ANNOUNCE] Sparse v0.6.4
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-sparse@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
References: <20210906042111.lhoq7egtpmw3jcv6@mail>
 <0c4480ce-6c92-7788-772c-581a76c2df51@codethink.co.uk>
 <20210907062928.qy37irlznwborcab@mail>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <0bd4f497-05f8-5636-5548-d8b289ea0dc0@codethink.co.uk>
Date:   Tue, 28 Sep 2021 22:05:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210907062928.qy37irlznwborcab@mail>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On 07/09/2021 07:29, Luc Van Oostenryck wrote:
> On Mon, Sep 06, 2021 at 11:04:14AM +0100, Ben Dooks wrote:
>> On 06/09/2021 05:21, Luc Van Oostenryck wrote:
>>> Sparse v0.6.4 is now out.
>>>
>>> The source code can be found at its usual repository:
>>>      git://git.kernel.org/pub/scm/devel/sparse/sparse.git v0.6.4
>>>
>>> The tarballs can be found at:
>>>      https://www.kernel.org/pub/software/devel/sparse/dist/
>>>
>>> Many thanks to people who have somehow contributed to the 299
>>> patches of this release:
>>>      Ramsay Jones, Linus Torvalds, Kyle Russell
>>
>> This has reminded me I have lost track of the printf formatting
>> changes. Is it possible to re-sync and work out what still needs
>> to be done to get this work merged?
> 
> Sure, the series can be merged with just a few trival conflicts.
> 
> I think things were left at
> https://lore.kernel.org/linux-sparse/20201013232231.10349-1-luc.vanoostenryck@gmail.com/T/#ma187dd3978640fccac03c0194fd5bdd84c437721
> 
> but the series is now at:
>    git://github.com/lucvoo/sparse-dev.git format-check
> 
> Are these patches fine for you?

This got lost in a pile of email, sorry.

I'll have a quick look this week.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
