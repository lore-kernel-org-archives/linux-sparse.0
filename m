Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61B9C4646E
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 23:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0E43222F9
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 23:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbgL1Wzw (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 28 Dec 2020 17:55:52 -0500
Received: from avasout03.plus.net ([84.93.230.244]:38719 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729625AbgL1WTw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 28 Dec 2020 17:19:52 -0500
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Dec 2020 17:19:51 EST
Received: from [10.0.2.15] ([80.189.83.3])
        by smtp with ESMTPA
        id u0hrkgOaZ99nqu0hsk5rFt; Mon, 28 Dec 2020 22:09:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1609193399; bh=62/TEeUCztfgTlH4f4eB0WOktq0tU7UYRI6/A2a9Ga8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=tQOdfUHgUoJss+1rZuq0PArElfb8ucrjgBfW6p78d2BRlYm5borXQ/4NGJ1hf5A4G
         X2IJrTrgiScFIsaNDkCx4D9wUZShOf4ETXRe4lmF20mUOrtaeZtB123qu9ZhMlFaXv
         pCTPMcx4184uC+GFtL/Vtz1PwJpkOcEgi7RXZgPwCDfwa421jLobrB2QAsSXCF3Ghr
         VA8cqy9nT13TUcFDIWyrKzzbmDcDfOnk9H+vTZdqFBoVFpuke2sA3oadh30R6/yBkD
         7XvkYrgOn6/P/IPb2XhpdpMLAqE9OIAkqVo8EOwzY4z5pCZLf1yg/PT0JUYYRUhwbX
         rd17NHEM6W5bw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Uoz4y94B c=1 sm=1 tr=0
 a=HN+d/rRCB1WM0IHjUF19mA==:117 a=HN+d/rRCB1WM0IHjUF19mA==:17
 a=IkcTkHD0fZMA:10 a=C4fSksaWOZVxES5CwuYA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/2] fix rem_usage()
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-sparse@vger.kernel.org
References: <20201227092759.30999-1-luc.vanoostenryck@gmail.com>
 <20201227092759.30999-3-luc.vanoostenryck@gmail.com>
 <52a111f5-aea4-d705-f0c3-d71ecb2226dc@ramsayjones.plus.com>
 <20201228213943.honhyxpk6apd23tg@ltop.local>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <f8b3a7fe-e4b3-a83f-7d2a-71ec8e79b3de@ramsayjones.plus.com>
Date:   Mon, 28 Dec 2020 22:09:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201228213943.honhyxpk6apd23tg@ltop.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJfj8DY1YZi5+o4Qs2JanDFhpKQFvKx1WAqsyolom/r8zLBjXwEoI6IbUX7WJoSBLQw8L/c57PNkHw4HQdi2E8f0a3/fiGL7Ysb7tc1jA321+HTgXwVT
 CLXvatm9Gm62V4vZNNCQ+4aGag7PyxRDqceezejuIDtDtIoXL19MbEknkly6IGh2PjPOGRGTFAgRdg==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 28/12/2020 21:39, Luc Van Oostenryck wrote:
> On Mon, Dec 28, 2020 at 05:22:36PM +0000, Ramsay Jones wrote:
>>
>>
>> On 27/12/2020 09:27, Luc Van Oostenryck wrote:
>>> rem_usage() is used to remove an element from a def-use chain. Optionally,
>>
>> Hmm, rename this to 'remove_usage()' at the same time?
> 
> It can't, 'remove_usage()' is already taken and 'rem_usage()' is more
> for internal uses than 'remove_usage()'.

Ugh! I just took a quick look. Ugly. ;-)

Well, I think I would rename it 'remove_use()' or somesuch instead.

ATB,
Ramsay Jones

