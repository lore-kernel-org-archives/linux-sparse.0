Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21718C433B4
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Apr 2021 17:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6DB16128B
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Apr 2021 17:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbhDQRrI (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 17 Apr 2021 13:47:08 -0400
Received: from avasout02.plus.net ([212.159.14.17]:39414 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236643AbhDQRrI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Apr 2021 13:47:08 -0400
Received: from [10.0.2.15] ([195.213.6.1])
        by smtp with ESMTPA
        id Xp1jlPFpg7QW9Xp1klAy7g; Sat, 17 Apr 2021 18:46:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1618681600; bh=qaoIGPWMociuFCqCG2vrNMT/1p0qH6zjHaI+G/bRZ2I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VkcjO89OHfDcH/amkgrQEO0CPh34Y53ZKkgSHBeeaGaO0mF8QsWi+yxhqElgUBppR
         kOJepL8froJO+DplsQ5+NW1LHGRkLjCuDJjdn3Xmh67tli1lTZk8PXiB8tOalWNhZi
         RlaryA7MFrzwxaX+eq9A3tEoGQm4173ual4UAq/0kiTsS27RsL5qIqD3jazL0ZEO8O
         cgdnc8IQ70RUKTSkSDXdEljLOIa7d934dMgq9ds1sCZx+7HJG6v1z4+wewENyBdR9B
         bp7WiKRcMKNWQxonfs++WBKFjwn4E47QaMipRUe3lfSYLDAwNPzqyNYZYd9ZKSmSC+
         L7c8xm1PnNFhA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=H+BAP9Qi c=1 sm=1 tr=0
 a=v1fZ9eGmBRQ2oAddCs0ezw==:117 a=v1fZ9eGmBRQ2oAddCs0ezw==:17
 a=IkcTkHD0fZMA:10 a=i0SAnIzfqV48RShxVuwA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] no needs to use MARK_CURRENT_DELETED() for multi-jumps
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-sparse@vger.kernel.org
References: <20210417133154.53987-1-luc.vanoostenryck@gmail.com>
 <YHsKV2s9XW4w8tK9@satellite> <20210417163850.wqkrde74s33gfghv@mail>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <f06fd5ff-c627-38a2-9d3c-d8bb7712f193@ramsayjones.plus.com>
Date:   Sat, 17 Apr 2021 18:46:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210417163850.wqkrde74s33gfghv@mail>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEHkSkpwdYQBOH0V9FLwp/yiyvgV0gAo3EGXcXRY1jgO02D9+Yw6qfewY8Nm5lm5Y9gyRHbt8HSILW/fYInJpuTkFnK6VdAaEbUmyp/e/lTBxyVdY8IN
 o5M0mRPue3qgZ4wKQNpe0UP1vdAHt1QzcnRjeVJlRVx9017O3AJSwUiPWEG0+OB47LoWoWbIoQCpBg==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 17/04/2021 17:38, Luc Van Oostenryck wrote:
> On Sat, Apr 17, 2021 at 05:18:31PM +0100, Ramsay Jones wrote:
>> On Sat, Apr 17, 2021 at 03:31:54PM +0200, Luc Van Oostenryck wrote:
>>> MARK_CURRENT_DELETED() was added for the case(s) where an element
>>> must be removed from the list but the address of the other elements
>>> must not be changed. In this case of effectively removing the
>>> element from it list, the element is 'marked' as deleted in the list
>>> and the list walking macros will later take this in account.
>>>
>>> However, this is not never needed for multi-jumps.
>>
>> s/not never/not ever/ ?
> 
> Hehe :) Thanks.
> Just 's/not never/never/'

Heh, palmface, of course! ;-)

ATB,
Ramsay Jones


