Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06BFC4361B
	for <linux-sparse@archiver.kernel.org>; Wed, 16 Dec 2020 22:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D3DE2342C
	for <linux-sparse@archiver.kernel.org>; Wed, 16 Dec 2020 22:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgLPWiD (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 16 Dec 2020 17:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgLPWiD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Dec 2020 17:38:03 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320D7C061794
        for <linux-sparse@vger.kernel.org>; Wed, 16 Dec 2020 14:37:23 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id o17so49549691lfg.4
        for <linux-sparse@vger.kernel.org>; Wed, 16 Dec 2020 14:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OU5A6v5bpij76Zpb0WFKHQR2I+Hk7B4Y1jDcTHSKXkU=;
        b=JpsxgNUE4RVzwGmVq/oda6qWUa4OrIOgb0nBpRhp9iLU59o4sHJ3g24zDE0NI4dQ0A
         WVu3kXjLDWqZQZefGdodVkEYkhe7l3SGsSCQH+XlId2sWvZLTFqOto6UuMa4R0xBMQ76
         4YADJ9MHnUsjkl7ntBV5WZdFRsEqGb70C7Nl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OU5A6v5bpij76Zpb0WFKHQR2I+Hk7B4Y1jDcTHSKXkU=;
        b=QWgqGwx3IIB8pG9YZS+hhFTHl9lmBWeLX3FFUtXCRz43Vuzhq91PXDHEMqm5GoCQip
         kEokuMewBukJX5NntQd19wUEpXbArpsjBdD3feM2uOMHUlmGAaeQiRNrPH8qbt9wIQ31
         kOczWpzMHS5Z+LnPSaUJkCsBcAJyrNxhfvRAx/fbOqY0KJYYgEo7vjFhITzE7vtjhsdP
         9PlNUYiqeoz9Ze5dmwmQdPFm/wOR71fknlQIDNIynf+x3XV+BclXKPDNgIU66UAokELk
         mnzxDSOhHNdcyK/2/kHsZVegn651Hec+YpjQVNw0nPciT5D8lz+8Xt53lvIITkvTH15y
         DKdw==
X-Gm-Message-State: AOAM5307t0dFS3k88poEVP8yR5Ka58x9RIu3mbLzcwO9aJ02/3GKV924
        EwyEnX4rNMtNDLQISTe62vhSjOE13n1vag==
X-Google-Smtp-Source: ABdhPJxEEybt6JXHEeZ9cWGzo8418AbvKCg62gzLLqwrKOPY7h76clQ8wRXHhKT7bG9T0Fy22zPI/A==
X-Received: by 2002:a2e:a58e:: with SMTP id m14mr15968669ljp.1.1608158241486;
        Wed, 16 Dec 2020 14:37:21 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id f4sm370582lfd.198.2020.12.16.14.37.20
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 14:37:20 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id s26so17804911lfc.8
        for <linux-sparse@vger.kernel.org>; Wed, 16 Dec 2020 14:37:20 -0800 (PST)
X-Received: by 2002:a19:7d85:: with SMTP id y127mr14215729lfc.253.1608158240204;
 Wed, 16 Dec 2020 14:37:20 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjiC6UejP6xob9BMQy98O6OLGDhy-qDfaFcOJxo90iOFg@mail.gmail.com>
 <20201216222448.2054-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20201216222448.2054-1-luc.vanoostenryck@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Dec 2020 14:37:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiWSQgvyKxaVDac+1Fto7_hYCY9Nir8eaPu7dNmV+b=tA@mail.gmail.com>
Message-ID: <CAHk-=wiWSQgvyKxaVDac+1Fto7_hYCY9Nir8eaPu7dNmV+b=tA@mail.gmail.com>
Subject: Re: [PATCH] warn when zero-extending a negation
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Dec 16, 2020 at 2:25 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> I suppose that it is fine for you that I your SoB instead of the
> 'Originally-by' I used here?

Either works for me.

Some of the cases I saw (from my very quick look) were because of
annoying zero extensions that should have been optimized away.

Example:

    static inline unsigned char bytemask(int bit)
    {
        return ~(1<<bit);
    }

    unsigned char maskout(unsigned char a, int bit)
    {
        return a & bytemask(bit);
    }

note how this is all safe, because everything is operating on just bytes.

But sparse complains:

    t.c:3:21: warning: zero-extending a negation - upper bits not negated

because obviously the usual C type expansion to 'int'.

But that really is because sparse is benign stupid, and leaves those
type expansions around even though they then get truncated down again.
You can see it in the code generation too:

Zero-extend, and then truncate:

  zext.32     %r2 <- (8) %arg1
  shl.32      %r5 <- $1, %arg2
  trunc.8     %r6 <- (32) %r5

then do the 'not' in 8 bits, because we did that part ok:

   not.8       %r7 <- %r6

and then the zero-extend and truncate thing again:

    zext.32     %r9 <- (8) %r7
    and.32      %r10 <- %r2, %r9
    trunc.8     %r11 <- (32) %r10

and then the return in 8 bits:

    ret.8       %r11

because sparse doesn't do the simplification to just do the shl and
and in 8 bits (but sparse *does* do the simplification to do the 'not'
in 8 bits).

So the warning comes from the fact that we kept that zero extend
around, even though it really wasn't relevant..

I don't know how many of the false positives were due to things like
this, but at least a couple were.

                Linus
