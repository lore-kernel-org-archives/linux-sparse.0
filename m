From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 07/13] llvm: fix output OP_ADD mixed with pointers
Date: Mon, 6 Mar 2017 10:17:35 -0800
Message-ID: <CA+55aFx=R=Z2jrTQhT2o4oA-it+sQjKT097zMgPhgKFp0byPFw@mail.gmail.com>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
 <20170305112047.3411-8-luc.vanoostenryck@gmail.com> <CANeU7Qk6xjhNPVZWxTB4iOavH5=bha+a_utz7+PJuSTo1WKgOg@mail.gmail.com>
 <CACXZuxfX0TiYGJDewbRW9Tr3-nzqiBrdOK0K+mO0qqwyGCrjSQ@mail.gmail.com>
 <CANeU7Q=Y7mx501ZAvXesWCL_C92RsjQvFNJ_4dLvUeOg2chFhg@mail.gmail.com> <20170306164306.hibukuy2t4j4camh@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:37360 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753330AbdCFTXA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Mar 2017 14:23:00 -0500
Received: by mail-it0-f49.google.com with SMTP id 203so57080309ith.0
        for <linux-sparse@vger.kernel.org>; Mon, 06 Mar 2017 11:22:59 -0800 (PST)
In-Reply-To: <20170306164306.hibukuy2t4j4camh@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Mar 6, 2017 at 8:43 AM, Luc Van Oostenryck
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

This is correct.

> == LLVM code from sparse-llvm ==
>
>         define i8* @foo(i32* %ARG1) {
>         L0:
>           %0 = getelementptr i32, i32* %ARG1, inttoptr (i64 20 to i32*)
>           %R3 = bitcast i32* %0 to i8*

This is garbage, I'm afraid.

When sparse does the "add 20 to pointer", it adds the *byte offset* 20
to the pointer. The LLVM module should not use "getelementptr" for
this, because it's not element #20, it's the element at offset 20.

I think you're supposed to either use "uglygep" with the base pointer
cast to a simple address-unit pointer (ie unsigned char).

Or not use GEP at all.

                Linus
