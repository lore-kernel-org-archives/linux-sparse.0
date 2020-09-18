Return-Path: <SRS0=Wnm1=C3=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78499C43464
	for <linux-sparse@archiver.kernel.org>; Fri, 18 Sep 2020 21:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A94F221EC
	for <linux-sparse@archiver.kernel.org>; Fri, 18 Sep 2020 21:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LI3K59+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIRVEZ (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 18 Sep 2020 17:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRVEZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Sep 2020 17:04:25 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D299C0613CE
        for <linux-sparse@vger.kernel.org>; Fri, 18 Sep 2020 14:04:25 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id j2so7356995eds.9
        for <linux-sparse@vger.kernel.org>; Fri, 18 Sep 2020 14:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=67LH/TGnvI3SJ1fCm3LUa5P2jFgYP5MapAJ+OBw6WqI=;
        b=LI3K59+47ttG9MHWm5R9W/Bj/id7HgXOFEeX/czMXIuhyPBFxUkIr4PCbkEhYYzCXo
         2SzGH4M/WbFJWNl0pN/Lu1COKH8wjk6LlwZqWAtXyt6d/25INs9ZhgUTTgh6TEX4vOhY
         22a2q32IWAGLCCcnjRDcZDfCNmqAJK+GJYoR9j5TQvpVges5bZD3aRql7S8zgOPzPbnl
         ObCXzUnN/zMcprZkN3BEGsG+2HMCYTOdFnjQuC3Dnx5JgI7TK/L4IsGvRPHLc6bmLEtF
         zRhJ4dHNPJoxfFRp9HBFUn+/0oQMsd6LJpT3PsSoVg9cPKH56QEeosnNdi+jefvMTmpp
         pJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=67LH/TGnvI3SJ1fCm3LUa5P2jFgYP5MapAJ+OBw6WqI=;
        b=chp8Eo/H13qgm+dkqS87FTyG8MAUtpubwNPvGkEpubFs+X+zlJA8TDa3Fqcr5+SzNN
         JchY9ZoesSYF7BpUZrexHS+ntjU1B9wyGK3TrzOLTtrcx/lM+f7ub0LXOKMjrDpkwVG3
         Nh3+IWA3Vo2JV8o6HBXBngH/ogwRT0SD659l0Ea4GrLuc8nqk/f+OlgexV8fzHVavMAM
         z2+f7PiSYDO/vogIIA+GjnidRKa4yIqaid0zxCkBkVpaAognZQRgyqjnCBkc+CJN4Rqp
         uuVQ+2iaplPD8Xh4aaSHO+HUZuAY5b1rbWfzCQK9E2Bc2/mHRlWeb/05GRAXx0gkTeu9
         jKUw==
X-Gm-Message-State: AOAM531dgXXOHGYMEUKtJYs9ZDxk8QyAhz1NErZLrUEJuGRjvYGFS7pE
        p6H/YowIpsVGj453hYfFvAbBI3BgBfE=
X-Google-Smtp-Source: ABdhPJwMqKXE+7q8x3hkoYpwzHUdyx6XVrLX3RMnfhN730TXrqa6LQG96A7gWgw6glTJvPZnVR+UAg==
X-Received: by 2002:aa7:d04d:: with SMTP id n13mr42033896edo.354.1600463063906;
        Fri, 18 Sep 2020 14:04:23 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:a042:11c2:1f02:36ab])
        by smtp.gmail.com with ESMTPSA id k8sm2956365ejz.60.2020.09.18.14.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 14:04:23 -0700 (PDT)
Date:   Fri, 18 Sep 2020 23:04:22 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: Making structs with variable-sized arrays unsized?
Message-ID: <20200918210422.uwq3pris3f3f5ku4@ltop.local>
References: <CAHk-=wgJZ05ap8VQdzWDWJVWVtZiOYTc6cnNB8gNeQzEnfm-tw@mail.gmail.com>
 <20200918204149.eqpl352wygwem34a@ltop.local>
 <CAHk-=wgnWnk6H376pux0V13Re6Gb6sFhqsS2oSW6E_v5CyfChQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgnWnk6H376pux0V13Re6Gb6sFhqsS2oSW6E_v5CyfChQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Sep 18, 2020 at 01:49:46PM -0700, Linus Torvalds wrote:
> On Fri, Sep 18, 2020 at 1:41 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > I also have 2 questions here under.
> >
> > >     struct bad {
> > >         unsigned long long a;
> > >         char b[];
> > >     };
> > ...
> > >     // The layout is odd
> > >     // The code does "info->align_size = 0" for unsized arrays, but it
> > > still works?
> > >     int odd(struct bad *a)
> > >     {
> > >         return __alignof__(*a);
> > >     }
> >
> > This returns 8. What's odd here?
> 
> The fact that it works correctly.
> 
> > The 0 align_size is only for the member 'b' and shouldn't have any
> > effect on the alignment of the whole struct. What am I missing?
> 
> I wrote that code by looking at the sparse source, and _expected_ it
> to return the wrong value.
> 
> Because the sparse code does
> 
>         /*
>          * Unsized arrays cause us to not align the resulting
>          * structure size
>          */
>         if (base_size < 0) {
>                 info->align_size = 0;
>                 base_size = 0;
>         }
> 
> so I expected that when base_size < 0, we'd drop the _previous_
> alignment we saved.
> 
> But what I suspect goes on is that base_size is actually 0, not < 0.
> But I didn't verify.

OK, I see. I'll check this.
 
> > >     // Arrays of flexible-array structures are pretty nonsensical
> > >     // Plus we don't even optimize the constant return. Sad.
> > >     int not_nice(struct bad p[2])
> > >     {
> > >         return (void *)(p+1) - (void *)p;
> > >     }
> >
> > I don't understand what you mean by 'optimize the constant return'.
> > test-linearize returns the only possible sensical answer (if the size
> > of the structure is accepted to be 8):
> >         not_nice:
> >         .L2:
> >                 <entry-point>
> >                 ret.32      $8
> 
> That's not what I see. I see
> 
>   not_nice:
>   .L2:
>         <entry-point>
>         add.64      %r3 <- %arg1, $8
>         sub.64      %r5 <- %r3, %arg1
>         trunc.32    %r6 <- (64) %r5
>         ret.32      %r6
> 
> which is rather different and not exactly optimal.
> 
> That wasn't what I _intended_ to look for, obviously. I expected the
> code you quote.
> 
> I wonder why it works for you but not me.

My fault, sorry. By error, I didn't run these tests on the head but in
one of my branches that coincidentally had some patches doing some
reassociation which then triggers the optimization.

-- Luc
