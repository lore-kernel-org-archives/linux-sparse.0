From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm casts needed on function call arguments and returns
Date: Sun, 19 Mar 2017 16:32:23 +0100
Message-ID: <20170319153222.wihoz27fiw3ospxw@macpro.local>
References: <CACXZuxd79XySoaYR5wckhx3KfQELV-gg5hWyTS5Q5i+=zOh6Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36698 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752004AbdCSPcw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 19 Mar 2017 11:32:52 -0400
Received: by mail-wm0-f42.google.com with SMTP id n11so46855589wma.1
        for <linux-sparse@vger.kernel.org>; Sun, 19 Mar 2017 08:32:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxd79XySoaYR5wckhx3KfQELV-gg5hWyTS5Q5i+=zOh6Fw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 14, 2017 at 10:48:53AM +0000, Dibyendu Majumdar wrote:
> It appears that both function call arguments and returns from
> functions need to be cast to the expected type in sparse-llvm. This
> may be because the linearizer is eliminating casts - I am not sure.

It's one of the cause, yes.
But again, in sparse the type are in the instructions, not in the values.

> From LLVM perspective two pointers to different base types are not the
> same - similarly various integer types and floating types are not
> interchangeable.
> 
> By adding casts to store operations (both op_store and op_phisrc) as
> well as in function call arguments the number of errors I am getting
> when compiling 'minilua' has reduced significantly. However still 192
> errors remain (but hopefully many will go with the next fix!).
> 
> Of course even with all errors being fixed it doesn't mean that the
> generated code is right. Only when I run the program on Lua test suite
> it will become apparent whether the generated code is correct or not.

Things should be greatly improved in the llvm-fixes-v3 serie
I submitted yesterday.

-- Luc
