From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Adding ignored attribute optimize
Date: Sat, 1 Jul 2017 15:21:36 -0700
Message-ID: <CANeU7Q=Zj6LT1--TP-XGouwVZVTgJor8h1+2GZ1r0HCjVa5pmw@mail.gmail.com>
References: <CANeU7QnNNL1u3BxhWLebFqzn+9Y7hHKABDo_mkEqfwF+VO963Q@mail.gmail.com>
 <20170629070437.o6j2bkv6wdbcknwa@ltop.local> <CANeU7QnfvQ5KNFKvGGeJ1u7CDpd5wigosY0BrGNT1H0KouPHuA@mail.gmail.com>
 <20170701092440.egmgcexgwuuybzj7@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35230 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbdGAWVh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 1 Jul 2017 18:21:37 -0400
Received: by mail-pg0-f50.google.com with SMTP id j186so78532858pge.2
        for <linux-sparse@vger.kernel.org>; Sat, 01 Jul 2017 15:21:37 -0700 (PDT)
In-Reply-To: <20170701092440.egmgcexgwuuybzj7@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Jul 1, 2017 at 2:24 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Sure it make some sense.
>
> But how often it happen and when it happen how much developers
> are impacted and for how long?

It actually happen right now with the kernel using require_context
which is not supported by sparse. Sparse should report error
on the sparse related syntax which it does not support. Gcc is
no going to report error on those sparse related attributes because
gcc never see them.

Because we have noway to tell an unknown attribute is belong
to sparse or gcc. Sparse checker should report it. It is very bad
silence on those sparse specific error and developer have no way
to know it.

I am fine with other use of sparse like sparse-llvm turn
it off by default. But for sparse checker program itself. I think
report the error is the right thing to do.

As for the distro version of sparse is too old.
I think the right thing to do is just get into the habit of release
more often.

I am guilty of not cutting a release for 3 years. On the other
hand, things are getting better now. Thanks to you, sparse
has merge more change in the recent half years than all
of the two years before it. I do expect to see another release to
merge your huge number of patches.


Chris
