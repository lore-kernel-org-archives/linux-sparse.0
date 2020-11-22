Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F505C5519F
	for <linux-sparse@archiver.kernel.org>; Sun, 22 Nov 2020 19:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E06020760
	for <linux-sparse@archiver.kernel.org>; Sun, 22 Nov 2020 19:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RpYihp/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgKVTAr (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 22 Nov 2020 14:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgKVTAq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 22 Nov 2020 14:00:46 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BE9C0613CF
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 11:00:46 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id d17so20735944lfq.10
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 11:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BKLrzrx25Rtgby5bU4xiKAHrXa1CYUKzz2uaeh4FjZU=;
        b=RpYihp/tKu4gD+tFLi8A30BSAVoAih7MCi7N6faDTNGwY7nvSYPQ7zxkVpFsdGITGo
         SIYt6Ic/Mydfqr/ewgWdmCQgPbRHiFw+lEPrKRZ7Ii7839FPz+87dXb9LLkD6iO/iU2y
         tjY3GuZ3SboLhFUPhtVzzoi37Zy60SfcOht/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BKLrzrx25Rtgby5bU4xiKAHrXa1CYUKzz2uaeh4FjZU=;
        b=U39vkblrVL7Ad88M0eP4+3pJkg9OtH9w4GNTz3PFIZJ8Y3W5ojif5U4WN2DjrtFSmd
         3WmQvQJt/JFUY8RgqfXwP0OCBsbxu1Dv8FTy19yi4Mm3aw/aGqyCfKZwJGfJ1/1Tu8XA
         6Wg+RROj8pbN0s1+41gwGCmkK+LKo01OUhp6dEbRQ9ulTgiE8qReE6EtHPqTvp2ZfTEs
         4QYSWFP76FBOGf+HObhjWN8M1rgXoN7vunqwM0WKPlRKVRL+HvP2ZYzXW4OKkOR2++lB
         5cyp6JQo1X+p0zZCEf5Rxd1nF0OSCQ85YM+k3RpYMUo+O6umg6Ge0bUjz9umie1O2WEl
         OgqA==
X-Gm-Message-State: AOAM532zuKwN8co/WP0aR0MgX/LMH6UKXqQQ+yxGbd+SH8JtdG1wYqg2
        rCjZ0pvVMP1y83nlKO9bLIeOFhtldc3v6Q==
X-Google-Smtp-Source: ABdhPJxegTjJupvOg+mFN6A8ZVOVf726HZ80unRQMYwOJOAB7Lp/Cxmga0+mR/a1hQON7u44iEGttw==
X-Received: by 2002:a19:7f55:: with SMTP id a82mr13105864lfd.603.1606071644235;
        Sun, 22 Nov 2020 11:00:44 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id j23sm189360lfh.88.2020.11.22.11.00.42
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2020 11:00:43 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id r24so4626833lfm.8
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 11:00:42 -0800 (PST)
X-Received: by 2002:ac2:598f:: with SMTP id w15mr10985577lfn.148.1606071642651;
 Sun, 22 Nov 2020 11:00:42 -0800 (PST)
MIME-Version: 1.0
References: <20201122152731.10994-1-luc.vanoostenryck@gmail.com> <20201122152731.10994-2-luc.vanoostenryck@gmail.com>
In-Reply-To: <20201122152731.10994-2-luc.vanoostenryck@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 22 Nov 2020 11:00:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjqwFDEJkGoPtjeTn1cDDpadz_eL_m1w-wk9G9Zmucosg@mail.gmail.com>
Message-ID: <CAHk-=wjqwFDEJkGoPtjeTn1cDDpadz_eL_m1w-wk9G9Zmucosg@mail.gmail.com>
Subject: Re: [PATCH 1/7] not: add testcases for canonicalization &
 simplification of negations
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

I thought we already canonicalized the pseudo ordering, but clearly not..

Anyway., looks good to me.

Btw, if you want to do another simplification, one that I've actually
seen multiple times in the kernel is this one:

    if (val1 & BITx)
       val2 |= BITy;

and turning it into

    val2 |= (val1 & BITx) .. shift left or right by (BITx-BITy);

and while actually testing the above, I note that sparse seems to have
problems with even simple if-conversion:

   #define BIT1 4
   #define BIT2 8

   int fn(int x, int y)
   {
        if (x & BIT1)
                y |= BIT2;
        return y;
   }

linearizes to a nasty mess of actual phi nodes and conditional jumps
rather than just a 'select' op. Never mind the actual unconditional
version, of course.

I didn't check why the if-conversion doesn't happen.

           Linus
