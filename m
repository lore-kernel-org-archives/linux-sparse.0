From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2] implement constant-folding in __builtin_bswap*()
Date: Thu, 24 Nov 2016 11:23:44 +0800
Message-ID: <CANeU7Qn+XvWWhW69HjgoDejsex-qgJWRup2G2LLzDKp1TG238Q@mail.gmail.com>
References: <20161117095503.8754-1-johannes@sipsolutions.net>
 <CANeU7Q=vFZ2CtMYjMEYSNcJmdEGbg+_f_wYCRwmKZh3Jc76jEA@mail.gmail.com>
 <1479721551.8662.10.camel@sipsolutions.net> <CANeU7QmSSPT9cq1fNqUxqk5DNWDn7RNLjKnFVdKUdJtCrqfBLg@mail.gmail.com>
 <20161122131543.GA8370@macbook.local> <CANeU7QmSd5Zd_H2jDQyTjUMg7C4_6wQOyCR73R=FTdJ=f4+ygg@mail.gmail.com>
 <20161122201650.GA12172@macpro.local> <CANeU7QkABOFTdUCdabWL1YwHb3Qf4huVL115AHqZBNcqUytmhg@mail.gmail.com>
 <20161123204838.GA14875@macpro.local> <CANeU7Qm56E34mgRz0ntwQ74gmdmEgzd4jEPw6Uuw5UW8UFR85A@mail.gmail.com>
 <20161124013125.GA18072@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:33753 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbcKXDXp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Nov 2016 22:23:45 -0500
Received: by mail-io0-f193.google.com with SMTP id j92so3763144ioi.0
        for <linux-sparse@vger.kernel.org>; Wed, 23 Nov 2016 19:23:45 -0800 (PST)
In-Reply-To: <20161124013125.GA18072@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Linux-Sparse <linux-sparse@vger.kernel.org>, Nicolai Stange <nicstange@gmail.com>

On Thu, Nov 24, 2016 at 9:31 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Maybe another approach is possible:
> - note the fact that "stuff" (I intentionally don't want to use
>   "function") like __builtin_bswap*() behave like an operator
>   or a function in the mathematical sense: they only depend on
>   their args, have no side-effect, ... in others word they are "pure"
>   like in MOD_PURE.
> - because they're pure they necessarily return constant value if given
>   constant args. This may be used early, the value itself is only needed
>   in later phases.

I think that is exactly why __builtins_xxx exist. There is also pure
function and inline function etc. I guess I will still call it a function
rather than "stuff".

> It may also not be a bad idea to have a specific instructions for these
> (like a few others, I'm thinking to rotate), after all it's not without
> reasons that common CPU archs have these as real instructions
> (but this won't directly help our present problem).

If the function is expanded at compile time. It does not matter what
instruction it was used. It only matter when it need to emit as real
instruction in the back end. The black end still have the flexibility
to inline asm it.

Agree, it does not help our current problem though.

Chris
