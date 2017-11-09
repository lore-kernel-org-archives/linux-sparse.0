From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 28/36] build: use a dot file name instead of local.mk:
 .sparse.mk
Date: Thu, 9 Nov 2017 21:48:03 +0100
Message-ID: <20171109204802.iezm2l5uhkfrxxys@ltop.local>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-28-luc.vanoostenryck@gmail.com>
 <57a86c63-05ff-fcfc-41c0-e0a7b1ccc0cf@kleine-koenig.org>
 <20171106154333.a5v6bji5u4gbuhn6@ltop.local>
 <120cc3cf-e27c-b5a3-0bb0-f56c2805608e@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:45875 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753851AbdKIUsH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 15:48:07 -0500
Received: by mail-wm0-f41.google.com with SMTP id y80so19733721wmd.0
        for <linux-sparse@vger.kernel.org>; Thu, 09 Nov 2017 12:48:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <120cc3cf-e27c-b5a3-0bb0-f56c2805608e@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc: linux-sparse@vger.kernel.org

On Thu, Nov 09, 2017 at 08:06:40PM +0100, Uwe Kleine-König wrote:
> Hello Luc,
> 
> On 11/06/2017 04:43 PM, Luc Van Oostenryck wrote:
> > On Mon, Nov 06, 2017 at 09:57:23AM +0100, Uwe Kleine-König wrote:
> >>> -local.mk
> >>> +.sparse.mk
> >>
> >> what is the motivation to hide this file? IMHO it is better to be aware
> >> of eventual changes to the build system and so don't hide the file.
> >>
> >> Having said that I question if it is a good idea at all to provide a way
> >> to change the build without dirtying the working copy.
> > 
> > I confess that this change is just for my own confort.
> > I often need to change change the CFLAGS while debugging or profiling.
> > I want that to be in a file, the file must of course not be under
> > version control and like .bashrc, kernel's .config or GCC's generated
> > .*.o.d files, I don't need to see this file and so I prefer it's an 
> > hidden one.
> >
> > I understand your worries but since it's a file purposely changed
> > so that files are compiled differently, there is no surprises.
> 
> <sarcasm>
> We could also add
> 
> 	#include ".sparse.c"
> 
> at the end of sparse.c (and touch this file in Makefile) in case you
> want to add a function there without dirtying the working copy. This
> could be used to overwrite weak functions for example.
> 
> Oh, and given that order in Makefile sometimes matter, we could add an
> sinclude sparse-pre.mk at the start of Makefile.
> </sarcasm>
> 
> IMHO these suggestions (that I hope you find absurd, too) are only
> little worse than your justification above.

:)

Yes, it's absurd.
I certainly don't want to hide .c files or .h, the Makefile also I don't
want to hide. These files contains the meat, the logic, they are the
objects on which developement are done, it make no sense to me to hide them.

It's very different for this file: I suppose for most dev, most of the time
we even don't need of this file but sometimes, for a specific purpose, for
a little while, we need some other flags. While this file is needed (for me,
it's 98% of the time for debugging and 2% of the time for profiling), I'll
make some commits, use 'git status' or 'git add -p' and such, so the strict
minima is that this file is ignored by the version control.

*Personally*, I also prefer that this file is not in the way in any possible
way, so yes, I prefer to not see it, I prefer even more that it's even not
in the tree.

For me, it's very very similar to all the .dot file we have in our home dirs
or simply the .git and .gitignore in the working tree.
Why are those files hidden? Will it be a good thing to make them visible?
I don't think so.

Others may have other preferences and other way of working, no problem,
I totally respect that and try to find the best for everyone.

> If I'd want to change CFLAGS, I'd do that directly in Makefile.

Doing it in the Makefile, is exactly the thing I don't want to do:
I want and I need to have my tree clean of this sort of things.

> git is
> powerful enough that this isn't in the way of committing and I
> personally like being remembered that I changed something. Of course
> this is subjective.

Yes, like this whole subject.

> > For dirtying the build ... yes, something could be done but really,
> > personnaly, I don't need this, I know when I need to clean my tree
> 
> famous words. How often did it happen to you that you thought you'd
> remember stuff when you need it and then only managed to do this after a
> 2 hour long debug session?

Honestly, it doesn't matter.
Even if I forget, what matters to me is "how much time will I waste?"
a few seconds, a few minutes or several hours of work?
In this case, it's a few seconds or at worst two minutes.

-- Luc
