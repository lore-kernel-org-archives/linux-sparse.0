From: Pavel Roskin <proski@gnu.org>
Subject: Re: [RFC PATCH] Fix crash in linearize_compound_statement()
Date: Tue, 08 Apr 2008 01:14:17 -0400
Message-ID: <1207631657.3209.13.camel@rd>
References: <1207601111.22430.28.camel@dv>
	 <70318cbf0804071455g2f15e136qab225063f7faa89f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:34065 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092AbYDHFOV (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 8 Apr 2008 01:14:21 -0400
In-Reply-To: <70318cbf0804071455g2f15e136qab225063f7faa89f@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Mon, 2008-04-07 at 14:55 -0700, Christopher Li wrote:
> On Mon, Apr 7, 2008 at 1:45 PM, Pavel Roskin <proski@gnu.org> wrote:
> >  static int x;
> >  static inline void foo(void)
> >  {
> >     if (x)
> >         x = 1;
> >  }
> >  static void bar(void)
> >  {
> >     foo();
> >  }
> >  static typeof(bar) quux;
> >
> >
> >  The crash happens in linearize_compound_statement(), and I believe that
> >  the reason is incorrect access to phi_node->phi_list without making sure
> >  that phi_node->opcode is OP_PHI.  When processing the above program,
> >  phi_node->phi_list can be OP_INLINED_CALL.
> 
> No, that is not the root cause. The root cause is you feed sparse with
> bad input. typeof(bar) will give you a type of a function. Sparse just let
> quux have the base type of bar function body. That is just so wrong.

I know.  And the source that was doing it is fixed long ago.

> >  I understand very little in sparse code, and I have no idea what kind of
> >  fallback is needed when phi_node->opcode is not OP_PHI.
> >
> >  But this patch fixes the crash:
> 
> As I said before, this is not the right fix. Wish it not get applied.

I should have been more clear.  Last time I was carried away by some
strange messages about "return" and labels, which seemed really weird to
me, but less so after your explanation.

This example is made from the same original source, but this time I
concentrated on the crash, because that's the thing that cannot be
justified by any bad code.

> I agree sparse should not assert on it, but not like this.

I don't quite understand why sparse is getting in this situation, but
I'm quite confident from seeing other code that phi_node->phi_list is
invalid if phi_node->opcode is not OP_PHI, and should not be accessed.
I'd rather see sparse tripping an assert and crashing before it happens
rather than see it interpreting some other data as phi_list and crashing
randomly while iterating over that bogus list.

> You should at least fix it from the typeof(bar) side, instead of try
> to linearize
> the same function twice.

That's fixed, of course.  And many other problems are fixed too, some of
which are user visible.  I really appreciate the usefulness of sparse.

All I'm trying to do now is to have that crash fixed, after which I
would be glad to forget the ugly code that caused it.

-- 
Regards,
Pavel Roskin
