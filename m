From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/2] be more generous with ptrlist repacking
Date: Mon, 28 Nov 2016 22:15:15 +0100
Message-ID: <20161128211514.GA1077@macbook.local>
References: <20161117172559.29417-1-luc.vanoostenryck@gmail.com>
 <CA+55aFwYGCD-+GhVLdHedu42cu1RyT+Ko9Dj6-pfTrPv0ZD5Jg@mail.gmail.com>
 <20161117202523.GA35194@macpro.local>
 <CA+55aFwsQYAFO+hbSi3pxvkjVA6Jv=DpeZrVHyzj9-RmAuF=tQ@mail.gmail.com>
 <20161118002918.GA35373@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34652 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754515AbcK1VPT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 28 Nov 2016 16:15:19 -0500
Received: by mail-wm0-f68.google.com with SMTP id g23so21228292wme.1
        for <linux-sparse@vger.kernel.org>; Mon, 28 Nov 2016 13:15:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161118002918.GA35373@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Dan Carpenter <dan.carpenter@oracle.com>

On Fri, Nov 18, 2016 at 01:29:19AM +0100, Luc Van Oostenryck wrote:
> On Thu, Nov 17, 2016 at 02:03:05PM -0800, Linus Torvalds wrote:
> > On Thu, Nov 17, 2016 at 12:25 PM, Luc Van Oostenryck
> > <luc.vanoostenryck@gmail.com> wrote:
> > >
> > > Would something like the following be fine?
> > 
> > This looks good to me, although I didn't actually test it.  But it
> > looks like what I would have expected.
> > 
> > Some of those inlines look large enough that I wonder how much sense
> > they make as inlines any more, but I think that's a separate issue.
> 
> Oh, I absolutely agree.
> What I would like is something more iterator oriented which keep track
> of the head-list-nr state. I have a working prototype I made last week
> but it still needs some more polishing.
> 

I've worked a bit more on this. I had a nice, clean & compact
implementation where basically all ptr_list walking was done by
something like:
	struct ptr_iter iter;
	ptr_iter_init(&iter, head);
	while ((ptr = ptr_iter_next(&iter)))
		...

Of course, still hidden under the macros which do the type checking.
This had the advantage that all the logic was in a single place.
It seemed to work well that is until I discovered that at a few places we're
storing null pointers in ptr_lists. It's thus not possible to use the
returned pointer to also check the end of list condition. The situation
is even a bit more complex because the PREPARE/NEXT_PTR_LIST() also
can't work with null pointers.

I've found a few alternative that work in all the cases but they aren't
simple & compact enough to my taste so I'll let things like they are
and maybe just sent a few cleanups later.

Luc
