From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2 2/2] fix: give a type to bad cond expr with known condition
Date: Fri, 4 Aug 2017 15:50:26 -0400
Message-ID: <CANeU7QkEx2cqKe4j8Bmf=rKTSOxPAhudxdbF9g-x-4tBFuzjwQ@mail.gmail.com>
References: <20170804160622.18260-1-luc.vanoostenryck@gmail.com> <20170804160622.18260-3-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34034 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbdHDTu1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 15:50:27 -0400
Received: by mail-pf0-f193.google.com with SMTP id t86so2716152pfe.1
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 12:50:27 -0700 (PDT)
In-Reply-To: <20170804160622.18260-3-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Aug 4, 2017 at 12:06 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Conditional expressions whose second & third operands
> have non-compatible types are not conform to the C standard
> and sparse emit a warning for them and return the expression
> as being erroneous. In consequence, such expressions are not
> given a type. This, in turn, makes that some further processing
> cannot be done (correctly).
>
> It seems that neither GCC nor clang emit a warning when
> there is a type mismatch but the condition is a constant.
>
> In the case we're interested here (the slow compilation of a file)
> the operation that cannot be done is the expansion its operands.
> This, in turn and among other things, makes that builtins like
> __builtin_constant_p() are not evaluated with disatrous consequence
> for the amount of work done in the next phases.
>
> Fix this by giving to conditional expressions with constant
> condition the same type as the operand selected by the conditional
> (but keeping the warning) as GCC & clang seems to do.

Looks good to me.

Chris
