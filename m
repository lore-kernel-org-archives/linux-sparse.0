From: Phil Carmody <phil@dovecot.fi>
Subject: Re: [PATCHv2 0/3] catch non-sign-extended '~' brainos
Date: Wed, 2 Jul 2014 12:28:53 +0300
Message-ID: <20140702092853.GE19158@phil.dovecot.net>
References: <1402315082-14102-1-git-send-email-phil@dovecot.fi>
 <1402386847-23477-1-git-send-email-phil@dovecot.fi>
 <20140627111900.GA19158@phil.dovecot.net>
 <CANeU7QkVj1gm3wQ6r1=akKX9W1cQvE3Un32CD=1UBecFCaq18Q@mail.gmail.com>
 <20140630085603.GB19158@phil.dovecot.net>
 <CANeU7Q=Z=Xac_T3JRAyqo_fF4LAKD-MM41NYz+nDstDutcVUfA@mail.gmail.com>
 <20140701113035.GC19158@phil.dovecot.net>
 <CANeU7QnQHzUHwP3imkcX2JX0NrR50rYjjXdObO1D03oHXQ82aA@mail.gmail.com>
 <20140702074329.GD19158@phil.dovecot.net>
 <CANeU7Q=RV4xC8REQg_LP5VJz9-WB-+o6UEo5N2Fea9Y2WqdSnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wursti.dovecot.fi ([87.106.245.223]:46746 "EHLO
	wursti.dovecot.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbaGBJ2N (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 Jul 2014 05:28:13 -0400
Content-Disposition: inline
In-Reply-To: <CANeU7Q=RV4xC8REQg_LP5VJz9-WB-+o6UEo5N2Fea9Y2WqdSnA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Jul 02, 2014 at 01:51:25AM -0700, Christopher Li wrote:
> On Wed, Jul 2, 2014 at 12:43 AM, Phil Carmody <phil@dovecot.fi> wrote:
> >
> > Do you care about the precise type of the value?
> > If you do, then it may be ugly, but it's pretty much obligatory.
> > And if you don't care about the precise type...
> 
> Yes, I make a mistake on my macro. But alignment can be
> precise being unsigned. In a 32 bit system, what if I want to make
> a 2G align memory? Your signed alignment will force to be a
> negative value. Which is not precise.

You always have the option of an explicit size_t in that case.

> >> I don't consider alignment being 4U as wrong by itself. The key question
> >> is how you use it.
> >
> > Absolutely. And doing a ~ and then an up-cast is using it dangerously.
> > Isn't that what sparse is supposed to be checking for?
> 
> Well, you still need to get the false positive rate down. Currently then
> signal to noise ratio is too low. I would not recommend turning it on
> by default. Did you find some real bug in that 500 error report? Real
> bug I mean it produce actually bug on the object code it generated.

I'd like to say I found a real bug in an different open source package
with that check enabled. However, that's not true; I wrote that check
because I was perturbed that sparse hadn't found the bug which I'd just 
had to debug manually. So yes, it can catch real world issues.

It's much more likely to find issues in userspace programs, where there's
more likelyhood of wanting to allocate blocks of memory larger than 4G,
of course.

> >> if we introduce:
> >>
> >> #define ALIGNMASK(align)   (size_t)(~((align) -1))
> >>
> >> And we always use the macro to create mask from alignment value.
> >> Then there is no need to enforce signedness of the var passed into the
> >> macro. Hey, it might even read better.
> >
> > Put 4U in that, and it still has the flaw of creating a truncated mask.
> > Put 4 in and it doesn't.
> 
> Right, I make a mistake on that macro. Good catch.  How about
> 
> #define ALIGNMASK(align)   (~((size_t)((align) -1)))
> 
> Will you be happy if I use 4U with that macro?

Indeed. However, if the only use of the 4U is when it is expanded
into the expression (size_t)((4U) -1), then what was the 'U' again?
It still seems like a cargo cult artefact.

> My point is, with the right macro, you can still use 4U to create
> alignment. We don't have to fight over 4U vs 4.

Agreed. And how do you know if you've got the right macro?
It's on that question that I'd like sparse to step in and help.

Phil
