From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v4 2/9] Remove single-store shortcut
Date: Thu, 10 Aug 2017 01:15:34 +0200
Message-ID: <CAExDi1TU1VN19NiUZOnEj+Dis0AuqA9eNFXnZVZ86L10OkSBWw@mail.gmail.com>
References: <CANeU7Qk99kn3etn8yoEKKFzcW15wHjt7OYPSpZhqCDc4DE3EDQ@mail.gmail.com>
 <20170809193806.30975-1-luc.vanoostenryck@gmail.com> <20170809193806.30975-3-luc.vanoostenryck@gmail.com>
 <CACXZuxejN5zBn4NN7XXmGhM26NJMiGAutW7+csb7kVPjWZRVLg@mail.gmail.com>
 <CAMHZB6FFs-SMSLr3awsHB+k1CTwwezrtbidS2bOMKJ1F2j_jng@mail.gmail.com> <CACXZuxc053p7yxDa_Y=tXxt+J4bLikiKjQU0us=_b27EHV1CFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:35258 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbdHIXPf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 19:15:35 -0400
Received: by mail-oi0-f53.google.com with SMTP id e124so75837612oig.2
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 16:15:35 -0700 (PDT)
In-Reply-To: <CACXZuxc053p7yxDa_Y=tXxt+J4bLikiKjQU0us=_b27EHV1CFg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Thu, Aug 10, 2017 at 12:23 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> Thank you. I am trying out this change as I am hoping it will help
> avoid the incorrect simplifications we saw in some cases. So far my
> findings are:
>
> It solves the bit field access issue: i.e. this test works
> (https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/set1/onebit.c).

Yes, it's the one I used for the patches.

> But it doesn't help with the issue with pseudos defined in one branch
> of the code (https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/bugs/simplifybug.c).
>
> Is there another fix / patch that you made to overcome above issue or
> would you expect both issues to be fixed by this change?

I don't know exactly what you have as problem with this other test.
I quickly looked at the output of test-linearize and I saw no problem
with self-defined pseudos. The phi-nodes are very wrong though but that's
another problem.

You may try the new SSA construction at :
   https://github.com/lucvoo/sparse/tree/sssa
It will help a lot.

But in both case, I saw that sparse-llvm crashes
(which is normal as none of the LLVM fixes are applied here).

In the coming days, I'll do a branch that aggregates all the good stuff.

But until then, can you explain exactly what is wrong with this second test?

> I will run my test cases with this change and report if anything breaks.

Thanks.
Testing in other environments, with other goals, is very useful.

-- Luc
