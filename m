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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82536C41620
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 23:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C7E4222F9
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 23:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbgL1Wzv (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 28 Dec 2020 17:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbgL1UCd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 28 Dec 2020 15:02:33 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB489C0613D6
        for <linux-sparse@vger.kernel.org>; Mon, 28 Dec 2020 12:01:52 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id n16so375852wmc.0
        for <linux-sparse@vger.kernel.org>; Mon, 28 Dec 2020 12:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A1W+++9hwvM/iaHlk0qenVvdQ/1gRCUUL5mFttdH9D8=;
        b=a+wDmmQaqxW7dgUFfgiVhIgpBWSlw0yCceHv4CCJmscBlyaxplXtPR6AFs67hTCusa
         3BfjNqrhYyqPCK/DRxba82WgHIXdPQF74FRn+RRXp2qdQqMTBTYJGSDXjUD2sLf5MzwH
         TRGJlr8ycUEXY6tAwZe8nY/inxU04AeJFSKJGBpqx0z4740ryhuqqwO4NRcnhhh32MGe
         qdjZpSjzZJtii2ifdluLffIuexG3PCdZtAWoxyuQz+KZ1opfYcXhVq4eR9dKXBFTtizz
         fpao2pTQ1qxqUynyNhrrTcLrorZzAJ+DQayPRdKup/Tzs7yopm9+NODTOESviPLcFcVM
         TFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A1W+++9hwvM/iaHlk0qenVvdQ/1gRCUUL5mFttdH9D8=;
        b=NKId/jPptqKQTmneXYBR4coxusW8ESRuYOyBtGMyGlEiM6IjtCT7KozAAjqiNRQcCi
         nM1V1brEqXddkOu+RRH5Fpo+qBgqCdgfVvwMwm0AOMfkqONq7fwJ9RQs+Vm7n76BmMD8
         r6ljonXhmhC98BcY8R/0vH9ccEEc36rNtOfzoGHS1yjZBo7FsMUW8kWud2iUm57iFysP
         nH98WsBtKJqTZlocgkArSWy9Y3VtMFfokH0/hB5Q8Bhi6JTzyAY4DFeSZS8Fp5etLnli
         8zx6bAfw1sJeExJ+CTviLaXl9GS3WL2l37iJ22K7zcB/sCrWFFFZZu00/1ojcjKLAbFS
         7PtQ==
X-Gm-Message-State: AOAM532B2FUHSTuPLm73C5WAVsYOY+OtpcvS7apnv8c2q69ZYds6XMZK
        a7TSKYCrYMjOogRENSTC7fwJE5+jnsE=
X-Google-Smtp-Source: ABdhPJwsVRwCo+op3xviahFT8sBb4vYVNPg5ON0SgiPDzSO/wX+8rwuahaoQP9hBneDefcLca+ngFQ==
X-Received: by 2002:a1c:6287:: with SMTP id w129mr421754wmb.71.1609185711556;
        Mon, 28 Dec 2020 12:01:51 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:1cf:be4f:91b8:4ca6])
        by smtp.gmail.com with ESMTPSA id j2sm56382213wrt.35.2020.12.28.12.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 12:01:51 -0800 (PST)
Date:   Mon, 28 Dec 2020 21:01:50 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     linux-sparse@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 05/16] add testcases for packed structures
Message-ID: <20201228200150.xvvrfno2e3mol7v4@ltop.local>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
 <20201226175129.9621-6-luc.vanoostenryck@gmail.com>
 <860fe109-6819-ec55-e55f-90812b9f90f2@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <860fe109-6819-ec55-e55f-90812b9f90f2@ramsayjones.plus.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Dec 28, 2020 at 04:17:36PM +0000, Ramsay Jones wrote:
> 
> 
> On 26/12/2020 17:51, Luc Van Oostenryck wrote:
> > Currently, packed structs are not handled correctly.
> > 
> > Add some testcases for them.
> > 
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > ---
> >  validation/packed-deref0.c | 24 ++++++++++++++++++++++++
> >  validation/packed-struct.c | 33 +++++++++++++++++++++++++++++++++
> >  2 files changed, 57 insertions(+)
> >  create mode 100644 validation/packed-deref0.c
> >  create mode 100644 validation/packed-struct.c
> > 
> > diff --git a/validation/packed-deref0.c b/validation/packed-deref0.c
> > new file mode 100644
> > index 000000000000..865ad68a4f37
> > --- /dev/null
> > +++ b/validation/packed-deref0.c
> > @@ -0,0 +1,24 @@
> > +#define	__packed	__attribute__((packed))
> > +
> > +typedef struct {
> > +	__INT8_TYPE__	a;
> > +	__INT16_TYPE__	b;
> > +	__INT32_TYPE__	c;
> > +} __packed obj_t;
> > +
> > +_Static_assert(sizeof(obj_t) == 7, "sizeof packed struct");
> > +
> > +static void foo(obj_t *ptr, int val)
> > +{
> > +	ptr->c = val;
> > +}
> > +
> > +static void bar(obj_t o)
> > +{
> > +	foo(&o, 0);
> > +}
> > +
> > +/*
> > + * check-name: packed-deref0
> > + * check-known-to-fail
> > + */
> > diff --git a/validation/packed-struct.c b/validation/packed-struct.c
> > new file mode 100644
> > index 000000000000..5039be4d0b45
> > --- /dev/null
> > +++ b/validation/packed-struct.c
> > @@ -0,0 +1,33 @@
> > +#define __packed __attribute__((packed))
> > +
> > +typedef unsigned char   u8;
> > +typedef __UINT16_TYPE__ u16;
> > +typedef __UINT32_TYPE__ u32;
> > +typedef __UINT64_TYPE__ u64;
> > +
> > +struct a {
> > +	u8 a;
> > +	u8 b;
> > +	u16 c;
> > +} __packed;
> > +_Static_assert(__alignof(struct a) == 1, "align struct");
> > +_Static_assert(   sizeof(struct a) == sizeof(u32), " size struct");
> 
> Hmm, I don't think '== sizeof(u32)' is any better than '== 4'.

Yes, I agree.

-- Luc 
