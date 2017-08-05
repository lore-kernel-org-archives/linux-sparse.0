From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2 1/2] take comma expr in account for constant value
Date: Sat, 5 Aug 2017 08:02:25 -0400
Message-ID: <CANeU7QnKFvjTdmGyQVP7AfBTSZn=LSzDjP6T68rvk07axcqm9g@mail.gmail.com>
References: <20170804160622.18260-1-luc.vanoostenryck@gmail.com>
 <20170804160622.18260-2-luc.vanoostenryck@gmail.com> <CANeU7QmakT6Q-7oYaG735cUOFt+L4C2JQ_eYHnfho+q5BLBmiQ@mail.gmail.com>
 <CAExDi1ST=xX=OS8FvbscHKMp3pyA728T=38yPVo4VuvSyxh8TA@mail.gmail.com>
 <CANeU7Q=_XWZDuUrZdkToUAw_Lm82UdtLXV+thEVnNK4Z+uWJtA@mail.gmail.com> <CAExDi1SehOyNXN7uQEgwfrc4z27r4gzxx1DhpDpF-aurBs4eUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33220 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbdHEMC0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 5 Aug 2017 08:02:26 -0400
Received: by mail-pg0-f65.google.com with SMTP id u185so4260656pgb.0
        for <linux-sparse@vger.kernel.org>; Sat, 05 Aug 2017 05:02:26 -0700 (PDT)
In-Reply-To: <CAExDi1SehOyNXN7uQEgwfrc4z27r4gzxx1DhpDpF-aurBs4eUg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Aug 4, 2017 at 5:20 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:

>>
>> If it compress 20 seconds to 2 seconds. I vote for include it.
>
> If only it would do so for every input code ;)
>

Because the offending source is come from a system
header file, I think it is more likely to hit in the field than
average project source file.


>
> OK, considering also that the situation may be present in other
> code (at various degree) and that this non-expansion of the
> builtin is really bad I'm fine to include it.
>
> Strangely I have a series of 5 or 6 patches fixing some similar situations
> (where some code is not evaluated and/or expanded, often creating
> duplicated warnings) but not this precise case.
> I never posted them because I considered it was too late in the release ...

I already applied as patch to sparse-next. I am doing the kernel
compile test right now. I will push it soon.

I confirm it cut the offending compile from 23 secons to:

real 0m3.425s
user 0m3.237s
sys 0m0.135s


Chris
