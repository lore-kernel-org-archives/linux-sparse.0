Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEDBC433FE
	for <linux-sparse@archiver.kernel.org>; Fri,  1 Apr 2022 00:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243462AbiDAAVc (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 31 Mar 2022 20:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243425AbiDAAV1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Mar 2022 20:21:27 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241563BBE5
        for <linux-sparse@vger.kernel.org>; Thu, 31 Mar 2022 17:19:26 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso2562234wme.5
        for <linux-sparse@vger.kernel.org>; Thu, 31 Mar 2022 17:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PlnMpYOXkJb3MsWMx3t3Karvr7oM4CxvFXYgLvSP2H0=;
        b=kbN4drDWXGTqRpuC4U+JxL0qNBRMGx952a73rWLXDa3Hlm4aUdgJ31IqJEf0Jx+ckC
         1aJEH9r0xzziPwQvQ5yR1zUgu8b/A3UaeJj9uHP6ugBk9il8p0uWsatZhH3m63SU1PVb
         LN+cROaanx5Hz6L2eD/KARZEowFji8nqD3SDTP8xKSDNd/A+2m2aG1X7n3oXXmbJXACF
         hWT+lCd9PhmgX7/cm4cn2k1BfRaTONAJdglMtzT2LRzqKs1SgYRqmfcpiohHool4PHfC
         eBuxx0iSCjIKVM+oUt93JFB24big5m2lNXVTPtPBTXmCA350ONdXl0t25CsLDpnjccyz
         jRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PlnMpYOXkJb3MsWMx3t3Karvr7oM4CxvFXYgLvSP2H0=;
        b=x34EHcFaTBjGcTCX9s1dmSVViH8J07a7c+UoRUtB5b+W4TOWd8BjlC60sxxY92Ydm2
         lgw8XdFNoCtzR7NAJgSGL7hdUkxjShLfRmQTTmYv6Cv/O8kMMZoG3WLy2L6dPjPtTmaS
         GUKBwED7TD/m461voq973J5AWFKJr/aGf14Om4ilNN36M/v+8rpPQo8+x+aqThFCH+WU
         GIOre/37D4G6ZcnjI0f+4ccvQoTjK767cPfPnyI12hpLgoNwgRlMeCg+OResLEwj9vK/
         281MAR2hAmQR666iOnnOtUL7yKj2btJ/AaMsTr3v00s3ZelCGCxr2w3qFJC1xZ7vWG3z
         q3GA==
X-Gm-Message-State: AOAM530g4/QMVm37M8ICmWSAh0XQpbK/m8b/8EXZYtqPp473+GJgEjTc
        qKSBaQNS/VK1E6XlXW84uqXhsR9Qchb2R64Kv56E+g==
X-Google-Smtp-Source: ABdhPJxATEUZYxO0stl0ueoGYAY1YKf0hGiTqAZL1ta/p5x+yRtL2fXZ3p8DLYTHHVSN7tIVp+IEj9AzjRy7KIMBcrY=
X-Received: by 2002:a05:600c:40f:b0:38c:be5c:9037 with SMTP id
 q15-20020a05600c040f00b0038cbe5c9037mr6618416wmb.44.1648772365332; Thu, 31
 Mar 2022 17:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648593132.git.marcelo.schmitt1@gmail.com>
 <11f4750c6d4c175994dfd36d1ff385f68f61bd02.1648593132.git.marcelo.schmitt1@gmail.com>
 <CABVgOSkb5CpnXDF_m7iy=A7RmN+KmY0T38TeZ4hKbmkdQgt6Yw@mail.gmail.com> <20220331081409.GY12805@kadam>
In-Reply-To: <20220331081409.GY12805@kadam>
From:   David Gow <davidgow@google.com>
Date:   Fri, 1 Apr 2022 08:19:13 +0800
Message-ID: <CABVgOS=uaNJq8SivkxY_4L+HRh9bwadGRqF8_tQP_UNGNbmY3g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Documentation: dev-tools: Enhance static analysis
 section with discussion
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-sparse@vger.kernel.org, cocci@inria.fr,
        smatch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>, julia.lawall@inria.fr
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Thu, Mar 31, 2022 at 4:14 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Mar 30, 2022 at 10:48:13AM +0800, David Gow wrote:
> > > +
> > > +Smatch does flow analysis and, if allowed to build the function database, it
> > > +also does cross function analysis. Smatch tries to answer questions like where
> > > +is this buffer allocated? How big is it? Can this index be controlled by the
> > > +user? Is this variable larger than that variable?
> > > +
> > > +It's generally easier to write checks in Smatch than it is to write checks in
> > > +Sparse. Nevertheless, there are some overlaps between Sparse and Smatch checks
> > > +because there is no reason for re-implementing Sparse's check in Smatch.
> >
> > This last sentence isn't totally clear to me. Should this "because" be "so"?
> >
>
> I stopped reading your email when you wrote "Cheers, David" but I should
> have scrolled down.
>
> There is not very much overlap between Sparse and Smatch.  Both have a
> warning for if (!x & y).  That is a tiny thing.  The big overlap is when
> it comes to the locking checks.  The Smatch check for locking is
> honestly way better and more capable.
>
> I always run both Sparse and Smatch on my patches.  I should run
> Coccinelle as well, but I'm more familiar with Sparse and Smatch.

Makes sense. I agree that the overlap doesn't seem particularly
important: it's the differences which should be more evident.

v3[1] of the patch cuts this down to just "Nevertheless, there are
some overlaps between Sparse and Smatch checks.", which I think is an
improvement.

Thanks,
-- David

[1]: https://lore.kernel.org/all/62f461a20600b95e694016c4e5348ef2e260fa87.1648674305.git.marcelo.schmitt1@gmail.com/
