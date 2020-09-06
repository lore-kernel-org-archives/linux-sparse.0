Return-Path: <SRS0=5g4H=CP=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C55C433E2
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 19:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83DDE20578
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 19:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOtWClT+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgIFTKt (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 6 Sep 2020 15:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgIFTKs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Sep 2020 15:10:48 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10589C061573
        for <linux-sparse@vger.kernel.org>; Sun,  6 Sep 2020 12:10:48 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id e23so15206675eja.3
        for <linux-sparse@vger.kernel.org>; Sun, 06 Sep 2020 12:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vdqj9HUxIcn2jOPKbWEdigqQXRKt2BDGrsJsAUgXHbE=;
        b=kOtWClT+ny77ID9MMiESxOQxq8hckj2D5J++ioDAmoVJdmeBSCuFsWPLkbLUaXgJMh
         rVMf7orixc1NUyVxsUIqIjczAiuHf4ShVHzi89HhFLLvcXaz0CMjOI5lD69Rfa1RiLrB
         0WYflGs8vD1of6HNvVAAefa9L8vRbqqKe5FCdGa4U0ZkRTpdW7Hj5lg46rR32awdwQvX
         qv1sczbGJECxBp+1HRMFCO7H0MRA4VlJwAYKwUmvVUmM2Pw7Z4CifGJ/ebE6bFwImiXK
         p5djF4AMnVKzDG3yC0Dy2jPOK3B9CkEj5TklgLjyzlGrGn00KRyEKKLv/2/UdOE9z03H
         mYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vdqj9HUxIcn2jOPKbWEdigqQXRKt2BDGrsJsAUgXHbE=;
        b=Wt/41OSAu74gmm+S9tD1iZYiOnVMOnboOZKk0HQVmNm5kQZVV4AOVh7auzOcRaLFQt
         gHWYf+meBtOXq87pfbSHQg4scfSB1qP1t+eYPM++AC8FrKG4Hi5Ynf4bb0iLHcXYifoI
         ki63r4RGetD4OG/mMBXHxvqWgemM5emJ9tFD2T/hN3jcmNXDdgPdrOZVVIIQ+H3os1fB
         GWJ6AhDh5FVXojxvS3yfr3k3mRocxiqT9VVORCWHCh9WkAy4HfDCU7YgHU4SlsArq9Df
         psfpk82cFse0+gO2HUZAAL/RSZRgQwj25z1m9BHYNEISGX5MzUbTMnIN1jf7NTZhu9+S
         6n5w==
X-Gm-Message-State: AOAM531B7uyGCYssRpTC1GZdxqKZgdm955NRYrGpm2jY9xwF/bzk7KIF
        bUfJ8b75sd4rO9h1BnQHKEKURtSdekk=
X-Google-Smtp-Source: ABdhPJzYhZ46rjK7HYhGJgkNp840xCKlOeuOSjdaKiq61RwBxOmHtMqvb5EXsGisqFF09uosLG5GOg==
X-Received: by 2002:a17:906:e4c:: with SMTP id q12mr17482687eji.425.1599419446567;
        Sun, 06 Sep 2020 12:10:46 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:1c0f:34d8:de78:ecc0])
        by smtp.gmail.com with ESMTPSA id t6sm12749806ejc.40.2020.09.06.12.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 12:10:46 -0700 (PDT)
Date:   Sun, 6 Sep 2020 21:10:45 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [PATCH 2/3] add more testcases for AND/OR simplification
Message-ID: <20200906191045.4vgg52mbzlsq5i4a@ltop.local>
References: <20200906124038.46786-1-luc.vanoostenryck@gmail.com>
 <20200906124038.46786-3-luc.vanoostenryck@gmail.com>
 <bd752e76-f71a-699a-7253-631bd9d4c090@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd752e76-f71a-699a-7253-631bd9d4c090@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sun, Sep 06, 2020 at 05:38:54PM +0100, Ramsay Jones wrote:
> 
> 
> On 06/09/2020 13:40, Luc Van Oostenryck wrote:
> > Add a few testcases showing the effectiveness of these
> > simplifications and to catch possible future regressions.
> > 
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > ---
> >  validation/optim/and-lsr-or-shl0.c | 12 ++++++++++++
> >  validation/optim/and-lsr-or-shl1.c | 12 ++++++++++++
> >  validation/optim/and-shl-or-lsr0.c | 13 +++++++++++++
> >  validation/optim/lsr-or-lsr0.c     | 20 ++++++++++++++++++++
> >  validation/optim/trunc-or-shl0.c   | 19 +++++++++++++++++++
> >  5 files changed, 76 insertions(+)
> >  create mode 100644 validation/optim/and-lsr-or-shl0.c
> >  create mode 100644 validation/optim/and-lsr-or-shl1.c
> >  create mode 100644 validation/optim/and-shl-or-lsr0.c
> >  create mode 100644 validation/optim/lsr-or-lsr0.c
> >  create mode 100644 validation/optim/trunc-or-shl0.c
> 
> Given that these are new tests, I was (er..) expecting some
> '*.expected' files! However, I guess (since they are all failing
> tests anyway) those will come in future patches which will
> actually implement the optimization.

Yes, I've pending series for these (and a lot of others) which
more or less depends on these tests. For *.expected files, I really
want to avoid this because it would be more things that should be
kept up to date. I prefer to add some comments and use the patterns
tests, all n the same file.
 
> > diff --git a/validation/optim/trunc-or-shl0.c b/validation/optim/trunc-or-shl0.c
> > new file mode 100644
> > index 000000000000..4d85a6bd4ec4
> > --- /dev/null
> > +++ b/validation/optim/trunc-or-shl0.c
> > @@ -0,0 +1,19 @@
> > +char trunc_or_shl0a(unsigned a, unsigned b)
> > +{
> > +	return (a << 8) | b;
> > +}
> > +
> > +char trunc_or_shl0b(unsigned a, unsigned b)
> > +{
> > +	return a | (b << 8);
> > +}
> > +
> > +/*
> > + * check-name: trunc-or-shl0
> > + * check-command: test-linearize -Wno-decl $file
> > + * check-known-to-fail
> > + *
> > + * check-output-ignore
> > + * check-output-excludes: or\\.
> > + * check-output-excludes: shl\\.
> 
> Hmm, I can't see an optimization for these two! :(
> Care to explain just what you expect? (maybe with an
> '*.expected' file?)

I saw your other email about it but I just would like to add
these sort of tests should really be read at the IR level,
the output of 'test-linearize $file.c'. Sometimes, the C file
is just a convoluted way to create some specific sequence of
IR instructions. Also, often the name of the file and the
comments directly refer to these instructions (like here 'trunc'
for the instruction OP_TRUNC).

For the simplification phase, it would be nice and easier to be
able to do the tests directly in the IR format. It shouldn't take
much time but ... one day ... maybe :)

-- Luc
