From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Cast to double being removed
Date: Sun, 19 Mar 2017 15:59:05 +0000
Message-ID: <CACXZuxfD_Jn8OMyE3sUcMNcJ+0CSwzFR2a_qd9w0TrZpJkxVsQ@mail.gmail.com>
References: <CACXZuxdNCM5wWvnYhvt65WaX6hSR_fTnaqd7=pv8O81NWoYQ_w@mail.gmail.com>
 <20170319152238.th3ts4pn7fcecpkt@macpro.local> <CACXZuxcShqiQ=R7dixD8DD8zuxt9WqAsQf1kkZLAYgJPGhbfcg@mail.gmail.com>
 <CAMHZB6HccEp3uacK_tFgxWymM+26bPS85jnTPAjqFpV+qsL70g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:37807 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbdCSQHD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 19 Mar 2017 12:07:03 -0400
Received: by mail-it0-f47.google.com with SMTP id g138so72343564itb.0
        for <linux-sparse@vger.kernel.org>; Sun, 19 Mar 2017 09:07:02 -0700 (PDT)
In-Reply-To: <CAMHZB6HccEp3uacK_tFgxWymM+26bPS85jnTPAjqFpV+qsL70g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 19 March 2017 at 15:54, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sun, Mar 19, 2017 at 4:43 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>> Hi Luc,
>>>> The cast to double has been removed. I am trying to understand where
>>>> this is happening as it seems to happen quite early on. Any tips on
>>>> where I should look?
>>>
>>> This is fixed by the patch I sent two days ago:
>>>         https://patchwork.kernel.org/patch/9618765/
>>>
>>
>> I found that in the simplification phase no account is taken of the
>> fact that a constant is floating point. Please try to run this test
>> and let me know if it works.
>
> I know. It's why I already sais several times that there is several issues with
> floating point numbers.
> I'll certainly look at these issues but currently I have around 40
> pending patch series
> for others problems ...
>
>> https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/netlib/paranoia.c
>
> Interesting.
> Do you know the license of this file?
>

http://www.netlib.org/paranoia/index.html

In the source it says:

You may copy this program freely if you acknowledge its source.

I have seen it distributed in other places so I believe it is not restricted.

Regards
Dibyendu
