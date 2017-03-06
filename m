From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 07/13] llvm: fix output OP_ADD mixed with pointers
Date: Tue, 7 Mar 2017 01:07:27 +0800
Message-ID: <CANeU7QnS2_OgvaZo1T+_cfw=ZKFvZEM8dnMet4kfqhTzGWUDHQ@mail.gmail.com>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
 <20170305112047.3411-8-luc.vanoostenryck@gmail.com> <CANeU7Qk6xjhNPVZWxTB4iOavH5=bha+a_utz7+PJuSTo1WKgOg@mail.gmail.com>
 <CACXZuxfX0TiYGJDewbRW9Tr3-nzqiBrdOK0K+mO0qqwyGCrjSQ@mail.gmail.com>
 <CANeU7Q=Y7mx501ZAvXesWCL_C92RsjQvFNJ_4dLvUeOg2chFhg@mail.gmail.com> <20170306164306.hibukuy2t4j4camh@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:33570 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754129AbdCFRH3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Mar 2017 12:07:29 -0500
Received: by mail-io0-f177.google.com with SMTP id f84so116489942ioj.0
        for <linux-sparse@vger.kernel.org>; Mon, 06 Mar 2017 09:07:28 -0800 (PST)
In-Reply-To: <20170306164306.hibukuy2t4j4camh@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 7, 2017 at 12:43 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> With an example:
> == C code ==
>         void *foo(int *p) { return p + 5; }
>
> == linearized code ==
>         foo:
>         .L0:
>                 <entry-point>
>                 add.64      %r2 <- %arg1, $20
>                 cast.64     %r3 <- (64) %r2
>                 ret.64      %r3
>
> == LLVM code from sparse-llvm ==
>         ; ModuleID = '<stdin>'
>         source_filename = "sparse"
>
>         define i8* @foo(i32* %ARG1) {
>         L0:
>           %0 = getelementptr i32, i32* %ARG1, inttoptr (i64 20 to i32*)
>           %R3 = bitcast i32* %0 to i8*
>           ret i8* %R3
>         }
>


OK, good. Let's use this example.
I am using clang to get the llvm bytecode. t.c is your example.

clang -S -emit-llvm /tmp/t.c
Here is output, compare the line I am pointing at:
The indices should be 5 according clang's output.
However sparse-llvm generate as 20 per your output
if I am reading it correctly.

Chris

============== t.ll =====================
 ModuleID = '/tmp/t.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i8* @foo(i32* %p) #0 {
  %1 = alloca i32*, align 8
  store i32* %p, i32** %1, align 8
  %2 = load i32*, i32** %1, align 8
  %3 = getelementptr inbounds i32, i32* %2, i64 5 <======== look here
  %4 = bitcast i32* %3 to i8*
  ret i8* %4
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false"
"less-precise-fpmad"="false" "no-frame-pointer-elim"="true"
"no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false"
"no-nans-fp-math"="false" "stack-protector-buffer-size"="8"
"target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2"
"unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.1 (tags/RELEASE_381/final)"}
================================================
