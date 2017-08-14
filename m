From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH] Give the constant pseudo value a size
Date: Mon, 14 Aug 2017 18:11:58 +0100
Message-ID: <CACXZuxekYwfO5LRYDbCQoP9eqRvYJvnCSj8YQ=TAw6wt6Q1KsA@mail.gmail.com>
References: <CANeU7Q=irkzkaKdaZT-0POrhj73ac3X8Bk-MW+jvFGtr1h5z0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:37696 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbdHNRL7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Aug 2017 13:11:59 -0400
Received: by mail-vk0-f42.google.com with SMTP id r199so33532801vke.4
        for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2017 10:11:59 -0700 (PDT)
In-Reply-To: <CANeU7Q=irkzkaKdaZT-0POrhj73ac3X8Bk-MW+jvFGtr1h5z0w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>

Hi Chris,

On 13 August 2017 at 05:18, Christopher Li <sparse@chrisli.org> wrote:
> This is actually easier than I though.
> It is also very simple to reason about.
>
> If you are not looking at the size field at all.
> It is exactly the same as before, except we
> create a few more pseudo for the same value
> that have different size.
>
> The size just tag along the constant pseudo.
> Which did not change any way.
>

I assume that you have not yet applied this approach to Sparse-LLVM
and tested that it works for var arg calls? I would suggest completing
the changes so that it can be tested thoroughly.

I personally don't have a preference one way or the other which approach we use.

The push approach has the benefit that it makes clear what arguments
are being passed in a call. Previously this information was not
revealed in the Sparse linearized dump. It would be a shame to lose
that information - perhaps you could still dump the arguments along
with a call?

Second benefit to me is that I have already incorporated this into
dmrC so changing it will mean rework for me.

BTW one could also have a more restricted 'push' solution that is
specific to var arg calls - i.e. only capture the arguments when
calling a var arg function, and avoid putting the push instructions
into the linear stream.

Regards
Dibyendu
