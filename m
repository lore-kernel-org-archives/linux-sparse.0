From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Thu, 2 Mar 2017 17:36:13 +0000
Message-ID: <CACXZuxfjJfDFuHkgMA+2V0tpuh-is15_sx0AJt+2EyjG7v6Y2g@mail.gmail.com>
References: <CAExDi1Sa3zDs--jht_43EmefT_nj5ThO_-QRdAFZJn=+rAw0iQ@mail.gmail.com>
 <CACXZuxeRe1Oe-Anht7hnsZgwZroP8sZdajvLBdO3oYCE1ofZ8Q@mail.gmail.com>
 <CACXZuxd2fO7-i84+nS5sC7ZHC68=_uJX3P9k75z05Y8vy2BAUA@mail.gmail.com>
 <20170302052124.fsqogvysufayy4to@macbook.local> <CACXZuxe_+-8H6SSA0NvpUdchWYzo_v=2KJq61QC9cVNYG3DGkQ@mail.gmail.com>
 <20170302135655.s742zcslis5r56if@macpro.local> <CACXZuxeiWM9zJZqtUC1YN6tFO6VsHkfTn9CZefr6P5nYUOpoRA@mail.gmail.com>
 <20170302160403.zz5efgh34jvjh5q5@macpro.local> <CACXZuxefWw7VT8VJPXuYZ2kBLK-N=eYGc6BF5Lnbg9vP-RqLWw@mail.gmail.com>
 <CACXZuxdr9ubL6S8PEzAHtOt9AT=PjYcv_8EotLD8_Cagc7ZGPw@mail.gmail.com> <20170302171842.xuk535w6wrfxke3b@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:32938 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbdCBWBq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 2 Mar 2017 17:01:46 -0500
Received: by mail-io0-f172.google.com with SMTP id f84so62118727ioj.0
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 14:01:29 -0800 (PST)
In-Reply-To: <20170302171842.xuk535w6wrfxke3b@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 2 March 2017 at 17:18, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Thu, Mar 02, 2017 at 04:30:53PM +0000, Dibyendu Majumdar wrote:
>> > Here is the output from linearize. I think the way stores and loads
>> > are handled is broken. It appears that the last store / load
>> > instruction is stored in insn->target->priv, and then used later on
>> > ... I do not understand what the code is trying to do. Is it trying to
>> > optimize away stores and loads?
>
> No, no.
> What is stored in ->priv is the target's  LLVMValueRef (and for a store
> the 'target' is what need to be stored).
> And indeed there is a bug there: it's target_in that should be stored in
> ->priv (in fact, for a store, there is no need to put anything at all
> in this field; at least I don't see any reason why it should).
> Nice catch.
> I don't know how it's related to your problem though.
>

My question was why is something being stored in 'priv' and used
later? That seems to be an optimisation? Why not recompute every time?

I think this caching in 'priv' and using it later is the cause of the
wrong code - unless as you say the value stored in 'priv' is incorrect
and needs fixing.

Regards
