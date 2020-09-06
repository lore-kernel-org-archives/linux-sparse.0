Return-Path: <SRS0=5g4H=CP=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BD3C433E2
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 16:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED02207BB
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 16:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="aQ0Lb+7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgIFQi6 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 6 Sep 2020 12:38:58 -0400
Received: from avasout04.plus.net ([212.159.14.19]:36003 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgIFQi5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Sep 2020 12:38:57 -0400
Received: from [10.0.2.15] ([195.213.6.112])
        by smtp with ESMTPA
        id ExgtkqD5VrXCcExgukzH51; Sun, 06 Sep 2020 17:38:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1599410336; bh=QYCVuBYtt5HRK8qLfMnMAgVVZ1p+yEy4KOkW3ZnYPt8=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=aQ0Lb+7rWbLXT0qafyRkK/L4LLelV0Mvn0kqNyP2m//RBNW/2nvFBzPOKubDTZwUl
         tXhRBXLCwifHSBOUA0M5wMeulV6K03QDjGPJ/Ajyf9iS7Bsgc7d7uRo80UGkpKkpyh
         k9G15I0NCVDuEELy/nLphBIfVf0HEE7lKfh1wQZsoc5hxDFlzrclMhFJGsKMTqwdum
         kgSafwzBEZ6n5qTjw2EjNyHzf1Bu3iL5+Ea2m3zkiIsUImyKAAGufMAZzWd6mXMBPC
         LmaL+nUotJsol2v6wvnThoKN36ola+gmflVc+tX0cE/3DOiVkxmZWvl0kE5DHA4uH5
         5kGtjpP24bcUA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Q+xJH7+a c=1 sm=1 tr=0
 a=/rD2idLCdDHnmLflUbi9CQ==:117 a=/rD2idLCdDHnmLflUbi9CQ==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=Nt63sFjEgXTrhx5RszAA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/3] add more testcases for AND/OR simplification
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
References: <20200906124038.46786-1-luc.vanoostenryck@gmail.com>
 <20200906124038.46786-3-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <bd752e76-f71a-699a-7253-631bd9d4c090@ramsayjones.plus.com>
Date:   Sun, 6 Sep 2020 17:38:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200906124038.46786-3-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfD9KSZJ2mU6MCY/ucXDdCT9nwKZs8lEhSZe/Q0jy8znuZAXAEOUHoa8R3mrvB9cvrqhY3mevMiRGz6WiOQxIDsfbhmYI2psfgE/+UnQDHYAmQm8j8Hzk
 C8TFLMVyJmyGLogsv7nwJ6C1AwTwtB519hFkv05KSZktdBynh7kt2wIVBfIUJs2FyNVED/ZH06tkpA==
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 06/09/2020 13:40, Luc Van Oostenryck wrote:
> Add a few testcases showing the effectiveness of these
> simplifications and to catch possible future regressions.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  validation/optim/and-lsr-or-shl0.c | 12 ++++++++++++
>  validation/optim/and-lsr-or-shl1.c | 12 ++++++++++++
>  validation/optim/and-shl-or-lsr0.c | 13 +++++++++++++
>  validation/optim/lsr-or-lsr0.c     | 20 ++++++++++++++++++++
>  validation/optim/trunc-or-shl0.c   | 19 +++++++++++++++++++
>  5 files changed, 76 insertions(+)
>  create mode 100644 validation/optim/and-lsr-or-shl0.c
>  create mode 100644 validation/optim/and-lsr-or-shl1.c
>  create mode 100644 validation/optim/and-shl-or-lsr0.c
>  create mode 100644 validation/optim/lsr-or-lsr0.c
>  create mode 100644 validation/optim/trunc-or-shl0.c

Given that these are new tests, I was (er..) expecting some
'*.expected' files! However, I guess (since they are all failing
tests anyway) those will come in future patches which will
actually implement the optimization.

> 
> diff --git a/validation/optim/and-lsr-or-shl0.c b/validation/optim/and-lsr-or-shl0.c
> new file mode 100644
> index 000000000000..e2a517ab65c4
> --- /dev/null
> +++ b/validation/optim/and-lsr-or-shl0.c
> @@ -0,0 +1,12 @@
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
> + */
> diff --git a/validation/optim/and-lsr-or-shl1.c b/validation/optim/and-lsr-or-shl1.c
> new file mode 100644
> index 000000000000..6f2d05a0bfdd
> --- /dev/null
> +++ b/validation/optim/and-lsr-or-shl1.c
> @@ -0,0 +1,12 @@
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
> + */
> diff --git a/validation/optim/and-shl-or-lsr0.c b/validation/optim/and-shl-or-lsr0.c
> new file mode 100644
> index 000000000000..f2a7cc631258
> --- /dev/null
> +++ b/validation/optim/and-shl-or-lsr0.c
> @@ -0,0 +1,13 @@
> +unsigned and_shl_or_lsr0(unsigned a, unsigned b)
> +{
> +	return ((a | (b >> 12)) << 12) & 0xfff00000;
> +}
> +
> +/*
> + * check-name: and-shl-or-lsr0
> + * check-command: test-linearize -Wno-decl $file
> + * check-known-to-fail
> + *
> + * check-output-ignore
> + * check-output-excludes: or\\.
> + */
> diff --git a/validation/optim/lsr-or-lsr0.c b/validation/optim/lsr-or-lsr0.c
> new file mode 100644
> index 000000000000..a1687ec21ff0
> --- /dev/null
> +++ b/validation/optim/lsr-or-lsr0.c
> @@ -0,0 +1,20 @@
> +#define	S	12
> +
> +//	((x >> S') | y) >> S;
> +// ->	((x >> S >> S) | (y >> S)

// -> (x >> S' >> S) | (y >> S)
// -> (x >> (32 - S + S)) | (y >> S)
// -> (x >> 32) | (y >> S)
// -> (0) | (y >> S)
// -> y >> S

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
> + * check-output-excludes: or\\.
> + */
> diff --git a/validation/optim/trunc-or-shl0.c b/validation/optim/trunc-or-shl0.c
> new file mode 100644
> index 000000000000..4d85a6bd4ec4
> --- /dev/null
> +++ b/validation/optim/trunc-or-shl0.c
> @@ -0,0 +1,19 @@
> +char trunc_or_shl0a(unsigned a, unsigned b)
> +{
> +	return (a << 8) | b;
> +}
> +
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

Hmm, I can't see an optimization for these two! :(
Care to explain just what you expect? (maybe with an
'*.expected' file?)

> + */
> 

ATB,
Ramsay Jones

