From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Question about Sparse Linear form and pseudos
Date: Sun, 20 Aug 2017 17:18:56 +0100
Message-ID: <CACXZuxf7jN5JTPhDbgDPPW-7wtWAQG5-4Ec0x9U4Y3Cv3ofZnw@mail.gmail.com>
References: <CACXZuxd4iKbuvZZ5M0q=xRRDMpxc5UjXp=4+vBjvF8rjdV4-=A@mail.gmail.com>
 <CANeU7Qm5nqDNKy05+iZMKtDiBKMueqfnqsw+b6BVysMQBP-eLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f170.google.com ([209.85.217.170]:34630 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753101AbdHTQS5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Aug 2017 12:18:57 -0400
Received: by mail-ua0-f170.google.com with SMTP id i3so19846248uad.1
        for <linux-sparse@vger.kernel.org>; Sun, 20 Aug 2017 09:18:57 -0700 (PDT)
In-Reply-To: <CANeU7Qm5nqDNKy05+iZMKtDiBKMueqfnqsw+b6BVysMQBP-eLQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

On 20 August 2017 at 16:44, Christopher Li <sparse@chrisli.org> wrote:
> On Sun, Aug 20, 2017 at 10:54 AM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>> I am trying to get to grips with the Sparse Linear format and the use
>> of pseudos.
>>
>> 1) A Sparse document says that pseudos are akin to SSA variables. Is
>> that a true statement - i.e. do pseudos follow the discipline that
>> only one assignment to a pseudo is allowed. As pseudos have also
>> different sub-types - does this statement apply to all pseudo types or
>> only some sub types?
>
> The pseudo should be SSA, it apply to all types of pseudo.
> You can thing of pseudos are similar to LLVM virtual registers.
>

I am wondering if this is true - please see my reply to Luc. In
particular it seems that stores to local variables are represented by
PSEUDO_SYMs and multiple assignments can occur to these. Hence the
PSEUDO_SYMs and probably PSEUDO_ARGs too are not SSA?

>>
>> 2) In a recent conversation it was stated that the baseline Linear
>> output from Sparse is already in SSA form. That implies that all
>> pseudos used are in SSA form already. However we know that in the
>> baseline line IR phi nodes may not be present. In LLVM the initial IR
>> lacks phi nodes too - instead local stack memory and load/store
>> sequences are used. However LLVM IR is still SSA at this stage. When
>> it is said that the baseline Linear IR is already SSA is it in this
>> sense?
>
> There are two different things happen here. For the IR that is
> generated from linearizing, without the simplification, all the pseudo
> is already SSA. It does not need phi node because all the internal
> usage of the pseudo already dominated by the pseudo defines.
>
> There is a separate phase, in simplify symbol access, will try to promote
> the memory load/store into the SSA pseudo registers. That is where
> the phi nodes come it.
>
> LLVM is similar in that regard. The very first batch of the byte code
> contain raw load/store on memory variables. You will not see the SSA
> on the memory variable. Then there is a pass call "promote memory
> to scalar". In this pass it will convert the memory access into SSA
> virtual registers.
>

Agreed - however there is one difference it seems. LLVM explicits
outputs alloca instructions for each memory location - and then does
store/load on these. In Sparse though, a sub type of pseudo -
PSEUDO_SYM is used for the same, right?

Regards
Dibyendu
