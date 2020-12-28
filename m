Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071FBC4332D
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 16:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CECD820731
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 16:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392959AbgL1QK4 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 28 Dec 2020 11:10:56 -0500
Received: from avasout06.plus.net ([212.159.14.18]:57762 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388377AbgL1QKz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 28 Dec 2020 11:10:55 -0500
Received: from [10.0.2.15] ([80.189.83.3])
        by smtp with ESMTPA
        id tv5zkPcYdhO4Htv60kCt9R; Mon, 28 Dec 2020 16:10:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1609171808; bh=E6qhLvf2nS047JHPaCr6TmGwUI0FRUS6HnYCnqfeWcA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ITffTv5UkvpuKDTo2YxQEFznywuwN7sFo0spo8AAwLZsSW8dmWSe29m9d8Dd0uImF
         kvT+bsT981iwqNprzaVm8JutBO6CIN059cRbzhV4YH8gyxbEA/HYoj5QwSp0JuWY5f
         GYYicClOTGDs6T4+hVoXgWvZQNqs3veIHUdLArSa/Sr2RKLPNGJnQyNoHzub9xpLP3
         tfMONO5jjZg2Qf6iTRwR6syFIHguKgsR1DA7ZPXM3mFNfZSQzFSi4yRIs1ze9TRvSK
         apmQLudxt9umOVTvRN9svvylUKgu2TplJ3Pei0VaNWdkKQ3xNohXiImkB2JwysBRAs
         JVXCy3hBolYwQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=SPPZqNnH c=1 sm=1 tr=0
 a=HN+d/rRCB1WM0IHjUF19mA==:117 a=HN+d/rRCB1WM0IHjUF19mA==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=ShXLDNKwgKEFvt9kLoIA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 02/16] add testcases for exotic enum values
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
 <20201226175129.9621-3-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <c1fad238-d585-d8b7-1b1a-70fd43982b1e@ramsayjones.plus.com>
Date:   Mon, 28 Dec 2020 16:10:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201226175129.9621-3-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEvCSEJKi1fS7gDRmVzLwe8kWCEdG1QZlX/uPW4av38VPiZXTkPSuo9pQWqPR4Ue9cH5GwBJO5/e9k0kq7SgkEJae6lJfwzg+8VhxSRHYr9J5sEuMzpM
 LmI7e267/adsUJsbAwdnEgr5zKeGLTl+NwpKyxsGjPza6F8flFnkbp5yhkFUwCEiABBAv3tsCRFwxQ==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 26/12/2020 17:51, Luc Van Oostenryck wrote:
> There is more than one complexity in the evaluation of enums.
> 
> Add a test for enums with 'exotic' values non-covered in other tests.

s/non-covered/not covered/

ATB,
Ramsay Jones

> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  validation/enum-type-exotic.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 validation/enum-type-exotic.c
> 
> diff --git a/validation/enum-type-exotic.c b/validation/enum-type-exotic.c
> new file mode 100644
> index 000000000000..a17ca0ad48ef
> --- /dev/null
> +++ b/validation/enum-type-exotic.c
> @@ -0,0 +1,28 @@
> +enum foobar {
> +        C = (unsigned char)0,
> +        L = 1L,
> +};
> +
> +unsigned int foo(void);
> +unsigned int foo(void)
> +{
> +#ifdef __CHECKER__
> +	_Static_assert([typeof(C)] == [enum foobar], "enum type");
> +	_Static_assert([typeof(C)] != [unsigned char], "char type");
> +#endif
> +
> +	typeof(C) v = ~0;
> +	return v;
> +}
> +
> +/*
> + * check-name: enum-type-exotic
> + * check-description:
> + *	GCC type's for C is 'int' or maybe 'unsigned int'
> + *	but certainly not 'unsigned char' like here.
> + * check-command: test-linearize -Wno-decl $file
> + * check-known-to-fail
> + *
> + * check-output-ignore
> + * check-output-excludes: ret\\.32 *\\$255
> + */
> 
