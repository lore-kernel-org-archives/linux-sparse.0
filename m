From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Thu, 2 Mar 2017 18:43:54 +0100
Message-ID: <20170302174353.4tb664cnfjjtxk5t@macpro.local>
References: <CACXZuxeRe1Oe-Anht7hnsZgwZroP8sZdajvLBdO3oYCE1ofZ8Q@mail.gmail.com>
 <CACXZuxd2fO7-i84+nS5sC7ZHC68=_uJX3P9k75z05Y8vy2BAUA@mail.gmail.com>
 <20170302052124.fsqogvysufayy4to@macbook.local>
 <CACXZuxe_+-8H6SSA0NvpUdchWYzo_v=2KJq61QC9cVNYG3DGkQ@mail.gmail.com>
 <20170302135655.s742zcslis5r56if@macpro.local>
 <CACXZuxeiWM9zJZqtUC1YN6tFO6VsHkfTn9CZefr6P5nYUOpoRA@mail.gmail.com>
 <20170302160403.zz5efgh34jvjh5q5@macpro.local>
 <CACXZuxefWw7VT8VJPXuYZ2kBLK-N=eYGc6BF5Lnbg9vP-RqLWw@mail.gmail.com>
 <CACXZuxeayh3PUdypas6Ww_1mT23ZOuJiZZA_NWDkSQbfes9Xzw@mail.gmail.com>
 <CACXZuxdaYwKm2pJV3zbusUbUdKx2M-nVjSJBfV6G4QwTY1vJ-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35381 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753100AbdCBRoA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 2 Mar 2017 12:44:00 -0500
Received: by mail-wm0-f43.google.com with SMTP id v186so141758002wmd.0
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 09:43:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxdaYwKm2pJV3zbusUbUdKx2M-nVjSJBfV6G4QwTY1vJ-A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Mar 02, 2017 at 05:18:16PM +0000, Dibyendu Majumdar wrote:
> Hi Luc,
> 
> I was looking at whether I can use the standard LLVM GEP api to access
> struct and array members in sparse-llvm. I noticed that the output
> from sparse has byte offsets of each member - but not the member's
> ordinal position.

Indeed, when the offset is a compile constant otherwise the offset
is set to zero and there is a pair OP_MUL/OP_ADD before that does
the needed pointer arithmetic.

> To use the native LLVM methods we would have to
> allow LLVM to work out byte offsets, and just use the struct or array
> definition. This would I think make the code more robust and also lead
> to better optimisation.

I'm not sure to understand here: which byte offsets need to be worked out?

Also, for the optimization, I wouldn't worry for now because:
- the linearized code is already optimized (nothing sophisticated but the
  essential is already there)
- you can always later call LLVM's optimization passes
- the code selector will also do some optimization.

> Unfortunately LLVM does not support unions so for unions a bit of what
> is being done now is probably needed, but even here it is better to
> cast a union to its member struct type and then use LLVM GEP api to
> access its members.
> 
> What do you think?

Honestly, I think nothing because I don't understand enough the issues
with sparse-llvm and what LLVM needs.

> I think adding the ordinal position to sparse symbols is a trivial
> enhancement - do you agree?

Unless I'm misunderstand what you mean, these postion are already there
but not explicitly: you can lookup the lists to see what position a field
in a structure is.
If you need the byte offsets, those are already available (or trivialy
calculable).

Luc
