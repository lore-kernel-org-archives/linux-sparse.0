From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Fri, 7 Jul 2017 09:11:25 +0200
Message-ID: <20170707071124.7jl346vehsisv7bx@ltop.local>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-2-luc.vanoostenryck@gmail.com>
 <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
 <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com>
 <20170707060413.jmnflgn6kutugozb@ltop.local>
 <CANeU7QmHW5MHKmEBf4ULeVyyHp4zue+errEw2ZB+y1P3Q8uLRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:36333 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750974AbdGGHLa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 03:11:30 -0400
Received: by mail-wr0-f179.google.com with SMTP id c11so33591884wrc.3
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 00:11:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QmHW5MHKmEBf4ULeVyyHp4zue+errEw2ZB+y1P3Q8uLRQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Jul 06, 2017 at 11:18:39PM -0700, Christopher Li wrote:
> On Thu, Jul 6, 2017 at 11:04 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > On Thu, Jul 06, 2017 at 06:18:48PM -0700, Christopher Li wrote:
> >> On Thu, Jul 6, 2017 at 5:40 PM, Christopher Li <sparse@chrisli.org> wrote:
> >> Most noticablely remove_usage() inside of the  kill_use_list()
> >> loop.
> >
> > Can you explain a bit what's wrong with this one?
> 
> Sure. Sorry I haven't be more specific.
> The offending list in question is not the instruction list. It is the
> pesudo->user list.
> 
> kill_use_list is iterate though p->user.
> FOR_EACH_PTR(list, p) {
> if (p == VOID)
> continue;
> kill_use(THIS_ADDRESS(p));
> } END_FOR_EACH_PTR(p)
> 
> 
> And remove_usage() is deleting the very same list
> from with in the loop. That is the bug.

Strange. kill_use_list() is only iterated via insn->phi_list
or insn->arguments, not p->user.

But yes, something is surely messing with the lists here.

> It likely a different bug than the one you discover.
> Your crash is likely cause by pack_ptr_list inside the
> ptrlist loop. Which cause some pointer point to deleted
> node.

Yes, it's a different one.
Mine wasn't through pack_ptr_list() but directly in the macros
doing the list walking of ep->bbs.

Anyway, look at all this later.

-- Luc
