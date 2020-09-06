Return-Path: <SRS0=5g4H=CP=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDFFC433E2
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 16:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 364F3208B3
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 16:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="Uyy2lJn0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgIFQq3 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 6 Sep 2020 12:46:29 -0400
Received: from avasout04.plus.net ([212.159.14.19]:36365 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgIFQq2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Sep 2020 12:46:28 -0400
Received: from [10.0.2.15] ([195.213.6.112])
        by smtp with ESMTPA
        id Exo9kqDQnrXCcExoBkzHAV; Sun, 06 Sep 2020 17:46:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1599410787; bh=3/vQpYcVTo66GimVy/QWo0XWN4JZRGPKe6xiIJnxzjs=;
        h=Subject:From:To:References:Date:In-Reply-To;
        b=Uyy2lJn0+iLKc/X+QxMuuWuiDFe5Xi7Y5qCv+vZqOTT4RLsU+XWHpvRBZSVndbbbe
         SN3CaEQexihLYvG+KQfp8MI8p31zsaGlA7P74gq1N/uOV7M7SzCD0ep3SbneVRNiFf
         WU4qHzdqOHCybxJzLkjJNT9b0pNFTEXwpPo9bDRUNX2KG6VwdomiO4CA4/6jVgUzkC
         pc8z3I8YFN0UClnP3902EJ2ipzo/RJu2fMR1XspkOgkttSsjAIAsxKiSYCYCzteQLY
         kjZXOK+9euudB4zZxAPwONllV9ikdoJw7ZZvJqUzON7yASRtAst6v7X7qjXKJJhm+7
         1jqcU0RsXsT0w==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Q+xJH7+a c=1 sm=1 tr=0
 a=/rD2idLCdDHnmLflUbi9CQ==:117 a=/rD2idLCdDHnmLflUbi9CQ==:17
 a=IkcTkHD0fZMA:10 a=XZJ_w_VrkxTz61mcyesA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/3] add more testcases for AND/OR simplification
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
References: <20200906124038.46786-1-luc.vanoostenryck@gmail.com>
 <20200906124038.46786-3-luc.vanoostenryck@gmail.com>
 <bd752e76-f71a-699a-7253-631bd9d4c090@ramsayjones.plus.com>
Message-ID: <b7c2bd42-0a27-8ab4-e2ed-1611a899e266@ramsayjones.plus.com>
Date:   Sun, 6 Sep 2020 17:46:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bd752e76-f71a-699a-7253-631bd9d4c090@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGQiKkXS88/YW1JWU5bLpSNxYgbKOREizFtI0EyzSwQq+A72jg/LU6QLwIgVuPP6otnygoJ5shkQeWvkr0cT5/WJjAbfbWvoGAC40jsZ8V9xLJ2XCDL7
 JccOL5zdGxCOzJiXdC5/UCjkQVkUY32/mbidaInYjj3bPmJ1T6Nf7vW03Dg8L80g254sz6xXgJOm+g==
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 06/09/2020 17:38, Ramsay Jones wrote:
[snip]

>> diff --git a/validation/optim/trunc-or-shl0.c b/validation/optim/trunc-or-shl0.c
>> new file mode 100644
>> index 000000000000..4d85a6bd4ec4
>> --- /dev/null
>> +++ b/validation/optim/trunc-or-shl0.c
>> @@ -0,0 +1,19 @@
>> +char trunc_or_shl0a(unsigned a, unsigned b)
>> +{
>> +	return (a << 8) | b;
>> +}
>> +
>> +char trunc_or_shl0b(unsigned a, unsigned b)
>> +{
>> +	return a | (b << 8);
>> +}
>> +
>> +/*
>> + * check-name: trunc-or-shl0
>> + * check-command: test-linearize -Wno-decl $file
>> + * check-known-to-fail
>> + *
>> + * check-output-ignore
>> + * check-output-excludes: or\\.
>> + * check-output-excludes: shl\\.
> 
> Hmm, I can't see an optimization for these two! :(
> Care to explain just what you expect? (maybe with an
> '*.expected' file?)
> 

Ah, so I only just noticed the 'char' return types! :-D

OK.

ATB,
Ramsay Jones

