From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] Adding ignored attribute optimize
Date: Sat, 1 Jul 2017 11:24:41 +0200
Message-ID: <20170701092440.egmgcexgwuuybzj7@ltop.local>
References: <CANeU7QnNNL1u3BxhWLebFqzn+9Y7hHKABDo_mkEqfwF+VO963Q@mail.gmail.com>
 <20170629070437.o6j2bkv6wdbcknwa@ltop.local>
 <CANeU7QnfvQ5KNFKvGGeJ1u7CDpd5wigosY0BrGNT1H0KouPHuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34349 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbdGAJYp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 1 Jul 2017 05:24:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id p204so11718714wmg.1
        for <linux-sparse@vger.kernel.org>; Sat, 01 Jul 2017 02:24:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QnfvQ5KNFKvGGeJ1u7CDpd5wigosY0BrGNT1H0KouPHuA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jun 29, 2017 at 02:46:09PM -0700, Christopher Li wrote:
> On Thu, Jun 29, 2017 at 12:04 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > There is also a long time 'require_context' in drivers/block/drbd,/
> > a failed attempt to fix or extend sparse's handling of lock context.
> > Why is it still there after all those years, I have no idea.
> 
> Yes, I notice that one too. But that one require to fix in the kernel side.
> Sparse does not support that kind of syntax.
> 
> >
> > Anyway, my position about these unknown attributes is still the same
> > of course: we should simply ignore them instead of annoying people
> > with useless warnings.
> 
> I have carefully consider your idea. It will have other unwanted behavior.
> That is why I did not apply your patch to change the default as no warning.
> 
> Let say some one typo the sparse specific attribute "__contxt__" instead
> of "__context__". Sparse will not give warning about those typo. The statement
> become an no-op. It will be very hard for developer to find out what
> is going on.
> In this case, we do want to give out warning on unknown sparse
> specific attributes.
> 
> Does it make sense?

Sure it make some sense.

But how often it happen and when it happen how much developers
are impacted and for how long?

Now compare that with the current situation with, for example,
this '__optimize__' or the '__alloc_align__' of last year, not
talking of the ones only used for less common architecture and
code other than Linux's kernel, where it happens all the time,
and when it happens it happens for *all* developpers who doesn't
even made any mistake, just wanting to check their code, and who
will receive this 'unknown attribute' warning, ad nauseum,
every time they want to check the code and this *until sparse
is updated to have this new attribute in its list* and worse,
for most people, *until their version of sparse in their distro
is updated*.

The last two points are higly critical in my eyes. It's one thing
to receive false-positive warnings (the attribute is only unknown
to sparse, it's a defect of sparse, not with the kernel or
the developer's code) just once or for a short while. And if sparse
could be updated within days and upgraded for everyone impacted,
then I would think exactly the same as you.  But as you know,
the situation is totally different.

Guess which version of sparse most distros are shipping?
sparse v0.5.0, of course, a three years old version.
Look at Debian, for example, they just released their new version
10 days ago, thus for the next two years or so, Debian users
(who don't use Sid or compile & install sparse themselves) will
still use sparse 0.5.0 with all its bad warnings.

In other words, this list of known attributes is totally
useless because it's never complete and always updated too
late for developers.

For me it's clear that we must here look after forward-compatibility.
And when we have, on one side, some rare legitimate warnings because
of a typo which will happen once for a single developer, and on the
other side, tons of false warnings which will confuse and annoy a
lot of devs for a very long time, I know which side must be choosen.

-- Luc
