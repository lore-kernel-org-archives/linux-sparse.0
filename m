Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AE7C2D0A3
	for <linux-sparse@archiver.kernel.org>; Mon,  9 Nov 2020 22:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A625206A4
	for <linux-sparse@archiver.kernel.org>; Mon,  9 Nov 2020 22:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhGKUeZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgKIWNt (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 9 Nov 2020 17:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKIWNs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 9 Nov 2020 17:13:48 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8017AC0613CF
        for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2020 14:13:48 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id s25so14581183ejy.6
        for <linux-sparse@vger.kernel.org>; Mon, 09 Nov 2020 14:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NyPmvUx+N3a43Z4ncHjt5gv2c9SyArX0Mbl626gfR9o=;
        b=UhGKUeZu6Ybhp4OB/r1jEIJVD6U4e5DT3v/TOY5lWPsnJdyhNElytxbUx9hK+Zg8Ot
         yudDXNkI/IBiyYUak0P4G6DGV+Fy0BQI7UZ7tgDxDNnn9s4e6Mej34S3LbnEJ0k76pUQ
         VsVrvIhA0lRxS7TVjRonsrPTAMAkG/GgIM9AAQ7rL6TvIGLN+53vOYwhwB8r8FEjsGbM
         l6Jlj/YeeF1rbgm1onhRC1BGGBohYpiwTraDNbHnmY71xHYHOClIUrogbu5jSsqq9swJ
         T7DCwTJ1LrqlRJycfIMPxSYWb2GpppTa49jCKen9dWg4kZ+L6nS+ZdrQ1AxCWWCnxHt4
         n9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NyPmvUx+N3a43Z4ncHjt5gv2c9SyArX0Mbl626gfR9o=;
        b=k98qOgvA79yy2ADG9zd6yruadaVJnJwlbWU4W0+5F3jjzHO8gJ+JQuqLZO/umjcGd3
         N7lwNEb3WKQqaRfsMwFdRx4gPqOUiUMWxwb3OrpUmlRcR1oBVtrivzR7H1rVZccnFY4O
         BE72d9s7wfrBPQbdEs2oH6egfAfLuS5tD2OHj/Wneme+xTcOJNqn5MDND9VMZh2tdFaO
         KvAr0sLwUB0rGJ/bhd1yRRtfB034N3klHP/VSNqkFgvpmjKaUNU6GjMFB8VCYS8K397V
         G/Y1dz4QQYEp7YClJnI1HbeuAEWCKkxz4Z+wT/kuNYf0rEtBSxEGlcPYpcmSoTNU5EqW
         blvw==
X-Gm-Message-State: AOAM530tD8EJMSQYhUsKC37f8wuWW0M7GihGMZ6ZfzyKAutMgd/3DKy3
        osyOrvIPtXNY1Se8Fgn2UF0EjzLJOe0=
X-Google-Smtp-Source: ABdhPJyrYGCr2oSsF7EaryvFg3qFx/i1kxytzhobksKBDl0qqge9NyC5QJAz5RXqjThzPBt1ttc6cA==
X-Received: by 2002:a17:906:4803:: with SMTP id w3mr16752496ejq.406.1604960027250;
        Mon, 09 Nov 2020 14:13:47 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:b825:8815:5c02:9524])
        by smtp.gmail.com with ESMTPSA id v18sm9861384edl.7.2020.11.09.14.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 14:13:46 -0800 (PST)
Date:   Mon, 9 Nov 2020 23:13:45 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: 'context imbalance' warnings
Message-ID: <20201109221345.uklbp3lzgq6g42zb@ltop.local>
References: <20201109211616.dyr7g62rz5oohseu@ltop.local>
 <CAHk-=wjwbK1vjoJKCCERXQkykNHa2Bfpg8CsyDrEU4mGyHA7Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjwbK1vjoJKCCERXQkykNHa2Bfpg8CsyDrEU4mGyHA7Kw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Nov 09, 2020 at 01:47:24PM -0800, Linus Torvalds wrote:
> On Mon, Nov 9, 2020 at 1:16 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> >    There is no phi-source here and the CBR at .L3 could be merged
> >    with the one at .L0, removing the false imbalance but it's not.
> >    I thought that sparse was doing this sort of branch simplification
> >    but it doesn't, or at least it doesn't in this (simple) situation.
> 
> The branch rewriting sparse does is very simplistic, afaik. It's also
> confusingly written. I blame myself.
> 
> Honestly, in that example you quote:
> 
>                 cbr         %arg1, .L1, .L2
>         .L1:    context     1
>                 br          .L3
>         .L2:    call        use, %r1
>                 br          .L3
>         .L3:    cbr         %arg1, .L5, .L4     ;; false imbalance here
> 
> we never even try to combine the two cbr's, because they don't jump
> directly to each other.
> 
> I think it would be easy to simplify if we just added some logic to
> change "unconditional branch to conditional branch", and moved the cbr
> up into L1 and L2, but I don't think we have any such logic (and it's
> a simplification that might end up being the opposite of a
> simplification - it would duplicate the conditional).
> 
> So we could try to remove L3 entirely, by moving it into both parents:
> 
>                 cbr         %arg1, .L1, .L2
>         .L1:    context     1
>                 cbr         %arg1, .L5, .L4
>         .L2:    call        use, %r1
>                 cbr         %arg1, .L5, .L4

Mmm yes, I see.
 
> and at that point, the branch simplification we *do* have woudl see
> that both of those duplicated conditional branches are now dominated
> by the first one, and we'd end up with
> 
>                 cbr         %arg1, .L1, .L2
>         .L1:    context     1
>                 br         .L5
>         .L2:    call        use, %r1
>                 br         .L4
> 
> and then we'd join L2 and L4 together and the end result would look nice.

I was simply thinking doing this directly. In the case of a simple
'diamond' (with the top and bottom CBR on the same conditional),
there is no dependency/dominance problems and it's enough to change
the target of the BR in the two side BBs.

> But as it stands now, L3 isn't dominated by one side of the original
> conditional branch (because we reach L3 from both sides), and the cbr
> in L3 isn't something we can simplify without duplicating it and
> moving it up into the parents.
> 
> Is duplicating the conditional branch worth it? In this case, clearly
> yes. But in general? Maybe we could do it in cases like this, when the
> *only* thing in a basic block is that conditional branch.

I think the general solution is to look at the dominance tree:
if there is another conditional branch with the same condition and which
dominates the current, then it must be safe to duplicate because it
can be simplified away anyway. Otherwise, I would prefer to avoid
duplicating anything without some cost/benefit guarantee.

-- Luc
