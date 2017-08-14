From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Give the constant pseudo value a size
Date: Mon, 14 Aug 2017 13:23:22 -0400
Message-ID: <CANeU7Q=gK9fgX6RkHdOmnvSB8iEEsJzC-RCgXfu=Y6gED=pUxg@mail.gmail.com>
References: <CANeU7Q=irkzkaKdaZT-0POrhj73ac3X8Bk-MW+jvFGtr1h5z0w@mail.gmail.com>
 <CACXZuxekYwfO5LRYDbCQoP9eqRvYJvnCSj8YQ=TAw6wt6Q1KsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:34098 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751538AbdHNRXX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Aug 2017 13:23:23 -0400
Received: by mail-yw0-f179.google.com with SMTP id s143so58809224ywg.1
        for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2017 10:23:23 -0700 (PDT)
In-Reply-To: <CACXZuxekYwfO5LRYDbCQoP9eqRvYJvnCSj8YQ=TAw6wt6Q1KsA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Aug 14, 2017 at 1:11 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> I assume that you have not yet applied this approach to Sparse-LLVM
> and tested that it works for var arg calls? I would suggest completing
> the changes so that it can be tested thoroughly.

No. this is just one night's hack to make the plumbing part work.
Provide a size for the VALUE pseudo. I haven't have a chance to
integrate into sparse-llvm.

> The push approach has the benefit that it makes clear what arguments
> are being passed in a call. Previously this information was not
> revealed in the Sparse linearized dump. It would be a shame to lose
> that information - perhaps you could still dump the arguments along
> with a call?

Are you sure?
Here is what I have for RC5:
./test-linearize cse.c

.L414:
load.64     %r1052 <- 0[insn]
call.64     %r1053 <- try_to_cse, %arg1, %r1044(last), %r1052
store.64    %r1053 -> 0[insn]
phisrc.64   %phi474 <- %r1053
br          .L413

You can see exactly what is the calling arguments. There is an pseudo_list
for the arguments.

struct /* call */ {
pseudo_t func;
struct pseudo_list *arguments; <==============
struct symbol *fntype;
};


The only thing you want, which is not there is the VALUE pseudo_size.
I add that in this patch.

I haven't take a deep look into the push instruction patch yet. I image this is
less impact on the IR and get the job done. With less redundant information
in the IR. The instruction stream is more compact as well.


Chris
