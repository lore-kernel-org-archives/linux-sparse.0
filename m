Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444E8C4161F
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 23:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D8472222A
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 23:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgL1Wzv (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 28 Dec 2020 17:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729367AbgL1UG3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 28 Dec 2020 15:06:29 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2375AC061793
        for <linux-sparse@vger.kernel.org>; Mon, 28 Dec 2020 12:05:49 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id v14so396941wml.1
        for <linux-sparse@vger.kernel.org>; Mon, 28 Dec 2020 12:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jubLZmNPoYcHIjV9WEye0XKaCN5ETfA9NxMHs2mHC1A=;
        b=bs15TbxxVcHUODzS6fa/2Kt+EWq0sqEOjq0L80hiVCgVVPyiMxxF/XbkIg+NpaBMDB
         cnyDqwlnMb4ZtOQ150EoPJ+DrNjsnAd+hVq7NiovBzcdIETtumhmQ5+DHxrOnl7z7ZMh
         aRMZbRZj+dGXDdiKZ9m143lrq+jumLLnLNCEw8z35q7M0MfxflELh5xhuasPEGQeBRLh
         3zXFa6LHaBKimi5gIJlzHsIhSoJrSLdGq3YB8KmcajoCn+Y06/UnWszKRkO+4YpdJaTj
         HBXDQAE4CHqwmo14QRc7a4moQaKI0Fdq11dXkVqavF3E79O2SSBp0v5wA0MoQS58PS5i
         uSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jubLZmNPoYcHIjV9WEye0XKaCN5ETfA9NxMHs2mHC1A=;
        b=tnpQqs44mzPmZv5ZPz82I+5P6KUVda2gTOYZgxeontmBZ6crvWYIL284dDAa01ir+r
         +arqo4U95X0Fha+Vn+buiRRgv8KACLW1qL6TYNqvU+1hyFmxIuOZXti7WrB7eZb2nq+w
         5yPsFMGjx5Kuh/b6NI41dt+jRIOYmA1nSAbE7IT1d/Ymq6V4ZqKyVpfl1sLud1ZU/ZO3
         FMG4RpPhWYJM3lDUJhe0cVaxdAI6+46c8NxjTZ+2CeU2Q1mOwUnhhPgIYc1l6zrg6EiF
         MjVm/aONmO2BI5Q7UxcDo62CCV40BEBH3hbgCaEIXZGXhRPicjUBra3OQdtuviQa7HX0
         RQpA==
X-Gm-Message-State: AOAM5302nTrnWueFtVpLTCE3nNIszy6M6bLFBLxrqSBOuACZP/Ef0tad
        So8XjdX6Mh/1Z6dJoEZJAao=
X-Google-Smtp-Source: ABdhPJydiUPDAGCaWWsckut/E4CiPMu1usxtbhNfVNI55XQkjmo1WA10+7CIfCp1RYehho07LsCKkA==
X-Received: by 2002:a1c:8d:: with SMTP id 135mr423546wma.177.1609185947965;
        Mon, 28 Dec 2020 12:05:47 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:1cf:be4f:91b8:4ca6])
        by smtp.gmail.com with ESMTPSA id c4sm460036wmf.19.2020.12.28.12.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 12:05:47 -0800 (PST)
Date:   Mon, 28 Dec 2020 21:05:46 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     linux-sparse@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 06/16] add testcases for packed bitfields
Message-ID: <20201228200546.co4ibljkw6zvp3pe@ltop.local>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
 <20201226175129.9621-7-luc.vanoostenryck@gmail.com>
 <2c40677d-a0a8-7f32-46c3-80dc0385efee@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c40677d-a0a8-7f32-46c3-80dc0385efee@ramsayjones.plus.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Dec 28, 2020 at 04:28:24PM +0000, Ramsay Jones wrote:
> 
> 
> On 26/12/2020 17:51, Luc Van Oostenryck wrote:
> > Currently, packed bitfields are not handled correctly.
> > 
> > Add some testcases for them.
> > 
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > ---
> >  validation/packed-bitfield0.c | 67 +++++++++++++++++++++++++++++++++++
> >  validation/packed-bitfield1.c | 28 +++++++++++++++
> >  validation/packed-bitfield2.c | 16 +++++++++
> >  validation/packed-bitfield3.c | 29 +++++++++++++++
> >  validation/packed-bitfield4.c | 19 ++++++++++
> >  validation/packed-bitfield5.c | 21 +++++++++++
> >  6 files changed, 180 insertions(+)
> >  create mode 100644 validation/packed-bitfield0.c
> >  create mode 100644 validation/packed-bitfield1.c
> >  create mode 100644 validation/packed-bitfield2.c
> >  create mode 100644 validation/packed-bitfield3.c
> >  create mode 100644 validation/packed-bitfield4.c
> >  create mode 100644 validation/packed-bitfield5.c
> > 
> > diff --git a/validation/packed-bitfield0.c b/validation/packed-bitfield0.c
> > new file mode 100644
> > index 000000000000..907500dedbf0
> > --- /dev/null
> > +++ b/validation/packed-bitfield0.c
> > @@ -0,0 +1,67 @@
> > +#define alignof(X)	__alignof__(X)
> > +#define __packed	__attribute__((packed))
> > +
> > +struct sa {
> > +	int a:7;
> > +	int c:10;
> > +	int b:2;
> > +} __packed;
> > +_Static_assert(alignof(struct sa) == 1, "alignof(struct sa)");
> > +_Static_assert( sizeof(struct sa) == 3,  "sizeof(struct sa)");
> > +
> > +struct __packed sb {
> > +	int a:7;
> > +	int c:10;
> > +	int b:2;
> > +};
> > +_Static_assert(alignof(struct sb) == 1, "alignof(struct sb)");
> > +_Static_assert( sizeof(struct sb) == 3,  "sizeof(struct sb)");
> 
> Why 'struct sb'? It is not used in the rest of the test (and is
> identical to 'struct sa').

Good question :)
I've probably reused some previous file as a kind of template.
 
> > diff --git a/validation/packed-bitfield3.c b/validation/packed-bitfield3.c
> > new file mode 100644
> > index 000000000000..6acff875299f
> > --- /dev/null
> > +++ b/validation/packed-bitfield3.c
> > @@ -0,0 +1,29 @@
> > +#define __packed __attribute__((packed))
> > +
> > +typedef unsigned char   u8;
> > +typedef __UINT16_TYPE__ u16;
> > +typedef __UINT32_TYPE__ u32;
> > +typedef __UINT64_TYPE__ u64;
> > +
> > +struct b {
> > +	u32	a:1;
> > +	u32	b:2;
> > +	u32	c:4;
> > +	u32	d:8;
> > +	u32	e:16;
> > +} __packed;
> > +_Static_assert(__alignof(struct b) == 1);
> > +_Static_assert(   sizeof(struct b) == sizeof(u32));
> 
> Again '== sizeof(u32)' does not seem useful. (what is it
> trying to say?)
> 
> > +
> > +struct c {
> > +	u8	a;
> > +	u8	b;
> > +	u64	c:48;
> > +} __packed;
> > +_Static_assert(__alignof(struct c) == 1);
> > +_Static_assert(   sizeof(struct c) == sizeof(u64));
> 
> ditto.

Yes, I agree.

-- Luc 
