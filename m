Return-Path: <SRS0=cH/F=EN=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DC2C388F7
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 19:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 265A020723
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 19:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604776396;
	bh=steMkrPFx3bZ8Rv8g+iJh2NOZlLLAIqMJjP3AhvYV9A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UGtSSsTrpvemltR3uipmAS/t8ZqBVyp2j9PiNyE9yBSy0AvaWZgreHolDym56vgBM
	 UygAEp6tmw9rs71cDBf6JkXp3C/TOe8a8lfP7Qs/tspoAbrlj1tikP+DH77czobxam
	 ESPlVzetJQpiLzxTxGXQj4bir64c7Oua+ej4cpng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgKGTNQ (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 14:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgKGTNP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 14:13:15 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39505C0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 11:13:15 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id s9so3427047ljo.11
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 11:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQJsF+uPH++EXbJocWq4EcJrZ5IoE8p5PtyUU/hz6k4=;
        b=Ja+cOvHkArk87sDL2Wre9LXTY3zedzmZnEQGc6/K4DO1J1RUU7/OnNBTlU5pBg0xlm
         J750+u8cO9dXpRZdlEMw+cLmlX5+IU66ZoWgS35K5E7xhGiijRjADvHGgq9zgCYBKx8r
         mNmdoj94vwp5Pcsota4gXMIovtUlbPZbDGIrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQJsF+uPH++EXbJocWq4EcJrZ5IoE8p5PtyUU/hz6k4=;
        b=t0jIugsH/R8maUP+Q41wpOwHzbt6XAK61xQina6d7rdSLogmOyxwL+RWJomk6MJKXI
         7ghbtBJAEp/tUpuBUXu8MG5euCVMHefJ8Fwavf8oJAzFAzh2+CWx1nEdHkmPGeNG0PDy
         Ul8oIhsjkCuVbmT5rri03jnFayD2R7e3yEUV8d96NkEu4MQIWjPl77AqwcGbYZGGnHbW
         7RE+apDOmD8v938j3BU5oUodQCgCHzPftzlX35qGUuS/19LDkm/jxl2wA+HU534Y2XjZ
         UFpqbOhYrt+VS254W2YF5zgoYwGMHBd5KjdhV+G0xakx2cx3AhT8xLnt8Lk220OIHXpz
         OuLQ==
X-Gm-Message-State: AOAM531ihSaa0ThC48EfwT4M1WncRVx6fIvOL3jkakJhDNlQB1ecjUIx
        +4X/NtWdttZkt2oKT2SbmI7KqrU04Nq41Q==
X-Google-Smtp-Source: ABdhPJyaDHiHuxX6hK/2Z1WomFOA3trpu27jVGM51KV32CJxh4vs9NibuUE4eCXRkO78nUrIZM1+vA==
X-Received: by 2002:a2e:9cc1:: with SMTP id g1mr3128294ljj.386.1604776392004;
        Sat, 07 Nov 2020 11:13:12 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 1sm569864lfi.263.2020.11.07.11.13.11
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2020 11:13:11 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id z21so5306100lfe.12
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 11:13:11 -0800 (PST)
X-Received: by 2002:a19:83c9:: with SMTP id f192mr2765104lfd.148.1604776390730;
 Sat, 07 Nov 2020 11:13:10 -0800 (PST)
MIME-Version: 1.0
References: <20201107114222.11866-1-luc.vanoostenryck@gmail.com> <CAHk-=wjvvkQm3zTobKUY2OuUfNACa13mhYeTPwVJcT0HVeRkjg@mail.gmail.com>
In-Reply-To: <CAHk-=wjvvkQm3zTobKUY2OuUfNACa13mhYeTPwVJcT0HVeRkjg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Nov 2020 11:12:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjGSQgE=YvQUpf-WcYA+oAs3p6i8teSA8VGoaOStS_m3g@mail.gmail.com>
Message-ID: <CAHk-=wjGSQgE=YvQUpf-WcYA+oAs3p6i8teSA8VGoaOStS_m3g@mail.gmail.com>
Subject: Re: [PATCH 0/5] simplify SEL(SEL, ...), ...)
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Nov 7, 2020 at 10:38 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think there's a couple of others, like
>
>   SEL(x, x, 0) -> x
>
> which looks insane, but I think these are the kinds of things that end
> up showing up when you inline things that return errors, and then you
> test them for zero etc.

Made-up crazy example:

    extern int fn(int);

    int t(int x)
    {
        int err = fn(x);
        if (err)
                return err;
        return 0;
    }

which is the kind of thing that can happen when you have various
config options and code goes away. It *should* just result in a no-op
(ie just call 'fn()' and return its value), but currently sparse
generates

    call.32     %r2 <- fn, %arg1
    select.32   %r6 <- %r2, %r2, $0
    ret.32      %r6

instead of

    call.32     %r2 <- fn, %arg1
    ret.32      %r2

but I hadn't actually applied your patches when I did that test, so
maybe you had caught this case already without me realizing it.

           Linus
