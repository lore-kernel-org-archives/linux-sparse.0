From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] build: clean up $CFLAGS handling in the makefile
Date: Thu, 9 Nov 2017 23:55:35 +0100
Message-ID: <CAExDi1Q5yuKSAwG7uLLnJ-0pDxKeH9=6cTQAp5YcxcQq1btw_g@mail.gmail.com>
References: <20171025142009.foxh2rblmfpxvm7d@ltop.local> <CANeU7Qnvvezdc62s-cAWNonw2cKOJPWH2xSdgTdAL4M4skSnJw@mail.gmail.com>
 <1509019885.29077.6.camel@kernel.org> <CANeU7QmOACXKv2T2ovg7mxEDdpjUrwRgyYUsp2benDWh9R-2iw@mail.gmail.com>
 <1509476260.4553.45.camel@kernel.org> <CANeU7Qm8YHpYLLW8O=y=m9m6kRAD_5MiTnS79N5ffCk-PVcxFQ@mail.gmail.com>
 <20171101141705.aqn5gnwvuohkapp3@ltop.local> <CANeU7Qm4+DWdcDrMytWqxTELrwuyMEkhs2hFGj6599ghetBE8A@mail.gmail.com>
 <20171105165751.iqqlaxz6yu27nouj@ltop.local> <CANeU7Qk=pg0kWEoT6KUK_+6PVEjfAJeh+-_=dB_LqT-Bh+88CQ@mail.gmail.com>
 <20171109212607.4lnd6aedr63c5ta2@ltop.local> <CANeU7QkW=UuptVXFwnv-5f2GmZQVuHBvk_H5Hu13-MG=jeDduA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:51949 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751463AbdKIWzh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 17:55:37 -0500
Received: by mail-it0-f49.google.com with SMTP id o135so12725004itb.0
        for <linux-sparse@vger.kernel.org>; Thu, 09 Nov 2017 14:55:36 -0800 (PST)
In-Reply-To: <CANeU7QkW=UuptVXFwnv-5f2GmZQVuHBvk_H5Hu13-MG=jeDduA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Jeff Layton <jlayton@kernel.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Nov 9, 2017 at 11:18 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Fri, Nov 10, 2017 at 5:26 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>>> The selfcheck on sparse-llvm.sc is independent of the CFLAGS changes.
>>
>> On the contrary, it's very much at the core of the way the
>> different CFLAGS variable are used.
>
> I mean the bug is triggerable even before the CFLAGS patch applied.
>
>>
>> Everywhere you will use something like:
>>    <sometarget>.o: <some CFLAGS variant> += <something>
>> you will also need to add <sometarget>.sc
>> It's the way you solve the problem and it may seems to you
>> independent of the CFLAGS changes and yet in my version of
>> the CFLAGS changes this bug was solved automatically by how
>> the CFLAGS were used (I discovered the bug while writting the
>> patch; you know this "ohoh, this can't possibly be correct").
>
> I see. You avoid using target specific variables. That might be
> a good idea. I was looking for the smallest fix to so that
> don't impact too much on the other Makefile changes.
>
> I don't like to have CFLAGS += for every thing though.
> It only works if the options always append from the tail.
> If it is order sensitive, need to insert in the middle, then
> you will need to have sub variable to group from any way,
> like your CPPFLAGS.

In the big makefile cleanup series, I've done slightly
differently but yes, no more target specific vars,
only <target>_CFLAGS and using 'cflags' for
flags private to sparse.
Aesthetically, it's not what I found the most pleasing
but this does well the job (SPARSE_CFLAGS, _CFLAGS,
C_FLAGS,  ... could have been used too).

-- Luc
