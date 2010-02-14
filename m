From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: Warnings on global symbols accessed only from assembly code
Date: Sun, 14 Feb 2010 02:48:32 +0200
Message-ID: <20100214004832.GA29636@laptop>
References: <20100212000052.GA6837@laptop> <70318cbf1002111706n7011eecpdaeb8bb691f95087@mail.gmail.com> <20100212014709.GA10748@laptop> <70318cbf1002112243q7de5f692k632f156d769fd7fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:42670 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab0BNAsf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 13 Feb 2010 19:48:35 -0500
Received: by fxm27 with SMTP id 27so115176fxm.25
        for <linux-sparse@vger.kernel.org>; Sat, 13 Feb 2010 16:48:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <70318cbf1002112243q7de5f692k632f156d769fd7fb@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@kernel.org>, linux-sparse@vger.kernel.org

On Thu, Feb 11, 2010 at 10:43:51PM -0800, Christopher Li wrote:
> On Thu, Feb 11, 2010 at 5:47 PM, Ahmed S. Darwish <darwish.07@gmail.com> wrote:
> >
> > The case I faced was kernel's main entrance C method which should only be
> > jumped to from bootstrap asm code. I think a declaration in such case will
> > only give bogus function usage impressions.
> 
> How about give it some prototype which clearly indicate the function should
> be only call from boot strap? e.g. BOOT_STRAP_ENTRY(function_name) which
> expand it to a function prototype.
>

mm, yes, I guess this can be a good-enough solution :)

> >
> >> > Unfortunately the current `-Wno-decl' solution is a bit extreme: it
> >> > turns off a very useful sparse feature (by design).
> >>
> >> Right, the problem is that sparse can't tell which functions are used in
> >> asm files and only skip warning on those.
> >>
> >
> > Would proposing an __attribute__ for such case be accepted in concept?
> 
> I don't thing it justify more non-stander attribute, which is
> for-the-sake-of-sparse thing as well.
>

It seems those non-standard attributes have some associated costs
that I'm not aware of; I can see the implicit trade-off then.

> Chris

Thanks for the sincere help.

-- 
Darwish
http://darwish.07.googlepages.com
