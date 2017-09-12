From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Some thoughts on the SSA debate
Date: Tue, 12 Sep 2017 11:06:30 +0100
Message-ID: <CACXZuxdtwsp=YXN_4q5Ox=6R6fKdz-6kLUcTYskJcwd6qvh5DQ@mail.gmail.com>
References: <CACXZuxdGXjyMJAh8CCUUFbLXWaLfLJ121S8UbRp9NbE4B1koZA@mail.gmail.com>
 <20170909020604.5io7kuw6itquzbfp@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f175.google.com ([209.85.217.175]:32898 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751326AbdILKGc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 12 Sep 2017 06:06:32 -0400
Received: by mail-ua0-f175.google.com with SMTP id g47so14511857uad.0
        for <linux-sparse@vger.kernel.org>; Tue, 12 Sep 2017 03:06:31 -0700 (PDT)
In-Reply-To: <20170909020604.5io7kuw6itquzbfp@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

H Luc,

On 9 September 2017 at 03:06, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Fri, Sep 08, 2017 at 11:28:57AM +0100, Dibyendu Majumdar wrote:
>>
>> 1. Firstly I think it is important to retain the existing "pre-phi"
>> linear code. This is fine for backends such as LLVM which do a good
>> job of transforming code anyway. It is also usually less buggy and
>> serves as a baseline for correctness. So after careful consideration I
>> would vote against adding phi instructions in the initial phase.
>
> That's forgetting that even with the "old/current" method create
> phi-nodes during linearization:
> - for the return mechanism
> - for some conditionals
>
> This also doesn't really take in account the fact that the SSA form
> is pretty fundamental to sparse (like it's most modern compilers).
>

I do not agree that the phi nodes "must" be present in the initial
linear output. In fact if you look at clang output, initial linear
output has allocas, and loads/stores. Later on these get converted to
phi nodes. As long as the SSA property is maintained, which it is for
Sparse, then this is fine in my view.

I have some practical reasons for it:

a) In the JIT world, we often want fast compilation. I already disable
all subsequent phases, and generate code from the initial linear
output.
b) Introducing phi nodes and then taking them out doesn't help because
it creates extra steps. I haven't yet tried the unssa option yet - I
may have a look at this at some point.
c) As both LLVM backend and my new backend use load/stores and allocas
anyway, the presence of phi nodes just makes the output more
convoluted as I showed earlier.
d) You are right that some phi nodes are output already in the initial
linear output. I would have preferred if this wasn't the case of
course.

Regards
Dibyendu
