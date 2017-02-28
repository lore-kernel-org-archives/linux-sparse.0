From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Tue, 28 Feb 2017 18:08:16 +0000
Message-ID: <CACXZuxdFQD+6yPcisZ=hJssO5fyxm9LYJbvVHsvnjRz87cCjrQ@mail.gmail.com>
References: <CACXZuxdav6y9uRC9mavNkVZS173k0ftw-8FpPanKLsoF-ws0Sw@mail.gmail.com>
 <20170228150956.moyfiyd5zf7tbeze@macbook.local> <CAExDi1Sa3zDs--jht_43EmefT_nj5ThO_-QRdAFZJn=+rAw0iQ@mail.gmail.com>
 <20170228173519.hyq3aihtg3zouoih@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:36377 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751134AbdB1SI4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Feb 2017 13:08:56 -0500
Received: by mail-io0-f170.google.com with SMTP id l7so14772055ioe.3
        for <linux-sparse@vger.kernel.org>; Tue, 28 Feb 2017 10:08:17 -0800 (PST)
In-Reply-To: <20170228173519.hyq3aihtg3zouoih@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 28 February 2017 at 17:35, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Not very pretty and incomplete but the following patch allow sparse-llvm
> to compile this:
>         struct mytype {
>                 int *foo;
>         };
>
>         extern void init_mytype(struct mytype *mt);
>         void init_mytype(struct mytype *mt)
>         {
>                 mt->foo = (int *)mt;
>                 mt->foo = (void *)mt;
>                 mt->foo = (int *)0;
>                 mt->foo = (void *)0;
>                 mt->foo = (void *)(long)0;
>         }
>
> It fail at " ... = (... *)1;" though.
>
>
> +               type = insn_symbol_type(fn->module, insn);
> +               switch (LLVMGetTypeKind(type)) {
> +               case LLVMPointerTypeKind:
> +                       assert(!pseudo->value);
> +                       result = LLVMConstPointerNull(type);
> +                       break;
> +               case LLVMIntegerTypeKind:
> +                       result = LLVMConstInt(type, pseudo->value, 1);
> +                       break;
> +               default:
> +                       assert(0);
> +               }

Following modified version should handle values than 0.

  LLVMTypeRef type = insn_symbol_type(fn->module, insn);
  switch (LLVMGetTypeKind(type)) {
  case LLVMPointerTypeKind:
   if (pseudo->value == 0)
    result = LLVMConstPointerNull(type);
   else
    result = LLVMConstIntToPtr(LLVMConstInt(LLVMIntType(bits_in_pointer),
pseudo->value, 1), type);
   break;
  case LLVMIntegerTypeKind:
   result = LLVMConstInt(type, pseudo->value, 1);
   break;
  default:
   assert(0);
  }

Regards
Dibyendu
