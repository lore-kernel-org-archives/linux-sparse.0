From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm issue with counter in a loop
Date: Sat, 11 Mar 2017 22:38:07 +0000
Message-ID: <CACXZuxdHKLiq-Bp8PWyMeCqphFRUbV6x6hKV80xQ2vkNW-DPqg@mail.gmail.com>
References: <CACXZuxdJXMo6peguA=5CF_3n+6i7gHJ9KLGU4fUuew=8e=ShWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:33359 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754980AbdCKWiJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 17:38:09 -0500
Received: by mail-io0-f171.google.com with SMTP id f84so65548516ioj.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 14:38:08 -0800 (PST)
In-Reply-To: <CACXZuxdJXMo6peguA=5CF_3n+6i7gHJ9KLGU4fUuew=8e=ShWw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

On 11 March 2017 at 22:04, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> I am not sure what is happening here. The test program is:
>
> extern int printf(const char *fmt, ...);
> int main(void) {
>     int Count;
>     for (Count = 0; Count < 4; Count++)
>     {
>         printf("%d\n", Count);
>         switch (Count)
>         {
>         case 1:
>             printf("%d\n", 1);
>             break;
>         case 2:
>             printf("%d\n", 2);
>             break;
>         default:
>             printf("%d\n", 0);
>             break;
>         }
>     }
>     return 0;
> }
>
> The linearized output I get:
>
> main:
> .L0:
>         <entry-point>
>         phisrc.32   %phi4(Count) <- $0
>         br          .L4
> .L4:
>         phi.32      %r1(Count) <- %phi4(Count), %phi5(Count)
>         setlt.32    %r2 <- %r1(Count), $4
>         br          %r2, .L1, .L9
> .L1:
>         symaddr.64  %r3 <- <anon symbol:000001A5682A1E38>
>         call.32     %r5 <- printf, %r3, %r1(Count)
>         switch      %r1(Count), 1 -> .L6, 2 -> .L7, default -> .L8
> .L6:
>         symaddr.64  %r7 <- <anon symbol:000001A5682A21B8>
>         call.32     %r8 <- printf, %r7, $1
>         br          .L2
> .L7:
>         symaddr.64  %r9 <- <anon symbol:000001A5682A2538>
>         call.32     %r10 <- printf, %r9, $2
>         br          .L2
> .L8:
>         symaddr.64  %r11 <- <anon symbol:000001A5682A28B8>
>         call.32     %r12 <- printf, %r11, $0
>         br          .L2
> .L2:
>         add.32      %r14 <- %r1(Count), $1
>         phisrc.32   %phi5(Count) <- %r14
>         br          .L4
> .L9:
>         ret.32      $0
>
>
> In sparse-llvm the instruction:
> add.32      %r14 <- %r1(Count), $1
>
> fails because the type of %r1(Count) is void. I am not sure why the
> type is void here.
>

Looks like the 'void' is coming from this in output_op_switch() in
sparse-llvm.c:

 target = LLVMBuildSwitch(fn->builder, sw_val,
     def ? def->priv : NULL, n_jmp);
...
 insn->target->priv = target;


So this is probably incorrect. Looks like we should not set
insn->target->priv  here as it is already set. Removing the assignment
resolves the issue.
