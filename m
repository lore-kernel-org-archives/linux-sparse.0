From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC] rationale for systematic elimination of OP_SYMADDR instructions
Date: Fri, 11 Aug 2017 00:16:18 +0200
Message-ID: <CAExDi1QVzkOVRxe+mdsHEi4=wirRFKrO+UFRDH2498z43oZidw@mail.gmail.com>
References: <20170309142044.96408-1-luc.vanoostenryck@gmail.com>
 <CANeU7QkhQJrGifw5zvRoN27yVEfmU23B+HG5KQy3R9G3aKWUgw@mail.gmail.com>
 <CAMHZB6EE93YSm0gVUr=dhNpsTZ1vU8acJ9msyh3VSdTOTVUq-w@mail.gmail.com>
 <CANeU7Q=zV+MAFOA6SzANEF9_7NB0rY719bzkesPnvUS9AqR+hw@mail.gmail.com>
 <CAMHZB6Gj0pS-z_tSPS+6tXhg2mAjGhDYxBLZXn0wmmAYePtZyg@mail.gmail.com>
 <CANeU7Qk7czDA+RJzxyZHRa9zJdvv19s0NYExfDoW+34HmkB4dA@mail.gmail.com>
 <CAMHZB6EvJss-53X2oyXGHTRpAjDnoK8W5dCbng2tqUmjMykORA@mail.gmail.com> <CANeU7QkJy-G4EXuJ94KBcmo3Bc0Pei0uQSTeYr-u4DxsSK==uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:32811 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbdHJWQT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 18:16:19 -0400
Received: by mail-oi0-f46.google.com with SMTP id f11so19564711oic.0
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 15:16:19 -0700 (PDT)
In-Reply-To: <CANeU7QkJy-G4EXuJ94KBcmo3Bc0Pei0uQSTeYr-u4DxsSK==uQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Aug 10, 2017 at 5:01 PM, Christopher Li <sparse@chrisli.org> wrote:
>
> Please correct me if I am wrong.  I still think:
> 1)  OP_SYMADDR can be generated from the symbol node and where
>      to place them (immediate D(N)).
>
> 2) If one of the back end needs them. Go ahead and generate OP_SYMADDR.
>    However, I don't think sparse checker need to use the OP_SYMADDR
>    so it will be more optimal  for sparse checker to avoid OP_SYMADDR.
>
>    Am I missing some thing?

I'm not sure to understand exactly what you mean here above, sorry.
But yes, I think you're missing something.

All this have already been explained during the initial discussion but:
* those OP_SYMADDR represent the *calculation* that is needed to get
the address of a symbol.
* depending on the architecture, the kind/linkage/visibility of the symbol,
  compiler flag, ... this calculation can be very simple, like:
  - just a constant (but a big one)
  - just a load at a constant address & a constant address
  - or much more complicated
* the OP_SYMADDR *abstract* away the *details* of this calculation
   but it is important to expose it
* of the reasons we want to expose it is that we *want* to do CSE on
  these calculations
* there is absolutely no reasons why we should process them differently
  than any other instructions. In particular, it would be absurd to:
  - try to put all of them at the top
  - try to place them ourself at some other special place (common parent,
    dominator, ...)
  because CSE will place them automatically at the best place: as near as
  possible from where they are needed.
* it would also be a very bad idea to *not* generate them and only let the
  backend generate them because it would then mean that iether:
  - no CSE on them
  - backend need to reimplement CSE for them
  The backend, just need to *expose the details*, maybe change those
  SYMADDR in the appropriate loads & adds & loads or whatever but
  they need to be already there and processed by the middle-end.

-- Luc
