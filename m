Return-Path: <SRS0=7JZe=EO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA46CC388F9
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 00:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 659F520702
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 00:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8ZUdlVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgKHAmG (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 19:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgKHAmF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 19:42:05 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C97C0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 16:42:05 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id dk16so7150183ejb.12
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 16:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jy6nDkddnMG2yNBVBxkZvhtw3xl6NwO9/ziBaQZ5liE=;
        b=I8ZUdlVkbELd3/rAwxFc9/1cQQE1j5zmLnJGO+iKb6x7z7NeshroZ+P5oX3Jv2yjNH
         YQaiiUqw5IHJ/4DQSSu8T7pnX0pKVdxNeSsYRhbo+qno+UVMq3/d5yWIf+7evv1Qu2Ww
         9Scn6DjfYLqi0KOvoTCXuuAGj92KpOor53A/WWJb5yFKk4jw5w6y2j1UiBpT1Mbof7Eg
         DNwrS1/F309PoR4iQh9aCGfXJ5E4jvVYdEGR8pxREY03zvAnhe0CBvJrE90QIdw7Ecun
         oPH/htF0pO0oldi5dSX6VlANF0z/abNCuKNVcCwbvf+dPJ5tLY+u9m+CrpRuYotWdJ5o
         9D5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jy6nDkddnMG2yNBVBxkZvhtw3xl6NwO9/ziBaQZ5liE=;
        b=gT3nALDEgazd3dIHWN9Wzqt+/kE8/3XXkhA79giqnC210PDi2i6iwunVGT+PjgJ5sa
         oDOv/yCnPh7GW5sxtdZtf/7PJCGFU69C+3LnDIYMeFXCfzom3JUGsTVIexYdUd+1L3EA
         cNH9sVh8aCiXWhUTWSDLFGNeyy97rSlTXCp+UknKl5elfwmxarkWDQ0blk8V+Kytk9Xe
         txeBJ2n3dI9emWi817v76nHcJG+NMBccNIewqXf3wC0f90SekP+VJgG1b/oWEFEmDMDs
         Fgwf6ZvdPDaViS3Y7H697zLclb4Cl7QpDxodBOY0Rs4iFOSKB4Vkv0t+HDm2GN3yNDEa
         aaRQ==
X-Gm-Message-State: AOAM532u/IEOIFrvJ+ApXF5PxmulQzWHJSoALRmkKNeOucLVAEPR4+7C
        Q9SrhMfXua6gaUkzrgmuyTc=
X-Google-Smtp-Source: ABdhPJx4TL85Gdh1EmxDkz22SQ+PNxFWv4/T8Cc+lKUGG4yxsoXF53p7ToqYTCOTy3FeheFJsnoNtw==
X-Received: by 2002:a17:906:ae52:: with SMTP id lf18mr9254762ejb.9.1604796122225;
        Sat, 07 Nov 2020 16:42:02 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:fce6:5cb0:27db:5e8c])
        by smtp.gmail.com with ESMTPSA id o31sm4525745edd.94.2020.11.07.16.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 16:42:01 -0800 (PST)
Date:   Sun, 8 Nov 2020 01:41:59 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Song Liu <songliubraving@fb.com>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: "warning: context imbalance" in kernel/bpf/hashtab.c
Message-ID: <20201108004159.gwbwirczpltkm7c3@ltop.local>
References: <246A7DB8-75D8-46B6-8AE4-BDACD5714EC2@fb.com>
 <CAHk-=wjbOjD_3HBas10sb9VKyNGvDrs9vXGj=rVc5TdPSPMDMA@mail.gmail.com>
 <20201106221917.n3is2fnud7jqa3x5@ltop.local>
 <CAHk-=whbo09hM0xW-qDLsZF4XunVDs5YwzH7a5G=5O+0qrPy_A@mail.gmail.com>
 <20201107013255.xpsfeamyco7ggnru@ltop.local>
 <CAHk-=wj0rBc0o_-u9H5_4-ZUnPOx-be3c1Dd-_WBWfPzEQtKRQ@mail.gmail.com>
 <20201107200924.fpybgapomro4xzxe@ltop.local>
 <CAHk-=wgCTM2HWeVFTvg7Dg1UQeYn1Md49e8VGCWELWq=c15_qg@mail.gmail.com>
 <20201107212327.js6dlr2tuzey4kz6@ltop.local>
 <CAHk-=wg8qsQ7Pu3umbw_kgT1OtSZY-dAaj2c6i4=xY_2=Q4C5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg8qsQ7Pu3umbw_kgT1OtSZY-dAaj2c6i4=xY_2=Q4C5w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Nov 07, 2020 at 02:20:03PM -0800, Linus Torvalds wrote:
