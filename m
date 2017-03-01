From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Wed, 1 Mar 2017 06:49:18 +0100
Message-ID: <20170301054917.th5eptntfnnui3qx@macpro.local>
References: <CACXZuxdav6y9uRC9mavNkVZS173k0ftw-8FpPanKLsoF-ws0Sw@mail.gmail.com>
 <20170228150956.moyfiyd5zf7tbeze@macbook.local>
 <CAExDi1Sa3zDs--jht_43EmefT_nj5ThO_-QRdAFZJn=+rAw0iQ@mail.gmail.com>
 <20170228173519.hyq3aihtg3zouoih@macpro.local>
 <CACXZuxdFQD+6yPcisZ=hJssO5fyxm9LYJbvVHsvnjRz87cCjrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35072 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbdCAF5T (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 1 Mar 2017 00:57:19 -0500
Received: by mail-wm0-f48.google.com with SMTP id v186so101461972wmd.0
        for <linux-sparse@vger.kernel.org>; Tue, 28 Feb 2017 21:56:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxdFQD+6yPcisZ=hJssO5fyxm9LYJbvVHsvnjRz87cCjrQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Feb 28, 2017 at 06:08:16PM +0000, Dibyendu Majumdar wrote:
> 
> Following modified version should handle values than 0.


Good, I'll cook a patch based on this.

But I still have a fundamental problem with pseudo_to_value().
It's working with your example because we're using an OP_STORE
and we're interesting in the type of the "target" and for this
instruction (admittedly, like most instructions) insn->type is
the type of insn->target. With insn->src or OP_SETNE, the result
would have been incorrect.

So while this patch is a little improvement and doesn't hurt,
it's still not a good solution.
What I last wrote on the subject the 29th Jan still holds
(the "type" info should be given as argument to pseudo_to_value()
instead of passing the pointer to the instruction) or at least
something along this line.

Luc Van Oostenryck
