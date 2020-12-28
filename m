Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3B0C43381
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 16:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4885B208D5
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 16:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633593AbgL1Q3R (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 28 Dec 2020 11:29:17 -0500
Received: from avasout06.plus.net ([212.159.14.18]:58953 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633597AbgL1Q3M (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 28 Dec 2020 11:29:12 -0500
Received: from [10.0.2.15] ([80.189.83.3])
        by smtp with ESMTPA
        id tvNgkPdsEhO4HtvNikCtnX; Mon, 28 Dec 2020 16:28:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1609172906; bh=ur+vCMDdPcT2J90JLb84ufFfdF5baeb4+7/ayDftrcU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=qZUGEw7dDwJPGw02/I/S2zATQiZbZU2U5F9cTObU6JVTvcra+9Jzy87k78xh9xMKu
         1epjixhvilo7tJ2fAzlaNdxk5+3tOiaf3niTWRxKCsfe9RmYbGSENELjBwAw7F/gZ5
         TaazzFrF31TBHUaV0VEWllxluV4odJ1Tc79LWcwaP2hfCEjvfwwwENzalCyI/RgUNB
         ua2q2Gw/kmxMMxBCJEx/6tKTLoQXzpBBshf5hJFejFbBMizPu6ie80ONM4lllpDDu1
         xs7KHcuTGsiSEejE2SXkFnAPjt1vzoYmXXhA9xSh8/HT8350ur+HYKAutx8Cm3VF4I
         Cx60d9fab3ggw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=SPPZqNnH c=1 sm=1 tr=0
 a=HN+d/rRCB1WM0IHjUF19mA==:117 a=HN+d/rRCB1WM0IHjUF19mA==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=L6HFMk6KsOFy63AIlGwA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 06/16] add testcases for packed bitfields
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
 <20201226175129.9621-7-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <2c40677d-a0a8-7f32-46c3-80dc0385efee@ramsayjones.plus.com>
Date:   Mon, 28 Dec 2020 16:28:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201226175129.9621-7-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHrgH6/XzoQ37n9vU+/2ELC645IWBPEPBRr4/Cva2TPwQrs2zr3KZA/RBxDBMoZH3eHz3Mq46s87idX26N/SZ/212TwJvd/MXQPqzqVZxLotMxRjNcWn
 u2W3uqpoa+RqXqeYgQYfD7TvUQiZ6WgJ2U22cRQntQCELAG/zwYh5w4LDw6UZvT9b+ONnNMDbbhtqQ==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 26/12/2020 17:51, Luc Van Oostenryck wrote:
> Currently, packed bitfields are not handled correctly.
> 
> Add some testcases for them.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  validation/packed-bitfield0.c | 67 +++++++++++++++++++++++++++++++++++
>  validation/packed-bitfield1.c | 28 +++++++++++++++
>  validation/packed-bitfield2.c | 16 +++++++++
>  validation/packed-bitfield3.c | 29 +++++++++++++++
>  validation/packed-bitfield4.c | 19 ++++++++++
>  validation/packed-bitfield5.c | 21 +++++++++++
>  6 files changed, 180 insertions(+)
>  create mode 100644 validation/packed-bitfield0.c
>  create mode 100644 validation/packed-bitfield1.c
>  create mode 100644 validation/packed-bitfield2.c
>  create mode 100644 validation/packed-bitfield3.c
>  create mode 100644 validation/packed-bitfield4.c
>  create mode 100644 validation/packed-bitfield5.c
> 
> diff --git a/validation/packed-bitfield0.c b/validation/packed-bitfield0.c
> new file mode 100644
> index 000000000000..907500dedbf0
> --- /dev/null
> +++ b/validation/packed-bitfield0.c
> @@ -0,0 +1,67 @@
> +#define alignof(X)	__alignof__(X)
> +#define __packed	__attribute__((packed))
> +
> +struct sa {
> +	int a:7;
> +	int c:10;
> +	int b:2;
> +} __packed;
> +_Static_assert(alignof(struct sa) == 1, "alignof(struct sa)");
> +_Static_assert( sizeof(struct sa) == 3,  "sizeof(struct sa)");
> +
> +struct __packed sb {
> +	int a:7;
> +	int c:10;
> +	int b:2;
> +};
> +_Static_assert(alignof(struct sb) == 1, "alignof(struct sb)");
> +_Static_assert( sizeof(struct sb) == 3,  "sizeof(struct sb)");

Why 'struct sb'? It is not used in the rest of the test (and is
identical to 'struct sa').

> +
> +
> +static int get_size(void)
> +{
> +	return sizeof(struct sa);
> +}
> +
> +static void chk_align(struct sa sa, struct sa *p)
> +{
> +	_Static_assert(alignof(sa) == 1, "alignof(sa)");
> +	_Static_assert(alignof(*p) == 1, "alignof(*p)");
> +}
> +
> +static int fp0(struct sa *sa)
> +{
> +	return sa->c;
> +}
> +
> +static int fpx(struct sa *sa, int idx)
> +{
> +	return sa[idx].c;
> +}
> +
> +static int fglobal(void)
> +{
> +	extern struct sa g;
> +	return g.c;
> +}
> +
> +static struct sa l;
> +static int flocal(void)
> +{
> +	return l.c;
> +}
> +
> +
> +int main(void)
> +{
> +	extern void fun(struct sa *);
> +	struct sa sa = { 0 };
> +
> +	fun(&sa);
> +	return 0;
> +}
> +
> +/*
> + * check-name: packed-bitfield0
> + * check-known-to-fail
> + */
> diff --git a/validation/packed-bitfield1.c b/validation/packed-bitfield1.c
> new file mode 100644
> index 000000000000..208a3dc5127c
> --- /dev/null
> +++ b/validation/packed-bitfield1.c
> @@ -0,0 +1,28 @@
> +#define __packed	__attribute__((packed))
> +
> +struct s {
> +	unsigned int f0:1;
> +	unsigned int f1:1;
> +	unsigned int pad:6;
> +} __packed;
> +_Static_assert(sizeof(struct s) == 1,  "sizeof(struct s)");
> +
> +extern struct s g;
> +
> +static int foo(struct s *ptr)
> +{
> +	int f = 0;
> +
> +	f += g.f0;
> +	f += g.f1;
> +
> +	f += ptr->f0;
> +	f += ptr->f1;
> +
> +	return f;
> +}
> +
> +/*
> + * check-name: packed-bitfield1
> + * check-known-to-fail
> + */
> diff --git a/validation/packed-bitfield2.c b/validation/packed-bitfield2.c
> new file mode 100644
> index 000000000000..4587ebec5c90
> --- /dev/null
> +++ b/validation/packed-bitfield2.c
> @@ -0,0 +1,16 @@
> +struct bf2 {
> +	unsigned p1:2;
> +	unsigned i1:32;
> +	unsigned p2:2;
> +	unsigned s9:9;
> +	unsigned s9:9;
> +	unsigned s9:9;
> +	unsigned b1:1;
> +} __attribute__((packed));
> +
> +_Static_assert(sizeof(struct bf2) == 8);
> +
> +/*
> + * check-name: packed-bitfield2
> + * check-known-to-fail
> + */
> diff --git a/validation/packed-bitfield3.c b/validation/packed-bitfield3.c
> new file mode 100644
> index 000000000000..6acff875299f
> --- /dev/null
> +++ b/validation/packed-bitfield3.c
> @@ -0,0 +1,29 @@
> +#define __packed __attribute__((packed))
> +
> +typedef unsigned char   u8;
> +typedef __UINT16_TYPE__ u16;
> +typedef __UINT32_TYPE__ u32;
> +typedef __UINT64_TYPE__ u64;
> +
> +struct b {
> +	u32	a:1;
> +	u32	b:2;
> +	u32	c:4;
> +	u32	d:8;
> +	u32	e:16;
> +} __packed;
> +_Static_assert(__alignof(struct b) == 1);
> +_Static_assert(   sizeof(struct b) == sizeof(u32));

Again '== sizeof(u32)' does not seem useful. (what is it
trying to say?)

> +
> +struct c {
> +	u8	a;
> +	u8	b;
> +	u64	c:48;
> +} __packed;
> +_Static_assert(__alignof(struct c) == 1);
> +_Static_assert(   sizeof(struct c) == sizeof(u64));

ditto.

ATB,
Ramsay Jones

> +
> +/*
> + * check-name: packed-bitfield3
> + * check-known-to-fail
> + */
> diff --git a/validation/packed-bitfield4.c b/validation/packed-bitfield4.c
> new file mode 100644
> index 000000000000..0342b2414b6e
> --- /dev/null
> +++ b/validation/packed-bitfield4.c
> @@ -0,0 +1,19 @@
> +#define __packed __attribute__((packed))
> +
> +typedef __UINT32_TYPE__ u32;
> +
> +struct s {
> +	u32	f:24;
> +} __packed;
> +_Static_assert(sizeof(struct s) == 3);
> +
> +static int ld(struct s *s)
> +{
> +	return s->f;
> +}
> +
> +/*
> + * check-name: packed-bitfield4
> + * check-description: Is check_access() OK with short packed bitfields?
> + * check-known-to-fail
> + */
> diff --git a/validation/packed-bitfield5.c b/validation/packed-bitfield5.c
> new file mode 100644
> index 000000000000..8f44d4c2c277
> --- /dev/null
> +++ b/validation/packed-bitfield5.c
> @@ -0,0 +1,21 @@
> +#define __packed __attribute__((packed))
> +
> +typedef __UINT32_TYPE__ u32;
> +
> +struct s {
> +	u32	a:5;
> +	u32	f:30;
> +	u32	z:5;
> +} __packed;
> +_Static_assert(sizeof(struct s) == 5);
> +
> +static int ld(struct s *s)
> +{
> +	return s->f;
> +}
> +
> +/*
> + * check-name: packed-bitfield5
> + * check-description: is check_access() OK with 'overlapping' packed bitfields?
> + * check-known-to-fail
> + */
> 
