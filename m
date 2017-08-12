From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm test cases
Date: Sat, 12 Aug 2017 14:44:54 +0100
Message-ID: <CACXZuxdFO=TbVgfqMCcAz5wTTk3=VizAodhOYMjiSb0cW5oRMw@mail.gmail.com>
References: <CACXZuxdrwNpr3yVkV=pBYty9jSjK_-HA9zDXwpfyB5evv_8Uzw@mail.gmail.com>
 <CANeU7Q=zF9hRqnNCN-+p0Y64yfkyaBvroeSP7faM4DSWW2RW5g@mail.gmail.com>
 <CACXZuxdvBVV+gDzWmFs=FA_s5Ric1djbF7mLNiea06SaSiqUOQ@mail.gmail.com> <CAExDi1TKwLKy66m35CMc4QZ5nRAbZMMmcheTrxTWxHACoPMm5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:32852 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbdHLNoz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 12 Aug 2017 09:44:55 -0400
Received: by mail-vk0-f47.google.com with SMTP id j189so21126208vka.0
        for <linux-sparse@vger.kernel.org>; Sat, 12 Aug 2017 06:44:55 -0700 (PDT)
In-Reply-To: <CAExDi1TKwLKy66m35CMc4QZ5nRAbZMMmcheTrxTWxHACoPMm5Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On 10 August 2017 at 23:50, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Thu, Aug 10, 2017 at 10:44 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>>
>> Yes, the current arrangement is a stop gap. As I develop both on
>> Windows and Linux, I need a portable solution so I cannot really use
>> shell scripts.
>
> People use bash with mingwin, for example. Would it be something
> usable for you?
>

I have a native MSVC build - I'd rather not have to rely upon mingw /
cygwin. Windows 10 now has a Linux subsystem - I am planning to do my
Linux builds within that. But I would rather have a test harness that
runs natively on all platforms.

>>> Another question is that, I don't know how many your test get impact
>>> by the llvm versions. If it get tight to a specific version of llvm, the
>>> test case has less value. People will get false positives due to different
>>> llvm version.
>
> If it begin to be the case we'll need to add a new tag telling to ignore
> the test if version this or that.
>
>> The tests are all designed to be runnable
>
> I think this is very very important.
> Of course, you're interested in LLVM output but not only.
>

Being able to run it is an easy way to verify that the test works -
because the success / failure condition is part of the test itself /
or output produced by the test. Ideally though I would like to be able
to validate the Sparse IR - but don't know an easy way to do this
other than comparing the output from linearizer.

> One thing I want to have for testing linearized code is a simulator
> for sparse's IR. It's even something quite easy (or at least straightforward)
> to do. At least once you can associate to each phi-node's 'argument' the
> parent BB they come from. This is something I'm planning to do for several
> reasons.
>

Do you mean you will have a VM that runs Sparse IR? That would be nice
but it is a lot of effort I would think.

Regards
Dibyendu
