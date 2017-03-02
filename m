From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Thu, 2 Mar 2017 18:27:50 +0100
Message-ID: <20170302172749.xopyshzxwcags4m6@macpro.local>
References: <CACXZuxdav6y9uRC9mavNkVZS173k0ftw-8FpPanKLsoF-ws0Sw@mail.gmail.com>
 <20170228150956.moyfiyd5zf7tbeze@macbook.local>
 <CAExDi1Sa3zDs--jht_43EmefT_nj5ThO_-QRdAFZJn=+rAw0iQ@mail.gmail.com>
 <CACXZuxeRe1Oe-Anht7hnsZgwZroP8sZdajvLBdO3oYCE1ofZ8Q@mail.gmail.com>
 <CACXZuxd2fO7-i84+nS5sC7ZHC68=_uJX3P9k75z05Y8vy2BAUA@mail.gmail.com>
 <20170302052124.fsqogvysufayy4to@macbook.local>
 <CACXZuxe_+-8H6SSA0NvpUdchWYzo_v=2KJq61QC9cVNYG3DGkQ@mail.gmail.com>
 <20170302135655.s742zcslis5r56if@macpro.local>
 <CACXZuxeiWM9zJZqtUC1YN6tFO6VsHkfTn9CZefr6P5nYUOpoRA@mail.gmail.com>
 <20170302160403.zz5efgh34jvjh5q5@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36093 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753791AbdCBR2S (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 2 Mar 2017 12:28:18 -0500
Received: by mail-wm0-f50.google.com with SMTP id n11so30476658wma.1
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 09:27:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170302160403.zz5efgh34jvjh5q5@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Mar 02, 2017 at 05:04:04PM +0100, Luc Van Oostenryck wrote:
> However, while running sparse-llvm on some code sample I use to test
> the linearization, I see that most errors are type errors and are
> related to pointer arithmetic, exactly where LLVM's getelemptr is used.
> Most offending instructions are OP_ADD (but since I have tests for 
> bitfields I see also errors for OP_AND, OP_OR & OP_LSR).
> I guess that if you test OP_ADD instruction with pointer on one side
> and integer on tne other side and issue an appropriate LLVMBuildGEP(),
> things will already be much better.

Another place, that clearly need some more love and attention is
output_op_ptrcast() (and possibly outpout_op_cast() too):
Not all OP_PTRCAST can be mapped to an LLVM bitcast, only the ones
wich doesn't change the size can (and even, I'm not suer all can).

Luc
