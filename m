Return-Path: <SRS0=5g4H=CP=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320A7C43461
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 18:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFBFC2080A
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 18:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N94FOp3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgIFSxF (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 6 Sep 2020 14:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729248AbgIFSwa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Sep 2020 14:52:30 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8A5C061574
        for <linux-sparse@vger.kernel.org>; Sun,  6 Sep 2020 11:52:30 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id z23so15073309ejr.13
        for <linux-sparse@vger.kernel.org>; Sun, 06 Sep 2020 11:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D5y+2VY8bz4vYVLw7AI0sHR7sw68+miD6BtlUjgNHJ0=;
        b=N94FOp3DepJwJbGbHYJmPffKZuUsBjBiHxdA3jtb0RCzLT5eZZCrafmxyFzrZriW51
         wQmgORBHxSk1nkhuc48S0nLPOOgBNeAetxPEY1MdWyHM2IUJCErDfkENL/gWkKPj1cXA
         p4PW7Znr0cHKs+HVK7jAOfdIrvpOCjyme4N5cwhcSng2/wvhNNWUik5S4Bm97XX5hpuy
         njgxQb805EQqa+Mv5ZPuz83nW4ULn4Cv6qcEbNNv3ndmxqFsLwPfgbZBgkEhIn79YXtd
         mIP8nHTh4ZkWVxYRFGMXYv+vU03EtVTQQxfem7aQXe6g8XnJiDGaVCkrdTKE+ILUSlVX
         TKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D5y+2VY8bz4vYVLw7AI0sHR7sw68+miD6BtlUjgNHJ0=;
        b=WoVUSpR1ZlrImPxB61CTR8PcBVDWroEK28EizsJ+EbBLG+qzmcWkz3Srrli6a/9w87
         epu4zqGqsDl1ZECMOuMptri5uUejBshyqf1cGIx9vJ4Avnk746sxTpXaRvxBc9qaLxsV
         ZYAX6Pj4y7JoHU7P2tllvKfbMgmzAT4dAyAO6wC0IDE2fr2XifMFtYN67mGVle7Gs3RI
         L0o7Uj7d3y2EfnUouRifL/N2cCg1hqp1oIhH6LzjtPjM18b8WlhjfVNcvdRnhfU5ojbn
         h7jII18I/K/4hy+1X6x0lYX2SLwFX2yPinvZjBPueqrYitC107G6P64WZMrXEwakJCPW
         3Lkg==
X-Gm-Message-State: AOAM531FJw4qxqn0YHcaIUghMLqawYgkazrjkbgebYO6SkS2mzCx3mjR
        0UlQkAWs4kQXlv3XH5JE5xVOqrKL2cs=
X-Google-Smtp-Source: ABdhPJyZDZaXkMmWBREh1D9KcAH8etTTruvb14w1HdWWOQ5HKQssZ39E385LJVvPz4dio2tHqpxaYQ==
X-Received: by 2002:a17:906:7cb:: with SMTP id m11mr18258545ejc.41.1599418348001;
        Sun, 06 Sep 2020 11:52:28 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:1c0f:34d8:de78:ecc0])
        by smtp.gmail.com with ESMTPSA id t12sm12619832edy.61.2020.09.06.11.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 11:52:27 -0700 (PDT)
Date:   Sun, 6 Sep 2020 20:52:26 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [PATCH 1/3] add more testcases for existing AND/OR
 simplifications
Message-ID: <20200906185226.sjfbnuo7dbrfc3dm@ltop.local>
References: <20200906124038.46786-1-luc.vanoostenryck@gmail.com>
 <20200906124038.46786-2-luc.vanoostenryck@gmail.com>
 <b699c65e-5173-79dc-3ddb-20242646f0f1@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b699c65e-5173-79dc-3ddb-20242646f0f1@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hi,

On Sun, Sep 06, 2020 at 05:12:40PM +0100, Ramsay Jones wrote:
> On 06/09/2020 13:40, Luc Van Oostenryck wrote:
> > Add a few more testcases to catch possible future regressions.
> > 
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > ---
> >  validation/optim/and-shl-or-and0.c  | 13 +++++++++++++
> >  validation/optim/lsr-or-and0.c      | 23 +++++++++++++++++++++++
> >  validation/optim/shl-or-constant0.c | 12 ++++++++++++
> >  validation/optim/shl-or-constant1.c | 12 ++++++++++++
> >  validation/optim/shl-or-constant2.c | 12 ++++++++++++
> >  5 files changed, 72 insertions(+)
> >  create mode 100644 validation/optim/and-shl-or-and0.c
> >  create mode 100644 validation/optim/lsr-or-and0.c
> >  create mode 100644 validation/optim/shl-or-constant0.c
> >  create mode 100644 validation/optim/shl-or-constant1.c
> >  create mode 100644 validation/optim/shl-or-constant2.c
> > 
> > diff --git a/validation/optim/and-shl-or-and0.c b/validation/optim/and-shl-or-and0.c
> > new file mode 100644
> > index 000000000000..ea08d2622a95
> > --- /dev/null
> > +++ b/validation/optim/and-shl-or-and0.c
> > @@ -0,0 +1,13 @@
> > +unsigned and_shl_or_and0(unsigned a, unsigned b)
> > +{
> > +	return (((a & 0xfff00000) | b) << 12) & 0xfff00000;
> 
> ->(((a & 0xfff00000) << 12) | (b << 12)) & 0xfff00000
> ->(( 0 | (b << 12)) & 0xfff00000
> ->((b << 12)) & 0xfff00000
> > +}
> > +
> > +/*
> > + * check-name: and-shl-or-and0
> > + * check-command: test-linearize -Wno-decl $file
> > + *
> > + * check-output-ignore
> > + * check-output-excludes: or\\.
> > + * check-output-excludes: lsr\\.
> 
> why would there be a right-shift to begin with?
> (maybe add check-output-excludes: %arg1)

I'm not sure. It may be an error in the testcase, maybe a copy-paste
from some other tests, but I think it comes from some simplification
steps involving masks and shift and where a masking operation like
(x & 0xfff00000) is first virtually transformed into ((x >> 20) << 20)
before being simplified away.
Yes, checking the absence of %arg1 is a good idea.

> > + */
> > diff --git a/validation/optim/lsr-or-and0.c b/validation/optim/lsr-or-and0.c
> > new file mode 100644
> > index 000000000000..3c369cb9497e
> > --- /dev/null
> > +++ b/validation/optim/lsr-or-and0.c
> > @@ -0,0 +1,23 @@
> > +#define	S	12
> > +
> > +//	((x & M) | b) >> S;
> > +// ->	((x >> S) & (M >> S)) | (b >> S)
> 
> OK
> 
> > +// 0a:  (M >> S) == 0
> > +// 0b:  (x >> S) == 0
> > +// 0c:  (b >> S) == 0
> 
> I do not understand what these three lines are trying to say! :(

It's just some leftover of personal notes about the 3 opportunities 
of simplifications. It's probably best to remove.

> > +
> > +int lsr_or_and0a(unsigned int x, unsigned int b)
> 
> s/and0a/and0/ - was there an '_and0b' at one time?

Yes, most probably.

> > diff --git a/validation/optim/shl-or-constant2.c b/validation/optim/shl-or-constant2.c
> > new file mode 100644
> > index 000000000000..9dbde3b574d7
> > --- /dev/null
> > +++ b/validation/optim/shl-or-constant2.c
> > @@ -0,0 +1,12 @@
> > +unsigned shl_or_constant1(unsigned a)
> 
> s/_constant1/_constant2/

Yes, it's better so.

Thanks,
-- Luc 
