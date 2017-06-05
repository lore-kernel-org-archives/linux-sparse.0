From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 3/3] allow to normalize the pseudos
Date: Mon, 5 Jun 2017 11:45:24 -0700
Message-ID: <CANeU7QnyLhPVAMDTGHLFnmgzcXWLeedr6mW=sCHZDL3C6igX=Q@mail.gmail.com>
References: <20170603073416.66808-1-luc.vanoostenryck@gmail.com> <20170603073416.66808-4-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:37208 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdFESp0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 5 Jun 2017 14:45:26 -0400
Received: by mail-it0-f50.google.com with SMTP id m47so85474877iti.0
        for <linux-sparse@vger.kernel.org>; Mon, 05 Jun 2017 11:45:25 -0700 (PDT)
In-Reply-To: <20170603073416.66808-4-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Jun 3, 2017 at 12:34 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Using the output of test-linearize for testing is not
> ideal because some details of this output are very dependent
> to small changes in linearization or optimization while the
> test in itself may very well not concerned about those changes.
>
> One of the things that are particulary sensitive to these changes
> is the number of the pseudos (%r123, ...).
>
> Make these tests much less sensitive to these changes by adding
> a normalization phase called just before emitting the output.
> This normalization will renumber all the pseudos sequentially,
> restarting at %r1 at each functions.

I have a totally untested idea might be able to simplify this
normalize process. It seems most of the pseudo output is
come from show_pseudo(). We can use the generation number
idea. All we need to do is just keep track of the base of the pseudo
number. If you need new series of number just set the base to a number bigger
than all of the pseudo number. That might means make alloc_pseudo::nr
visible to other function we know what is the max pseudo number.

Initialize the normalization is easy, just set
     pseudo_base = ++pseudo_max;

Then in show_pseudo() we can do the normalize as following:

if (pseudo->nr - pseudo_base < 0)
     pseudo->nr = ++pseudo_max;

For the output of the number, we have:
nr = pseudo->nr - pseudo_base;


One problem I can see if the pseudo->nr wrap around then it
will create confusion. Maybe not some thing we need to worry
about any time soon. Another thing is the pseudo->nr only
make sense in the function scope. We might able to use that
to handle overflowing if it really became a problem.

Might have some other problem as I haven't try to code it myself.

Chris
