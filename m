From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Potential incorrect simplification
Date: Tue, 28 Mar 2017 11:02:32 -0700
Message-ID: <CA+55aFz6C5bEJqr72mBauWRUQiKYJ8eQpiXrKRW7JEiKXjZdrw@mail.gmail.com>
References: <CACXZuxeRXsYWgwihs1nmmTYaLoyhw+PDAy6jEemkZJFpySdfQA@mail.gmail.com>
 <CAExDi1TtcpZtnEV6ctyA9MacJA_9h4njmhd-MSA3KgOq8oK_gA@mail.gmail.com>
 <CACXZuxfxNNh+ThcT=7Xr98tToL2GimFi7UOTSwgNq6mfLLGNfA@mail.gmail.com>
 <20170328141113.kbrwdva6ttsrokts@macpro.local> <CACXZuxen9UFGNp8=-OQHoqRQJ5F__rwQoCJJ6TdkAo6HEXWOQw@mail.gmail.com>
 <CA+55aFx6g3-+6tJ_6Uqu4K1pQoDnqcXrjSGYsryLjjksEtT06A@mail.gmail.com> <20170328170049.2y6lwxx64yzjjwmc@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:36197 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753955AbdC1SCy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Mar 2017 14:02:54 -0400
Received: by mail-it0-f48.google.com with SMTP id e75so64870715itd.1
        for <linux-sparse@vger.kernel.org>; Tue, 28 Mar 2017 11:02:53 -0700 (PDT)
In-Reply-To: <20170328170049.2y6lwxx64yzjjwmc@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 28, 2017 at 10:00 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> I agree, of course, but I think there is a problem anyway.

Yes. I just wanted to point out that it's not the simplification phase
that is the problem, and that sparse is technically correct (for some
definition of "technically" ;)

> The problem here with this %r4 is created by the single-store
> shortcut which replace all loads with the same value as the one
> used for the unique store (even loads that are not dominated
> by the store). Fair enough, don't use uninitialized vars.

Yeah.

Personally, I absolutely detest a lot of the undefined C corner cases.
I'm a huge fan of the language, but almost all of the the "undefined
behavior" in C is a huge mistake.

Pretty much every "undefined behavior" in the standard should have
been "implementation defined", or at least have the option to be so.
For example, it would have been much nicer if all variables were
implicitly initialized to zero, not just static variables. In 99% of
all cases the compiler won't even care, since it will see the actual
real initialization anyway, and the "initialize automatic variables to
zero" wouldn't matter - except from a repeatability, security and
simplicity standpoint.

Obviously, that particular choice made more sense in legacy C (when
optimizations weren't nearly as smart as what people take for granted
today, and CPU cycles were more expensive).

> Now, if you remove this single-store shortcut and just let the normal
> find_dominating_stores() do its job, the resulting code become
> the expected:
>         ret.32      $0
>
> Not just by coincidence (I checked the intermediate steps):
> sparse deduces then correctly that the value in the conditional
> is always true and everything become dead after that.

Nice.

> But what annoys me really is that:
> -) once you remove the single-store shortcut, it seems there is
>    other problems (I just saw it by doing some code comparison,
>    I need to create a few clear examples).

The single-store shortcut is actually pretty important, because it is
what turns a *lot* of local variables from stack memory things into
pseudos. That's partly because the sparse optimizations aren't all
that smart.

Sparse code gen sometimes looks really good, but it's really largely
due to SSA really being a wonderful model. It makes some "complex"
optimizations magically trivial.  But outside of those things, sparse
really is pretty damn stupid.

I actually would whole-heartedly support a "all local variables are
initialized to zero" mode, which would get rid of a lot of these
undefined cases.

But it would also be good to just warn about it - the problem is that
sparse doesn't even necessarily *understand* when it generates garbage
from garbage input, because the transformations are so mindless, and
the SSA code works without ever understanding the notion of truly
"dominating" operations.

                   Linus
