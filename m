From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH RFC 07/13] evaluate: check static storage duration
 objects' intializers' constness
Date: Mon, 11 Jan 2016 19:02:05 +0100
Message-ID: <20160111180205.GD2972@macpro.local>
References: <871tfzkcgi.fsf@gmail.com>
 <20160109180450.GA2718@macpro.local>
 <8737u6wfpj.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35640 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757521AbcAKSCK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 11 Jan 2016 13:02:10 -0500
Received: by mail-wm0-f66.google.com with SMTP id f206so27402802wmf.2
        for <linux-sparse@vger.kernel.org>; Mon, 11 Jan 2016 10:02:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8737u6wfpj.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Sat, Jan 09, 2016 at 11:28:08PM +0100, Nicolai Stange wrote:
> Luc Van Oostenryck <luc.vanoostenryck@gmail.com> writes:
> 
> > On Thu, Jul 23, 2015 at 01:19:09AM +0200, Nicolai Stange wrote:
> >> Initializers of static storage duration objects shall be constant
> >> expressions [6.7.8(4)].
> >> 
> >> Warn if that requirement is not met.
> >> 
> >> Identify static storage duration objects by having either of
> >> MOD_TOPLEVEL or MOD_STATIC set.
> >> 
> >> Check an initializer's constness at the lowest possible subobject
> >> level, i.e. at the level of the "assignment-expression" production
> >> in [6.7.8].
> >> 
> >> For compound objects, make handle_list_initializer() pass the
> >> surrounding object's storage duration modifiers down to
> >> handle_simple_initializer() at subobject initializer evaluation.
> >
> >
> > This patch makes validation/{builtin_bswap,choose_expr}.c fail.
> > Of course, it's directly related to the purpose of the patch but
> > then the test should be adapted.
> >
> 
> Yes, you are absolutely right. However, as mentioned in this RFC series'
> cover letter, I decided to leave these two failers as is "for the moment".

It's fine then.
I just wanted to be sure that you was aware of it.

> Certainly this is anything but best practice and I can only
> apologize for sending you half (well 97%) baken patches -- and promise
> to never do it again...

Personally, I think that drafts are very fine.
They're the basis on which we, developers, can exchange ideas.
And your patches are far from drafts, they are already finely coocked.

But just to be sure to avoid any misunderstanding:
you know that I'm not the maintainer, just a reviewer. Right?


Yours,
Luc
