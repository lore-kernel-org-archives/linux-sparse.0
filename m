From: Christopher Li <sparse@chrisli.org>
Subject: Re: [WIP 00/13] LLVM fixes
Date: Mon, 6 Mar 2017 09:47:10 +0800
Message-ID: <CANeU7QnkWXYF6U_S2YdqJs=hqCtRDrsn+jHVf922vnxzDBXb=g@mail.gmail.com>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:33184 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752414AbdCFB4N (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 20:56:13 -0500
Received: by mail-io0-f173.google.com with SMTP id f84so103186854ioj.0
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 17:56:12 -0800 (PST)
In-Reply-To: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Pekka Enberg <penberg@gmail.com>

Adding CC to Pekka Enberg, he submit most of the llvm patches.

Chris

On Sun, Mar 5, 2017 at 7:20 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> This series solves a number of issues in sparse-llvm,
> mainly about wrong type information as needed for LLVM
> or simply the lack of these infos.
> These issues have been reported and investigated by
> Dibyendu Majumdar.
>
> These patches have been lightly tested and already
> allow to compile a lot more code to LLVM.
> It's still incomplete though:
> - it won't work on bitfields
> - it won't work on computed gotos
> - it won't work on label-as-value
> - it won't work on exotic instructions (OP_SPLICE)
> - few things are working correctly with floats
>   (but this is not specific to sparse-llvm).
> There is most probably a bunch of others issues too.
>
> For testing purpose this serie is also available at:
>   https://github.com/lucvoo/sparse/tree/llvm-fixes-v0
>
>
> Luc Van Oostenryck (13):
>   llvm: add a helper to convert an integer to a ValueRef
>   llvm: fix translation of PSEUDO_VALs into a ValueRefs
>   llvm: fix output_op_store() which modify its operand
>   llvm: fix output_op_[ptr]cast()
>   add get_nth1_arg()
>   llvm: fix type of literal integer passed as arguments
>   llvm: fix output OP_ADD mixed with pointers
>   llvm: add support for OP_NEG
>   give a type to OP_PHISOURCE
>   give a type to OP_SEL, always
>   llvm: remove unneeded arg 'module'
>   llvm: remove unneeded arg 'fn'
>   llvm: fix: do not mix pointers and floats when doing compares
>
>  flow.c                        |   2 +-
>  linearize.c                   |  18 ++--
>  linearize.h                   |   2 +-
>  memops.c                      |   2 +-
>  sparse-llvm.c                 | 187 +++++++++++++++++++++++++++++++-----------
>  symbol.h                      |  13 +++
>  validation/backend/null.c     |  24 ++++++
>  validation/backend/store-x2.c |  16 ++++
>  8 files changed, 203 insertions(+), 61 deletions(-)
>  create mode 100644 validation/backend/null.c
>  create mode 100644 validation/backend/store-x2.c
>
> --
> 2.11.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
