From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm results from trying to compile a largish program
Date: Tue, 14 Mar 2017 13:17:31 +0000
Message-ID: <CACXZuxf02DM+spQckV0CyycaY7dqUbuM9wuKNktaRMndvtfpBQ@mail.gmail.com>
References: <CACXZuxdT9fXHnysUFUoMqe+dEuDSKHsQS3Tn8KFEfAP2cnAnJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:37994 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751773AbdCNNRj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 14 Mar 2017 09:17:39 -0400
Received: by mail-it0-f45.google.com with SMTP id m27so50863156iti.1
        for <linux-sparse@vger.kernel.org>; Tue, 14 Mar 2017 06:17:38 -0700 (PDT)
In-Reply-To: <CACXZuxdT9fXHnysUFUoMqe+dEuDSKHsQS3Tn8KFEfAP2cnAnJA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

On 13 March 2017 at 19:34, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> I tried to compile a Lua implementation using sparse-llvm. This
> particular implementation is called 'minilua' as it is a cut down
> version of Lua 5.1.5 created by Mike Pall for the LuaJIT project.
>
> I had to change all static initializations of course as these are
> unsupported in sparse-llvm. I also had to add support for casting
> floating point values to integer type in 'op_cast' implementation.
>
> sparse-llvm managed to consume the program after these changes but
> there were many LLVM errors reported, which indicates that the
> generated code is incorrect.
>
> I have saved the results from this exercise here:
>
> https://github.com/dibyendumajumdar/dmr_c/tree/master/tests/minilua
>
> Hopefully this will help in analysing the errors and deciding how to fix them.
>

I have fixed a bunch of issues in my repository - and the updated
error list now is much reduced! Please see the link above for the
remaining errors and the generated code.

Thanks and Regards
Dibyendu
