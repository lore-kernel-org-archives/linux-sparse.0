From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse problem with Linux kernel v5.5
Date: Fri, 7 Feb 2020 11:31:40 +0100
Message-ID: <20200207103140.mflxhk5jse6bvvzw@ltop.local>
References: <6ee65b69-9ffc-78c6-66b7-3ce586687d74@infradead.org>
 <CAHk-=wgQM29j0BJ-b0fTfwA9nc_fiS09Mi2oO8hX34oRxR6+xA@mail.gmail.com>
 <20200206114619.bfszxgs6jmdgroo6@ltop.local>
 <3b68ba4b-f16a-8404-4e07-27788ebbfce3@infradead.org>
 <20200206200610.7ktqp2yzriw7zurx@ltop.local>
 <CAHk-=whEFcgPW8oD=rGGyDiML_7AaCP0DGdW=WXjvF9zAv6Vrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56047 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgBGKbp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Feb 2020 05:31:45 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so1970132wmj.5
        for <linux-sparse@vger.kernel.org>; Fri, 07 Feb 2020 02:31:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAHk-=whEFcgPW8oD=rGGyDiML_7AaCP0DGdW=WXjvF9zAv6Vrg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, Arthur Fabre <afabre@cloudflare.com>

On Thu, Feb 06, 2020 at 03:47:21PM -0800, Linus Torvalds wrote:
> On Thu, Feb 6, 2020 at 12:06 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > However, I thought that the 5+seconds of runtime with 2.9Gb of memory
> > consumption I reported earlier was somehow excessive. So, I looked
> > at the preprocessed file and my editor (and several other tools) chocked
> > near the end ... It appears that one line is 2.8Mb on a total of 6.2MB
> > and contains 28968 times the expression for num_possible_cpus().
> 
> Whee..
> 
> > The origin of this is situted at line 647:
> >         smap->bucket_log = max_t(u32, 1, ilog2(roundup_pow_of_two(...));
> > because ilog2() is an 'interesting' macro which is already expanded
> > inside roundup_pow_of_two().
> 
> Yeah, so we have "const_ilog2()" expanding its argument 63 times (to
> handle the "just turn it into a constant" case), and so
> 
>    ilog2(roundup_pow_of_two(x))
> 
> where both ilog2() and roundup_pow_of_two() contains a const_ilog()
> ends up internally essentially expanding x 63*63 times. Plus a couple
> for the non-constant case.
> 
> And in this case 'x' wasn't all that simple to begin with on SMP.
> 
> And then the "max_t" thing adds another factor of 7 due to the whole
> "let's keep a constant expression constant" with all the careful "can
> I use a variable or not" code.
> 
> So you get 7*63*63 expansions of num_possible_cpus(), plus that "some
> slop" for the other cases.

Exactly.
 
> I wonder if we could just make sparse _warn_ about this kind of
> situation with expressions that are very big - even if they turn into
> nothing)?

I guess it wouldn't be hard to keep track of the nesting level of
expressions and issue a warning when some limit is reached.
Keeping track of the total size seems slightly more annoying to track
but seems feasible too.
 
> Because I bet it's not good for a real compiler either. Compile time
> does matter to people, and this clearly wasn't intentional.
> 
> And even if we apply a patch to avoid it here, that's fine, but others
> might be lurking.
> 
> Of course, sometimes you do want to have that kind of nested expansion
> on purpose - creating huge expression lists for some initializer or
> whatever. And sometimes the constant value is what you care about, and
> are willing to have complex expressions.
> 
> I don't think anybody intended for the expression to be quite _that_
> complex, though..

Yes, indeed.
Huge expression lists for initializers should not be a problem in itself,
it's only the nesting of such macros that is problematic.

> > This exists since the introduction of this file in commit
> >     6ac99e8f23d4 bpf: Introduce bpf sk local storage
> > but back then it made sparse consume only about 500Mb of memory on it.
> 
> Well, the fact that sparse memory use has exploded by a factor of 6 is
> not exactly good either. What happened?

The patch 85749218e3a6 ("bpf: Fix out of bounds memory access in bpf_sk_storage")
added the call to max_t().

> > but a better patch should, I think, directly use ilog2() and avoid the roundup.
> 
> No, I think it would be better to just split that expression up.

<snip>

> because honestly, that is just a whole lot more legible anyway. Maybe
> even split _that_ up, and have the max_t as a separate thing.
> 
> Right now the constant in the comment (2) doesn't match the constant
> in the code (1) because the code is too dense for its own good.
> 
> Of course, currently that "too dense for its own good" code ends up
> evaluating to a constant on UP. Which the easier-to-read code does
> not.
> 
> I'm not convinced that it makes sense to optimize for UP that much.

Yes, I agree.


I also think that const_ilog2() could advantageously use __builtin_clz():
Sparse, like gcc, expands it if its argument is constant.


-- Luc
