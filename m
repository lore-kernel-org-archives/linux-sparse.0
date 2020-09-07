Return-Path: <SRS0=xoI2=CQ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B70C43461
	for <linux-sparse@archiver.kernel.org>; Mon,  7 Sep 2020 00:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26083214F1
	for <linux-sparse@archiver.kernel.org>; Mon,  7 Sep 2020 00:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="FzcHeXNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgIGAPY (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 6 Sep 2020 20:15:24 -0400
Received: from avasout06.plus.net ([212.159.14.18]:48375 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgIGAPY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Sep 2020 20:15:24 -0400
Received: from [10.0.2.15] ([195.213.6.112])
        by smtp with ESMTPA
        id F4oZkCAufkvt5F4oak7dYa; Mon, 07 Sep 2020 01:15:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1599437721; bh=0E/IwhCSC0LhKAtJhUYK+2EyqNWZfN6Xp29Iqmi+kDQ=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=FzcHeXNIBFnY2zlKRXsnr0dC78zDANf4xC6azXFe4kf93YbKKgKg6ELP/mPKAXsYw
         GBewRCqZFu0Y2uXJ0y6TkN/SAKvchECEj1kDdiKdLqr9hgB5ZWVfidfKg2M+Xgdphm
         fxLCnGRejxq+JSf2iX/XsJ8Cq4uyP9wY6PYWS0+SK0ugLADCdnbXatoZ2ildFozAh+
         rXmCKkzUFLWA0kor9wUQ5ChhZNILjJ+Fgu0fQzDVkX2BISWqp0y77oPe8C1q93Xcqx
         Rb03f3rlSvFM2tuVorgCnAnpZXCV8LY78ve9P6hZud42GcB4x0Xm8cjVIhVYvAylO9
         q1XrenaJM1bxg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=ENCdL2RC c=1 sm=1 tr=0
 a=/rD2idLCdDHnmLflUbi9CQ==:117 a=/rD2idLCdDHnmLflUbi9CQ==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=CZ93LnbAB3jHazIm4WkA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 3/3] add more testcases for AND/OR simplification
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
References: <20200906211646.58946-1-luc.vanoostenryck@gmail.com>
 <20200906211646.58946-4-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <7ead3fd3-34f4-f5d4-21fa-c7937fcab5fe@ramsayjones.plus.com>
Date:   Mon, 7 Sep 2020 01:15:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200906211646.58946-4-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfECkjswX6BSrCQcXYaeg+2UkGqEiQFowcLPWogFM2mp28cq9nR7baMG/tYM0BNWMttfXPunMzfKKov3pdiUgKYNnLBcGaaplk70nf5/4EyuAvhQywtgp
 ug1SAItLa4BdxoUyikepzhTG0uIqVSyKndjZx/VVM79uiB4BndevQli3bFArxFQICjWorPYsHKgKCA==
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 06/09/2020 22:16, Luc Van Oostenryck wrote:
> Add a few testcases showing the effectiveness of these
> simplifications and to catch possible future regressions.
> 

Sorry, I had to step away from the keyboard for a couple
of hours ...

> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  validation/optim/and-lsr-or-shl0.c | 13 +++++++++++++
>  validation/optim/and-lsr-or-shl1.c | 13 +++++++++++++
>  validation/optim/and-shl-or-lsr0.c | 13 +++++++++++++
>  validation/optim/lsr-or-lsr0.c     | 22 ++++++++++++++++++++++
>  validation/optim/trunc-or-shl0.c   | 22 ++++++++++++++++++++++
>  5 files changed, 83 insertions(+)
>  create mode 100644 validation/optim/and-lsr-or-shl0.c
>  create mode 100644 validation/optim/and-lsr-or-shl1.c
>  create mode 100644 validation/optim/and-shl-or-lsr0.c
>  create mode 100644 validation/optim/lsr-or-lsr0.c
>  create mode 100644 validation/optim/trunc-or-shl0.c
> 
> diff --git a/validation/optim/and-lsr-or-shl0.c b/validation/optim/and-lsr-or-shl0.c
> new file mode 100644
> index 000000000000..46ab1bde5249
> --- /dev/null
> +++ b/validation/optim/and-lsr-or-shl0.c
> @@ -0,0 +1,13 @@
> +// =>	0
> +unsigned int and_lsr_or_shl0(unsigned int a, unsigned int b)
> +{
> +	return ((a | b << 12) >> 12) & 0xfff00000;
> +}
> +
> +/*
> + * check-name: and-lsr-or-shl0
> + * check-command: test-linearize -Wno-decl $file
> + * check-known-to-fail
> + *
> + * check-output-excludes: shl\\.

Why not something like:
  * check-output-contains: ret.32 *\\$0
  * check-output-excludes: shl\\.
  * check-output-excludes: or\\.
  * check-output-excludes: lsr\\.
  * check-output-excludes: and\\.

> + */
> diff --git a/validation/optim/and-lsr-or-shl1.c b/validation/optim/and-lsr-or-shl1.c
> new file mode 100644
> index 000000000000..22fee362b16b
> --- /dev/null
> +++ b/validation/optim/and-lsr-or-shl1.c
> @@ -0,0 +1,13 @@
> +// =>	(((a | b << 12) >> 12)
> +unsigned int and_lsr_or_shl1(unsigned int a, unsigned int b)
> +{
> +	return ((a | b << 12) >> 12) & 0x000fffff;
> +}
> +
> +/*
> + * check-name: and-lsr-or-shl1
> + * check-command: test-linearize -Wno-decl $file
> + * check-known-to-fail
> + *
> + * check-output-excludes: shl\\.

Hmm, this should be ': and\\.' right?

> + */
> diff --git a/validation/optim/and-shl-or-lsr0.c b/validation/optim/and-shl-or-lsr0.c
> new file mode 100644
> index 000000000000..f2a7cc631258
> --- /dev/null
> +++ b/validation/optim/and-shl-or-lsr0.c
> @@ -0,0 +1,13 @@

Hmm, I can't see the optimization, just ...

> +unsigned and_shl_or_lsr0(unsigned a, unsigned b)
> +{
> +	return ((a | (b >> 12)) << 12) & 0xfff00000;

->((a << 12) | ((b >> 12) << 12)) & 0xfff00000
->((a << 12) | b) & 0xfff00000
so that ...

> +}
> +
> +/*
> + * check-name: and-shl-or-lsr0
> + * check-command: test-linearize -Wno-decl $file
> + * check-known-to-fail
> + *
> + * check-output-ignore
> + * check-output-excludes: or\\.

... this wouldn't be correct. puzzled! :(

> + */
> diff --git a/validation/optim/lsr-or-lsr0.c b/validation/optim/lsr-or-lsr0.c
> new file mode 100644
> index 000000000000..aad4aa7fda56
> --- /dev/null
> +++ b/validation/optim/lsr-or-lsr0.c
> @@ -0,0 +1,22 @@
> +#define	S	12
> +
> +//	((x >> S') | y) >> S;
> +// ->	((x >> S' >> S) | (y >> S)

s/((x/(x/

> +// ->	((x >> 32) | (y >> S)

s/((x/(x/

> +// =>	(y >> S)
> +
> +int lsr_or_lsr0(unsigned int x, unsigned int b)
> +{
> +	return ((x >> (32 - S)) | b) >> S;
> +}
> +
> +/*
> + * check-name: lsr-or-lsr0
> + * check-command: test-linearize -Wno-decl $file
> + * check-known-to-fail
> + *
> + * check-output-ignore
> + * check-output-pattern(1): lsr\\.
> + * check-output-excludes: and\\.

why would an 'and' be here anyway?

> + * check-output-excludes: or\\.
> + */
> diff --git a/validation/optim/trunc-or-shl0.c b/validation/optim/trunc-or-shl0.c
> new file mode 100644
> index 000000000000..ab92aca1b711
> --- /dev/null
> +++ b/validation/optim/trunc-or-shl0.c
> @@ -0,0 +1,22 @@
> +// => TRUNC(b, 8)
> +char trunc_or_shl0a(unsigned a, unsigned b)
> +{
> +	return (a << 8) | b;
> +}
> +
> +// => TRUNC(a, 8)
> +char trunc_or_shl0b(unsigned a, unsigned b)
> +{
> +	return a | (b << 8);
> +}
> +
> +/*
> + * check-name: trunc-or-shl0
> + * check-command: test-linearize -Wno-decl $file
> + * check-known-to-fail
> + *
> + * check-output-ignore
> + * check-output-excludes: or\\.
> + * check-output-excludes: shl\\.
> + * check-output-pattern(2): %arg

OK, good.

> + */
> 

ATB,
Ramsay Jones

