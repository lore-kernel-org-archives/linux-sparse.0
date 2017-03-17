From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [RFC v0 0/4] Give a type to constants, considered harmful
Date: Fri, 17 Mar 2017 11:03:49 +0000
Message-ID: <CACXZuxcfGzSFvvdE9nGZmKbcMKTOi=CWJDTOFC3QLbawCqZbBQ@mail.gmail.com>
References: <20170311154725.87906-1-luc.vanoostenryck@gmail.com>
 <20170312203040.erc4n2iollen2274@macpro.local> <CACXZuxd=G7mMX2msGh6TuQMgDYkM3G6H5O2Yab6MWbWPJmWtKA@mail.gmail.com>
 <20170316172001.zyn7fu6ig4aoyez5@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:38306 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbdCQLMc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 17 Mar 2017 07:12:32 -0400
Received: by mail-it0-f43.google.com with SMTP id m27so21122264iti.1
        for <linux-sparse@vger.kernel.org>; Fri, 17 Mar 2017 04:10:44 -0700 (PDT)
In-Reply-To: <20170316172001.zyn7fu6ig4aoyez5@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

Hi Luc,

On 16 March 2017 at 17:20, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sun, Mar 12, 2017 at 10:25:48PM +0000, Dibyendu Majumdar wrote:
>> On 12 March 2017 at 20:30, Luc Van Oostenryck <luc.vanoostenryck@gmail.com> wrote:
>> > I have begun to try to make use of this and I'm now convinced
>> > that this direction is not a viable solution for sparse.
>> >
>> > Sparse's IR is slightly lower-level that LLVM's IR, more close
>> > to what a real CPU would do. This can already be seen at some
>> > instructions (nothing like GEP in sparse), the real difference
>> > is less obvious but it's heer that things begin to hurt.
>> > Indeed, sparse's CPU-like model implies that values are typeless
>> > but have a size and sparse's CSE and simplification is heavily
>> > based on this.
>> > Once you try to add and maintain complete and correct typing to
>> > sparse's instructions so that they can be used easily by sparse-llvm
>> > you realize that:
>> > - you need to add a lot more casts
>> > - you need to change CSE to make things equivalent only if they
>> >   have the same type
>> > - a lot of simplifications are wrong, some can be corrected by adding
>> >   even more casts.
>> >
>> > So, while I'm very fine to add typing info where it was missing,
>> > I have no interest in making the simplifications more complex and
>> > of lesser quality.
>> >
>>
>> I do not know / understand enough to comment on this but I find that
>> your patches are working well for sparse-llvm.
>
> Yes, sure. This fixes a number of issues regarding sparse-llvm and
> more importantly it gives opportinities for even more fixes.
>
> But if you look at patch 4/4, you can see that I already had to
> restrict equivalent (for Common Subexpression Elimination)
> PSEUDO_VAL to those of the same type. That's annoying.
>
> Once you take the simplifications in account, you realize that a
> pseudo that had one type before simplification become of another
> type after simplification. This is more annoying but yes fixable
> with a cost.
>
> And in general, the simplifications we do destroy the exact (C) types.
> From what I've seen there is no way we can keep the full types and
> do the simplifications we do.
>
> So, even giving the correct types to the instructions that missed
> them is useless once you do the CSE and the simplifications.
> Which is perfectly logical, once the types have been validated
> why would the IR instructions mind that the value is 'int' or 'long'
> if both have the same size, same with a plain 'int' and a 'const int'?
> Same with addresses of object of different types.
>
> After all, LLVM also don't care much about primitive types, integers
> also are not typed, just their size matter (and the information about
> the size is carried by the instruction). It's only for pointers that
> LLVM care about the size.
>
>> In particular without
>> the type information in constants, I cannot see how variadic functions
>> can be called correctly.
>
> Yes, variadic called with constants is an 'interesting' case.
> But here also, it's not the the type that is needed for correctness,
> it's only the size.
>
>> If the changes done so far haven't broken anything then perhaps they
>> can be left in?
>
> I'll of course do my best to keep as much as possible.
>
> For sparse-llvm, I haven't thought a lot about it, partly because
> I'm not interested in it, but I think there is two possibilities
> for it to be correct and complete:
> 1) ignore as much typing as possible, including casting pointers
>    to integer of the right size (wich will emiminate all issues with
>    GEP and pointer arithmetic, and only casting them back to pointers
>    for loads & stores.
> 2) bypass the CSE & simplification (and possibly using LLVM's
>    optimization phases).
>

Thank you for the detailed explanation of issues. I agree that there
is a mismatch of levels in the sparse linearized IR which is low level
and the LLVM IR which is somewhat higher level. It is still possible
to make sparse-llvm work by essentially casting most results to the
expected type. If for PSEUDO_VALs we had the size information only -
that would help because all we need is the size to ensure that the
value is passed correctly during a function call in the variadic
function case.

The downside of the approach required in sparse-llvm is that LLVM will
not be able to perform many of its optimisations which require
additional type based metadata.

Once the sparse-llvm implementation works correctly for real life
complex programs, I hope to start work on a different backend using
'nanojit'. The nanojit IR is close to sparse IR, except there are no
phi nodes. But we convert phis to stack variables in sparse-llvm
anyway so this approach will translate well. 'nanojit' is very small
JIT - much less capable than LLVM but at the same time, better as a
JIT engine due to speed of compilation and compactness.

Thanks and Regards
Dibyendu
