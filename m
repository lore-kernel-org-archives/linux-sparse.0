From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Potential issue with handling of va_arg()
Date: Fri, 31 Mar 2017 15:06:09 +0100
Message-ID: <CACXZuxeBMkbp3zTpsFFdMXsuW+ea2z+HKNFAMdSbiuEcF-hvfg@mail.gmail.com>
References: <CACXZuxcVfKc914gx8Bj=eYsT1fS46hG8BfvBQK5Kthhk+yjeDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:33943 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754676AbdCaOGL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 31 Mar 2017 10:06:11 -0400
Received: by mail-it0-f44.google.com with SMTP id y18so6211668itc.1
        for <linux-sparse@vger.kernel.org>; Fri, 31 Mar 2017 07:06:10 -0700 (PDT)
In-Reply-To: <CACXZuxcVfKc914gx8Bj=eYsT1fS46hG8BfvBQK5Kthhk+yjeDA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

On 31 March 2017 at 14:47, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> I am investigating a failure in this test:
>
> #include <stdarg.h>
> #include <stdlib.h>
> #include <stdio.h>
>
> void error_message(const char *fmt, ...) {
> va_list argp;
> va_start(argp, fmt);
> vfprintf(stdout, fmt, argp);
> va_end(argp);
> }
>
> int main(void)
> {
> error_message("%s\n", "hello world");
> return 0;
> }
>
>
> The linearized output for error_message() is:
>
> rror_message:
> .L0:
> <entry-point>
> store.64    %arg1 -> 0[fmt]
> cast.64     %r2 <- (64) fmt
> load.64     %r3 <- 0[stdout]
> call.32     %r6 <- vfprintf, %r3, %arg1, %r2
> ret
>
> Above seems incorrect to me, as %r2 should be pointing to [8]fmt presumably?
>

I think this might be because the macro __builtin_va_start() is being
defined in sparse but this doesn't match what gets defined by gcc? I
see this in sparse:

#define __builtin_va_start(a,b) ((a) = (__builtin_va_list)(&(b)))

but if I run above code through gcc then preprocessed output says:

__builtin_va_start(argp, fmt);

Thanks and Regards
Dibyendu
