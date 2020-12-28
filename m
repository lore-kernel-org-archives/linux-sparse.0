Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D5BC433E9
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 23:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F8D72222A
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 23:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbgL1Wzu (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 28 Dec 2020 17:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729353AbgL1UAb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 28 Dec 2020 15:00:31 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B878C061793
        for <linux-sparse@vger.kernel.org>; Mon, 28 Dec 2020 11:59:51 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m5so12342714wrx.9
        for <linux-sparse@vger.kernel.org>; Mon, 28 Dec 2020 11:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nle/Fk0wuDrP4w56YfyN49HXPMMNZKWh2BnMwFzCHB8=;
        b=rfS7wr093IfutyWUPal6c7HNuSvUF6fwaEZ0Z9fsfVcsgp5x7zx2zFRnUENJEtqInq
         Z4uOw0itq8gHGOxSjfvYqAS6UqkEyKJZolMMIHun2WtreDNuQRZGuGd+0xnxMF+hkt1N
         UmIXNTFYrJVS94YJhKaMl2/CuDE52b2C8e5lRA4uBXUazCsBUw9SrQUclGusxsToAgZ8
         55zpAGkrRDDqZcCelBBVzjpXgeEFh98II+QjkibvjNrAXnrV99XmEzP6FPw1lCRdQPqx
         Nx2Za60+U1P3rihBshssBxqtQ0xMYbFFO6Eo3SIBdN0B9zqwz7Yw70wIfJp3ptvHgpGr
         CyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nle/Fk0wuDrP4w56YfyN49HXPMMNZKWh2BnMwFzCHB8=;
        b=IAekQ1UjJb0w8G2nDSrxiHZBkPEJ6O44Fi5HhAV8IzDACi1+V8e7Sdt93QqXSS12xe
         gpflwL2En5lBY8rJda7Q8TrnLZHFjjj6rbbXKvW3kbSGYT4WP7gGnDI0JpQRp6igR6NH
         CU7LyNIy8E1sCJ5mtcI1Dn6bUDmV8VhJrVFxUQQ1xVC5Th+polS/ZQszmrvmHg+c5Uyn
         3ulJl7PBVj1yv1o/2W/yXYE34XJDAzSy1pgu8kGiDyHyxOXEY1MSENQuouMKZ/5SI3fS
         57yAPi19oNO0LPzSOyrBFPiPXoqbs4ONxTQ6DG7tNMLoTnm0kvumqMhJBx5ClmWxNh21
         dGRw==
X-Gm-Message-State: AOAM530OnLjY2NfAaNjSNBBywSiABtMMdBcFChRaNPiNYXdJFnz4PtTn
        yET+ResDZeWvBSL1EzoMR+x41aCk0fc=
X-Google-Smtp-Source: ABdhPJydLdIAv5l8Ow3pQp8tAXZe2zQ4IrEiOVJHHl4OAg9CApaOMpaB/FvXQc/e3zTt67ag7lZyQw==
X-Received: by 2002:a5d:67c3:: with SMTP id n3mr52144339wrw.297.1609185590051;
        Mon, 28 Dec 2020 11:59:50 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:1cf:be4f:91b8:4ca6])
        by smtp.gmail.com with ESMTPSA id x66sm457621wmg.26.2020.12.28.11.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 11:59:49 -0800 (PST)
Date:   Mon, 28 Dec 2020 20:59:48 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     linux-sparse@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 04/16] add testcases for type attributes
Message-ID: <20201228195948.5kqsxvp3qat2mvxq@ltop.local>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
 <20201226175129.9621-5-luc.vanoostenryck@gmail.com>
 <f39438bd-3ab3-b827-a488-510b49351eb5@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f39438bd-3ab3-b827-a488-510b49351eb5@ramsayjones.plus.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Dec 28, 2020 at 04:13:54PM +0000, Ramsay Jones wrote:
> On 26/12/2020 17:51, Luc Van Oostenryck wrote:
> > diff --git a/validation/type-attribute-qual.c b/validation/type-attribute-qual.c
> > new file mode 100644
> > index 000000000000..ab19a605bda1
> > --- /dev/null
> > +++ b/validation/type-attribute-qual.c
> > @@ -0,0 +1,12 @@
> > +static const struct s {
> > +	int x;
> > +} map[2];
> > +
> > +static void foo(struct s *p, int v)
> > +{
> > +	p->x += v;
> > +}
> 
> Hmm, I don't understand what this is testing! :(

The declaration of map also contains the definition of 'struct s'.
The test, by tryin to modify something of type 'struct s', allows to
verify that the 'const' applies only to 'map' and not to 'struct s'.

I'll add a comment.
-- Luc
