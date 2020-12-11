Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4644DC4361B
	for <linux-sparse@archiver.kernel.org>; Fri, 11 Dec 2020 17:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B63223EF1
	for <linux-sparse@archiver.kernel.org>; Fri, 11 Dec 2020 17:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387512AbgLKQkK (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 11 Dec 2020 11:40:10 -0500
Received: from avasout04.plus.net ([212.159.14.19]:35886 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388177AbgLKQkE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 11 Dec 2020 11:40:04 -0500
Received: from [10.0.2.15] ([80.189.83.3])
        by smtp with ESMTPA
        id nlRrk82NfrXCcnlRskgocM; Fri, 11 Dec 2020 16:39:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1607704756; bh=bpHXcSSAMyH6uk32Wmr8xGqYaf3VJSTNOnENDg7cNGQ=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=JXlD9o6hwSQtUvCB21YhKcHTQSPOHHHhqVIQCRhQ2YpF16UG7mwRpx1pz3nqYh3wj
         /h3cbl8TeM4cBQ+R1yVguoSczJHG6XT/LTOK4X9HvjvEnMj5suLFgjLTfxzicrh66o
         YMkKLXfWmVWbvrtNqPck5NBZxcw+ZS1un94N5phpQ8Xa8GxSJhYyWNAMQprJ0uiD4l
         mbRrGD3tBCQ3uI5GQEBzkMLBqKSt4IQf6/lmYPKnacR2fwu3zTOuebNLYaJLGI8i7W
         NgzN7d5M0hD/gf4iJON/IjvK6q6rQ/13MyNQ0eiVuy790qV7kPZuKPyCXpUz49Ytnj
         2b78V8jZNJocg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Q+xJH7+a c=1 sm=1 tr=0
 a=HN+d/rRCB1WM0IHjUF19mA==:117 a=HN+d/rRCB1WM0IHjUF19mA==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=RokRPllCdvZ1-8MnbB8A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] testsuite: fix parsing of tags used in the testcases
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
References: <20201211130619.71317-1-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <4176615c-73b8-ff5e-d705-f6a71ea49cab@ramsayjones.plus.com>
Date:   Fri, 11 Dec 2020 16:39:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201211130619.71317-1-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBafB9ugynfwWMEaAu7J8MmPS3uYq87xJd88C7UhuC73K6z3jeIXn+qMS8zO1GCM4iRNdw+SP8c8X5DJuMZJTNjlxOOinrUxqzSUo2NQrFt8rV4Xc1+/
 iy1MdcuT747jnHBcTyuV0bw2EuwqpznTqE06VaqoTbA5cbsBp/S+6Dktk+1BxDihdpO/2xHYq9FVow==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 11/12/2020 13:06, Luc Van Oostenryck wrote:
> In testcases' tags, if a value contains 'check-' then this
> value will be used as the tagname instead of the value.
> 
> Fix this by adding a bit more context in the regexp used for parsing these.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  validation/test-suite | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/validation/test-suite b/validation/test-suite
> index 6935d40cee51..1b05c75e9f74 100755
> --- a/validation/test-suite
> +++ b/validation/test-suite
> @@ -84,8 +84,8 @@ get_tag_value()
>  	check_assert=""
>  	check_cpp_if=""
>  
> -	lines=$(grep 'check-[a-z-]*' $1 | \
> -		sed -e 's/^.*\(check-[a-z-]*:*\) *\(.*\)$/\1 \2/')
> +	lines=$(grep '^ \* check-[a-z-]*' $1 | \
> +		sed -e 's/^ \* \(check-[a-z-]*:*\) *\(.*\)$/\1 \2/')
>  
>  	while read tag val; do
>  		#echo "-> tag: '$tag'"
> 

I needed to apply this to get the testsuite to pass on tonights
'fetch'. However, my immediate thought was 'what if you had more
than one space before/after the '*'?

It just so happens that I had a couple of 'warning: <file>: test unhandled'
after applying the patch (for asm-empty-clobber.c and asm-goto-labels.c)
where they had two spaces after the '*', so ... :-D

ATB,
Ramsay Jones
