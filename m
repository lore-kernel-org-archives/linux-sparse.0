Return-Path: <SRS0=5g4H=CP=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D650C43461
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 21:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F5820838
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 21:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="tWSa/D3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgIFVy3 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 6 Sep 2020 17:54:29 -0400
Received: from avasout04.plus.net ([212.159.14.19]:51389 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgIFVy3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Sep 2020 17:54:29 -0400
Received: from [10.0.2.15] ([195.213.6.112])
        by smtp with ESMTPA
        id F2cEkqRjfrXCcF2cFkzLLn; Sun, 06 Sep 2020 22:54:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1599429267; bh=eICrEQ7aKJ5I1GGRK0sIWA9PmKQyfPbR578VAwfrEHE=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=tWSa/D3mUcmXaDuEHaO5XXnHZZCh9m+zL2I9iJbOpiBXrPE8hxZOp4KDYXSjCcWZm
         PRfMpMwGV4lFt52bk9IcjEOl64pt3OSwOE1uHpjQa8HS3DaEOZRmnpYTE3ng8vJxah
         ofHl8s8VyB8ZmQf/ISysrzX5yBh4YShBZf2CtHBb9cFDm2QicO1RE1GIIfK87AYEOA
         Q/ZPpFfX9QW0N2xpjFRgZSirv8hVtqelzUDAoP06NxuCisWrFJkhY4FlYAP1Gf2471
         Pi6cGC9KJYlw91rKtsEsrEOzcoHPgBHcQeykh9BLZpoXdDMk1wqEKnYjI1cRZRrfgv
         x63/lW1BPtvyQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Q+xJH7+a c=1 sm=1 tr=0
 a=/rD2idLCdDHnmLflUbi9CQ==:117 a=/rD2idLCdDHnmLflUbi9CQ==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=6OwA3YtzKFKbIgi4kO8A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 2/3] add more testcases for existing AND/OR
 simplifications
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
References: <20200906211646.58946-1-luc.vanoostenryck@gmail.com>
 <20200906211646.58946-3-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <5ba9625b-4670-ea6a-c59d-d795406b9c39@ramsayjones.plus.com>
Date:   Sun, 6 Sep 2020 22:54:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200906211646.58946-3-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOnFH8lLmjcHIdfCeLqrb4bfNRJzi+IkPO/2JatID+bgfepXLWboVCn4V2ZMwvCvj6mqPXX6fSWPkskERBEo2tAyvkUZUiHKc2pBKImMqa3R8raq6J2f
 ufcEuernq0sUft9n+u0EmOYjG1X5MyDQfePvrvHXKzVmMkYQafjYUfxCSvp6BVk0xZTvtOtUuPFr+g==
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 06/09/2020 22:16, Luc Van Oostenryck wrote:
> Add a few more testcases to catch possible future regressions.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  validation/optim/and-shl-or-and0.c  | 15 +++++++++++++++
>  validation/optim/lsr-or-and0.c      | 22 ++++++++++++++++++++++
>  validation/optim/shl-or-constant0.c | 12 ++++++++++++
>  validation/optim/shl-or-constant1.c | 12 ++++++++++++
>  validation/optim/shl-or-constant2.c | 12 ++++++++++++
>  5 files changed, 73 insertions(+)
>  create mode 100644 validation/optim/and-shl-or-and0.c
>  create mode 100644 validation/optim/lsr-or-and0.c
>  create mode 100644 validation/optim/shl-or-constant0.c
>  create mode 100644 validation/optim/shl-or-constant1.c
>  create mode 100644 validation/optim/shl-or-constant2.c
> 
> diff --git a/validation/optim/and-shl-or-and0.c b/validation/optim/and-shl-or-and0.c
> new file mode 100644
> index 000000000000..298dcb434fc7
> --- /dev/null
> +++ b/validation/optim/and-shl-or-and0.c
> @@ -0,0 +1,15 @@
> +// =>	(b << 12) & 0xfff00000
> +unsigned and_shl_or_and0(unsigned a, unsigned b)
> +{
> +	return (((a & 0xfff00000) | b) << 12) & 0xfff00000;
> +}
> +
> +/*
> + * check-name: and-shl-or-and0
> + * check-command: test-linearize -Wno-decl $file
> + *
> + * check-output-ignore
> + * check-output-excludes: or\\.
> + * check-output-excludes: lsr\\.

Hmm, this still doesn't sit right - have you discovered the
reason for this?

> + * check-output-excludes: %arg1\\.
> + */
> diff --git a/validation/optim/lsr-or-and0.c b/validation/optim/lsr-or-and0.c
> new file mode 100644
> index 000000000000..fe3a2649eea2
> --- /dev/null
> +++ b/validation/optim/lsr-or-and0.c
> @@ -0,0 +1,22 @@
> +#define	S	12
> +
> +//	((x & M) | b) >> S;
> +// ->	((x >> S) & (M >> S)) | (b >> S)
> +// but	(M >> S) == 0
> +// =>	(b >> S)

yep, better.

ATB,
Ramsay Jones

> +
> +int lsr_or_and0a(unsigned int x, unsigned int b)
> +{
> +	return ((x & 0x00000fff) | b) >> S;
> +}
> +
> +/*
> + * check-name: lsr-or-and0
> + * check-command: test-linearize -Wno-decl $file
> + *
> + * check-output-ignore
> + * check-output-pattern(1): lsr\\.
> + * check-output-excludes: %arg1\\.
> + * check-output-excludes: and\\.
> + * check-output-excludes: or\\.
> + */
> diff --git a/validation/optim/shl-or-constant0.c b/validation/optim/shl-or-constant0.c
> new file mode 100644
> index 000000000000..25347b4b3b20
> --- /dev/null
> +++ b/validation/optim/shl-or-constant0.c
> @@ -0,0 +1,12 @@
> +unsigned shl_or_constant0(unsigned a)
> +{
> +	return (a | 0xfff00000) << 12;
> +}
> +
> +/*
> + * check-name: shl-or-constant0
> + * check-command: test-linearize -Wno-decl $file
> + *
> + * check-output-ignore
> + * check-output-excludes: or\\.
> + */
> diff --git a/validation/optim/shl-or-constant1.c b/validation/optim/shl-or-constant1.c
> new file mode 100644
> index 000000000000..cd3ea8bb011b
> --- /dev/null
> +++ b/validation/optim/shl-or-constant1.c
> @@ -0,0 +1,12 @@
> +unsigned shl_or_constant1(unsigned a)
> +{
> +	return (a | 0x000fffff) << 12;
> +}
> +
> +/*
> + * check-name: shl-or-constant1
> + * check-command: test-linearize -Wno-decl $file
> + *
> + * check-output-ignore
> + * check-output-contains: ret\\..*\\$0xfffff000
> + */
> diff --git a/validation/optim/shl-or-constant2.c b/validation/optim/shl-or-constant2.c
> new file mode 100644
> index 000000000000..d4618eb1bab8
> --- /dev/null
> +++ b/validation/optim/shl-or-constant2.c
> @@ -0,0 +1,12 @@
> +unsigned shl_or_constant2(unsigned a)
> +{
> +	return (a | 0x00ffff0f) << 12;
> +}
> +
> +/*
> + * check-name: shl-or-constant2
> + * check-command: test-linearize -Wno-decl $file
> + *
> + * check-output-ignore
> + * check-output-contains: or\\..*\\$0xfff0f
> + */
> 
