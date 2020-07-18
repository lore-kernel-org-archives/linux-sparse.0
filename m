Return-Path: <SRS0=GL7X=A5=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42ADC433DF
	for <linux-sparse@archiver.kernel.org>; Sat, 18 Jul 2020 23:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD10A21775
	for <linux-sparse@archiver.kernel.org>; Sat, 18 Jul 2020 23:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeeTPb/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgGRXhC (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 18 Jul 2020 19:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgGRXhC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Jul 2020 19:37:02 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17B8C0619D2
        for <linux-sparse@vger.kernel.org>; Sat, 18 Jul 2020 16:37:01 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id z17so10311090edr.9
        for <linux-sparse@vger.kernel.org>; Sat, 18 Jul 2020 16:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0LgqDISF4yQML1x2jox7rxq/jQlLvpjbpXDilNthIWM=;
        b=YeeTPb/c0Z3tgGWIbKkp8qWdywxlYnDNFYWl6Or6UDOKakuZNywCkQgcLWq6fxHHac
         FcfDU6knBi38DCmJwKNdbjsHt4woVAz1biwIo2ahnZrRlbDJ2LVjtr9nu0DAe5xvQE9d
         4oqRW0K5dr3jIINAFC+msMAyZlnjZFHdGjnqP754lesTKiQvecRXYdwelAeKT/Buj6uG
         Y05vIRD2PYf3EyOGmUoLwBUXUGd8PU9cpCgmI7mLuvIppUuPEiK6xsira0qxP5WvKe1g
         b1wX7oInqMJnMIqSoAAzunSYbcQmpoZQRfhpHv+Fq6Gsp4gmwBHTNY+vkWNffFrHFBo3
         D07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0LgqDISF4yQML1x2jox7rxq/jQlLvpjbpXDilNthIWM=;
        b=FPgeQQwaczw1FQMgbBXI7iZViTuVBAFmqT6QghdVC2viMz+8yLZtNrniVcp1uCqvqi
         wq71/I1muQXZcbgn25HM3WI3O1ooCYPcTHmDlvRjxMjNA0yY4VdxHYdXvCdO+/3tigIj
         op5GzYNRnMLI2Rzka0B0PXtKXHmDFabh5oNvXmjWztZbuwWkNg3F3CGg52CE1zo6VpVW
         d6dGlZf9YBtx+eIvAeNAZflO5KLnTdf/iDXM7rUDlJKPcaW01l31yrB+iN8ymr6mCO1v
         yjoXgMCTevIXRQ+SR3gJnoo2z9bUR8vLXH/F4rchoEVo4Dph3J6sxXhJ5n7ztrzABqZI
         GTwg==
X-Gm-Message-State: AOAM533Mbv8CS3wOtry6c4Yf0a4TlGpKaovYgsVeCw3kaw57tP7taiyf
        qwJDiPfKzXsMuK37QKLJABs18T6D
X-Google-Smtp-Source: ABdhPJxo9kiW4AWOWSa3zYysyxQYHAhXHIDbwvoY0rB+6Ot/sfpn8ekYiHyYg5pWbWeYk0+VDOw6zg==
X-Received: by 2002:a50:ab5c:: with SMTP id t28mr15400293edc.209.1595115420188;
        Sat, 18 Jul 2020 16:37:00 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:9830:688a:d816:7e62])
        by smtp.gmail.com with ESMTPSA id c18sm11531377eja.59.2020.07.18.16.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 16:36:59 -0700 (PDT)
Date:   Sun, 19 Jul 2020 01:36:58 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH] warnings: ensure the source filename is shown at least
 once
Message-ID: <20200718233658.nf7ry2nbw4mrviry@ltop.local>
References: <20200718183955.16718-1-luc.vanoostenryck@gmail.com>
 <CAHk-=wjAe_XCz9O2z_FRAOw4iA1+zF9Mcvi3Mp17tpH9y+cLkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjAe_XCz9O2z_FRAOw4iA1+zF9Mcvi3Mp17tpH9y+cLkQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Jul 18, 2020 at 01:21:35PM -0700, Linus Torvalds wrote:
> On Sat, Jul 18, 2020 at 11:40 AM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > When checking a series of files, if some warnings or errors
> > are issued but only coming from some includes, it's not possible
> > to identify which source file is responsible since its filename
> > is not displayed.
> >
> > So, if the first warning is from a file other than the source
> > file, display first a note coming from the source file itself.
> 
> This really isn't enough when the include chain is deeper and more complex.

Yes, my use case was much more limited.
 
> How about something a bit more complex? This is only lightly tested,
> but I don't have time for anything more right now..
> 
> It results in things like

I like it a lot and it works nicely.
 
> That stream chaining information might perhaps be useful for other cases too?

For sparse itself, I don't know, but for some other tools that would
analyze the code/#include structure, yes surely.
 
> Would it be better to save the whole 'pos' for the chain, so that
> you'd get line numbers etc for the chain? Probably. As mentioned, this
> is a quick "how about something like this".

I added this in a following patch.
 
> If you extend it and do more testing, you can have my sign-off, or
> just take ownership of the patch entirely with my ack..

I only removed a repetition in an initialization, so I added your s-o-b.

> Now off for more kernel stuff after a quick sparse excursion...

Yes, sure!
Thanks a lot because it's, I think, a really nice improvement.
-- Luc
