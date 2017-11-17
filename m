From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [GIT PULL] llvm fixes
Date: Fri, 17 Nov 2017 20:50:06 +0100
Message-ID: <20171117195004.s472oqlldfrgiz2t@ltop.local>
References: <20170918095135.12066-1-luc.vanoostenryck@gmail.com>
 <20171117095147.a4v4alrcr77rafut@ltop.local>
 <CANeU7QnTtcKP9ukNqGmMzfVMviYwYEfYFhgLRHHGxCqR7sPGEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:45008 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756258AbdKQTuJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 17 Nov 2017 14:50:09 -0500
Received: by mail-wm0-f51.google.com with SMTP id r68so8621164wmr.3
        for <linux-sparse@vger.kernel.org>; Fri, 17 Nov 2017 11:50:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QnTtcKP9ukNqGmMzfVMviYwYEfYFhgLRHHGxCqR7sPGEQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Fri, Nov 17, 2017 at 06:24:09PM +0800, Christopher Li wrote:
> On Fri, Nov 17, 2017 at 5:51 PM, Luc Van Oostenryck wrote:
> > FWIW, I've now pushed this to my dev tree at:
> >         git://github.com/lucvoo/sparse.git master
> >
> > with the two patches related to OP_PUSH removed and
> > replaced by something with minimal impact and directly
> > storing the type of the arguments into the OP_CALL
> > instructions.
> 
> Isn't type of arguments can be get from the call function prototype?
> 
> So those kind of the information is duplicated most of the time.
> The only useful place is variable arguments that the argument is
> from the variable part and the argument is constant value.

Yes, this has been pretty clear since the beginning:
- Currently, nowhere in the "normal" sparse code is the type or
  the size of a constant something we care about.
- The only place it is needed is:
  - for sparse-llvm and then only for variadic arguments
    (where there is nothing in the prototype about these type).
- Other backends will, obviously, need the same information.

Also, but maybe less obvious:
- Till now, no pseudo has any kind of typing *directly* attached
  to it. In fact, the pseudos are typeless (all of them) and the
  code is designed around this. The types are given by the usage
  or other secondary information.
- Here under, by 'type', you often need to understand
  'some type system', either:
  - the full typing represented by 'struct symbol' 
  - a subset of the this full type, like 'size + integer/float'
  
> I did try to remove the OP_PUSH and the associate type from
> your git series. Removing the OP_PUSH is not too bad. But undoing
> the associate type is a major hassle.
> 
> Do you see any problem using the pseudo value with size patch?
> Now it has the second patch to work with llvm as well. Should be testable.

I already said in June-August that I tried this approach and that
it didn't work (well, I'm sure that it is possible to make it work,
it's just more complex that it seems).

I'm sure it's testable (but what does that mean exactly?).
I'm convinced it passes the testsuite and kernel check.
But given that, as stated here above, nowhere in the code
this information is needed, it's pretty normal that the
changes have zero effect there. OTOH, these changes have
impact on a few things related to the level below, thus
*it is needed* to test things at IR level.

Now, I have no hard problem with the PSEUDO_VAL.size
approach from a theorical point of view (even if I would
prefer the mathematical PoV that 0 is 0, 1 is 1, etc.).
I even think that *eventually* it may very well be
the right solution (probably the whole typing at IR
level need to be revisited).

On a practical level, things are differents:
- The introduction of PSEUDO_VAL.size create
  a segragation between pseudos of the same value
  but different uses (different sizes).
  This has impact on the CSE.
  Admittingly, there shouldn't be any impact and it's
  maybe a sign that something is wrong elsewhere.
- There are places in the code where kinds of implicit
  castings are done (the OP_SET_* instructions are
  especially concerned). Some may consider this as a
  bug, to me it's at least a problem.
  To solve the problems there you need to:
  1) identify all places where such is done
  2) look if the pseudo is a constant
  3) if it is a constant, look at its type/size
  4) make the needed adjustment.
- On another level, even if your patch is quite small
  and simple, it's still relatively invasive and is
  guaranted to create bad conflicts in numerous pending patches.

Now, aren't these not solvable?
I'm sure they are solvable. The problems are the price/work
and the moment. Of course, the price and moment mostly
concerns the person who will make the work.

For my part, I consider that there are others things
immensely more important than trying to solve this now,
like, for example, fixing the SSA conversion.

-- Luc Van Oostenryck
