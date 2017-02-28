From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Tue, 28 Feb 2017 18:03:05 +0100
Message-ID: <CAExDi1Sa3zDs--jht_43EmefT_nj5ThO_-QRdAFZJn=+rAw0iQ@mail.gmail.com>
References: <CACXZuxdav6y9uRC9mavNkVZS173k0ftw-8FpPanKLsoF-ws0Sw@mail.gmail.com>
 <20170228150956.moyfiyd5zf7tbeze@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34326 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbdB1REQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Feb 2017 12:04:16 -0500
Received: by mail-qk0-f181.google.com with SMTP id s186so27885287qkb.1
        for <linux-sparse@vger.kernel.org>; Tue, 28 Feb 2017 09:03:07 -0800 (PST)
In-Reply-To: <20170228150956.moyfiyd5zf7tbeze@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Feb 28, 2017 at 4:09 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> There is indeed some problems regarding this, we looked a bit at this
> some weeks ago. However I firmly believe that the information about
> the type belong to the operations and not the values.

I've taken a very quick look at this "mt->foo = (void *)0"
The type info is perfectly present.
If in sparse-llvm.c:output_op_store() you add somewhere something like:
    fprintf(stderr, "-> %s\n", show_typename(insn->type));
You will see that it display the expected type: "int *".
This is all the type info needed: it's the type of insn->target (the
value to be stored)
and the type of the dereferencing of insn->src (the (base) address).

The problem is that output_op_store() doesn't use this info, it tries to deduce
this type via pseudo_to_value() but pseudo_to_value() wrongly assumes that all
PSEUDO_VALUE-pseudo are integer.

Luc
