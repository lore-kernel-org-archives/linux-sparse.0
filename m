From: Christopher Li <sparse@chrisli.org>
Subject: Re: Question about Sparse Linear form and pseudos
Date: Sun, 20 Aug 2017 11:44:42 -0400
Message-ID: <CANeU7Qm5nqDNKy05+iZMKtDiBKMueqfnqsw+b6BVysMQBP-eLQ@mail.gmail.com>
References: <CACXZuxd4iKbuvZZ5M0q=xRRDMpxc5UjXp=4+vBjvF8rjdV4-=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:33914 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753039AbdHTPon (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Aug 2017 11:44:43 -0400
Received: by mail-yw0-f179.google.com with SMTP id s143so80472184ywg.1
        for <linux-sparse@vger.kernel.org>; Sun, 20 Aug 2017 08:44:42 -0700 (PDT)
In-Reply-To: <CACXZuxd4iKbuvZZ5M0q=xRRDMpxc5UjXp=4+vBjvF8rjdV4-=A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 20, 2017 at 10:54 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi,
>
> I am trying to get to grips with the Sparse Linear format and the use
> of pseudos.
>
> 1) A Sparse document says that pseudos are akin to SSA variables. Is
> that a true statement - i.e. do pseudos follow the discipline that
> only one assignment to a pseudo is allowed. As pseudos have also
> different sub-types - does this statement apply to all pseudo types or
> only some sub types?

The pseudo should be SSA, it apply to all types of pseudo.
You can thing of pseudos are similar to LLVM virtual registers.

>
> 2) In a recent conversation it was stated that the baseline Linear
> output from Sparse is already in SSA form. That implies that all
> pseudos used are in SSA form already. However we know that in the
> baseline line IR phi nodes may not be present. In LLVM the initial IR
> lacks phi nodes too - instead local stack memory and load/store
> sequences are used. However LLVM IR is still SSA at this stage. When
> it is said that the baseline Linear IR is already SSA is it in this
> sense?

There are two different things happen here. For the IR that is
generated from linearizing, without the simplification, all the pseudo
is already SSA. It does not need phi node because all the internal
usage of the pseudo already dominated by the pseudo defines.

There is a separate phase, in simplify symbol access, will try to promote
the memory load/store into the SSA pseudo registers. That is where
the phi nodes come it.

LLVM is similar in that regard. The very first batch of the byte code
contain raw load/store on memory variables. You will not see the SSA
on the memory variable. Then there is a pass call "promote memory
to scalar". In this pass it will convert the memory access into SSA
virtual registers.

Chris
