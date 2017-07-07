From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Fri, 7 Jul 2017 10:32:36 +0200
Message-ID: <20170707083235.ks2mdsrs2ogrlt7l@ltop.local>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-2-luc.vanoostenryck@gmail.com>
 <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
 <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com>
 <20170707060413.jmnflgn6kutugozb@ltop.local>
 <CANeU7QmHW5MHKmEBf4ULeVyyHp4zue+errEw2ZB+y1P3Q8uLRQ@mail.gmail.com>
 <20170707071124.7jl346vehsisv7bx@ltop.local>
 <CANeU7QnAyCaDFj5S5Nk0OxWpXSesnjiijQQDxpJBvfY8oVUVjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:36638 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752507AbdGGIcp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 04:32:45 -0400
Received: by mail-wr0-f177.google.com with SMTP id c11so36481935wrc.3
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 01:32:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QnAyCaDFj5S5Nk0OxWpXSesnjiijQQDxpJBvfY8oVUVjw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Jul 07, 2017 at 01:25:14AM -0700, Christopher Li wrote:
> On Fri, Jul 7, 2017 at 12:11 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >> And remove_usage() is deleting the very same list
> >> from with in the loop. That is the bug.
> >
> > Strange. kill_use_list() is only iterated via insn->phi_list
> > or insn->arguments, not p->user.
> >
> > But yes, something is surely messing with the lists here.
> >
> 
> I figure it out. It is a false alarm on the checking side.
> The condition I want to check can still cause a bug,
> but this report is not one of those conditions.
> 
> It is cause by this code:
> 
> static int dead_insn(struct instruction *insn, pseudo_t *src1,
> pseudo_t *src2, pseudo_t *src3)
> {
> struct pseudo_user *pu;
> FOR_EACH_PTR(insn->target->users, pu) {
> if (*pu->userp != VOID)
> return 0;
> } END_FOR_EACH_PTR(pu);
> 
> So the return terminate the execution flow before
> reaching to the  END_FOR_EACH_PTR(pu).
> The ptr->active still think we are in the loop
> But we are not.

OK, I see.
 
> It is a bug in the checking side. I still think this kind
> of checking is useful, but need some special handle
> of bail out of the ptr_list loop.

Yes, some kind of optional integrity checking or the kind of
checks you're doing here should be very usefull.

> Very sorry about that.

No problem, of course. 

-- Luc
