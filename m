Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5906EC4332D
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 16:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3935F20867
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 16:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438134AbgL1QOn (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 28 Dec 2020 11:14:43 -0500
Received: from avasout06.plus.net ([212.159.14.18]:57986 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbgL1QOm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 28 Dec 2020 11:14:42 -0500
Received: from [10.0.2.15] ([80.189.83.3])
        by smtp with ESMTPA
        id tv9ekPcmFhO4Htv9fkCtEi; Mon, 28 Dec 2020 16:13:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1609172036; bh=+/HrqG/VWtrINCJwq7gkxbatqYP2VBg3xJW1GGgRohQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=H0aK8p6g1CCD/A7f5TdU1ay0qyT1AzZyCATEHDkEKJUemoaktRvBN9G0Bw2sxRCmu
         CEgucbVJhoFHHmQj9SCHa7lpiqEuT5kO/QY77+xzEamb7pkxrpHResPOcbf4u7LXxz
         F2Q2sOg+ijMxJ6jiRRBBx960MxdWhAO7Abbtpbm3H3xdJEJZ9ZzOyU6uDWgm3WsES5
         pUKyatkpIS6ciUHiJsAIfX3AWBMmby0xjDC89gf1EIdSZwexWWm0bXujGfqebzasiS
         dozYY+5F+GRsMPSkhy95FQYlzLL131prjgiwbfEnB4Db5Ate9HqtkXNoLxZoYtiSZe
         ehpZSojlfyM2w==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=SPPZqNnH c=1 sm=1 tr=0
 a=HN+d/rRCB1WM0IHjUF19mA==:117 a=HN+d/rRCB1WM0IHjUF19mA==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=7FDETKbVEq9MJ04ngX8A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 04/16] add testcases for type attributes
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
 <20201226175129.9621-5-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <f39438bd-3ab3-b827-a488-510b49351eb5@ramsayjones.plus.com>
Date:   Mon, 28 Dec 2020 16:13:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201226175129.9621-5-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLRXqv4acy5L1DDZF+9WApaS++mzSFcilieijidi2vB9OlIcjBAiMcdcb91fu/Ioy7iElokJcTdYtnCDhcocvxR6mIlosmAhaYvHYbtPMyQ8gVDg7uGQ
 +JuDz4/+bS8gz5wU/hq4tON7y+LzeCAKHKSx/RUurku8dXjaMaiAFaIUTRehEv47A1t/L8pcxHRuXQ==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 26/12/2020 17:51, Luc Van Oostenryck wrote:
> Currently, type attributes are not handled correctly.
> 
> Add some testcases for them.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  validation/type-attribute-align.c | 20 ++++++++++++++++++
>  validation/type-attribute-as.c    | 34 +++++++++++++++++++++++++++++++
>  validation/type-attribute-mod.c   | 22 ++++++++++++++++++++
>  validation/type-attribute-qual.c  | 12 +++++++++++
>  4 files changed, 88 insertions(+)
>  create mode 100644 validation/type-attribute-align.c
>  create mode 100644 validation/type-attribute-as.c
>  create mode 100644 validation/type-attribute-mod.c
>  create mode 100644 validation/type-attribute-qual.c
> 
> diff --git a/validation/type-attribute-align.c b/validation/type-attribute-align.c
> new file mode 100644
> index 000000000000..d9358bff8327
> --- /dev/null
> +++ b/validation/type-attribute-align.c
> @@ -0,0 +1,20 @@
> +#define __aligned(N)	__attribute__((aligned(N)))
> +#define alignof(X)	__alignof__(X)
> +
> +struct s {
> +	short a, b, c;
> +} __aligned(2*sizeof(short));
> +
> +static int fs(void) { return  sizeof(struct s); }
> +static int fa(void) { return alignof(struct s); }
> +
> +void main(void)
> +{
> +	_Static_assert( sizeof(struct s) == 4 * sizeof(short), "size");
> +	_Static_assert(alignof(struct s) == 2 * sizeof(short), "alignment");
> +}
> +
> +/*
> + * check-name: type-attribute-align
> + * check-known-to-fail
> + */
> diff --git a/validation/type-attribute-as.c b/validation/type-attribute-as.c
> new file mode 100644
> index 000000000000..b40b4e7dddf5
> --- /dev/null
> +++ b/validation/type-attribute-as.c
> @@ -0,0 +1,34 @@
> +#define	__as		__attribute__((address_space(__as)))
> +
> +struct s {
> +	int i;
> +} __as;
> +
> +
> +extern void use0(void *);
> +extern void use1(void __as *);
> +
> +void main(void)
> +{
> +	struct s s;
> +	int i;
> +
> +	use0(&s);	// KO
> +	use0(&i);	// OK
> +	use1(&s);	// OK
> +	use1(&i);	// KO
> +}
> +
> +/*
> + * check-name: type-attribute-as
> + * check-known-to-fail
> + *
> + * check-error-start
> +type-attribute-as.c:16:15: warning: incorrect type in argument 1 (different address spaces)
> +type-attribute-as.c:16:15:    expected void *
> +type-attribute-as.c:16:15:    got struct s __as *
> +type-attribute-as.c:19:15: warning: incorrect type in argument 1 (different address spaces)
> +type-attribute-as.c:19:15:    expected void __as *
> +type-attribute-as.c:19:15:    got int *
> + * check-error-end
> + */
> diff --git a/validation/type-attribute-mod.c b/validation/type-attribute-mod.c
> new file mode 100644
> index 000000000000..0e7b166a4aec
> --- /dev/null
> +++ b/validation/type-attribute-mod.c
> @@ -0,0 +1,22 @@
> +#define	__noderef	__attribute__((noderef))
> +
> +struct s {
> +	int i;
> +} __noderef;
> +
> +
> +void main(void)
> +{
> +	struct s s;
> +
> +	s.i = 0;
> +}
> +
> +/*
> + * check-name: type-attribute-mod
> + * check-known-to-fail
> + *
> + * check-error-start
> +type-attribute-mod.c:12:9: warning: dereference of noderef expression
> + * check-error-end
> + */
> diff --git a/validation/type-attribute-qual.c b/validation/type-attribute-qual.c
> new file mode 100644
> index 000000000000..ab19a605bda1
> --- /dev/null
> +++ b/validation/type-attribute-qual.c
> @@ -0,0 +1,12 @@
> +static const struct s {
> +	int x;
> +} map[2];
> +
> +static void foo(struct s *p, int v)
> +{
> +	p->x += v;
> +}

Hmm, I don't understand what this is testing! :(

ATB,
Ramsay Jones

> +
> +/*
> + * check-name: type-attribute-qual
> + */
> 