> On Sat, Nov 7, 2020 at 1:23 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > Yes, but the branch simplifications depend on the simplifications
> > that can be made on the condition. For the moment there is a focus
> > on select because it often happens when the condition is simple but
> > for these context imbalance the general case is something like:
> >         stuff
> >         if (arbitrary condition)
> >                 take lock
> >         do other stuff
> >         if (same arbitrary condition)
> >                 release lock
> >
> > and the problem is (at least) twofold (but partially related):
> > 1) recognize that the second condition is the same as the first one
> > 2) avoid that partial optimizations of the first condition 'leak'
> >    into the common part because this often inhibits doing 1)
> >    [Sorry, if this is not very clear. I need to find some small
> >     examples to illustrate this].
> >
> > When the condition is very simple, it is converted into a select
> > but very often it's more complex, involves a memory access and/or
> > some function calls or some asm.
> 
> Note that if the condition is complex and involves memory etc, it's
> generally actually a bug in the kernel.
> 
> Because if it could possibly change between the lock taking and
> releasing, you are now broken.
> 
> So I wouldn't want to accept code like that _anyway_. Any complex
> conditional needs to be written as
> 
>      lock = complex_conditional;
>      if (lock)
>           take lock
>      do other stuff
>      if (lock)
>           release lock
> 
> and if sparse handles _that_ case well, then all is ok.
> 
> If sparse complains about the fragile "repeat complex conditional that
> couldn't be simplified to show that it was obviously identical", then
> that's actually a _good_ thing.
> 
> Because we want to complain about stuff where it's not obviously clear
> that the conditional is 100% the same.
> 
> Now, even in the above, if we'd want sparse to say that is ok, then
> we'd actually need to make the context tracking itself able to deal
> with "conditional on this pseudo", which it doesn't do right now.
> 
> So right now it requires that much simpler case where you actually end
> up not ever having that shared case in the middle at all, and the
> simplification really ends up showing that the real path is really
> 
>      error = complex_conditional;
>      if (error)
>           return error;
>      take lock
>      do other stuff
>      release lock
> 
> which apparently sparse now - with your simplification - can see that
> the code actually ends up doing .
> 
> Which is even better.
> 
> I'd much rather have the lock context tracking show that locking is
> simple, and that we don't have any code that sometimes is called
> locked, and sometimes is not.
> 
> Because even if you can prove - with some kind of conditional context
> tracking - that the context at least _nests_ correctly (ie you always
> properly unlock something you locked), that isn't actually the big
> problem. The big problem really is "why did that 'do-other-stuff'
> sometimes run without locking, and sometimes with locking?"

But isn't a lot of code written to explicitly support this, with an
argument or some other condition selecting between the locked mode
or the unlocked mode?


> So the lock context tracking is fairly inflexible on purpose. It's
> _meant_ to not just do "unlock matches a lock" matching. It's meant to
> also track "ok, there is no odd 'sometimes locked, sometimes not'
> code".

I agree with all this but I think the situation is not so clear cut.
I've made a few examples, oversimplified, totally made-up but
representative of the situations with the context tracking.

	void take_lock(void) __attribute__((context(x, 0, 1)));
	void drop_lock(void) __attribute__((context(x, 1, 0)));
	void minor(void);
	void major(void);
	int complex_cond(void);
	
This one is fine for Sparse
	static inline int cond_lock1(void)
	{
		if (complex_cond()) {
			take_lock();
			minor();
			return 1;
		}
		return 0;
	}
	static void ok1(void)
	{
		int cond = cond_lock1();
		if (cond) {
			major();
			drop_lock();
		}
	}
It produces the following:
	ok1:
		call.32     %r1 <- complex_cond
		cbr         %r1, .L1, .L5
	.L1:
		call        take_lock
		context     1
		call        minor
		# call      %r3 <- cond_lock1
		call        major
		call        drop_lock
		context     -1
		br          .L5
	.L5:
		ret
Good.

The next one corresponds to the situation Song Liu reported
	static inline int cond_lock2(void)
	{
		if (!complex_cond())
			return -1;
	
		take_lock();
		minor();
		return 0;
	}
	static int okish(void)
	{
		int cond = cond_lock2();
		if (cond)
			return 0;
		major();
		drop_lock();
		return 1;
	}

Sparse currently produces the following:
	okish:
		call.32     %r6 <- complex_cond
		select.32   %r8 <- %r6, $0, $0xffffffff
		cbr         %r6, .L8, .L9
	.L8:
		call        take_lock
		context     1
		call        minor
		br          .L9
	.L9:
		# call      %r8 <- cond_lock2
		seteq.32    %r11 <- %r8, $0
		cbr         %r6, .L11, .L12
	.L11:
		call        major
		call        drop_lock
		context     -1
		br          .L12
	.L12:
		ret.32      %r11

Sparse complains about a context imbalance because of L8/L9.
The seteq is not merged with the select but something can be done
about it or on the conditional branch that depends on it.
I'll look at it right away.

[But from what I remember when I analyzed some of these, it's in
 similar situations that things are messy, when cond_lock() is
 slightly more complex and partial simplifications begins to mix
 things from the surrounding blocks].


The one that really annoys me is this one. It's very simple and, as
far as I know, quite common in the kernel but kinda hopeless.
	static void ko(int cond)
	{
		if (cond)
			take_lock();
		major();
		if (cond)
			drop_lock();
	}

It produces the following:
	ko:
		cbr         %arg1, .L14, .L15
	.L14:
		call        take_lock
		context     1
		br          .L15
	.L15:
		call        major
		cbr         %arg1, .L16, .L17
	.L16:
		call        drop_lock
		context     -1
		br          .L17
	.L17:
		ret

There is no select, no seteq/setne, no complex condition, nothing.
It's an idealization but I think that a lot of code involving
conditional locks boils down to this and as I said is quite common.

What do we want to do about this? I don't think there is nothing that
can be done except warning or duplicating .L15, making it as if the
code would have been written as:
	static void ko(int cond)
	{
		if (cond) {
			take_lock();
			major();
			drop_lock();
		} else {
			major();
		}
	}
It's doable of course but ... well, I don't think we want to do this.

-- Luc
