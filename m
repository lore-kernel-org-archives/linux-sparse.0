From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Potential issue with handling of va_arg()
Date: Fri, 31 Mar 2017 15:34:24 +0100
Message-ID: <CACXZuxe5wXPPQ8bCfmg1DeaqsC=L3SwZVY=pjisswNJEMcQzMQ@mail.gmail.com>
References: <CACXZuxcVfKc914gx8Bj=eYsT1fS46hG8BfvBQK5Kthhk+yjeDA@mail.gmail.com>
 <CACXZuxeBMkbp3zTpsFFdMXsuW+ea2z+HKNFAMdSbiuEcF-hvfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:35793 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754861AbdCaOe0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 31 Mar 2017 10:34:26 -0400
Received: by mail-io0-f181.google.com with SMTP id z13so40840847iof.2
        for <linux-sparse@vger.kernel.org>; Fri, 31 Mar 2017 07:34:25 -0700 (PDT)
In-Reply-To: <CACXZuxeBMkbp3zTpsFFdMXsuW+ea2z+HKNFAMdSbiuEcF-hvfg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

On 31 March 2017 at 15:06, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> On 31 March 2017 at 14:47, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
>> I am investigating a failure in this test:
>>
>> #include <stdarg.h>
>> #include <stdlib.h>
>> #include <stdio.h>
>>
>> void error_message(const char *fmt, ...) {
>> va_list argp;
>> va_start(argp, fmt);
>> vfprintf(stdout, fmt, argp);
>> va_end(argp);
>> }
>>
>> int main(void)
>> {
>> error_message("%s\n", "hello world");
>> return 0;
>> }
>>
>>
>> The linearized output for error_message() is:
>>
>> rror_message:
>> .L0:
>> <entry-point>
>> store.64    %arg1 -> 0[fmt]
>> cast.64     %r2 <- (64) fmt
>> load.64     %r3 <- 0[stdout]
>> call.32     %r6 <- vfprintf, %r3, %arg1, %r2
>> ret
>>
>> Above seems incorrect to me, as %r2 should be pointing to [8]fmt presumably?
>>
>
> I think this might be because the macro __builtin_va_start() is being
> defined in sparse but this doesn't match what gets defined by gcc? I
> see this in sparse:
>
> #define __builtin_va_start(a,b) ((a) = (__builtin_va_list)(&(b)))
>
> but if I run above code through gcc then preprocessed output says:
>
> __builtin_va_start(argp, fmt);
>

And it also seems that LLVM provides special instructions and
intrinsics for variable argument handling:

http://llvm.org/docs/LangRef.html#int-varargs

I don't know how to fix this issue as it appears that there is
OP_VAARG instruction in sparse but this is not implemented/output?

Thanks and Regards
Dibyendu
