Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B8DC4332E
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 16:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EB59207DE
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 16:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733022AbgL1QS1 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 28 Dec 2020 11:18:27 -0500
Received: from avasout06.plus.net ([212.159.14.18]:58190 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633017AbgL1QSZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 28 Dec 2020 11:18:25 -0500
Received: from [10.0.2.15] ([80.189.83.3])
        by smtp with ESMTPA
        id tvDEkPczkhO4HtvDGkCtIw; Mon, 28 Dec 2020 16:17:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1609172258; bh=JbUv/8uy5WNBemNmRzHe6ntYBj3A59mYIgveYBVCVbY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YKn2gc4vFK+GTHzhOWAvnbkjFtf22Kz0jZWIKRKnWS10Pu3gs8wAya+SiX614wark
         oFRfKF8bU2v4A8QZqlLg/z+vZvaFoBcDUtefuV+LF/0nBMmVgc3orghQo0iU5AAg7L
         SzTRlcR0T+jAAxMyo4hyZGJXNOKazxhUM0mBCHx3E7D7zpj9B1i4IDbcSkca3mSSH4
         +qUe8FwyCdDTymuwiCJpJ52j4TVj2HxHWb4aJk81PMVtSV2RSxbJc6sFWFYhC4Vo8f
         N6nIYrjpe5B37lqJ/x/5KgJBvYBqfTu2DJHr8ClFOfuI+XLGxgIr5lQX8fjZIUuKbI
         FtsTR0uD9HCPA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=SPPZqNnH c=1 sm=1 tr=0
 a=HN+d/rRCB1WM0IHjUF19mA==:117 a=HN+d/rRCB1WM0IHjUF19mA==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=SCBUOdos1vj2vPOXI-AA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 05/16] add testcases for packed structures
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
 <20201226175129.9621-6-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <860fe109-6819-ec55-e55f-90812b9f90f2@ramsayjones.plus.com>
Date:   Mon, 28 Dec 2020 16:17:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201226175129.9621-6-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCa5tyJcrZh7UC0lFkOavlOnb5QyDzjxUQBd2dCERHEW/GRX9yamrZJqLCNcLzOYmr5+dGCxlLlEqAs/Kd1DOZWJme4OyqfYmM7zYyIp8gjULC1ZA02b
 m/ciiepoe2vP6yS5Abh7v44zbZgXvIbGepd/QUJlSdLMfdBUPLwMKHYosx+sKsMqMfPvd0oBdyyenQ==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 26/12/2020 17:51, Luc Van Oostenryck wrote:
> Currently, packed structs are not handled correctly.
> 
> Add some testcases for them.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  validation/packed-deref0.c | 24 ++++++++++++++++++++++++
>  validation/packed-struct.c | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
>  create mode 100644 validation/packed-deref0.c
>  create mode 100644 validation/packed-struct.c
> 
> diff --git a/validation/packed-deref0.c b/validation/packed-deref0.c
> new file mode 100644
> index 000000000000..865ad68a4f37
> --- /dev/null
> +++ b/validation/packed-deref0.c
> @@ -0,0 +1,24 @@
> +#define	__packed	__attribute__((packed))
> +
> +typedef struct {
> +	__INT8_TYPE__	a;
> +	__INT16_TYPE__	b;
> +	__INT32_TYPE__	c;
> +} __packed obj_t;
> +
> +_Static_assert(sizeof(obj_t) == 7, "sizeof packed struct");
> +
> +static void foo(obj_t *ptr, int val)
> +{
> +	ptr->c = val;
> +}
> +
> +static void bar(obj_t o)
> +{
> +	foo(&o, 0);
> +}
> +
> +/*
> + * check-name: packed-deref0
> + * check-known-to-fail
> + */
> diff --git a/validation/packed-struct.c b/validation/packed-struct.c
> new file mode 100644
> index 000000000000..5039be4d0b45
> --- /dev/null
> +++ b/validation/packed-struct.c
> @@ -0,0 +1,33 @@
> +#define __packed __attribute__((packed))
> +
> +typedef unsigned char   u8;
> +typedef __UINT16_TYPE__ u16;
> +typedef __UINT32_TYPE__ u32;
> +typedef __UINT64_TYPE__ u64;
> +
> +struct a {
> +	u8 a;
> +	u8 b;
> +	u16 c;
> +} __packed;
> +_Static_assert(__alignof(struct a) == 1, "align struct");
> +_Static_assert(   sizeof(struct a) == sizeof(u32), " size struct");

Hmm, I don't think '== sizeof(u32)' is any better than '== 4'.

ATB,
Ramsay Jones

> +
> +struct b {
> +	u32	a;
> +	u32	b;
> +} __packed;
> +_Static_assert(__alignof(struct b) == 1, "align struct");
> +_Static_assert(   sizeof(struct b) == 8, "size struct");
> +
> +struct c {
> +	u16	a;
> +	u32	b;
> +} __packed;
> +_Static_assert(__alignof(struct c) == 1, "align struct");
> +_Static_assert(   sizeof(struct c) == 6, "size struct");
> +
> +/*
> + * check-name: packed-struct
> + * check-known-to-fail
> + */
> 
