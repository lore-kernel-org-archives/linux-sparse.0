Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A546EC433F5
	for <linux-sparse@archiver.kernel.org>; Sun, 22 May 2022 15:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbiEVPJf (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 22 May 2022 11:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiEVPJf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 22 May 2022 11:09:35 -0400
X-Greylist: delayed 182 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 22 May 2022 08:09:32 PDT
Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB5C3A5E3
        for <linux-sparse@vger.kernel.org>; Sun, 22 May 2022 08:09:32 -0700 (PDT)
Received: from [10.0.2.15] ([147.147.167.40])
        by smtp with ESMTPA
        id snA3n2GidOC4ksnA4nRoyO; Sun, 22 May 2022 16:06:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1653231988; bh=5WsWZzuPe4VWyqeEYqEzfre7+g2ON+e0M44zrthOPCI=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To;
        b=AhlNEnGOS/UQlrOW67QU14LEm6O9E5Hedd0K6hcDgckwlnBXdhsb+A8WUWzZv59hZ
         ypwE7XE3rFVzAviuu8Gg1jbbsfm5WLibQ7io1NSrPENFToiJ0/2qDJFc5jb5uzLD7Q
         KPrWAI5/1TlYdXqRQ6gs0UixUQyBEiziy3EaRE095D5EzC8WF0tpOKhTpAakoYN0ND
         hNzFyvT1itS/GMUTLPJGd/5IGCqPUbWZVbAbaXabEiu+NBPaPcGOn9geZ12U1NV4TY
         rw392K7UWh3FWm5dMtem3w8iGCBohLuY1XpY7wi/e7poJyftQlbxy7mybxARmQFn2O
         Bp31VMmny8GqA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=FsUWQknq c=1 sm=1 tr=0 ts=628a5174
 a=nyqnwr6A7Kzjd6EpZhiMcA==:117 a=nyqnwr6A7Kzjd6EpZhiMcA==:17
 a=IkcTkHD0fZMA:10 a=DYzKCcsm62tQ7I8jnDYA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <c07296ee-650a-7261-5acb-75013b909d9b@ramsayjones.plus.com>
Date:   Sun, 22 May 2022 16:06:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 0/2] sparse v0.6.4 regression
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <c29182d4-3141-83c6-21f6-d7f368b3d3c5@ramsayjones.plus.com>
 <20220521094418.pf6s4usfq4npktn6@mail>
Content-Language: en-GB
In-Reply-To: <20220521094418.pf6s4usfq4npktn6@mail>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMiyi8VkPvicrv27w3mEDd9vBy4uqY1iGQTvSoKOyXAUKiagdJBhUGjF5z5hpWecvwbQ4Vajre4CLG7A5+ozvIyzhsIdOR/P0VmqitOnTOfkrvvVbk1c
 ERMn6YrpMw4nH2iukTYHjvLKRAeSQGXn1/vdstMYQEUMn/y/Cup38QAhLSo2Klwu6Sa8RWjpIOqpVkEG75rF6OrrYeDp/ZHtuLY=
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 21/05/2022 10:44, Luc Van Oostenryck wrote:
> On Tue, Sep 28, 2021 at 12:41:27AM +0100, Ramsay Jones wrote:

> Hi Ramsay,

Hi Luc, good to hear from you! Hope you are keeping well.

>> I noticed a regression introduced by commit a69f8d70 which, effectively,
>> disables the 'memcpy-max-count' check. (I had done a 'make CC=cgcc' in
>> git, expecting to see some warnings, including the 'memcpy-max-count'
>> check, and it didn't appear ... :( ). Sorry for not noticing before, but
>> the 'sparse' make target is supposed to suppress that warning for the
>> pack-revindex.c file, so ... ;P
>>
>> [I tried finding your last 'kernel sparse warnings change' list email
>> to see how many of these warnings still appear in the kernel ... well
>> it would be zero with v0.6.4!]
> 
> Now I can see 4 of them.

I tested today's master (@commit fbdc046e (Use offsetof macro to silence
null ptr subtraction warning, 2022-03-21)), without issue on 64-bit
linux and cygwin. (so, not 32-bit linux, which requires a reboot ...)

Also, a 'make CC=cgcc' now issues all the warnings I expect, including:

      CC pack-revindex.o
  pack-revindex.c:73:23: warning: memset with byte count of 262144

I noticed that three RISC-V patches have been pushed since then, so I will
test those later ...

>> I also included the 'case label' patch I sent before, this time with
>> a commit message and a test. (The test could be extended when sparse
>> is updated to include the full label-positioning of C23!).
> 
> Thank you very much, pushed now, and ...

Thanks!

> apologies for this huge delay.

No problem.

ATB,
Ramsay Jones

