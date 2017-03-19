From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm switch constants must all be same type as switch
 value
Date: Sun, 19 Mar 2017 01:52:46 +0100
Message-ID: <20170319005245.os6jl436ajvqiyud@macpro.local>
References: <CACXZuxfOP79gJbOD=02pPYWV4HQbnN0tRVWup77_etBxvhjAAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36952 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbdCSAwv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Mar 2017 20:52:51 -0400
Received: by mail-wm0-f46.google.com with SMTP id n11so40510349wma.0
        for <linux-sparse@vger.kernel.org>; Sat, 18 Mar 2017 17:52:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxfOP79gJbOD=02pPYWV4HQbnN0tRVWup77_etBxvhjAAQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Mar 13, 2017 at 09:24:47PM +0000, Dibyendu Majumdar wrote:
> Hi,
> 
> While investigating errors that occurred when compiling 'minilua' I
> found that the sparse-llvm output for switch statements is hard coded
> to generate int32 values even when the switch is on a different
> integer type. I believe following fix is needed in output_op_switch():
> 
>  FOR_EACH_PTR(insn->multijmp_list, jmp) {
>   if (jmp->begin == jmp->end) {  /* case N */
>    LLVMAddCase(target,
>     LLVMConstInt(LLVMTypeOf(sw_val), jmp->begin, 0),
>     jmp->target->priv);
>   } else if (jmp->begin < jmp->end) { /* case M..N */
>    assert(0);
>   }
>  } END_FOR_EACH_PTR(jmp);

There is also a problem with signed/unsigned constants,
like everywhere else in the code.

Could you submit a test case for this?

-- Luc
