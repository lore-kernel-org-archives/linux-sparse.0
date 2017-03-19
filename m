From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 00/30] LLVM fixes
Date: Sun, 19 Mar 2017 22:02:40 +0100
Message-ID: <CAExDi1Qy=8ynU-6cMGXXHB85Zv7dDTBZV+dBj=A9-Yy0Q8WS6w@mail.gmail.com>
References: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
 <CANeU7Q=LVUz35hFxdfDUp+vza=xwJP=SHx5F1ApUsLeWLqRraw@mail.gmail.com> <20170319165158.6ufqlyedbs5bdd2w@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33632 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752547AbdCSVLa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 19 Mar 2017 17:11:30 -0400
Received: by mail-qk0-f172.google.com with SMTP id y76so97493589qkb.0
        for <linux-sparse@vger.kernel.org>; Sun, 19 Mar 2017 14:10:29 -0700 (PDT)
In-Reply-To: <20170319165158.6ufqlyedbs5bdd2w@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Sun, Mar 19, 2017 at 5:51 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sun, Mar 19, 2017 at 09:28:31AM -0700, Christopher Li wrote:
>> On Sat, Mar 18, 2017 at 6:41 PM, Luc Van Oostenryck
>> <luc.vanoostenryck@gmail.com> wrote:
>> > This series solves a number of issues in sparse-llvm,
>> > mainly about wrong or missing type information as needed
>> > to build LLVM IR.
>> > Most of these issues have been reported and investigated by
>> > Dibyendu Majumdar.
>>
>>
>> Thanks for the patches.
>>
>> I will take a look and try it on sparse-next.
>
> OK, thanks.
> It seems that you will need to drop patch 2 as a late addition
> of a test case cause a failure of in the test suite (but the code itself
> is OK).
>
> I'll respin the serie later after your review.

Also, don't spend too much time on the part involving
..._rvalue(),_ivalue() & _pvalue() as I'm rewritting this
to make it more generic & systematic.

-- Luc
