Return-Path: <SRS0=50jZ=ID=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842EDC433E0
	for <linux-sparse@archiver.kernel.org>; Fri,  5 Mar 2021 21:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F38465065
	for <linux-sparse@archiver.kernel.org>; Fri,  5 Mar 2021 21:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhCEVYK (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 5 Mar 2021 16:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhCEVX7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 5 Mar 2021 16:23:59 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DBDC06175F
        for <linux-sparse@vger.kernel.org>; Fri,  5 Mar 2021 13:23:58 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id k9so5939562lfo.12
        for <linux-sparse@vger.kernel.org>; Fri, 05 Mar 2021 13:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SydtHA9ySlkODMySHl2z0gV1PL50P5TP1t2fIowj2ao=;
        b=IiowVuY5H7HwbHt3FsPfra4svFZ+jyUJwevcVWIDYh7E47fIsYZfyfxWEaqkp+Y1Cl
         aM4IJyeHPL8m5C/ULkmtXt/Tk2W67vqLtjpPJix1g5tvliIcOrY+E/aTytf6+TPiYUkB
         XhWp9HZieAf4AnqTMwrfdrBt63JbWcnOu+SvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SydtHA9ySlkODMySHl2z0gV1PL50P5TP1t2fIowj2ao=;
        b=LGEBbv5hg9r01CNBdNkhM2XQutKM38FoBj+zvjE2haRPBbCwqJt2xkyC+OIzdYiiSS
         WawArT/vyBYVEAUdrqWCYpNvtNrsEo8HnjqPz+YspaUaeOvznY545ED8Ta4gD6dvvdOm
         ymGmxz870KkhEkKXdkMzaqQiSLZ1QPUePpyk8ZvGoKCX+aCv1DIx+oJAFUQ2Eh8mm14K
         SaF1p8g7aursefcM9312xxSReq4a7T/GQLn9qbYhDA8WSI7VZ9lI4zTylw9XgiH9GnqQ
         AYYWYOgpgg61SBoWogMMjNx25a3e73hopICWKv2F+zXY3+GxOAm5RlXPv9qvrU8QMplG
         sqpw==
X-Gm-Message-State: AOAM532ZtkZ/LTxremOKWWSWaRGoGY3xZY6VRTvrPQZZ63FjoR25vrUe
        d9bfEWwuvm0KT0qx7CeXWQ5Q3GcX/XeWrA==
X-Google-Smtp-Source: ABdhPJzLfeXiAiXvz9llpuMdGMF8QcmpcxmQ+y1UbzJOvNJwLm+eEC30edZR/7DBVp6ClMkDwPhZPw==
X-Received: by 2002:a05:6512:224b:: with SMTP id i11mr7274404lfu.652.1614979436898;
        Fri, 05 Mar 2021 13:23:56 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id y17sm440718lfb.132.2021.03.05.13.23.55
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 13:23:55 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id p15so4538882ljc.13
        for <linux-sparse@vger.kernel.org>; Fri, 05 Mar 2021 13:23:55 -0800 (PST)
X-Received: by 2002:a2e:a589:: with SMTP id m9mr151221ljp.220.1614979434841;
 Fri, 05 Mar 2021 13:23:54 -0800 (PST)
MIME-Version: 1.0
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain> <CAHk-=wjFWZMVWTbvUMVxQqGKvGMC_BNrahCtTkpEjxoC0k-T=A@mail.gmail.com>
 <YDvwVlG/fqVxVYlQ@localhost.localdomain> <CAHk-=wi54DEScexxpMrO+Q2Nag_Tup+Y5YBHc_9_xGLeRfP8pA@mail.gmail.com>
 <877dmo10m3.fsf@tromey.com> <CAHk-=wi13+FLcRo4zmnRUmmY=AAns-Yd5NR_mVdcAd6ZrPq2fA@mail.gmail.com>
 <4835ec1d2ecc40b285596288a0df4f47@AcuMS.aculab.com> <CAHk-=wh8PptzH-=ak1D7C5Zp6EJ8eurYqVqGdQauupAFaNuG4g@mail.gmail.com>
 <44a0cc9cb5344add8ee4d91bffbf958f@AcuMS.aculab.com>
In-Reply-To: <44a0cc9cb5344add8ee4d91bffbf958f@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 Mar 2021 13:23:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=whh3fiL7FcLD_r1rfx-gP9W4HWS7vTPM9LKUH+0xzF2=A@mail.gmail.com>
Message-ID: <CAHk-=whh3fiL7FcLD_r1rfx-gP9W4HWS7vTPM9LKUH+0xzF2=A@mail.gmail.com>
Subject: Re: [PATCH 00/11] pragma once: treewide conversion
To:     David Laight <David.Laight@aculab.com>
Cc:     Tom Tromey <tom@tromey.com>, Alexey Dobriyan <adobriyan@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Mar 5, 2021 at 1:19 AM David Laight <David.Laight@aculab.com> wrote:
>
> The point is that you can skip the unwanted parts of
> #if without having to parse the file at all.
> You just need to detect the line breaks.

That's not actually true AT ALL.

You still need to at the very least parse the preprocessor tokens,
looking for things like #if, #else, and #endif. Because those can -
and do - nest inside the whole thing, so you're not even looking for
the final #endif, you have to be aware that there might be new #if
statements that means that now you now have to increment the nesting
count for the endif.

And to do even just *THAT*, you need to do all the comment parsing,
and all the string parsing, because a #endif means something entirely
different if there was a "/*"  or a string on a previous line that
hasn't been terminated yet (yes, unterminated strings are bad
practice, but ..).

And regardless of even _those_ issues, you still should do all the
other syntactic tokenization stuff (ie all the quoting, the the
character handling: 'a' is a valid C token, but if you see the string
"it's" outside of a comment, that's a syntax error even if it's inside
a disabled region. IOW, this is an incorrect file:

   #if 0
   it's a bug to do this, and the compiler should scream
   #endif

because it's simply not a valid token sequence. The fact that it's
inside a "#if 0" region doesn't change that fact at all.  So you did
need to do all the tokenization logic.

The same goes for all the wide string stuff, the tri-graph horrors, etc etc.

End result: you need to still do basically all of the basic lexing,
and while you can then usually quickly throw the result mostly away
(and you could possibly use a simplified lexer _because_ you throw it
away), you actually didn't really win much. Doing a specialized lexer
just for the disabled regions is probably simply a bad idea: the fact
that you need to still do all the #if nesting etc checking means that
you still do need to do a modicum of tokenization etc.

Really: the whole "trivial" front-end parsing phase of C - and
particularly C++ - is a huge huge deal. It's going to show in the
profiles of the compiler quite decisively, unless you have a compiler
that then spends absolutely insane time on optimization and tries to
do things that basically no sane compiler does (because developers
wouldn't put up with the time sink).

So yes, I've even used things like super-optimizers that chew on small
pieces of code for _days_ because they have insane exponential costs
etc. I've never done it seriously, because it really isn't realistic,
but it can be a fun exercise to try.

Outside of those kinds of super-optimizers, lexing and parsing is a
big big deal.

(And again - this is very much language-specific.  The C/C++ model of
header files is very very flexible, and has a lot of conveniences, but
it's also a big part of why the front end is such a big deal. Other
language models have other trade-offs).

             Linus
