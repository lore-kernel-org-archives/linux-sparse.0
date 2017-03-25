From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v5 04/14] rewrite compare_opcode() like swap_compare_opcode()
Date: Sat, 25 Mar 2017 16:35:39 -0700
Message-ID: <CANeU7Qm_6_PtvOE=WpubgPgyo7SSGXvX3j8rq5m4UzR1EiHxQQ@mail.gmail.com>
References: <20170324231421.14869-1-luc.vanoostenryck@gmail.com>
 <20170324231421.14869-5-luc.vanoostenryck@gmail.com> <CA+55aFzgt9iAKQqNzBPDFT=kTL9sP=OyjsQOJ+mxuJYQRwPQkg@mail.gmail.com>
 <CAMHZB6Fb2Zjpr720P88RPCe-TBtak0G9qiBAiTk0eLpeFCV31g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:37300 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751205AbdCYXf4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 25 Mar 2017 19:35:56 -0400
Received: by mail-it0-f46.google.com with SMTP id 190so21558773itm.0
        for <linux-sparse@vger.kernel.org>; Sat, 25 Mar 2017 16:35:50 -0700 (PDT)
In-Reply-To: <CAMHZB6Fb2Zjpr720P88RPCe-TBtak0G9qiBAiTk0eLpeFCV31g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Fri, Mar 24, 2017 at 4:54 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Yes, indeed.
> I've some plan to add better handling of floating-point and the compare
> is part of it. It'll need a new set of instructions to do it correctly
> (precisely
> because for fp numbers once you care about NaNs/unordered "a < b" is *not*
> the same as "!(a >= b)").
> But there is also a number of bugs I want to solve, especially one related to
> the misplacement of phi-node and another about missing reloads. For the moment
> I think we can pretend that all the fp values we deal with are ordered ones.

Can we detect it is the floating point type then avoid doing the
compare swap for
floating point?

Chris
