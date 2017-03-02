From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Thu, 2 Mar 2017 14:56:55 +0100
Message-ID: <20170302135655.s742zcslis5r56if@macpro.local>
References: <CACXZuxdav6y9uRC9mavNkVZS173k0ftw-8FpPanKLsoF-ws0Sw@mail.gmail.com>
 <20170228150956.moyfiyd5zf7tbeze@macbook.local>
 <CAExDi1Sa3zDs--jht_43EmefT_nj5ThO_-QRdAFZJn=+rAw0iQ@mail.gmail.com>
 <CACXZuxeRe1Oe-Anht7hnsZgwZroP8sZdajvLBdO3oYCE1ofZ8Q@mail.gmail.com>
 <CACXZuxd2fO7-i84+nS5sC7ZHC68=_uJX3P9k75z05Y8vy2BAUA@mail.gmail.com>
 <20170302052124.fsqogvysufayy4to@macbook.local>
 <CACXZuxe_+-8H6SSA0NvpUdchWYzo_v=2KJq61QC9cVNYG3DGkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37759 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbdCBOHE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 2 Mar 2017 09:07:04 -0500
Received: by mail-wm0-f42.google.com with SMTP id n11so25838034wma.0
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 06:06:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxe_+-8H6SSA0NvpUdchWYzo_v=2KJq61QC9cVNYG3DGkQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Mar 02, 2017 at 05:41:59AM +0000, Dibyendu Majumdar wrote:
> On 2 March 2017 at 05:21, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >> Anyway have hit a bunch of other issues with sparse-llvm ... :-(
> >
> > Each day its problem (and happily its solution too!).
> >
> 
> I will submit test cases for the new problems when I get some time.

OK. Thanks.

> But I am beginning to think that there is quite a bit of work needed
> to fix the issues, and in any case it might be better to create an
> LLVM backend from the parse tree rather than the linearized version.

Possible, but this will certainly need some work too.

> The current approach is very low level - for example struct member
> access bypasses the natural LLVM way of doing it.

Yes, that's true.

> This approach will
> have the consequence that LLVM will generate poor quality code as it
> will not have enough information to optimise properly. The current
> approach is more suited to backends that directly emit machine code I
> think.

As far as I understood, the idea behind the linearized code and the
optimization made on it was to have it's own backend. Sparse-llvm
only came much later.

Regards,
Luc
