Return-Path: <SRS0=cH/F=EN=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B3BC388F7
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 19:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C41920885
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 19:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604778005;
	bh=JU6RZDl6e4F1tr37KHya842Pzo2BFrvShCZc5w+Knt8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=18ipbprrQF6kq/ScNYbUMGGu9gfl5epigDRwwQlVPKdvRO19tdzsND6dm5CURAVW1
	 /oLkOgnOsSlhrZpSJxWzeLWZ+Ze24UDGcjVejLzUrELCueQs+sBg6AawtpNyHcjcXA
	 PJ5I/RvON+Sxj9U68lwG219HTAM+aVF8/vjyJMeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgKGTkF (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 14:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgKGTkE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 14:40:04 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD1DC0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 11:40:03 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id l10so5226183lji.4
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 11:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wL6bOYc3gaI3Crwhz5Jcaa1bu1eYq5oBnnwh9xcD42Q=;
        b=CLHdRagFI0JXuwtHVNAAKdbOR2t55CX6nktfp+K8aDL/AwjBDOdKIfygnW8rdUxC+2
         FfZffeGt8DRKNOfLDjJin3ROVyWiw+xDI437ITThPFL7e6XTlnv55qRJhyqjrds67E+k
         8s1Ne3lpKsK9sukXwWBWEtmVbfSf0bBgyeLXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wL6bOYc3gaI3Crwhz5Jcaa1bu1eYq5oBnnwh9xcD42Q=;
        b=GoD5fpu55bmt/G72FVJ9ie51uZcabFKt4Ohy8VR9md5MqTf7CMFFRLWQKa10Wc+vMg
         efUI3ZqSb4B6HjKfmWhYBgj/cmHqWF/qQ6hrBvBgxj6TgHgeGreMYaTPQ9rRXf9fTTA+
         eVDZ6J/8S+t3TNmcnQXJtCLzQhE0uxM9rRhbTnxDdGfGhPMUMtPn5p0R8VB8y5uAEBDt
         2bRWvnBXeeJSue5mJ/y/3kOEVkDA83+jCZAA/Hv37kKwsPFN107IIFNrmGw13a2GhNMv
         9jl/IIlIQvERksfaqv15nD4lOOGT/a1P0ohNWHSfGKW4kslWaD7pkXZjW+DyRKxlA1+a
         Ivtw==
X-Gm-Message-State: AOAM5331BNpP7vG9EEqzgeIq0GTGNsQUqksPKVmNnr0S2L45PI9KG9GW
        1wUuO/zQEAkZyLn9hm9nqYzpjaY21yyZPg==
X-Google-Smtp-Source: ABdhPJxh+XJZGJYOMDSOCETDtJaIZ2UiDrx1L9nrZ+xaXW6+p5ncovCE/ul6wFI0WsMb1arpY+kArg==
X-Received: by 2002:a2e:86d2:: with SMTP id n18mr2789877ljj.271.1604778000251;
        Sat, 07 Nov 2020 11:40:00 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id l6sm645981lfk.267.2020.11.07.11.39.58
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2020 11:39:59 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id y25so4310781lja.9
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 11:39:58 -0800 (PST)
X-Received: by 2002:a2e:9212:: with SMTP id k18mr14530ljg.371.1604777998599;
 Sat, 07 Nov 2020 11:39:58 -0800 (PST)
MIME-Version: 1.0
References: <4126C08B-532F-4B6A-A3C2-9F7928EA2806@fb.com> <20201105211342.6mglug2a74bi5hvd@ltop.local>
 <CAHk-=wjgKzHvGYbHpJ6DJj6W73b54QqNK0LSjY-jYdU3kxhWMQ@mail.gmail.com>
 <20201105215023.wvekadtkdwgz7yim@ltop.local> <B8E674A7-1B84-4E64-A688-EF226A947AB3@fb.com>
 <CAHk-=wiTAFVdMCF=oADAOFwVWff2Rs1qqD1Wqj8rF0zTgbLYag@mail.gmail.com>
 <246A7DB8-75D8-46B6-8AE4-BDACD5714EC2@fb.com> <CAHk-=wjbOjD_3HBas10sb9VKyNGvDrs9vXGj=rVc5TdPSPMDMA@mail.gmail.com>
 <20201106221917.n3is2fnud7jqa3x5@ltop.local> <CAHk-=whbo09hM0xW-qDLsZF4XunVDs5YwzH7a5G=5O+0qrPy_A@mail.gmail.com>
 <20201107013255.xpsfeamyco7ggnru@ltop.local>
In-Reply-To: <20201107013255.xpsfeamyco7ggnru@ltop.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Nov 2020 11:39:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj0rBc0o_-u9H5_4-ZUnPOx-be3c1Dd-_WBWfPzEQtKRQ@mail.gmail.com>
Message-ID: <CAHk-=wj0rBc0o_-u9H5_4-ZUnPOx-be3c1Dd-_WBWfPzEQtKRQ@mail.gmail.com>
Subject: Re: "warning: context imbalance" in kernel/bpf/hashtab.c
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Song Liu <songliubraving@fb.com>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Nov 6, 2020 at 5:33 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> So, I think that the next questions are:
> * which selects should be moved up?
> * up to where should them be moved?

Honestly, it's not even clear they should be moved up. It could be
moved down too, particularly in this kind of case where there is only
one user of the result (ie move it down to just before the use).

Moving down to the use is in many ways is much easier than moving up,
because then you don't need to worry about whether the sources to the
select have been calculated yet. No need for any dominance analysis or
anything like that for that case.

But my personal guess is that by default we shouldn't try to
excessively move instructions unless we have an actual reason to do
so.

So I don't think your patch a good simplification in general.
Particularly the "move up" part, when you might just end up doing an
entirely unnecessary select that would normally have been done only in
some unusual conditional case.

Now, instead, I think the proper select simplification is to tie it
together with the conditional branch. Look at what I had after the
other select simplifications:

    .L0:
        <entry-point>
        cbr         %arg1, .L5, .L4

    .L4:
        call        spin_lock
        br          .L5

    .L5:
        # call      %r4 <- errno, %r1
        select.32   %r6 <- %arg1, $0xffffffff, $0
        cbr         %arg1, .L6, .L2

    .L2:
        call        spin_unlock
        br          .L6

    .L6:
        ret.32      %r6

and notice that

        cbr         %arg1, .L5, .L4
    .L5:
        select.32   %r6 <- %arg1, $0xffffffff, $0

sequence. In particular, notice how we have a conditional branch to a
"select" that has the *same* conditional as the branch!

So I think the *proper* fix is to not think of this case as "move the
select", but as a special case of branch following: the same way that
a conditional branch to another conditional branch can be simplified
if the condition is the same, you can simplify the case of
"conditional branch to select with the same condition".

That said, that "proper fix" looks a bit painful. My gut feel is that
we shouldn't have generated that "select" in the first place at all.
We should have kept it as a conditional branch, then done branch
following, and done the whole "turn a branch-over into a select" at a
later stage.

Have we done that if_convert_phi() simplification too early?

I didn't really follow the whole chain of how we got to this point.

              Linus
