Return-Path: <SRS0=NWui=DH=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806F6C47425
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 20:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DB6920759
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 20:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbgI3U7Q (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 30 Sep 2020 16:59:16 -0400
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:50870 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725355AbgI3U7Q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Sep 2020 16:59:16 -0400
Received: from cpc98990-stkp12-2-0-cust216.10-2.cable.virginm.net ([86.26.12.217] helo=[192.168.0.10])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1kNjBx-0004bY-Rf; Wed, 30 Sep 2020 21:59:13 +0100
Subject: Re: update to format parsing branch
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-sparse@vger.kernel.org
References: <3960bea7-69ef-ed00-66cf-ac73d5cd8876@codethink.co.uk>
 <20200930202934.rjcfxikrzfvesxnc@ltop.local>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <e73b1efe-16ac-883f-4d33-4982d1a5782a@codethink.co.uk>
Date:   Wed, 30 Sep 2020 21:59:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200930202934.rjcfxikrzfvesxnc@ltop.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On 30/09/2020 21:29, Luc Van Oostenryck wrote:
> On Wed, Sep 30, 2020 at 09:35:50AM +0100, Ben Dooks wrote:
>> I've done a rebase to v0.6.2 and put the result up at:
>>
>> https://gitlab.com/CodethinkLabs/sparse bjdooks/printf-new3

[snip]

> So, is it possible to respin the series with:
> * the small changes I've made here above
> * removing the changelogs from the commit messages
> * using the same email address for the author and the SoB?

Ok, will sort these out tonight.

What's the best branch to base-on for merge?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
