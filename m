Return-Path: <SRS0=oVrj=CR=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A77C2D0A7
	for <linux-sparse@archiver.kernel.org>; Tue,  8 Sep 2020 19:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F04820658
	for <linux-sparse@archiver.kernel.org>; Tue,  8 Sep 2020 19:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="FjgRGte1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbgIHTvO (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:51:14 -0400
Received: from avasout04.plus.net ([212.159.14.19]:35433 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730744AbgIHPt5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 8 Sep 2020 11:49:57 -0400
Received: from [10.0.2.15] ([195.213.6.112])
        by smtp with ESMTPA
        id FfiqksLXCrXCcFfirk056R; Tue, 08 Sep 2020 16:39:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1599579593; bh=M5eSNq/76p4JSSPzZ+znSX+4am2qx6GBlsKX0KBZ+hM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=FjgRGte1lWSNXTAskNAaSLBHuL4vOHhMm/CPWnP2WZlll/e5vgyO4kG+2TzF82fmb
         bx1wis9TXb5BrqDAkwkTyAB72BERhBOCHGOZK37sX1ZWdERK30SSaE65kbyvTTlN4z
         9EaY2LaNdRhS9ptFPkn6k0szoFqL5GxYHFMf1sUaovQjZ3KnYF5rdnXcp/My7BfzmV
         2FLBYirrPc6QEu8u/u44D5a7bDcYI/GGP5SePlUbVnhf4SaEUu9rlAJIxLGlmKWZ6/
         ZJfc5slGe4IDQMUjXq3KOCnbRAxvl5ytBXHgPQA5VC5gTenmJsGmytK+wSYF1niZ8H
         IVIopNZNlTxuQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Q+xJH7+a c=1 sm=1 tr=0
 a=/rD2idLCdDHnmLflUbi9CQ==:117 a=/rD2idLCdDHnmLflUbi9CQ==:17
 a=IkcTkHD0fZMA:10 a=oYJ8nWOx8e2xI6b8hhcA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 3/3] add more testcases for AND/OR simplification
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-sparse@vger.kernel.org
References: <20200906211646.58946-1-luc.vanoostenryck@gmail.com>
 <20200906211646.58946-4-luc.vanoostenryck@gmail.com>
 <7ead3fd3-34f4-f5d4-21fa-c7937fcab5fe@ramsayjones.plus.com>
 <20200907222122.ruonzxhhfjk6dix2@ltop.local>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <5940333f-0536-1a8f-9564-52db579e96d6@ramsayjones.plus.com>
Date:   Tue, 8 Sep 2020 16:39:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200907222122.ruonzxhhfjk6dix2@ltop.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfArbauUaZ2dUXp9CSWz0x4VOEJm0/lFsm/FMWRM1enSnq+LjMHKxxP0OlspWkET7eUrdvQ2bIQZPyR6Ka2wkmyR/+woftsBC2ugvlflcShcVn6nfafzZ
 hzvOuDkc51wCFj6wtbmqAJ3PaG8OXDMxS74k7cQ2E7Di0JxlRoeGZ0Iq3MGfUq9Y+0ZwkshCmH4h1w==
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 07/09/2020 23:21, Luc Van Oostenryck wrote:

>>> diff --git a/validation/optim/and-lsr-or-shl0.c b/validation/optim/and-lsr-or-shl0.c
>>> new file mode 100644
>>> index 000000000000..46ab1bde5249
>>> --- /dev/null
>>> +++ b/validation/optim/and-lsr-or-shl0.c
>>> @@ -0,0 +1,13 @@
>>> +// =>	0
>>> +unsigned int and_lsr_or_shl0(unsigned int a, unsigned int b)
>>> +{
>>> +	return ((a | b << 12) >> 12) & 0xfff00000;
>>> +}
>>> +
>>> +/*
>>> + * check-name: and-lsr-or-shl0
>>> + * check-command: test-linearize -Wno-decl $file
>>> + * check-known-to-fail
>>> + *
>>> + * check-output-excludes: shl\\.
>>
>> Why not something like:
>>   * check-output-contains: ret.32 *\\$0
> 
> Yes, at the end this check is the only thing that matters. And since
> it's all pure expressions, if there is a return with a constant,
> no other instructions can possibly be present.

:-D 

OK, so let's imagine there is a bug (perhaps an off-by-one, say)
that results in some IR _not_ being removed properly, will this
test catch that? Does it matter? why not?

Given that you don't provide an '*.expected' file, adding the
following to the test won't guarantee to catch that bug either,
but would hopefully increase the odds. (this assumes that the
pre-optimization pass IR contains 'shl', 'or', 'lsr' and 'and',
of course).

> 
>>   * check-output-excludes: shl\\.
>>   * check-output-excludes: or\\.
>>   * check-output-excludes: lsr\\.
>>   * check-output-excludes: and\\.
> 
> But these tests were written (more than 2 years ago, so I forgot the
> details about them) for very specific steps in the simplification
> phase, most probably aiming bitfields (hence the constant shifts &
> masks). In this case it was for a simplification that removed the '<<'.> 
[snip]

>>> diff --git a/validation/optim/lsr-or-lsr0.c b/validation/optim/lsr-or-lsr0.c
>>> new file mode 100644
>>> index 000000000000..aad4aa7fda56
>>> --- /dev/null
>>> +++ b/validation/optim/lsr-or-lsr0.c
>>> @@ -0,0 +1,22 @@
>>> +#define	S	12
>>> +
>>> +//	((x >> S') | y) >> S;
>>> +// ->	((x >> S' >> S) | (y >> S)
>>
>> s/((x/(x/
>>
>>> +// ->	((x >> 32) | (y >> S)
>>
>> s/((x/(x/
>>
>>> +// =>	(y >> S)
>>> +
>>> +int lsr_or_lsr0(unsigned int x, unsigned int b)
>>> +{
>>> +	return ((x >> (32 - S)) | b) >> S;
>>> +}
>>> +
>>> +/*
>>> + * check-name: lsr-or-lsr0
>>> + * check-command: test-linearize -Wno-decl $file
>>> + * check-known-to-fail
>>> + *
>>> + * check-output-ignore
>>> + * check-output-pattern(1): lsr\\.
>>> + * check-output-excludes: and\\.
>>
>> why would an 'and' be here anyway?
> 
> Because each shift has a implicit mask associated with it:
> 	(x >> S) == ((x & 0xffffffff) >> S) == (x >> S) & 0x000fffff
> In some simplifications I made, it becomes an explicit mask and
> sometimes there was a left-over. But yes, it's not very interesting here.

;-P

So, imagine you didn't know the inner workings of the
optimization code, looking at the test text alone, would
you understand why the test asserts what it does?
(The input IR to the algorithm doesn't have an 'and', right?)

[Similar comment about other email on patch #2, the input IR
doesn't have an 'lsr', right?]

OK, I promise not to comment further on this series! ;-)

ATB,
Ramsay Jones
