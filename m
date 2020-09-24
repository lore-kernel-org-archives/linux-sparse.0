Return-Path: <SRS0=G+3i=DB=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EDAC4363D
	for <linux-sparse@archiver.kernel.org>; Thu, 24 Sep 2020 19:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B7302220C
	for <linux-sparse@archiver.kernel.org>; Thu, 24 Sep 2020 19:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiThuC2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgIXTiV (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 24 Sep 2020 15:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbgIXTiU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 24 Sep 2020 15:38:20 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89389C0613CE
        for <linux-sparse@vger.kernel.org>; Thu, 24 Sep 2020 12:38:20 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e23so416490eja.3
        for <linux-sparse@vger.kernel.org>; Thu, 24 Sep 2020 12:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9ZZtgnfSWRHeBBZWSZrsXewCDhq4sQ6yjehgMYiuwH8=;
        b=FiThuC2Gwl4Ib5lMy9ZF+rPyTp50xu1ITtnQLvS6mgpnDe0rK15KpMDUQgTmX769qI
         9UjJEAkVjrl8Z2YFpsWblnCdhzoqa8Kjaz3P4N8W4FeiWBMgL56TuoU2ZdgEtOesEk4W
         vt51QQLksJC6T9RE6jptaqRog+ZD4SmuCoaCUuLVlQGd2flznK8RlghVeqwxKhYv29gR
         cUhSKY5KSxv1EfmWMdyFDwZLWt/xJtKn1LRAVpugmFOX0n1GKTLc8TXz3M4lVNz/BRNb
         Pq3bVZio6U1Yc0dW+OuTgNL+uVUVnRJ3WHoaGL/hvb5TWwf5tdJ8t+dZ9HmYja4w5YUx
         H+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9ZZtgnfSWRHeBBZWSZrsXewCDhq4sQ6yjehgMYiuwH8=;
        b=TjuU33MySLv1a0m1MXEeTUcA8iDPB6wK51G25gRmgier0NwIpUyjySvWEbt2Enw6Ec
         G67MurFEPfKeJ4pIINCBla0uhZH/wYqy6epusTi3oqB8vuSGj5/4ZtzgvrliT9hQN4kJ
         SKM5QiBf3zgzSON5SXQOOGUtRDtCKLHKDJJL5q01O40WWZTH72Zu84rCooIvxVaXFb4V
         ToW5gsSoXM7689Whzy27OyKu8utn5nLJPdxhb86xs0iM0bkf/3Hui5qR3l6zosp8l09B
         S1ZFRfvozvahKnBYauF9q+sbw3x2U9AlNcgNcRGWXmvYwhMYUpkxbUowzSrRtQLNwUh8
         q/sA==
X-Gm-Message-State: AOAM532HidvM/wLnXYDt4x+ZfPF7v1rnyMimNmZMNfiimg8Bj2wdK81e
        LT3GiFUr2JTmVsBLurr8+hE4L7ArdM0=
X-Google-Smtp-Source: ABdhPJxi5kGZq7txgUFVJrCaMsN4WPo6tS2CGlia4TntokHW10dY0FEkFBoR+4gt3m9FuQOpN9xn2Q==
X-Received: by 2002:a17:906:9a1:: with SMTP id q1mr246758eje.30.1600976299234;
        Thu, 24 Sep 2020 12:38:19 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:ec59:f6e1:1368:c855])
        by smtp.gmail.com with ESMTPSA id y25sm123097edv.15.2020.09.24.12.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 12:38:18 -0700 (PDT)
Date:   Thu, 24 Sep 2020 21:38:17 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Christian Eggers <ceggers@arri.de>
Cc:     linux-sparse@vger.kernel.org, Dirk Mueller <dmueller@suse.com>,
        Jiri Slaby <jirislaby@gmail.com>
Subject: Re: Segmentation fault when running sparse with current linux master
Message-ID: <20200924193817.5ilitvaqneach5pg@ltop.local>
References: <1832426.vqaiCtIcaR@n95hx1g2>
 <20200917142017.5fhdjdfrwjyjqlpu@ltop.local>
 <4184357.m9dUj1Odhv@n95hx1g2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4184357.m9dUj1Odhv@n95hx1g2>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Sep 21, 2020 at 09:44:00AM +0200, Christian Eggers wrote:
> Hi Luc,
> 
> On Thursday, 17 September 2020, 16:20:17 CEST, Luc Van Oostenryck wrote:
> > On Thu, Sep 17, 2020 at 01:08:57PM +0200, Christian Eggers wrote:
> > > Build of the current linux kernel breaks on my system due to segmentation
> > > fault when running sparse.
> > >
> > > Sparse version: 0.6.2 (built by openSUSE build service)
> >
> > Hi,
> >
> > This has already been reported and fixed in the main tree in late July.
> > It's not clear to me if the latest OpenSUSE packages for sparse contain
> > or not the needed fix.
> >
> > Can you try the version compiled from the source? It's super-easy:
> >       cd $dir
> >       git clone git://git.kernel.org/pub/scm/devel/sparse/sparse.git
> >       cd sparse
> >       make
> >       cp sparse ~/bin/
> >
> 
> I fetched the source RPM from openSUSE and replaced the 0.6.2 tar.xz with the
> current master. After building an updating the RPM, sparse doesn't crash
> anymore.
> 
> openSUSE ships two versions of sparse [1]:
> - official release: 20180324
> - experimental: 0.6.2
> 
> It seems that both version are affected from this problem. The "experimental"
> version should be automatically updated after a new version of sparse is
> released. The "official release" will probably only accept patches resolving
> specific problems. If you can provide a patch against 20180324, I would try to
> write a bug report against the openSUSE package. This could save some time for
> the next person stumbling over this problem... If you provide the commit id,
> openSUSE can also decide themself whether to fix or upgrade the current
> version.

In the official tree, there is a branch 'maint-v0.6.2' which just contain
4 patches fixing some problems with the release v0.6.2, the second patch
	77f35b796cc8 ("generic: fix missing inlining of generic expression")
being the one fixing this problem.

For info, I'll most probably make a new full release in a few weeks
(rc1 in 7-10 days, release 1-2 weeks later).

Best regards
-- Luc 
