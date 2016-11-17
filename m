From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 3/3] By default disable '-Wunknown-attribute'
Date: Thu, 17 Nov 2016 19:04:19 +0100
Message-ID: <20161117180418.GB25228@macpro.local>
References: <20161102215939.36765-1-luc.vanoostenryck@gmail.com>
 <20161102215939.36765-4-luc.vanoostenryck@gmail.com>
 <CANeU7QnpsYS-YwSgqw8tiKO7FUFxjrRbKUoA8bb-gTsjK-YVvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33428 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932329AbcKQSEW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 13:04:22 -0500
Received: by mail-wm0-f65.google.com with SMTP id u144so23577957wmu.0
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 10:04:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QnpsYS-YwSgqw8tiKO7FUFxjrRbKUoA8bb-gTsjK-YVvA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Nov 18, 2016 at 12:52:37AM +0800, Christopher Li wrote:
> On Thu, Nov 3, 2016 at 5:59 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Generally, we won't be interested by the warnings from this flag,
> > but we can always explicitly ask for them if needed.
> 
> I don't want to disable it by default. I think default should be on so
> that we can collect test case and prepare to add them later one.
> 
> I would much rather see a patch to make those attribute parsed
> eventually. I think gcc or clang should have a collection of all
> the attribute stash some where. I haven't take a closer look myself.
> 
> Most of the attribute are trivial to parse correctly. We should have
> some thing like empty_int_attribute instead of blindly ignore them.
> 
> Also ideally the attribute should be a list instead of member in the
> ctype structure. Most of the symbol has at most one attribute any
> way. That is a much bigger change though.


I'm not surprised that you don't want to have it disabled by default.
But leaving it on would, in my opinion, miss the point entirely.
Why would sparses *users* be annoyed with warnings that doesn't
concern them? What kind of useful information it gives to them that
sparse doesn't know about this or this new attribute?
Even worse, what the difference for sparse between having this option
disabled by default and just adding yet another attribute to the lists
of known ones (even if it is not in the format of a list)?

I have taken a look at such gcc list before I wrote this serie.
There is a whole bunch of them for exotic uses on exotic architectures
and a more limited number fo them for more common use. But
don't forget that it's also not only the question of the existing
attributes but the fact that each gcc version (and maybe clang) may
add a few new ones and soon or later someone will use them.

Don't take me wrong, if it would make a visible semantic difference
I would be the first to say that such or such attribute need to be
handled correctly. And I think that patches doing the parsing of
some more attributes should be welcomed.
But given what sparse curently do and is used, leaving this option
enabled by default is, in my opinion, useless and just annoyance for
its users.

Also, I don't exagerate too much by saying that during the last 2 years
or so there has been almost as much patches for these new attributes
than anything else. It's a bit ridiculous.


Luc
