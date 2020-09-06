Return-Path: <SRS0=5g4H=CP=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E445C433E2
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 16:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80CEE2075A
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 16:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="FZwEQr8m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgIFQUQ (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 6 Sep 2020 12:20:16 -0400
Received: from avasout04.plus.net ([212.159.14.19]:35034 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728779AbgIFQUP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Sep 2020 12:20:15 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Sep 2020 12:20:14 EDT
Received: from [10.0.2.15] ([195.213.6.112])
        by smtp with ESMTPA
        id ExHUkqBrLrXCcExHWkzGgq; Sun, 06 Sep 2020 17:12:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1599408762; bh=TwusdC5SXSsVfLEKUqFIT0rw9z6aJJEalfwtAkRVKlU=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=FZwEQr8m0Iq4elQ0jqmf9hgcgwgo2g5HsbvKzOTjiAmFIf9MFBf7ElxBQD5KXnfP9
         ElORsq3DBHZalYAoTTSQLqLBC3nMTgH6/ryxkDhGv8ui0YhzKJL+VGV3mgUNJdX+En
         zHN1PH5Lxl1i/1azmM4UAkbsKDP8XLkBbvOEah3HRRLkNHCZuCftlJ9mDHZgAOvYAY
         v8/sBGOvSlEcm5+hE03zofmXMNbb3fIIO5bsc1rw2A/JNe/yZwClM6ZSdJwLUmnXPe
         lA9KrwgHEVUIrTFpR95H8IC0GCwrrfDz3LVqkmxRnuyniypE/xLeAwAugp1SMTIxhs
         ssIAw/1Z4AmAw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Q+xJH7+a c=1 sm=1 tr=0
 a=/rD2idLCdDHnmLflUbi9CQ==:117 a=/rD2idLCdDHnmLflUbi9CQ==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=9xaCok67IMOZZ_14N7cA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/3] add more testcases for existing AND/OR
 simplifications
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
References: <20200906124038.46786-1-luc.vanoostenryck@gmail.com>
 <20200906124038.46786-2-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <b699c65e-5173-79dc-3ddb-20242646f0f1@ramsayjones.plus.com>
Date:   Sun, 6 Sep 2020 17:12:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200906124038.46786-2-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFRvRIrKJg7rAwjUU1JVM5iqX4+WFii0IDGxMc6NWkfATpr1yToRnHz5u1JDkq9tDmABHquyJtlLjneaMBThMgqGLceBgbMb2rrjWO6WRJoQCxUsjLph
 cbyjnm760zpWJS5BBKuSo+mBqN17uw9s94iOpXWhbhJlhUSFpPtrSu83t1RJAK/WmjN0gNUToKxH0A==
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 06/09/2020 13:40, Luc Van Oostenryck wrote:
> Add a few more testcases to catch possible future regressions.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  validation/optim/and-shl-or-and0.c  | 13 +++++++++++++
>  validation/optim/lsr-or-and0.c      | 23 +++++++++++++++++++++++
>  validation/optim/shl-or-constant0.c | 12 ++++++++++++
>  validation/optim/shl-or-constant1.c | 12 ++++++++++++
>  validation/optim/shl-or-constant2.c | 12 ++++++++++++
>  5 files changed, 72 insertions(+)
>  create mode 100644 validation/optim/and-shl-or-and0.c
>  create mode 100644 validation/optim/lsr-or-and0.c
>  create mode 100644 validation/optim/shl-or-constant0.c
>  create mode 100644 validation/optim/shl-or-constant1.c
>  create mode 100644 validation/optim/shl-or-constant2.c
> 
> diff --git a/validation/optim/and-shl-or-and0.c b/validation/optim/and-shl-or-and0.c
> new file mode 100644
> index 000000000000..ea08d2622a95
> --- /dev/null
> +++ b/validation/optim/and-shl-or-and0.c
> @@ -0,0 +1,13 @@
> +unsigned and_shl_or_and0(unsigned a, unsigned b)
> +{
> +	return (((a & 0xfff00000) | b) << 12) & 0xfff00000;

->(((a & 0xfff00000) << 12) | (b << 12)) & 0xfff00000
->(( 0 | (b << 12)) & 0xfff00000
->((b << 12)) & 0xfff00000
> +}
> +
> +/*
> + * check-name: and-shl-or-and0
> + * check-command: test-linearize -Wno-decl $file
> + *
> + * check-output-ignore
> + * check-output-excludes: or\\.
> + * check-output-excludes: lsr\\.

why would there be a right-shift to begin with?
(maybe add check-output-excludes: %arg1)

> + */
> diff --git a/validation/optim/lsr-or-and0.c b/validation/optim/lsr-or-and0.c
> new file mode 100644
> index 000000000000..3c369cb9497e
> --- /dev/null
> +++ b/validation/optim/lsr-or-and0.c
> @@ -0,0 +1,23 @@
> +#define	S	12
> +
> +//	((x & M) | b) >> S;
> +// ->	((x >> S) & (M >> S)) | (b >> S)

OK

> +// 0a:  (M >> S) == 0
> +// 0b:  (x >> S) == 0
> +// 0c:  (b >> S) == 0

I do not understand what these three lines are trying to say! :(

> +
> +int lsr_or_and0a(unsigned int x, unsigned int b)

s/and0a/and0/ - was there an '_and0b' at one time?

> +{
> +	return ((x & 0x00000fff) | b) >> S;

->((x & 0x00000fff) >> S) | (b >> S)
->((0)) | (b >> S)
-> b >> S

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

OK

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

->(a << 12) | (0xfff00000 << 12)
->(a << 12) | (0)
-> a << 12

> +}
> +
> +/*
> + * check-name: shl-or-constant0
> + * check-command: test-linearize -Wno-decl $file
> + *
> + * check-output-ignore
> + * check-output-excludes: or\\.

OK

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

OK

> + */
> diff --git a/validation/optim/shl-or-constant2.c b/validation/optim/shl-or-constant2.c
> new file mode 100644
> index 000000000000..9dbde3b574d7
> --- /dev/null
> +++ b/validation/optim/shl-or-constant2.c
> @@ -0,0 +1,12 @@
> +unsigned shl_or_constant1(unsigned a)

s/_constant1/_constant2/

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

OK

> + */
> 

ATB,
Ramsay Jones

