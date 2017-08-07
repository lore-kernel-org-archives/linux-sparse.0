From: Christopher Li <sparse@chrisli.org>
Subject: Re: SCC: a sparse based compiler backend
Date: Sun, 6 Aug 2017 20:51:11 -0400
Message-ID: <CANeU7QkDLcCAcA7xk96iL1E9e4O7=ura1skPGQ8-hgkP4HGobw@mail.gmail.com>
References: <20170806210152.11002-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34062 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751374AbdHGAvN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 20:51:13 -0400
Received: by mail-pg0-f47.google.com with SMTP id u185so27490503pgb.1
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 17:51:12 -0700 (PDT)
In-Reply-To: <20170806210152.11002-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Sun, Aug 6, 2017 at 5:01 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Since it seems to be an interest on the subject, here is a
> small compiler, or more exactly, a partial compiler backend.
>
> Acessing symbols is very limited though and there is nothing
> done yet for register allocation (and even less scheduling).
>
> It can currently generate code for ARM & ARM64 and can easily
> be adapted for other RISC arch. Code for x86 would need more work.
>
> I don't feel the need to patchbomb the ML so here is the URL:
>   git://github.com/lucvoo/sparse.git codegen

I just look at it a very little bit. From github.

It seem to be the most advance form of C compiler for sparse so far.

Congratulations.

I realized that you use .md format for your machine code description.
If it is your own format I would avoid .md because that is the mark down
format recognized by github etc. I am tempting to use md myself for the
documents of sparse. I will send out a different email for discussion.

You will see that file display funny in github, because github think that is
MarkDown format.

Chris
