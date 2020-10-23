Return-Path: <SRS0=Zl/b=D6=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658B9C388F9
	for <linux-sparse@archiver.kernel.org>; Fri, 23 Oct 2020 19:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F355B20BED
	for <linux-sparse@archiver.kernel.org>; Fri, 23 Oct 2020 19:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfPVbfTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754062AbgJWTIx (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 23 Oct 2020 15:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S463236AbgJWTIx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 23 Oct 2020 15:08:53 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1491C0613CE
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 12:08:51 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a6so1178577edx.6
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 12:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dtSZsuWclnZSbqawta2oLsH4zmSqLcwLBzmRtutEkS8=;
        b=gfPVbfTjEbESFKPuUtO2uQ3mebQwbjEJGtRoWf8g6LFrzAsIWUx+Zr1HrsV/n1iS52
         WxS0W02lzVVK84LZ0V21vgMDnZoji58vTBeKqdAogxoqKFX+6jSrJNm4H3nZz6n9owN/
         Vf5T/9O5X4+if0PluYSuGAlPADWtprlnOgYCcde8MXFgE1dtUoRFmhyiTfHORtexomfR
         VjwcBmNngEkFcHkS3ETtAKxq48nFINdTIBywasQsttFmjNhwhM5eg+pncjWANqZ9vi8v
         hsyKmewOrOcIuL0lEKXUpMv1GO8A2QX1c39mTjYE+og4o9j9C9rNTRqAld+t4666pBVR
         ixkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dtSZsuWclnZSbqawta2oLsH4zmSqLcwLBzmRtutEkS8=;
        b=qLKSplD16RvSBxl2D1lKxaBTTy9W9fpkTW6LDZyBrGz7nMDd3J1QvyDoH4Qtwpx4G3
         DY6A31PsLzROqhMBDIh8e9MAbBViXLHRaw9mVZeUQDhAZjbnNfhY5KLnDP9d5npBoB1c
         3nnwur5bdSDwk9K0/e84pAvCcCWhTENLo9Ejt2zBXoZCF0L23JUx7BiA0n7Q80oqsgyl
         nyCKtnDvG3THzdvff3VjfBxiPRF6lcj7mnQd1cX8nKOVisxwxc4wXuE3O/J2J8dur4Tz
         7ZI+N1RYJ/+g/gHhgoQHatt1Xv0lbJt57vT8lAxmBmVXClmas9YTVPF3WeIYcBdLrXIm
         K1Lg==
X-Gm-Message-State: AOAM5309Av39HgCzg2w5sXlcQKQ+qpoY09B0mtegse3C4tmU6w7QrcCK
        gtXsAWxLgLuE3q6F5ZKzDz8q5YL/ex0=
X-Google-Smtp-Source: ABdhPJz9CW5I4tXpvmKt5J7+pk40/m7fI3B+DOwIL1bS/KrcAp59ypeGCk1OrqG2ToKifwmQUQg+Zg==
X-Received: by 2002:aa7:cd42:: with SMTP id v2mr1873307edw.191.1603480130713;
        Fri, 23 Oct 2020 12:08:50 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:432:6544:d213:607])
        by smtp.gmail.com with ESMTPSA id g18sm1260082eje.12.2020.10.23.12.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 12:08:50 -0700 (PDT)
Date:   Fri, 23 Oct 2020 21:08:48 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH 1/2] simplify unsigned compares against 0
Message-ID: <20201023190848.hjskgyakexljodnh@ltop.local>
References: <20201023155832.57237-1-luc.vanoostenryck@gmail.com>
 <20201023155832.57237-2-luc.vanoostenryck@gmail.com>
 <CAHk-=wjc7dZCCKF4xOar1HKtNRtnnwqCJTZuJM-YPyyT=wZryw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjc7dZCCKF4xOar1HKtNRtnnwqCJTZuJM-YPyyT=wZryw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Oct 23, 2020 at 09:13:22AM -0700, Linus Torvalds wrote:
> On Fri, Oct 23, 2020 at 8:58 AM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > Some unsigned compares against 0 are always true or always false
> > (x < 0 or x >= 0). Simplify them.
> 
> Fair enough, but if you're simplifying compares, one of the more
> important simplifications is to make the compare unsigned in the first
> place.
> 
> ...
> 
> Another comparison simplification often worth doing is to do cast
> simplification, ie
> 
>    ((cast) X cmpop Y)

Yes, these seem quite easy with a nice return rate. I've a lot of
pending, uncompleted topic branches (which I'm currently trying
to polish and upstream, hence the apparent lack of a direction line)
but I don't think I've anything for these. I'll look at them soon. 

-- Luc
