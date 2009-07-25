From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 5/5] Add a --version option to sparse
Date: Sat, 25 Jul 2009 12:34:59 -0700
Message-ID: <70318cbf0907251234o6028d0adh8a470f40f373578@mail.gmail.com>
References: <4A62395D.9000207@ramsay1.demon.co.uk>
	 <70318cbf0907211757w1e0e3436hcc8b679c6de60804@mail.gmail.com>
	 <4A6A0BF2.7080509@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pz0-f172.google.com ([209.85.222.172]:60721 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124AbZGYTe7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 25 Jul 2009 15:34:59 -0400
Received: by pzk2 with SMTP id 2so21941pzk.33
        for <linux-sparse@vger.kernel.org>; Sat, 25 Jul 2009 12:34:59 -0700 (PDT)
In-Reply-To: <4A6A0BF2.7080509@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Fri, Jul 24, 2009 at 12:30 PM, Ramsay
Jones<ramsay@ramsay1.demon.co.uk> wrote:
> $ git checkout master
> $ git describe
> 0.4.1-99-g37f041a

If works well if you are following the official branch. If you are working
on your own, you might have some private tag. Then that will mess up
the "git describe". My tag might not even look like a version number.

So for version numbers, I still prefer the dot and numbers. We can
follow what Linux kernel do for version strings.

> My intent with this patch was to provide sparse (the program) with a
> version number; *not* the sparse library, which is a separate issue.
> (If a library version number is implemented, then the sparse program
> version number *could* be the same number, of course). I did not
> consider the other example programs built with sparse, but I suppose
> they could all share the same version number if necessary.

In my mind, they share the same version number. Individual version
the program inside sparse package is kind of messy. I don't see
a need for that in the near future yet.

> However, you would not want sparse (the library) to force *all*
> applications built with the library to handle the --version option
> by printing the sparse (the program) version string and exiting!

That is what YOUR current patch do, no?

>
> So, the library should just set a version_option seen flag and let
> the application process this flag itself.

That will force every program to process the version itself, doing more
or less the same thing.

Let's say I don't need separate version inside sparse package.
Does "-v" printing out sparse version string in side lib.c satisfy
your need already? In that case, I don't see the need for a separate
"--version".

Chris
