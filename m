From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/4] chrisl master branch patches
Date: Sun, 12 Oct 2014 17:22:50 +0800
Message-ID: <CANeU7QnDim5JuSO5HBgBgwUVu1cGDyBwcAKUTVY-vQKjfrBiLw@mail.gmail.com>
References: <54398B23.8080501@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:44353 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbaJLJWv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 12 Oct 2014 05:22:51 -0400
Received: by mail-qa0-f47.google.com with SMTP id cm18so3279405qab.20
        for <linux-sparse@vger.kernel.org>; Sun, 12 Oct 2014 02:22:50 -0700 (PDT)
In-Reply-To: <54398B23.8080501@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sun, Oct 12, 2014 at 3:55 AM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
> Hi Chris,
>
> I don't know how you like to manage your public repo, but if you
> don't mind re-winding your master branch, then you could squash
> patch #1 into commit e23abfd and patch #2 into fe57afa.

I should have try the review branch. Now it is push to master.
I can't rewind it.
>
> The final patch is a possible alternative to "[PATCH 04/10]
> compile-i386.c: don't mix calls to write(2) with stdio", which
> basically just removes the compile program. If you prefer
> another solution, just let me know.

I think I would just keep it as example of using the sparse
front end AST. For compiling, the sparse-llvm does a better job
there.

>
> [Note: I have been living with the RFC patch #10 for quite a
> while now with no problems. However, it was just a quick hack
> to speed up cgcc/sparse on Cygwin and, on reflection, not a
> good reason to introduce a sparse configuration file! Also, the
> use of the perl language for the config file can be viewed as
> a bit cute (too cute for some people). I will probably keep it
> as a locally applied patch on cygwin (it is a noticeable speedup
> on cygwin), but remove it on Linux.]

It seems scary the config file you can put any perl code there.
Any way, I think in the long term, it is better move cgcc stuff
into sparse. So sparse do not need to have a wrapper to setup
the compiling environment. To speed up things, it is best
to invoke sparse without a wrapper. That is how it is done in
the kernel checking.

Chris
