From: Bernd Petrovitsch <bernd@sysprog.at>
Subject: Re: including sparse headers in C++ code
Date: Tue, 09 Nov 2010 14:28:05 +0100
Message-ID: <1289309285.14246.16.camel@thorin>
References: <AANLkTinGSRQYqR2h+V0nAB+vn4xWCGxgbmGHuMm-xHyB@mail.gmail.com>
	 <AANLkTinaDZZmyeaK+rAvLCdZ-90n17WhABRsZGUBBcSH@mail.gmail.com>
	 <1286710919.24953.2.camel@thorin> <201010101352.10864.kdudka@redhat.com>
	 <1286790249.24953.14.camel@thorin>
	 <AANLkTin00gg79Zdg1JJgaaK+2wzgu9Xpr719MYOebQ+J@mail.gmail.com>
	 <20101011191219.GD8537@feather> <1286981110.14103.86.camel@thorin>
	 <20101020072945.GA3232@ZenIV.linux.org.uk> <1287567544.7542.7.camel@thorin>
	 <AANLkTikBMpuwHZpAsSmcP_5MC3GJQNZE3SrRT6VQ8boS@mail.gmail.com>
	 <1288358560.7795.34.camel@thorin>
	 <AANLkTinmmLf9dMvLfWk09kGV6RbEo9HMV8ds=yGEQyMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:5932 "EHLO
	esgaroth.petrovitsch.priv.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752027Ab0KIN2f (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 9 Nov 2010 08:28:35 -0500
In-Reply-To: <AANLkTinmmLf9dMvLfWk09kGV6RbEo9HMV8ds=yGEQyMw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Kamil Dudka <kdudka@redhat.com>, Tomas Klacko <tomas.klacko@gmail.com>, linux-sparse@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>

Hi!

On Don, 2010-11-04 at 17:57 -0700, Christopher Li wrote: 
> On Fri, Oct 29, 2010 at 6:22 AM, Bernd Petrovitsch <bernd@sysprog.at> wrote:
> >
> > Voila.
> 
> -               struct basic_block *true = br->bb_true;
> -               struct basic_block *false = br->bb_false;
> -               br->bb_false = true;
> -               br->bb_true = false;
> +               struct basic_block *true_expr = br->bb_true;
> +               struct basic_block *false_expr = br->bb_false;
> +               br->bb_false = true_expr;
> +               br->bb_true = false_expr;
> 
> Hmm, not very "true" symbol is an expression type. You end up calling
> basicl_block pointer as true_expr, that is misleading.
> Same thing happen to pseudo_t pointers.

Frankly, I don't understand what you mean (especially with the pseudo_t)
- which also explains why the suboptimal variable naming and I cannot
come up with a better name.

> Looks fine otherwise.

Bernd
-- 
mobile: +43 664 4416156              http://www.sysprog.at/
    Linux Software Development, Consulting and Services

