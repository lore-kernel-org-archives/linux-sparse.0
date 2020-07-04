From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 2/3] add memory asm constraint for PPC
Date: Sun, 5 Jul 2020 00:44:39 +0200
Message-ID: <20200704224439.h2lwfccvsdgwhkbw@ltop.local>
References: <20200704135747.87752-1-luc.vanoostenryck@gmail.com>
 <20200704135747.87752-3-luc.vanoostenryck@gmail.com>
 <693a3fa0-5202-3695-54cf-aa1cc1f514fd@ramsayjones.plus.com>
 <20200704193248.simtaedrt7gbiepy@ltop.local>
 <900dd2ad-9037-cefb-6a22-27cd0b971716@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgGDWon (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 4 Jul 2020 18:44:43 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07388C061794
        for <linux-sparse@vger.kernel.org>; Sat,  4 Jul 2020 15:44:43 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id e15so31230189edr.2
        for <linux-sparse@vger.kernel.org>; Sat, 04 Jul 2020 15:44:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <900dd2ad-9037-cefb-6a22-27cd0b971716@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: linux-sparse@vger.kernel.org

On Sat, Jul 04, 2020 at 10:07:15PM +0100, Ramsay Jones wrote:
> 
> 
> On 04/07/2020 20:32, Luc Van Oostenryck wrote:
> > On Sat, Jul 04, 2020 at 06:44:53PM +0100, Ramsay Jones wrote:
> 
> >> On 04/07/2020 14:57, Luc Van Oostenryck wrote:
> >>> The 'Z' asm constraint is used for doing IO accessors on PPC but
> >>> isn't part of the 'common constraints'. It's responsible for
> >>> more than half of all warnings (with defconfig + allyesconfig).
> >>
> >> Not a problem, but this made me think 'half of which warnings'. :-D
> >> I assume, but it's just a guess, this means 'half of all asm-constraints
> >> warnings on the kernel PPC build'.
> >>
> >> How many warnings is that? What percentage is that of _all_ sparse
> >> warnings on a typical kernel build?
> > 
> > It's literally more than half of all warnings issued by sparse when doing
> > a build of the kernel with 'defconfig' and another one with 'allyesconfig'
> > (all my tests on kernel builds are done like so) on a ppc64 machine:
> > 	$ grep ': \(error\|warning\):' log-master-master | wc -l
> > 	138581
> > 	$ grep ': \(error\|warning\):' log-arch-asm-mem | wc -l
> > 	50006
> > So, this series eliminates about 64% of all warnings, a nice
> > improvement of the S/N ratio.
> 
> Oh, nice!
> 
> It's a _long_ time since I last built the kernel (about when reading
> Greg's 'Linux Kernel in a Nutshell' book, so about 2006), and I don't
> even recall if I ran sparse over it. (Hmm, did you have to specify
> a C parameter to make or something?).

Yes, the simplest is to use 'make C=2'.

> Anyway, that is still a very large number of error/warnings - has it
> always been that bad?

Well, I like to think that it has improved considerably the last years.
But yes, it's still very much. The problem is not very simple and has,
I think, multiple causes, like (in random order):
  * not all developers use sparse
    * some don't really know about it
    * some don't want to use it anymore
  * support for architectures other than i386/x86_64 was very weak
  * sparse used to (and still) issue a lot of false negatives
  * documentation for sparse is very ... sparse
  * sparse's warnings are not always easy to understand
  * developers doesn't always seem to know/understand well the
    kind of checks sparse is doing, what's it is possible, what it is
    capable (I'm thinking of the address spaces, the context/locking
    and bitwise).
  * it's not always obvious what is the value of sparse warnings
  * it's not always obvious what is the value of fixing sparse warnings
  * fixing sparse warnings in the kernel is not very gratifying
  * devs are usually paid (and like) to add features, not to touch to
    code that seems to work.
  * very strict typing, like created with __bitwise, sometimes requires
    a lot of interfaces variant (one for each type/arguments/return value)
    otherwise functionally identical and C has essentially no support
    for generic programming (everything must be done with macros & typeof).
  * for several reasons, it can very quickly become very frustrating
    to make (series of) patches that fix sparse warnings in the kernel.
   
OTOH, on x86, the vast majority of warnings I see are totally valid ones.
By far, the most common ones are those involving __bitwise, then missing
static, then problems with address space (especially with __rcu), then
with contexts. The remaining ones are drops of water in the ocean.

Also, the kernel has about 30 millions lines of code, thousands of devs,
hundreds of new devs every releases, ... So, maybe it's not so bad.

Finally, CI/bot testing/building has progressed a lot lately and have
a very positive effect on sparse warnings (it can also be quite
frustrating because every day you see automatic reports, take a
quick look, think "oh, it shouldn't be hard to fix it" but then it's
"oh, well ..." because you have absolutely not the bandwidth for it).

> Yep, I know what you mean. However, I don't think you should shy
> away from clean-ups for too long - it will be counter-productive
> in the end.

Yes. I generally do this on a kind of "on demand basis". When I need
to touch some code and it's too hard to change or follow, I first
reorganize or simplify it. Sometimes it's really needed, sometimes
it's only a kind of nice side-effect, like here (I have 3 incoming
series on top of it).

-- Luc
