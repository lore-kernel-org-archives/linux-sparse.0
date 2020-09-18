Return-Path: <SRS0=Wnm1=C3=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A97BC43463
	for <linux-sparse@archiver.kernel.org>; Fri, 18 Sep 2020 20:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDD5421734
	for <linux-sparse@archiver.kernel.org>; Fri, 18 Sep 2020 20:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600462206;
	bh=9XcLEkGLgFSGXVA4tKxxJfh+hGMT8XywPcblLmhYoZk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hqZr//lJYmUu+03ooRCicxQT1p/vMqAaD5rDu0TuhTRaxJFmXsiG7DMl7xWLAXkjw
	 1kCm2FWHxgh5Aqor62qrAckeiAg5IebEx14KVxi4F+HtV753u+JpezmvXieBlgd8s2
	 00uR+f/QdJ/PFBXQzNPtqwnZGzH0L99nFcV421Fk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgIRUuG (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 18 Sep 2020 16:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRUuG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Sep 2020 16:50:06 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0362C0613CE
        for <linux-sparse@vger.kernel.org>; Fri, 18 Sep 2020 13:50:05 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a15so6156158ljk.2
        for <linux-sparse@vger.kernel.org>; Fri, 18 Sep 2020 13:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KCQvCmUg9/wycBQszcBzeDjt8kIBeEHljQvM+LDbBqs=;
        b=FH/KkT9dfFG13yYVHoi5aMEPb0skJi5kU25Id1FmfjMR+c2DY/OcGBhyyPklUc8zId
         Ev1VOowQ0e+LbnNLiY02xwddLJECCGEJJJmp+hx/Ju47jmcKbxaDHwrMQj+ELjsevdNa
         hNnwHHEyoFvX1wReRYy8/8VFpYM9S5PwUaKA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KCQvCmUg9/wycBQszcBzeDjt8kIBeEHljQvM+LDbBqs=;
        b=g+GZ2iWBwT4bajkFM1jfTkuN6+XUIgIXA/TzVVzleD8hQ+vhovRmxRF+XL13peZRyq
         oXVFHUop2VGHN5KP3EzJYiEulES2d6xVRq6+JWCCW2ocoU5qTtThevt/yuiRpmBK2W+I
         KczLuXrPMZRqcltOwGODjS9ExlEFEe4uWnebpZfbFu+vwtIN2SD95cOit2w5Imc1lvUR
         zdcfSuXEU+qSVcY8UYL10uQNqvxqKAYYDPenOau48L5VBfD/aaj6aF4J7YEKd5uTms2Y
         Tgh6mLuD8qBb9jd8KbD2tCx6n9x5CD3AdEAWhugF9/+LbovjdK+2xfmw++AQzMODmCNM
         3Wgg==
X-Gm-Message-State: AOAM533YpuRw7oWUOjkUGodMi+Q0ql9iOAx90UjizgZbDN8NzkFh9oY7
        ykWB7hWppeKzQ6QrAGbA6X8CG7TP6cBN0Q==
X-Google-Smtp-Source: ABdhPJy/gHx8SiQ3v5clc+QlYG+uwBgFVuztFE6cimayX5H+0r+dHLvwxjoZY8Tk8omIskEcU9bujg==
X-Received: by 2002:a2e:4e01:: with SMTP id c1mr11724730ljb.144.1600462204078;
        Fri, 18 Sep 2020 13:50:04 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 191sm805795lfa.131.2020.09.18.13.50.03
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 13:50:03 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id k25so6167993ljk.0
        for <linux-sparse@vger.kernel.org>; Fri, 18 Sep 2020 13:50:03 -0700 (PDT)
X-Received: by 2002:a05:651c:514:: with SMTP id o20mr13196477ljp.312.1600462202763;
 Fri, 18 Sep 2020 13:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgJZ05ap8VQdzWDWJVWVtZiOYTc6cnNB8gNeQzEnfm-tw@mail.gmail.com>
 <20200918204149.eqpl352wygwem34a@ltop.local>
In-Reply-To: <20200918204149.eqpl352wygwem34a@ltop.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Sep 2020 13:49:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgnWnk6H376pux0V13Re6Gb6sFhqsS2oSW6E_v5CyfChQ@mail.gmail.com>
Message-ID: <CAHk-=wgnWnk6H376pux0V13Re6Gb6sFhqsS2oSW6E_v5CyfChQ@mail.gmail.com>
Subject: Re: Making structs with variable-sized arrays unsized?
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Sep 18, 2020 at 1:41 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> I also have 2 questions here under.
>
> >     struct bad {
> >         unsigned long long a;
> >         char b[];
> >     };
> ...
> >     // The layout is odd
> >     // The code does "info->align_size = 0" for unsized arrays, but it
> > still works?
> >     int odd(struct bad *a)
> >     {
> >         return __alignof__(*a);
> >     }
>
> This returns 8. What's odd here?

The fact that it works correctly.

> The 0 align_size is only for the member 'b' and shouldn't have any
> effect on the alignment of the whole struct. What am I missing?

I wrote that code by looking at the sparse source, and _expected_ it
to return the wrong value.

Because the sparse code does

        /*
         * Unsized arrays cause us to not align the resulting
         * structure size
         */
        if (base_size < 0) {
                info->align_size = 0;
                base_size = 0;
        }

so I expected that when base_size < 0, we'd drop the _previous_
alignment we saved.

But what I suspect goes on is that base_size is actually 0, not < 0.
But I didn't verify.

> >     // Arrays of flexible-array structures are pretty nonsensical
> >     // Plus we don't even optimize the constant return. Sad.
> >     int not_nice(struct bad p[2])
> >     {
> >         return (void *)(p+1) - (void *)p;
> >     }
>
> I don't understand what you mean by 'optimize the constant return'.
> test-linearize returns the only possible sensical answer (if the size
> of the structure is accepted to be 8):
>         not_nice:
>         .L2:
>                 <entry-point>
>                 ret.32      $8

That's not what I see. I see

  not_nice:
  .L2:
        <entry-point>
        add.64      %r3 <- %arg1, $8
        sub.64      %r5 <- %r3, %arg1
        trunc.32    %r6 <- (64) %r5
        ret.32      %r6

which is rather different and not exactly optimal.

That wasn't what I _intended_ to look for, obviously. I expected the
code you quote.

I wonder why it works for you but not me.

               Linus
