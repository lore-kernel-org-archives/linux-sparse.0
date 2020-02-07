From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH bpf] bpf: Improve bucket_log calculation logic
Date: Fri, 7 Feb 2020 21:41:44 +0100
Message-ID: <20200207204144.hh4n4o643oqpcwed@ltop.local>
References: <20200207081810.3918919-1-kafai@fb.com>
 <CAHk-=wieADOQcYkehVN7meevnd3jZrq06NkmyH9GGR==2rEpuQ@mail.gmail.com>
 <CAHk-=wjbhawNieeiEig4LnPVRTRPgY8xag7NuAKuM9NKXCTLeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43235 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgBGUlt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Feb 2020 15:41:49 -0500
Content-Disposition: inline
In-Reply-To: <CAHk-=wjbhawNieeiEig4LnPVRTRPgY8xag7NuAKuM9NKXCTLeQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, David Miller <davem@davemloft.net>, kernel-team@fb.com, Linux-Sparse <linux-sparse@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>

On Fri, Feb 07, 2020 at 11:39:24AM -0800, Linus Torvalds wrote:
> On Fri, Feb 7, 2020 at 10:07 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I do think this is a good test-case for sparse. Luc, have you looked
> > at what it is that then makes sparse use *so* much memory for this one
> > line?
> 
> Looking at the profile, it's doing a lot of "copy_expression()".
> 
> Which comes from inlining.
> 
> I think the problem may be that with that macro expansion from hell we
> end up with 28968 copies of cpumask_weight(), and sparse will inline
> every one of them into the parse tree - even though basically none of
> them are _used_.

Yes, indeed. I was just what I saw too.

> In fact, it's worse than that: we end up having a few rounds of
> inlining thanks to

<snip> 

> So we may have "only" 28968 calls to cpumask_weight(), but it results
> in millions of expressions being expanded.

Yes, roughly 1500 expressions per call (:
 
> If we did some basic simplification of constant ops before inlining,
> that would likely help a lot.
> 
> But currently sparse does inline function expansion at type evaluation
> time - so long before it does any simplification of the tree at all.
> 
> So that explains why sparse happens to react _so_ badly to this thing.
> A real compiler would do inlining much later.
> 
> Inlining that early is partly because originally one of the design
> ideas in sparse was to make inline functions act basically as
> templates, so they'd react to the types of the context. But it really
> bites us in the ass here.
> 
> Luc, any ideas? Yes, this is solvable in the kernel, but it does show
> that sparse simply does a _lot_ of unnecessary work.

I never saw it so badly but it's not the first time I've bitten by
the very early inlining. Independently of this, it would be handy to
have an inliner at IR level, it shouldn't be very difficult but ...
OTOH, it should really be straightforward would be to separate the
current tree inliner from the type evaluation and instead run it just
after expansion. The downsides would be:
  * the tree would need to be walked once more;
  * this may make the expansion less useful but it could be run again
    after the inlining.

[ If we would like to keep inline-as-template it would just need to be
  able to detect such inlines at type evaluation and only inline those. ]

I'll look more closely at all of it during the WE.

-- Luc
