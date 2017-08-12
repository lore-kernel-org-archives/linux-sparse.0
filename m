From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v4 2/9] Remove single-store shortcut
Date: Sat, 12 Aug 2017 21:28:18 +0200
Message-ID: <CAExDi1Q6XXfLuV8deQVH_d+hni_z7azQsKOBdNDG976R_qQs8A@mail.gmail.com>
References: <CANeU7Qk99kn3etn8yoEKKFzcW15wHjt7OYPSpZhqCDc4DE3EDQ@mail.gmail.com>
 <20170809193806.30975-1-luc.vanoostenryck@gmail.com> <20170809193806.30975-3-luc.vanoostenryck@gmail.com>
 <CACXZuxejN5zBn4NN7XXmGhM26NJMiGAutW7+csb7kVPjWZRVLg@mail.gmail.com>
 <CAMHZB6FFs-SMSLr3awsHB+k1CTwwezrtbidS2bOMKJ1F2j_jng@mail.gmail.com>
 <CACXZuxc053p7yxDa_Y=tXxt+J4bLikiKjQU0us=_b27EHV1CFg@mail.gmail.com>
 <CAExDi1TU1VN19NiUZOnEj+Dis0AuqA9eNFXnZVZ86L10OkSBWw@mail.gmail.com>
 <CACXZuxdyWs8WJ7JKwZQRiO133UcnXe-y4ZXttqJh54A2cf87YQ@mail.gmail.com>
 <CAMHZB6FL65PKYr=QmLaKCF=saQ2eTSz-DQ+wfiebM0pKLFwAqQ@mail.gmail.com> <CACXZuxfz97mUr3U9yO3y23ePGozkmTPGOYuttzgeDta8iGACww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:33653 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbdHLT2T (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 12 Aug 2017 15:28:19 -0400
Received: by mail-oi0-f54.google.com with SMTP id f11so57697579oic.0
        for <linux-sparse@vger.kernel.org>; Sat, 12 Aug 2017 12:28:19 -0700 (PDT)
In-Reply-To: <CACXZuxfz97mUr3U9yO3y23ePGozkmTPGOYuttzgeDta8iGACww@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Sat, Aug 12, 2017 at 8:51 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> ..., I would like to try out your new SSA construction approach.
> Please let me know if this is complete (i.e. functional).

It's more than simply functional, it seems to work pretty well:
- it passes the testsuite
- it doesn't crash while using it on the kernel or any of my tests
  (I have plenty of tests I can't upstream or doesn't make sense
  to be upstreamed)
- the generated code handle correctly the placement of phi-nodes
- the generated code handle correctly undefined vars/pseudos
- it's a bit faster than the current sparse and use less memory

But:
- it needs more testing
- code needs some polish here & there
- it's not a panacea for all current issues.

In my opinion, it's a HUGE step forward.

> I had a look
> at the branch above, but not all commits appeared to be related to the
> SSA construction, so any pointer to the list of changes I should pick
> would be very helpful.

True, the first commits are some small improvement, bug fixes or
even optimization fixes I need for testing during development.

Currently, I'm busy to aggregate the others changes, the LLVM ones
and friends. There are a few merge conflicts to solve but not much.
The next step will be to make the SSA more usable.

-- Luc
