From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC,PATCH 4/4] add support for LLP64 arch
Date: Wed, 8 Feb 2017 23:01:32 +0100
Message-ID: <20170208220131.dt6zlo43d7yy6f6d@macpro.local>
References: <20170207200425.34189-1-luc.vanoostenryck@gmail.com>
 <20170207200425.34189-5-luc.vanoostenryck@gmail.com>
 <CANeU7QkYmA1opeNQTYjOUXs8hSn1oG3RumVtR094rb4w8KucEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34525 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751815AbdBHW2t (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Feb 2017 17:28:49 -0500
Received: by mail-wm0-f67.google.com with SMTP id c85so370260wmi.1
        for <linux-sparse@vger.kernel.org>; Wed, 08 Feb 2017 14:28:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QkYmA1opeNQTYjOUXs8hSn1oG3RumVtR094rb4w8KucEQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Thu, Feb 09, 2017 at 05:24:01AM +0800, Christopher Li wrote:
> The patch as already apply in sparse-next.
> 
> On Wed, Feb 8, 2017 at 4:04 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > There was recently on the mailing list some questions
> > and a need to support LLP64 model.
> >
> > This patch add is by adjusting a few size-related variables
> > under the control of a new flag: -msize-llp64 (ugly name
> > but we already have we have '-msize-long').
> 
> I am wondering how does gcc windows handle such situation.
> 
> Should we some flag some arch thing like "mingw64" which
> turn on the LLP64 mode. If gcc has such a flag for cross compile
> mingw, we should borrow that instead.

Well, I suppose GCC is configured for MinGW at build time (and
I understood that cygwin on x86-64 is LP64).
Anyway, I don't any kind of option in GCC that would correspond
to this.

I propose to leave it as such or to simply drop this patch as
I'm planning to change somewhat this part anyway (essentially
because 99% of the time I'm doing cross-compile development
and the current situation doesn't suit me at all. And when
hacking on sparse, I'm much much more interested in the output
of test-linearize than sparse in itself, so cgcc is useless
for me. This serie is just the minimal to make my live easier and
this LLP64 is just something closely related someone had a need for).

> ]> +               if (arch_m64 == ARCH_LP64) {
> > +                       bits_in_long = 64;
> > +                       max_int_alignment = 8;
> > +                       size_t_ctype = &ulong_ctype;
> > +                       ssize_t_ctype = &long_ctype;
> > +                       add_pre_buffer("#weak_define __LP64__ 1\n");
> > +                       add_pre_buffer("#weak_define _LP64 1\n");
> > +               } else {
> 
> It works as it is. But we might want to test against arch_m64==ARCH_LLP64
> just to make the code section clear what it was for.
> 
> Again, ff there is a new version of patch. I will replace this one in
> sparse-next.
> 
> Chris

Yes, it was what I wanted to do first but then I realised it will hardly
be a third choice and so I did it this way.
A new version is coming.

Luc
