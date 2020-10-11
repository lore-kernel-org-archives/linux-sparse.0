Return-Path: <SRS0=hzTE=DS=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0512EC43457
	for <linux-sparse@archiver.kernel.org>; Sun, 11 Oct 2020 19:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4EC02087D
	for <linux-sparse@archiver.kernel.org>; Sun, 11 Oct 2020 19:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgJKTwC (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 11 Oct 2020 15:52:02 -0400
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:42306 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726456AbgJKTwC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 11 Oct 2020 15:52:02 -0400
Received: from cpc98990-stkp12-2-0-cust216.10-2.cable.virginm.net ([86.26.12.217] helo=[192.168.0.10])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1kRhNw-00084C-Gs; Sun, 11 Oct 2020 20:52:00 +0100
Subject: Re: [PATCH 0/8] format check tweaks
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-sparse@vger.kernel.org
References: <20201005020002.1108-1-luc.vanoostenryck@gmail.com>
 <58d771f9-7560-f682-3173-78dea0f83711@codethink.co.uk>
 <20201005234749.dfw34pvgb2uavuko@ltop.local>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <504d8f5f-d8bc-e7f5-a096-ee097411c3f9@codethink.co.uk>
Date:   Sun, 11 Oct 2020 20:51:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201005234749.dfw34pvgb2uavuko@ltop.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On 06/10/2020 00:47, Luc Van Oostenryck wrote:
> On Mon, Oct 05, 2020 at 10:04:43AM +0100, Ben Dooks wrote:
>> On 05/10/2020 02:59, Luc Van Oostenryck wrote:
>>> Ben, these are small changes I think should be applied with
>>> your series, on top of the patches I send yesterday.
>>> I've pushed everything at:
>>> 	git://github.com/lucvoo/sparse-dev.git format-check
>>> If you're fine with these, I can squeeze them with the series.
>>>
>>> There are also a few tests I don't agree with:
>>> 	const void *ptr = ...
>>> 	printf("%s", ptr);
>>> These tests silently accept this, but they should warn.
>>> But this can be fixed at a later step.
>>
>> ok, thanks.
> 
> Hi,
> 
> I've now pushed it on a separate branch on the official tree:
>    git://git.kernel.org/pub/scm/devel/sparse/sparse.git format-check
> 
> It will thus not be rebased anymore and any changes will need to be
> incrementally on top of it.
> 
>> I'm going to try and work out the best way to deal with the kernel
>> extra funsies. I have a few ideas but yet to make a coherent document
>> about them.
> 
> Well, the reason I've not yet merged it with the main branch is
> because enabling -Wformat creates really a lot of warnings in
> the kernel and people definitively use this.
> 
> Most of these warnings (if not all) is caused by using
> check_assignment_types() which was good as a quick & dirty solution
> in the early stages but isn't at all adequate as a true solution
> and this for several reasons. I've also begin to take a look at
> this with a relatively satisfying result by adopting the following
> strategy:
> 	Since no 'checking' function in evaluate.c has the needed
> 	characteristics, simplest is to create in verify-format.c
> 	what is needed.
> This also gives the flexibility needed to support things like
> -Wformat-signedness.
> 
> I add here below only small extract because it's for now quite
> messy and need quite a bit of polishing.

I've not had time to run the latest against the kernel as I forgot
the disc password to my main machine and have had to rebuild the
system from scratch.

Let me know if there's anything else I can help with.



-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
