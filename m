Return-Path: <SRS0=5g4H=CP=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8330FC433E2
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 20:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18C5720C09
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 20:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="SCv6pZTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgIFUMZ (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 6 Sep 2020 16:12:25 -0400
Received: from avasout04.plus.net ([212.159.14.19]:46625 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgIFUMY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Sep 2020 16:12:24 -0400
Received: from [10.0.2.15] ([195.213.6.112])
        by smtp with ESMTPA
        id F11SkqNLNrXCcF11TkzK7K; Sun, 06 Sep 2020 21:12:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1599423143; bh=cD9MbFtN72M+BbPphKv0xlktf2IJKLj+k3LnvbVcvhg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SCv6pZTrPv6YeC0qPNGo71cb4ji0f0/c3wNUA6sUqkirXRhss+KAz8IH2P5juKwYx
         qjD4e2M9qwrFx3rFkg27fgO1F1tuvRDc1zAXpnkqW0i7Y1oss5IPP/oaToBsCAwL50
         ti2oJjp99Q27QOXvASyoo83NTNow9Gr5e6WEuLbibhJQIsK72Whk4k7WCPk85xD7gu
         Bhn3x2VseJ5LOopdxqfRruh1lTkvYZEmBJKt8tNOvJ6UgEfOvqoonTNSIm7QlqF9xv
         Ka0wSk2YP1qzbNZIrVi40DZXwDryxW8Ng7rYTgbSI3t+YGLrsJYMxuEQ1v7+mdEcKP
         rxMGG2j4FWbyQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Q+xJH7+a c=1 sm=1 tr=0
 a=/rD2idLCdDHnmLflUbi9CQ==:117 a=/rD2idLCdDHnmLflUbi9CQ==:17
 a=IkcTkHD0fZMA:10 a=r7fnfc_2mhp7aiB55ygA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/3] add more testcases for AND/OR simplification
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-sparse@vger.kernel.org
References: <20200906124038.46786-1-luc.vanoostenryck@gmail.com>
 <20200906124038.46786-3-luc.vanoostenryck@gmail.com>
 <bd752e76-f71a-699a-7253-631bd9d4c090@ramsayjones.plus.com>
 <20200906191045.4vgg52mbzlsq5i4a@ltop.local>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <a845a6af-39bc-c936-0e0c-401025960ac6@ramsayjones.plus.com>
Date:   Sun, 6 Sep 2020 21:12:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200906191045.4vgg52mbzlsq5i4a@ltop.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDPUm2KTBmE2gSB1+nzmU8HlR3VAhTEYidmQeUX+laGf3xiq0DnyQ6wfeNgiqsiEq1/fGsbzWEYQpGGxxrobjc1Ym7I0RIk7eQN3o4ESvRQQvsTZdoM7
 HAnSUC9XDgxlTIi8wp30Y51UFkdpxcocaxJL7jZXN2IoEgpY20ysxMECkrrC1R2OsHyE682x5qRBuA==
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 06/09/2020 20:10, Luc Van Oostenryck wrote:
> On Sun, Sep 06, 2020 at 05:38:54PM +0100, Ramsay Jones wrote:
>> On 06/09/2020 13:40, Luc Van Oostenryck wrote:

>> Hmm, I can't see an optimization for these two! :(
>> Care to explain just what you expect? (maybe with an
>> '*.expected' file?)
> 
> I saw your other email about it but I just would like to add
> these sort of tests should really be read at the IR level,
> the output of 'test-linearize $file.c'. Sometimes, the C file
> is just a convoluted way to create some specific sequence of
> IR instructions. Also, often the name of the file and the

Yeah, indeed - which is kinda why I would have liked to see
an '*.expected' file! It is just hard to try looking at the
C code and imagine the likely optimization opportunities and
the effect they have on the IR. :-D

Having said that, I do understand why you would rather not do
that. It just makes reviewing such patches a hard job, requiring
a bit of imagination (which I don't have!). :-P

> comments directly refer to these instructions (like here 'trunc'
> for the instruction OP_TRUNC).
> 
> For the simplification phase, it would be nice and easier to be
> able to do the tests directly in the IR format. It shouldn't take
> much time but ... one day ... maybe :)

yeah, we can dream! ;-)

ATB,
Ramsay Jones

