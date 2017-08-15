From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC] sparse SSA construction
Date: Tue, 15 Aug 2017 09:59:30 -0400
Message-ID: <CANeU7Qk9C-78+-a2TOGUWiLof9S_p9vO6bHyNf6xZqZ5X1CoUQ@mail.gmail.com>
References: <20170806202651.8763-1-luc.vanoostenryck@gmail.com> <CACXZuxchKzgv_cN7MzZnT09OX1thdODoinqSVzK8jSxdPCVK8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:34587 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbdHON7b (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 15 Aug 2017 09:59:31 -0400
Received: by mail-yw0-f176.google.com with SMTP id s143so5157665ywg.1
        for <linux-sparse@vger.kernel.org>; Tue, 15 Aug 2017 06:59:31 -0700 (PDT)
In-Reply-To: <CACXZuxchKzgv_cN7MzZnT09OX1thdODoinqSVzK8jSxdPCVK8w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Aug 15, 2017 at 9:41 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>> I don't feel it's needed to patchbomb the ML for the moment
>> so I'll only give the URL to the repo:
>>
>>   git://github.com/lucvoo/sparse.git sssa
>
> I have merged the new SSA implementation in your sssa-mini-clean
> branch - which I understand is minimal set of changes needed for the
> new SSA on top of RC5 - into my project dmrC.
>
> I have been testing the changes  - and so far I am pleased to report
> that after a small set of changes (described below) - all my existing
> tests pass.
>

Thanks for the report and testing.

> a) I had to disallow struct / union types from being treated as simple types.
> b) I am setting UNDEF pseudos a value of 0 in LLVM backend - this is
> to ensure I can do the same in other backends.
> c) I found that CBR instructions can get a PSEUDO_VAL as the condition
> which was not being handled correctly in my version of LLVM backend.
> Somehow this did not occur in the past so I am not yet sure how this
> is related to the changes.
>
> The new implementation does not appear to suffer from the performance
> degradation we saw after removing the single store shortcut.

That is good to hear. With the shortcut removed, sparse actually suffer
a lot of finding store/load domination for large graphs. The recursive
way of finding domination has no cache acceleration at all.
There is a lot of room to improvement.


>
> Finally the new code seems simpler and elegant. I would suggest adding
> some comments in ssa.c - perhaps copy the pseudo code from the paper
> it is based on - to better explain what is going on.

Yes, I think that is helpful. I am reading the paper right now.

This ssa conversion will need to break into smaller piece for review
and merge. The general recommended number of patch for the first
round is 15 or so at a time in the Linux kernel submmitting-patches.rst
documentation.


Chris
