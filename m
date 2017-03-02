From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Thu, 2 Mar 2017 20:34:16 +0100
Message-ID: <CAExDi1S01UxR0_Kbc33NGp1RMbYT12brE=Kst8pkt51w36-Aag@mail.gmail.com>
References: <CACXZuxeRe1Oe-Anht7hnsZgwZroP8sZdajvLBdO3oYCE1ofZ8Q@mail.gmail.com>
 <CACXZuxd2fO7-i84+nS5sC7ZHC68=_uJX3P9k75z05Y8vy2BAUA@mail.gmail.com>
 <20170302052124.fsqogvysufayy4to@macbook.local> <CACXZuxe_+-8H6SSA0NvpUdchWYzo_v=2KJq61QC9cVNYG3DGkQ@mail.gmail.com>
 <20170302135655.s742zcslis5r56if@macpro.local> <CACXZuxeiWM9zJZqtUC1YN6tFO6VsHkfTn9CZefr6P5nYUOpoRA@mail.gmail.com>
 <20170302160403.zz5efgh34jvjh5q5@macpro.local> <CACXZuxefWw7VT8VJPXuYZ2kBLK-N=eYGc6BF5Lnbg9vP-RqLWw@mail.gmail.com>
 <CACXZuxeayh3PUdypas6Ww_1mT23ZOuJiZZA_NWDkSQbfes9Xzw@mail.gmail.com>
 <CACXZuxdaYwKm2pJV3zbusUbUdKx2M-nVjSJBfV6G4QwTY1vJ-A@mail.gmail.com>
 <20170302174353.4tb664cnfjjtxk5t@macpro.local> <CACXZuxfkYqgPxE3OGdz7funUJtB6=K3TTwhzyZLJ=Kcio_7HXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33229 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbdCBWJ0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 2 Mar 2017 17:09:26 -0500
Received: by mail-qk0-f178.google.com with SMTP id n127so148094040qkf.0
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 14:09:25 -0800 (PST)
In-Reply-To: <CACXZuxfkYqgPxE3OGdz7funUJtB6=K3TTwhzyZLJ=Kcio_7HXg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Mar 2, 2017 at 7:58 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> On 2 March 2017 at 17:43, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> On Thu, Mar 02, 2017 at 05:18:16PM +0000, Dibyendu Majumdar wrote:
>>> Hi Luc,
>>>
>>> I was looking at whether I can use the standard LLVM GEP api to access
>>> struct and array members in sparse-llvm. I noticed that the output
>>> from sparse has byte offsets of each member - but not the member's
>>> ordinal position.
>>
>> Indeed, when the offset is a compile constant otherwise the offset
>> is set to zero and there is a pair OP_MUL/OP_ADD before that does
>> the needed pointer arithmetic.
>>
>>> To use the native LLVM methods we would have to
>>> allow LLVM to work out byte offsets, and just use the struct or array
>>> definition. This would I think make the code more robust and also lead
>>> to better optimisation.
>>
>> I'm not sure to understand here: which byte offsets need to be worked out?
>
> You use the GEP API which allows you say that you want to access field
> 5 from a struct, and so on. Here 5 is the fifth field. LLVM works out
> the rest. This is better than casting the struct to char* and then
> doing pointer arithmetic.

OK. Yes.

>> Also, for the optimization, I wouldn't worry for now because:
>> - the linearized code is already optimized (nothing sophisticated but the
>>   essential is already there)
>> - you can always later call LLVM's optimization passes
>> - the code selector will also do some optimization.
>>
>
> Sure but my experience with LLVM is that it needs to have type
> metadata for each store and load instruction to properly do type based
> alias analysis. Otherwise it will miss optimisation opportunities.
> Maybe we can still provide type metadata as we do have the symbol
> definition etc.

There is certainly no reasons to not give easily available information.

> But I agree that if sparse-llvm works correctly for all inputs then
> that is a big step forward (for me) !

Indeed :)


Luc
