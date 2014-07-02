From: Phil Carmody <phil@dovecot.fi>
Subject: Re: [PATCHv2 0/3] catch non-sign-extended '~' brainos
Date: Wed, 2 Jul 2014 10:43:29 +0300
Message-ID: <20140702074329.GD19158@phil.dovecot.net>
References: <1402315082-14102-1-git-send-email-phil@dovecot.fi>
 <1402386847-23477-1-git-send-email-phil@dovecot.fi>
 <20140627111900.GA19158@phil.dovecot.net>
 <CANeU7QkVj1gm3wQ6r1=akKX9W1cQvE3Un32CD=1UBecFCaq18Q@mail.gmail.com>
 <20140630085603.GB19158@phil.dovecot.net>
 <CANeU7Q=Z=Xac_T3JRAyqo_fF4LAKD-MM41NYz+nDstDutcVUfA@mail.gmail.com>
 <20140701113035.GC19158@phil.dovecot.net>
 <CANeU7QnQHzUHwP3imkcX2JX0NrR50rYjjXdObO1D03oHXQ82aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wursti.dovecot.fi ([87.106.245.223]:44385 "EHLO
	wursti.dovecot.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbaGBHmt (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 Jul 2014 03:42:49 -0400
Content-Disposition: inline
In-Reply-To: <CANeU7QnQHzUHwP3imkcX2JX0NrR50rYjjXdObO1D03oHXQ82aA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Jul 01, 2014 at 12:42:51PM -0700, Christopher Li wrote:
> On Tue, Jul 1, 2014 at 4:30 AM, Phil Carmody <phil@dovecot.fi> wrote:
> > With unsigned, it becomes a lot quieter, but still much noiser than my
> > original. (I have a v3 which excludes an idiom using '/'.)
> 
> Yes, because it cover more than just binary operations.
> If you consider zero extend the unsigned type introducing error,
> the binary operation just how you use the error bits.
> 
> >> #define NLMSG_ALIGNTO    4U
> >
> > I consider that, pedantically, to be worth fixing. alignments are defined
> > by the C standard to be of type size_t. It should either be ((size_t)4)
> 
> ((size_t)4) is hell ugly.

Do you care about the precise type of the value?
If you do, then it may be ugly, but it's pretty much obligatory.
And if you don't care about the precise type...

> > if you care about the precise type, or 4 if you don't, but not 4U. The
> > 'U' adds nothing apart from a way to create an incorrect mask.
> 
> That is debatable. Enforcing 4U vs 4 is annoying and buy you nothing
> most of the case.

What do you mean by "enforcing"? I consider persuading people to write
simpler, less breakable code to be a good thing.

> I don't consider alignment being 4U as wrong by itself. The key question
> is how you use it.

Absolutely. And doing a ~ and then an up-cast is using it dangerously.
Isn't that what sparse is supposed to be checking for?

> if we introduce:
> 
> #define ALIGNMASK(align)   (size_t)(~((align) -1))
> 
> And we always use the macro to create mask from alignment value.
> Then there is no need to enforce signedness of the var passed into the
> macro. Hey, it might even read better.

Put 4U in that, and it still has the flaw of creating a truncated mask.
Put 4 in and it doesn't.

Do you still want to defend 4U?

Phil

