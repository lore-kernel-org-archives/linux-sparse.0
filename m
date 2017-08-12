From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm test cases
Date: Sat, 12 Aug 2017 16:43:28 +0200
Message-ID: <CAExDi1QoYQ=shqx6CtiwkDznjwqjixTyaq1yqasD-YQv7Vtu1w@mail.gmail.com>
References: <CACXZuxdrwNpr3yVkV=pBYty9jSjK_-HA9zDXwpfyB5evv_8Uzw@mail.gmail.com>
 <CANeU7Q=zF9hRqnNCN-+p0Y64yfkyaBvroeSP7faM4DSWW2RW5g@mail.gmail.com>
 <CACXZuxdvBVV+gDzWmFs=FA_s5Ric1djbF7mLNiea06SaSiqUOQ@mail.gmail.com>
 <CAExDi1TKwLKy66m35CMc4QZ5nRAbZMMmcheTrxTWxHACoPMm5Q@mail.gmail.com> <CACXZuxdFO=TbVgfqMCcAz5wTTk3=VizAodhOYMjiSb0cW5oRMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:36595 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbdHLOn3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 12 Aug 2017 10:43:29 -0400
Received: by mail-oi0-f46.google.com with SMTP id g131so54647070oic.3
        for <linux-sparse@vger.kernel.org>; Sat, 12 Aug 2017 07:43:29 -0700 (PDT)
In-Reply-To: <CACXZuxdFO=TbVgfqMCcAz5wTTk3=VizAodhOYMjiSb0cW5oRMw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Aug 12, 2017 at 3:44 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> I have a native MSVC build - I'd rather not have to rely upon mingw /
> cygwin.

I can understand that.

> Windows 10 now has a Linux subsystem - I am planning to do my
> Linux builds within that. But I would rather have a test harness that
> runs natively on all platforms.

I can understand that also but:
- if you want to validate the IR, it's something that is platform independent
  and if validated on your linux platform it will be valid for the others too
- the script used to run the test is something very simple, it shouldn't
  take much work to write a version in some other language.
  Making this new version *the* official version is something else
  and rewritting all the testcases so that this or that is easier for this
  new version would be a totally different question, of course.

>
> Being able to run it is an easy way to verify that the test works -
> because the success / failure condition is part of the test itself /
> or output produced by the test. Ideally though I would like to be able
> to validate the Sparse IR - but don't know an easy way to do this
> other than comparing the output from linearizer.

Slowly, it's what I'm already doing in the current testcases.
It's far from ideal but we can already progress.

>> One thing I want to have for testing linearized code is a simulator
>> for sparse's IR. It's even something quite easy (or at least straightforward)
>> to do. At least once you can associate to each phi-node's 'argument' the
>> parent BB they come from. This is something I'm planning to do for several
>> reasons.
>
> Do you mean you will have a VM that runs Sparse IR? That would be nice
> but it is a lot of effort I would think.

Yes. I call that a simulator but it's all the same.
It would be a program that take some input file
(either directly the C source or the IR in some format yet to defined)
and will 'execute' the IR instruction.
It's in fact something very easy to do, something like a weekend project,
*once* we associate parent BB to phi-node's 'arguments'.

This BB for phi-node's arg is something very needed and it's the top
of my todo list but for the moment, there is more important things to
fix.

-- Luc
