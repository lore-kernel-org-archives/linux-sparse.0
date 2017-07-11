From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] V2 move kill_unreachable_bbs to outer cse stage Was Re:
 [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Tue, 11 Jul 2017 11:26:26 +0200
Message-ID: <20170711092625.ux6xonjiqxhotczf@ltop.local>
References: <CANeU7QkCcx1d29megDn9bQ0g7rw04=ujsWCe_bN1Kc1NW_-NZw@mail.gmail.com>
 <20170709165157.w6jnjkwca7dwxj64@ltop.local>
 <CANeU7Qms0KKSWU0dyHomz1iEczdiYn_7SwsJZmPCSXDhsag0Tw@mail.gmail.com>
 <20170710070520.fzr3wqgaugkfocfo@ltop.local>
 <CANeU7QnoP5g2kww5Up1gW7ucWB2H7xuGdzQ-0bTei4cWxjAz=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:36534 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754141AbdGKJ01 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 11 Jul 2017 05:26:27 -0400
Received: by mail-wr0-f170.google.com with SMTP id c11so174877660wrc.3
        for <linux-sparse@vger.kernel.org>; Tue, 11 Jul 2017 02:26:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QnoP5g2kww5Up1gW7ucWB2H7xuGdzQ-0bTei4cWxjAz=w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Jul 10, 2017 at 06:21:22AM -0700, Christopher Li wrote:
> On Mon, Jul 10, 2017 at 12:05 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >> > It would also be nice to know why the patch that came with the bug
> >> > report have been discarded without a single comment.
> >>
> >> Sorry I haven't been more specific. I think the original patch is a bit
> >> too complicated. Also just as I suspected, there is more than the bb
> >> list get affected. If possible, I think we should try to avoid get into nested
> >> loop delete in the first place rather than make the nested loop delete
> >> work.
> >
> > I can hardly qualify my patch as 'complicated' but well ...
> > This patch have been done with two goals in mind:
> > 1) solve the problem with the deleted BB
> > 2) do not change anything at the simplification since interaction
> >    between differents parts there can have bad effects (it's to fix
> >    a problem there that the kill_unreachable_bbs() had been added).
> >
> > Your patch, take care of point 1) but not 2) and effectively
> > change when the BBs are removed and this change the interaction
> > between insert_branch() and some others parts.
> 
> You are right. I will never consider 2) as my goal. Simply because
> if the compiler has to depend on certain order of optimization (delete
> dead BB vs memops, CSE) and it can't figure out the order by itself.
> Then I consider a bug in the compiler.

You may qualify this as a bug but in the real world it's totally
normal to have interactions between optimization passes (yes, this
means that the result will depend on the order of the passes).
This is especially true when it concern dead code elimination.

Any decent compiler book will tell you a bit more about this.

But well, you're the maintainer, it's your responsability to
make the good choices for the project.

-- Luc Van Oostenryck 
