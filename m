From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Thu, 2 Mar 2017 18:57:22 +0100
Message-ID: <CAExDi1QY1+KEsdzBuy0aorDwzvoL2Vos-F5P1HsJZCjT9o0R0w@mail.gmail.com>
References: <CAExDi1Sa3zDs--jht_43EmefT_nj5ThO_-QRdAFZJn=+rAw0iQ@mail.gmail.com>
 <CACXZuxeRe1Oe-Anht7hnsZgwZroP8sZdajvLBdO3oYCE1ofZ8Q@mail.gmail.com>
 <CACXZuxd2fO7-i84+nS5sC7ZHC68=_uJX3P9k75z05Y8vy2BAUA@mail.gmail.com>
 <20170302052124.fsqogvysufayy4to@macbook.local> <CACXZuxe_+-8H6SSA0NvpUdchWYzo_v=2KJq61QC9cVNYG3DGkQ@mail.gmail.com>
 <20170302135655.s742zcslis5r56if@macpro.local> <CACXZuxeiWM9zJZqtUC1YN6tFO6VsHkfTn9CZefr6P5nYUOpoRA@mail.gmail.com>
 <20170302160403.zz5efgh34jvjh5q5@macpro.local> <CACXZuxefWw7VT8VJPXuYZ2kBLK-N=eYGc6BF5Lnbg9vP-RqLWw@mail.gmail.com>
 <CACXZuxeayh3PUdypas6Ww_1mT23ZOuJiZZA_NWDkSQbfes9Xzw@mail.gmail.com> <20170302174959.kh7x5bmwccl7fpig@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34836 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751460AbdCBU3d (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 2 Mar 2017 15:29:33 -0500
Received: by mail-qk0-f176.google.com with SMTP id m67so28327573qkf.2
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 12:29:11 -0800 (PST)
In-Reply-To: <20170302174959.kh7x5bmwccl7fpig@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Mar 2, 2017 at 6:49 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>>
>> It appears that the sparse-llvm code is storing the LLVM instruction
>> for '%r2' in pseudo->priv.
>>
>> >         store.64    %r2 -> 0[%arg1]
>
> Ah yes, it overwrite the correct value previously stored there (the
> LLVMValueRef corresponding to %r2) with the return value of LLVMBuildStore().
>
>> And then it using the value of the store instruction whenever it sees '%r2'?
>>
>> >         load.64     %r18 <- 8[%r2]
>>
>> But here it fails because it needs to cast the LLVM store instruction
>> to be a pointer to access 8[]?
>
> Yes, now anything using %r2 will go wrong.
>
> Removing the last line of output_op_store() (insn->target->priv = target;)
> should fix this.


In fact LLVMBuildStore() return a LLVMValueRef.
Could this be the 'void' we seen?

Luc
