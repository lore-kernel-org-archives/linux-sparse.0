From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 09/29] add helper to test if a variable is "simple"
Date: Fri, 18 Aug 2017 14:35:45 -0400
Message-ID: <CANeU7Qk5=4Cm7HVeCk402nz4p2HivossoMgM6XTxHrk41Dz2BA@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <20170816153455.97693-10-luc.vanoostenryck@gmail.com> <CANeU7QmU30Oafe5Peq6D5tnfBE+k=T+tttt3_vV0MeDGbbTZxQ@mail.gmail.com>
 <CACXZuxfQejAOR-JwSh+tYtjBgr3wYawVgEFNAXRU6c_QoTQKRA@mail.gmail.com>
 <CAExDi1SBiBWPO8RzfbxDbEnqaDTqO=EFX9HmjB+BjsaW75Ccbw@mail.gmail.com>
 <CACXZuxd4FLJ7h7jeyi_NL8eDseciidShLX7xWMmF84bOBLxmVg@mail.gmail.com>
 <CAExDi1TNbGgNkKqaPM0tgUof6m9hJVSR-XZaYbQO4QOPewFjzw@mail.gmail.com>
 <CACXZuxf0gQfdMqa6XLmcmnrzD9SzqefL5Aw9+AsuYqp8cC_HnQ@mail.gmail.com>
 <CANeU7QkGxD3g=kQkMHKNzagMA51moni0EHy_iazEDidQjEeZQg@mail.gmail.com> <CACXZuxd0aesRaQYqq8hzojxLQUfowZmdLT3c_8ZN2nUe6tbbzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:33823 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbdHRSfq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 14:35:46 -0400
Received: by mail-yw0-f176.google.com with SMTP id s143so63769049ywg.1
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 11:35:46 -0700 (PDT)
In-Reply-To: <CACXZuxd0aesRaQYqq8hzojxLQUfowZmdLT3c_8ZN2nUe6tbbzg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Aug 18, 2017 at 2:15 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> I have it setup so that if optimization is switched off I skip the CSE
> / Flow Simplification steps. In the older version the
> simplify_symbol_usage() was also being skipped but that is not used
> now. (Although the way I have merged this - I have the old code still
> there, and I can switch between the two implementations using a
> #define).
>
> As all my LLVM tests pass in this setup this is fine right now. I
> still get failures in some cases when the other subsequent stages are
> enabled - so there must be some incorrect simplifications occurring
> somewhere. I do not yet have specific tests to track down where the
> issues are.

At the point the SSA code is not merge yet. After we merger it.
report back if you found some issue using the llvm back end.

>
> As I mentioned before - ideally it would be good have a SSA step that
> is reusable. Then you could run this step several times during the
> process - and allow some simplification phases to generate non SSA
> code. Perhaps the new SSA approach can be adapted for this. This would
> also allow access to the first pass linearized output without
> promotion to pseudos.

As the way this ssa conversion is implement. I actually don't know
how hard it is to skip the promotion. I haven't look to that part of
the code yet. I image there will be a test if this variable has been
taking address or not. If so, it can't directly promote to pseudo without
the load/store. That would be one possible place to insert the option
to disable this. But again, let me look at the code first.

> But this should not stop us from moving forward with this change - as
> I think the SSA hooks into the linearization step are pretty specific
> and it should be relatively easy to have a mode where those steps are
> "dummied" - i.e. do nothing.
>
> I have a question though. For my other backend I need liveness
> analysis done even if I skip the other steps. Is it okay to run the
> liveness analysis phase while skipping the CSE / Flow simplification
> phases?

You can, but it is less effective. You will see a lot of load/store into the
memory. SSA make it easy to trace the define and usage chain.
Without that you can't really see well what is going on with the content
of the memory.

Chris
