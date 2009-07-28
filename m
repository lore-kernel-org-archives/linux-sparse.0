From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Detect unused header files?
Date: Tue, 28 Jul 2009 22:58:08 +0200
Message-ID: <20090728205808.GA20955@merkur.ravnborg.org>
References: <20090728181803.GA20845@merkur.ravnborg.org> <70318cbf0907281336p47b68b5cg44a3e7206646cb80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from pfepb.post.tele.dk ([195.41.46.236]:45740 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244AbZG1U6I (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 28 Jul 2009 16:58:08 -0400
Content-Disposition: inline
In-Reply-To: <70318cbf0907281336p47b68b5cg44a3e7206646cb80@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: sparse <linux-sparse@vger.kernel.org>

On Tue, Jul 28, 2009 at 01:36:26PM -0700, Christopher Li wrote:
> On Tue, Jul 28, 2009 at 11:18 AM, Sam Ravnborg<sam@ravnborg.org> wrote:
> > In the kernel we would like to avoid all
> > unused include files.
> > Especially in the headers we export to userspace.
> >
> > Are there any easy way we can use sparse to detect
> > that a specific header file is not used?
> 
> I don't know a way to do that with current sparse.
> We can implement some code for this.

Would be great...
If you can give some general into I can maybe give
it a shot albeit I have only very limited sprase
hacking knowledge.

> 
> We need to have a good definition of what is used.

The short version...
The header file that include the file is dependent
on the included file.

So if we:
- use (check/test/reference) a macro from the file => used
- use a typedef/struct
- ...
then we need the included header file.

> 
> > The header files I have in mind will be fully self-contained
> > as they all include the header files they need to be used.
> 
> But a lot of case we have the header file is used in *another*
> file.
We do not care about this case...

The objective is to get the exported kernel headers as lean as possible.
This may occasionally break userland - but until now this has
been manageable.


If we apply this to kernel internal headers then we need to
do a bit of test builds to check things.
This is the same thing we do when we untange the include mess we have
today so we know what to do.
-next is btw a great help here.

If we do this inside spase or using a dedicated backend is not so important.
But adding this as a default=disabled option to sparse would be preferred.

	Sam
