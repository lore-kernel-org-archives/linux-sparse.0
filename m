From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 4/4] CSE: improve hashing of non-commutative binops
Date: Thu, 23 Feb 2017 15:13:14 +0100
Message-ID: <20170223141313.o2vdjzv5y3c4lo5f@macpro.local>
References: <20170216231231.5781-1-luc.vanoostenryck@gmail.com>
 <20170216231231.5781-5-luc.vanoostenryck@gmail.com>
 <CANeU7Q=2un=p62S5ToDt8djfhDLVtv=mgYoAcuOFGTQ9D_P+7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:34562 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751107AbdBWON4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 23 Feb 2017 09:13:56 -0500
Received: by mail-wr0-f182.google.com with SMTP id z61so22460846wrc.1
        for <linux-sparse@vger.kernel.org>; Thu, 23 Feb 2017 06:13:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=2un=p62S5ToDt8djfhDLVtv=mgYoAcuOFGTQ9D_P+7w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Feb 23, 2017 at 08:39:17PM +0800, Christopher Li wrote:
> On Fri, Feb 17, 2017 at 7:12 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > During CSE equivalent instructions should hash to the same value
> > but we should also try to *not* hash to the same value instructions
> > that cannot be equivalent.
> > For commutative ops this means that the hash function should itself
> > be commutative/symmetrical regarding the exchange of its operands.
> > This is already the case but the current hash function is symmetrical
> > for all binops, not only the commutative ones. Thus expressions like
> > 'a - b' and 'b - a' hash to the same value while it should be the case
> > only when 'a == b'.
> >
> > Fix this by changing the hashing of non-commutative binops so that it
> > is anti-symmetrical regarding the exchange of operands while keeping
> > commutative ones symmetrical.
> >
> > This change have no functional effects (in the sense that it shoudl
> > CSE exactly the same instructiosn as before), it should only improve
> > the efficiency of the hashing+comparing.
> >
> > Note: on the 5000+ test set I'm using, I can't see any significant
> >   speedup which is quite normal since most of the functions therein
> >   have (much) less instructions than the size of the hash table.
> >   The effect of this patch should only be on much bigger functions.
> 
> I apply and push this series to sparse-next.
I don't see them yet, but it's not important.

> Just curious if there is test case can show the performance increase.
I don't have such test case. To see any effect you would need a
function with a number of instructions quite large relatively to
the size of the hash table. It's even worse than that, it's the
number of pair of dual instructions (like 'a - b' / 'b - a') that
should be large (and to see a significant relative difference,
those pairs should also be a significant proportion of the total
numbers of instructions).

If needed I could try to build some artificial cases to determine
when a difference appears but ... (see below).

> As far as I can tell, this patch has down side as well, it hash the non
> commutative operation *twice*.
Sure it has some down fall but I it's not true that they are now
hashed twice. The number of operations is exactly the same as for
the commutative ones: each of src1 & src2 are 'hashed' together with
the opcode and the instruction size (and the hash() function is
essentially a no-op, not a costly thing anyway). The difference
between the two cases is that for commutative instructions src2
is first hashed and then there is a fall-through to the unary ops
to add src1's hash.
The down side is only a slight increase in code complexity.

> If for most of the case this actually
> is the higher cost we might want to keep the old behavior.
I can redo my tests and give the numbers but the measurements
I made didn't didn't showed any significant differences:
no speedup but also no slowdown.


That said, I completly agree that there is not much justification
to this patch. The only reason I made it was because when I modified
the code for the commutative case (which don't give a speedup but
eliminate more common expression) I took a look at the non-commutative
situation and said to myself something like: "Oh, they are hashed
symmetrically, like the commutative ones, that's not very logical".

So, I have absolutely no problems if this patch is dropped.
(much more interesting is the patch following this in the serie:
 "[RFC] CSE: relax type checking in hashing/compare").

Luc
