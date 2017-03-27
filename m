From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v5 04/14] rewrite compare_opcode() like
 swap_compare_opcode()
Date: Mon, 27 Mar 2017 18:29:09 +0200
Message-ID: <20170327162909.zvdl4ohcicprbdlm@macpro.local>
References: <20170324231421.14869-1-luc.vanoostenryck@gmail.com>
 <20170324231421.14869-5-luc.vanoostenryck@gmail.com>
 <CA+55aFzgt9iAKQqNzBPDFT=kTL9sP=OyjsQOJ+mxuJYQRwPQkg@mail.gmail.com>
 <CAMHZB6Fb2Zjpr720P88RPCe-TBtak0G9qiBAiTk0eLpeFCV31g@mail.gmail.com>
 <CANeU7Qm_6_PtvOE=WpubgPgyo7SSGXvX3j8rq5m4UzR1EiHxQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:36680 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbdC0Q30 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 12:29:26 -0400
Received: by mail-wr0-f170.google.com with SMTP id w11so49677269wrc.3
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 09:29:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Qm_6_PtvOE=WpubgPgyo7SSGXvX3j8rq5m4UzR1EiHxQQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sat, Mar 25, 2017 at 04:35:39PM -0700, Christopher Li wrote:
> On Fri, Mar 24, 2017 at 4:54 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Yes, indeed.
> > I've some plan to add better handling of floating-point and the compare
> > is part of it. It'll need a new set of instructions to do it correctly
> > (precisely
> > because for fp numbers once you care about NaNs/unordered "a < b" is *not*
> > the same as "!(a >= b)").
> > But there is also a number of bugs I want to solve, especially one related to
> > the misplacement of phi-node and another about missing reloads. For the moment
> > I think we can pretend that all the fp values we deal with are ordered ones.
> 
> Can we detect it is the floating point type then avoid doing the
> compare swap for floating point?

We were not talking about the swap here but of the 'negate'
(and the swaping of the operands is immune to the NaNs/unordered).

And in fact, the code which needs the negation of compare's opcode
can't be called with floating-points args as this code is part of
the simplification made when one of the argument is a constant
(and only if the constant is 0 or 1). And by constant we mean here
a PSEUDO_VAL, which can never be part of a floating-point operation.

So in no cases can we have a problem because of that.

-- Luc
