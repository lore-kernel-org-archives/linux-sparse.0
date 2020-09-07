Return-Path: <SRS0=xoI2=CQ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47A1C43461
	for <linux-sparse@archiver.kernel.org>; Mon,  7 Sep 2020 22:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96BC5215A4
	for <linux-sparse@archiver.kernel.org>; Mon,  7 Sep 2020 22:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ad0LkQki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgIGWV0 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 7 Sep 2020 18:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgIGWVZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Sep 2020 18:21:25 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B122C061573
        for <linux-sparse@vger.kernel.org>; Mon,  7 Sep 2020 15:21:25 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id z22so19832205ejl.7
        for <linux-sparse@vger.kernel.org>; Mon, 07 Sep 2020 15:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HGQZgRPGz6VL6A2af/zTMri7IqW9kD+84y3AQjOk4I0=;
        b=ad0LkQkikfG8fQ1qSLBI8FYewHEZRhZxS0jR/7P1CUrrEZVs1E5GuoHxRTI1b9OKoU
         1HnOOWIATOCouuLTx/ZIiiRCgh6ME3bVgZz751T1OQkt9gS8iwrv1MSZvH3bHkGTBh+d
         6uVHWaXs8r0mKQBg5hHNQ6NdEOBhujPkvoNQv8eqc8H3SQsmLaznFf/ElsVpPeJOE0Cy
         P+V3FkxpHtluqtj9Y6mU+ta33ApKcXnKs8HPewR6SY319MkPmH4s79x83HXtxnVeRUYm
         5OLgN1wTbIgZbf415uTI7l25f1r9Gsr5oRZrVc1FbJrERIyEVjujeo3msh/yOsWWeXXN
         GSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HGQZgRPGz6VL6A2af/zTMri7IqW9kD+84y3AQjOk4I0=;
        b=d10h9fAPO4YC9YLTJNNT+4Uf+Wz93GshqH7wWJLBBBmypzPs/hmQYEGzELeaK2c4Ny
         k8qoheh7B+UY0htGOgU2l5p9apsuEeJPx45uJkPqpBHLdnZU/GHcKnRWlDefjYNFsCi2
         fJgXf8P3ybOu50y33w7E/REZXPbw2AyO/YQJbPSCBXkUjB27tr5gl//hjHDGsqbaZoD+
         AsQsA9V6ZyZzNA36eA/yprBsRuXRpRjeQ5BcnJJfaNvMgZGoFxtPGEBozVop+UTwq4pH
         1nuPYlBvXZR8VkN0QTkE9m0fZNdWsOsFlcpKOv69PSeXBIQgGzMJb9WL2EeXdDdF4eg3
         i8Pw==
X-Gm-Message-State: AOAM533O+KkofMAu41V9rGuCvHBQtvN9P2SlNj+vTaDc1zTj8jk20pCu
        9wLEz6SHSh2QJnwH7R4XeQ8t1JKF530=
X-Google-Smtp-Source: ABdhPJyxP7ZfZFCYZFGDazLfgJKe6q8+hA+CD1BUtddeLKfSJmOCUlRoyXy1Ftcz9s5Eg0Fn+35few==
X-Received: by 2002:a17:906:3e4e:: with SMTP id t14mr13856467eji.269.1599517283628;
        Mon, 07 Sep 2020 15:21:23 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:a4cd:133f:f17f:2a5d])
        by smtp.gmail.com with ESMTPSA id h1sm16078521edl.36.2020.09.07.15.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 15:21:22 -0700 (PDT)
Date:   Tue, 8 Sep 2020 00:21:22 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [PATCH v2 3/3] add more testcases for AND/OR simplification
Message-ID: <20200907222122.ruonzxhhfjk6dix2@ltop.local>
References: <20200906211646.58946-1-luc.vanoostenryck@gmail.com>
 <20200906211646.58946-4-luc.vanoostenryck@gmail.com>
 <7ead3fd3-34f4-f5d4-21fa-c7937fcab5fe@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ead3fd3-34f4-f5d4-21fa-c7937fcab5fe@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Sep 07, 2020 at 01:15:18AM +0100, Ramsay Jones wrote:
> On 06/09/2020 22:16, Luc Van Oostenryck wrote:
> > Add a few testcases showing the effectiveness of these
> > simplifications and to catch possible future regressions.
> > 
> 
> Sorry, I had to step away from the keyboard for a couple
> of hours ...

No, problem, of course.
 
