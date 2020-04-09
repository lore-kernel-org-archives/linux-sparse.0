From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Interesting (?) failure case
Date: Thu, 9 Apr 2020 21:34:21 +0200
Message-ID: <20200409193421.ibvzpbgdl2amk4dx@ltop.local>
References: <CAHk-=wg=Fs=EecQCNNzofn8+QXuB-sYy9m+YVPAmzDesmqFsbg@mail.gmail.com>
 <20200409062319.ykuewl7z3dc3a55n@ltop.local>
 <CAHk-=wgLxBez6hB1t5UQbhpFpwXpASe-+Nqz5_=_Qp1w-9hz9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f54.google.com ([209.85.128.54]:51844 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgDITe0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Apr 2020 15:34:26 -0400
Received: by mail-wm1-f54.google.com with SMTP id x4so1034476wmj.1
        for <linux-sparse@vger.kernel.org>; Thu, 09 Apr 2020 12:34:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHk-=wgLxBez6hB1t5UQbhpFpwXpASe-+Nqz5_=_Qp1w-9hz9g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Thu, Apr 09, 2020 at 09:51:28AM -0700, Linus Torvalds wrote:
> On Wed, Apr 8, 2020 at 11:23 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > Yes, the problem is caused at expand_conditional() where one of
> > the sides is throwed away if the condition is known. So the label
> > doesn't exist anymore and at linearization Sparse ends with a
> > jump to an unexisting BB.
> 
> Yes.
> 
> And I don't think that's really a problem per se. I think the gcc
> model of saying "you jumped to an invalid place, go away" is fine -
> particularly since this can only happen if you use a gcc extension to
> begin with.
> 
> So I don't think sparse is wrong, except for the total lack of any
> error messages.
> 
> > I tried to simply discard the early optimization in expand but
> > then when testing the kernel I got a whole bunch of warnings
> 
> I don't think we want to get rid of the early tree-level
> simplifications. They are sensible and help avoid unnecessary work
> later.

Yes, sure. I had hopped to be able to keep the advantages of the
value-expansion while keeping the original information but it
would need quite a bit changes and is certainly not worth this
"jump inside a (discarded) expression statement".
It's interesting, though, that a simple
	if (0) ...stuff... 
can't be discarded at expand time because of the gotos/labels.

> So I'd much rather just figure out some way to say "hmm, this goto is
> to something that was removed earlier, let's just say so".
> 
> > I tried also to warn on gotos jumping into an expression statement.
> > The idea was to give a new 'label_scope' for each such statement.
> > Things are a bit complicated because the labels are implicitly
> > declared by the gotos.
> 
> Yes. I think the gcc warning is nice, but I also think that it would
> be entirely sufficient to not notice at an early stage, but only when
> linearizing and hitting the "I'm branching to something that I can't
> generate code for", and report it at that point, instead of being
> clever and analyzing scopes up front.

Yes, that's certainly much easier and avoids the current garbage with
the IR and the diagnostic will, I think, still be informative enough.

-- Luc
