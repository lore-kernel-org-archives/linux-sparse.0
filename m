From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Cast to double being removed
Date: Sun, 19 Mar 2017 16:54:09 +0100
Message-ID: <CAMHZB6HccEp3uacK_tFgxWymM+26bPS85jnTPAjqFpV+qsL70g@mail.gmail.com>
References: <CACXZuxdNCM5wWvnYhvt65WaX6hSR_fTnaqd7=pv8O81NWoYQ_w@mail.gmail.com>
 <20170319152238.th3ts4pn7fcecpkt@macpro.local> <CACXZuxcShqiQ=R7dixD8DD8zuxt9WqAsQf1kkZLAYgJPGhbfcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36715 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbdCSPzS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 19 Mar 2017 11:55:18 -0400
Received: by mail-qk0-f181.google.com with SMTP id 1so94746682qkl.3
        for <linux-sparse@vger.kernel.org>; Sun, 19 Mar 2017 08:54:10 -0700 (PDT)
In-Reply-To: <CACXZuxcShqiQ=R7dixD8DD8zuxt9WqAsQf1kkZLAYgJPGhbfcg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Mar 19, 2017 at 4:43 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi Luc,
>>> The cast to double has been removed. I am trying to understand where
>>> this is happening as it seems to happen quite early on. Any tips on
>>> where I should look?
>>
>> This is fixed by the patch I sent two days ago:
>>         https://patchwork.kernel.org/patch/9618765/
>>
>
> I found that in the simplification phase no account is taken of the
> fact that a constant is floating point. Please try to run this test
> and let me know if it works.

I know. It's why I already sais several times that there is several issues with
floating point numbers.
I'll certainly look at these issues but currently I have around 40
pending patch series
for others problems ...

> https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/netlib/paranoia.c

Interesting.
Do you know the license of this file?

> I had to switch off simplifications of instructions that have a
> floating point type.

OK, but the specific problem exposed by your example was something else,
a tiny braino most probably.

-- Luc