> > diff --git a/validation/optim/and-lsr-or-shl0.c b/validation/optim/and-lsr-or-shl0.c
> > new file mode 100644
> > index 000000000000..46ab1bde5249
> > --- /dev/null
> > +++ b/validation/optim/and-lsr-or-shl0.c
> > @@ -0,0 +1,13 @@
> > +// =>	0
> > +unsigned int and_lsr_or_shl0(unsigned int a, unsigned int b)
> > +{
> > +	return ((a | b << 12) >> 12) & 0xfff00000;
> > +}
> > +
> > +/*
> > + * check-name: and-lsr-or-shl0
> > + * check-command: test-linearize -Wno-decl $file
> > + * check-known-to-fail
> > + *
> > + * check-output-excludes: shl\\.
> 
> Why not something like:
>   * check-output-contains: ret.32 *\\$0

Yes, at the end this check is the only thing that matters. And since
it's all pure expressions, if there is a return with a constant,
no other instructions can possibly be present.

>   * check-output-excludes: shl\\.
>   * check-output-excludes: or\\.
>   * check-output-excludes: lsr\\.
>   * check-output-excludes: and\\.

But these tests were written (more than 2 years ago, so I forgot the
details about them) for very specific steps in the simplification
phase, most probably aiming bitfields (hence the constant shifts &
masks). In this case it was for a simplification that removed the '<<'.

> > diff --git a/validation/optim/and-lsr-or-shl1.c b/validation/optim/and-lsr-or-shl1.c
> > new file mode 100644
> > index 000000000000..22fee362b16b
> > --- /dev/null
> > +++ b/validation/optim/and-lsr-or-shl1.c
> > @@ -0,0 +1,13 @@
> > +// =>	(((a | b << 12) >> 12)
> > +unsigned int and_lsr_or_shl1(unsigned int a, unsigned int b)
> > +{
> > +	return ((a | b << 12) >> 12) & 0x000fffff;
> > +}
> > +
> > +/*
> > + * check-name: and-lsr-or-shl1
> > + * check-command: test-linearize -Wno-decl $file
> > + * check-known-to-fail
> > + *
> > + * check-output-excludes: shl\\.
> 
> Hmm, this should be ': and\\.' right?

My intention was most certainly to test the shl but my comment
here above is wrong. It should have been:
	//	((a | (b << 12)) >> 12) & 0x000fffff
	// ->	((a >> S) | ((b << S) >> S)) & 0x000fffff
	// ->	((a >> S) | (b & 0x000fffff)) & 0x000fffff
	// =>	((a >> S) | b) & 0x000fffff
	// or	(a >> S) | (b & 0x000fffff)

> > diff --git a/validation/optim/and-shl-or-lsr0.c b/validation/optim/and-shl-or-lsr0.c
> > new file mode 100644
> > index 000000000000..f2a7cc631258
> > --- /dev/null
> > +++ b/validation/optim/and-shl-or-lsr0.c
> > @@ -0,0 +1,13 @@
> 
> Hmm, I can't see the optimization, just ...
> 
> > +unsigned and_shl_or_lsr0(unsigned a, unsigned b)
> > +{
> > +	return ((a | (b >> 12)) << 12) & 0xfff00000;
> 
> ->((a << 12) | ((b >> 12) << 12)) & 0xfff00000
> ->((a << 12) | b) & 0xfff00000
> so that ...
> > +}
> > +
> > +/*
> > + * check-name: and-shl-or-lsr0
> > + * check-command: test-linearize -Wno-decl $file
> > + * check-known-to-fail
> > + *
> > + * check-output-ignore
> > + * check-output-excludes: or\\.
> 
> ... this wouldn't be correct. puzzled! :(

Indeed, I probably meant 0x00000fff instead of 0xfff00000
	//	((a | (b >> S)) << S) & 0x00000fff
	// ->	((a << S) | ((b >> S) << S)) & 0x00000fff
	// ->	((a << S) | (b & 0xfffff000)) & 0x00000fff
	// ->	(a << S) & 0x00000fff
and then:
	// =>	0

> > diff --git a/validation/optim/lsr-or-lsr0.c b/validation/optim/lsr-or-lsr0.c
> > new file mode 100644
> > index 000000000000..aad4aa7fda56
> > --- /dev/null
> > +++ b/validation/optim/lsr-or-lsr0.c
> > @@ -0,0 +1,22 @@
> > +#define	S	12
> > +
> > +//	((x >> S') | y) >> S;
> > +// ->	((x >> S' >> S) | (y >> S)
> 
> s/((x/(x/
> 
> > +// ->	((x >> 32) | (y >> S)
> 
> s/((x/(x/
> 
> > +// =>	(y >> S)
> > +
> > +int lsr_or_lsr0(unsigned int x, unsigned int b)
> > +{
> > +	return ((x >> (32 - S)) | b) >> S;
> > +}
> > +
> > +/*
> > + * check-name: lsr-or-lsr0
> > + * check-command: test-linearize -Wno-decl $file
> > + * check-known-to-fail
> > + *
> > + * check-output-ignore
> > + * check-output-pattern(1): lsr\\.
> > + * check-output-excludes: and\\.
> 
> why would an 'and' be here anyway?

Because each shift has a implicit mask associated with it:
	(x >> S) == ((x & 0xffffffff) >> S) == (x >> S) & 0x000fffff
In some simplifications I made, it becomes an explicit mask and
sometimes there was a left-over. But yes, it's not very interesting here.

Thanks for noticing all this. I'll sort & reorganize them.

-- Luc
