From: Van Oostenryck Luc <luc.vanoostenryck@gmail.com>
Subject: Re: Output from linearize and LLVM error
Date: Fri, 27 Jan 2017 16:59:30 +0100
Message-ID: <CAExDi1SVaW1ZrcGZLHS+2T22zaAEiMKiNVzVnX4PdgurwoizXA@mail.gmail.com>
References: <CACXZuxdM0zwfubUxHTJDen456-y9cpgpQJBcB8gKoXYtX5baSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33112 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932195AbdA0QAF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Jan 2017 11:00:05 -0500
Received: by mail-qt0-f193.google.com with SMTP id n13so46759541qtc.0
        for <linux-sparse@vger.kernel.org>; Fri, 27 Jan 2017 07:59:36 -0800 (PST)
In-Reply-To: <CACXZuxdM0zwfubUxHTJDen456-y9cpgpQJBcB8gKoXYtX5baSA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: linux-sparse@vger.kernel.org

On Fri, Jan 27, 2017 at 3:00 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi
> I am investigating some assertion failures I am getting from LLVM when
> trying to compile some test code. Following is a simple test program
> that is failing.
>
> typedef unsigned long long size_t;
> extern void *malloc(size_t);
> struct foo {
>         int i;
> };
> typedef struct foo foo;
> foo*  testfunc(void);
> foo* testfunc(void) {
>         foo *p = (foo *) malloc(sizeof(struct foo));
>         return p;
> }
>
> There were two failures. First one occurs in the result of the
> sizeof() expression - it seems the builder tries to create an integer
> constant but passes LLVM a 'char *' as the type, which causes an
> assertion failure in LLVM. This error occurs in pseudo_to_value()
> function in sparse-llvm.c for the case PSEUDO_VAL. I worked around
> this by checking if the type is a pointer and then asking LLVM to
> create an integer constant of appropriate size (not sure why the type
> is a pointer type here).
>
> Here is the output from test-linearize:
>
> testfunc:
> .L0x7ffae85d1010:
>  <entry-point>
>  call.64     %r1 <- malloc, $4
>  cast.64     %r2 <- (64) %r1
>  ret.64      %r2
>
> The second LLVM assertion failure occurs in the cast to (64).
>
> My question is this - does this cast look correct? Should it not be a
> pointer cast rather than an integer cast?

I think both problems are already addressed but the patches haven't
yet been handled.

You may look at:
- https://patchwork.kernel.org/patch/9469701/
- https://patchwork.kernel.org/patch/9516077/

> Also the output from test-linearize and test-parsing do not seem to
> dump the types. How can I get the types dumped out as well?

Yes, it's sometimes annoying.
Generaly, I when I need this, I add a few printf( .... show_typename(sym))

Regards,
Luc Van Oostenryck
