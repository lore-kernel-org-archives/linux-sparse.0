From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Fri, 3 Mar 2017 05:21:22 +0100
Message-ID: <CAExDi1SyhYmf7i6htgGXjU1pKmoz_53m4HjkP=PS11zRK8m38w@mail.gmail.com>
References: <CAExDi1Sa3zDs--jht_43EmefT_nj5ThO_-QRdAFZJn=+rAw0iQ@mail.gmail.com>
 <CACXZuxeRe1Oe-Anht7hnsZgwZroP8sZdajvLBdO3oYCE1ofZ8Q@mail.gmail.com>
 <CACXZuxd2fO7-i84+nS5sC7ZHC68=_uJX3P9k75z05Y8vy2BAUA@mail.gmail.com>
 <20170302052124.fsqogvysufayy4to@macbook.local> <CACXZuxe_+-8H6SSA0NvpUdchWYzo_v=2KJq61QC9cVNYG3DGkQ@mail.gmail.com>
 <20170302135655.s742zcslis5r56if@macpro.local> <CACXZuxeiWM9zJZqtUC1YN6tFO6VsHkfTn9CZefr6P5nYUOpoRA@mail.gmail.com>
 <20170302160403.zz5efgh34jvjh5q5@macpro.local> <CACXZuxefWw7VT8VJPXuYZ2kBLK-N=eYGc6BF5Lnbg9vP-RqLWw@mail.gmail.com>
 <CACXZuxeayh3PUdypas6Ww_1mT23ZOuJiZZA_NWDkSQbfes9Xzw@mail.gmail.com>
 <20170302174959.kh7x5bmwccl7fpig@macpro.local> <CAExDi1QY1+KEsdzBuy0aorDwzvoL2Vos-F5P1HsJZCjT9o0R0w@mail.gmail.com>
 <CACXZuxfR6HNzvzkCLy1R2bik4R2p9t1i1+fga91GP-SnMAkwmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:34767 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751340AbdCCISO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 3 Mar 2017 03:18:14 -0500
Received: by mail-qk0-f169.google.com with SMTP id s186so163784956qkb.1
        for <linux-sparse@vger.kernel.org>; Fri, 03 Mar 2017 00:17:43 -0800 (PST)
In-Reply-To: <CACXZuxfR6HNzvzkCLy1R2bik4R2p9t1i1+fga91GP-SnMAkwmQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Mar 2, 2017 at 7:02 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>> In fact LLVMBuildStore() return a LLVMValueRef.
>> Could this be the 'void' we seen?
>>
>
> It returns a Value that is a store instruction, or at least that's the
> way I interpret this and so yes, I think the type of this was void.

I failed to find doc about it. But anwyay, overwritting the target->priv
can't be correct.

> BTW removing the line makes progress, but it fails at the add
> instruction later. Are there other issues like this you can spot? I am
> a bit lost here I am afraid.
No, not like this. What I saw was just the result of looking at your
example and trying to understand what's happening.

Luc
