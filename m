From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v5 04/14] rewrite compare_opcode() like swap_compare_opcode()
Date: Sat, 25 Mar 2017 00:54:21 +0100
Message-ID: <CAMHZB6Fb2Zjpr720P88RPCe-TBtak0G9qiBAiTk0eLpeFCV31g@mail.gmail.com>
References: <20170324231421.14869-1-luc.vanoostenryck@gmail.com>
 <20170324231421.14869-5-luc.vanoostenryck@gmail.com> <CA+55aFzgt9iAKQqNzBPDFT=kTL9sP=OyjsQOJ+mxuJYQRwPQkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35327 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbdCXXyX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:54:23 -0400
Received: by mail-qk0-f172.google.com with SMTP id v127so3864955qkb.2
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:54:22 -0700 (PDT)
In-Reply-To: <CA+55aFzgt9iAKQqNzBPDFT=kTL9sP=OyjsQOJ+mxuJYQRwPQkg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Sat, Mar 25, 2017 at 12:24 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Mar 24, 2017 at 4:14 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> More precisely, use a table to get the opcdoe corresponding
>> to the negated compare and use a more explicit name for the
>> function.
>
> Side note: this code should verify that it doesn't operate on a
> floating point compare.
>
> You can't negate a FP compare, because the negation doesn't
> necessarily have the opposite value.
>
> For example, "a < b" is *not* the same as "!(a >= b)" for floating
> point values when one of them is a NaN. Both < and >= will compare as
> false, so "negating" the op won't actually negate the resulting
> logical operation.
>
>              Linus

Yes, indeed.
I've some plan to add better handling of floating-point and the compare
is part of it. It'll need a new set of instructions to do it correctly
(precisely
because for fp numbers once you care about NaNs/unordered "a < b" is *not*
the same as "!(a >= b)").
But there is also a number of bugs I want to solve, especially one related to
the misplacement of phi-node and another about missing reloads. For the moment
I think we can pretend that all the fp values we deal with are ordered ones.

-- Luc
