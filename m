From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-next and preview of 0.5.1-rc5
Date: Wed, 26 Jul 2017 11:00:23 +0200
Message-ID: <20170726090022.2waraq4rgci2wuq2@ltop.local>
References: <CANeU7Qk-9RcNkWoEL5-0AKyd2Q30BvtjfivEG_KgD4kAH-aEdA@mail.gmail.com>
 <20170715182159.ltikqlbe6rktxfhz@ltop.local>
 <CANeU7Qkt4+QsgrrwUSwiiJ_V77gnJgb5YW0qSwwx1-uu9-GhLw@mail.gmail.com>
 <20170719221738.2gkctzmdjajz4uec@ltop.local>
 <CANeU7QkevpEdcp-WmM820sjJ4-LhVyPHeGHETh64WG3jPzewhA@mail.gmail.com>
 <20170720223554.54ohh7pfl7qm43dc@ltop.local>
 <CANeU7QkgF5N_Byw3j4G-dV1ZoWR6CW+y+UZa3MkrVcFNZmYz8Q@mail.gmail.com>
 <CANeU7QnovxzRQuhjyRHY==B2Vk5qU9Qk08rTDuvdwmARGci4Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:37509 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbdGZJA0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 26 Jul 2017 05:00:26 -0400
Received: by mail-wr0-f170.google.com with SMTP id 33so72212461wrz.4
        for <linux-sparse@vger.kernel.org>; Wed, 26 Jul 2017 02:00:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QnovxzRQuhjyRHY==B2Vk5qU9Qk08rTDuvdwmARGci4Og@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Jul 21, 2017 at 11:55:09PM -0400, Christopher Li wrote:
> Notice the "add.64      %r6 <- %r6, $4", that is very wrong.
> Not valid SSA form at all.

This is typical of situations where undefined pseudos are involved.
For example this is what Linus wrote on the subject some months ago:

	       and.32      %r3 <- %r4, $-65
	        or.32       %r4 <- %r3, $64
	
	which *initializes* the pseudo %r4 in the second instruction, but uses
	it in the first one. That's a classic pattern of uninitialized pseudos
	in sparse exactly because of the SSA logic.
	
	But it is all internally consistent, and the simplification is
	"correct". The simplification phase very much has a "garbage in,
	garbage out" model.

> I believe that is the one of the condition triggering the crazy programmer
> bug.

Of course, again this is explained in the original patch description.
The "crazy programmer" warning is all about this condition,
either in a single instruction or a chain producing such a cycle.

> It is just you pack the BB early so it does not
> trigger the "crazy programmer".

Yes, this is what was explained in the original patch description.

> I think your patch pack the BB early to avoid the "crazy programmer".
> That sounds more like a cover up rather than a proper fix up.

Like explained in the original patch description, this situation with
a self-defined pseudo can happen in unreachable code *even* if the
pseudo was in fact defined if:
- the definition was done in a loop header
- the loop header was deleted by insert_branch()
  * the definition is then removed, the pseudo become undefined
  * it shouldn't matter since all it's use is now in dead code
  * we don't know the that the loop is now dead code before
    kill_unreachable_bbs() is called.
  * therefore, kill_unreachable_bbs() must be called:
    - after a branch have been deleted
    - before simplify_one_memop() is called and is about to issue the
      "crazy programmer" warning 
      BECAUSE THE "crazy programmer" WARNING SHOULD NOT BE ISSUED
      IF THE CONCERNED CODE IS IN FACT DEAD CODE.

So, if you really prefer, you can call kill_unreachable_bbs() just before
the "crazy programmer" check instead of just after the branch delete
like it was done in my patch but calling kill_unreachable_bbs()
only after clean_up_insn() like done in your patch is wrong.

> If we have the proper SSA form, the "crazy programmer" shouldn't
> pop up at all.

See Linus explanation here above.


I found absolutely incredible the amount of time already wasted
on this issue and it is even not closed yet.
I feel really tired and totally disgusted by all this.

-- Luc

