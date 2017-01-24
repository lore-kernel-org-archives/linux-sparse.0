From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Query regarding sizeof long
Date: Tue, 24 Jan 2017 19:00:03 +0100
Message-ID: <CAMHZB6EB31xGf6C-j=x0MpPnKjyap5Hb7P5BJd1V5DsycT92DA@mail.gmail.com>
References: <CACXZuxdCP6C_1Y7OHgrxkLYct6CuuArM22ZH6_g_CHixMDhTQQ@mail.gmail.com>
 <20170124144711.evipzg47ka572qgd@macpro.local> <CACXZuxdGV=VMiVdw7qM-wOzjOXEAV8WAw9KaXM+zpcA1c2RK6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:36129 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbdAXSAE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 24 Jan 2017 13:00:04 -0500
Received: by mail-qt0-f176.google.com with SMTP id k15so196685584qtg.3
        for <linux-sparse@vger.kernel.org>; Tue, 24 Jan 2017 10:00:04 -0800 (PST)
In-Reply-To: <CACXZuxdGV=VMiVdw7qM-wOzjOXEAV8WAw9KaXM+zpcA1c2RK6w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Jan 24, 2017 at 4:08 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi Luc,
>
> On 24 January 2017 at 14:47, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> On Tue, Jan 24, 2017 at 02:23:13PM +0000, Dibyendu Majumdar wrote:
>>> I am working on porting Sparse to Windows, and I noticed that in
>>> 64-bit architecture the bits_in_long is set to 64. This is not true
>>> for Windows where long is 32 bits on a 64-bit machine. I was wondering
>>> if I just need to set this parameter to 32 or if there are other
>>> implications that I need to be aware of.
>>
>> If you just change the initial value in target.c, it won't do what you
>> need because currently, if you compile sparse on a machine where
>> __x86_64__ is defined, it will automatically enable the -m64 option
>> which will setup things for an LP64 architecture instead of the LLP64
>> that you need (inside handle_arch_m64_finalize()).
>>
>
> Yes I noticed that and I can easily make that conditional on MSVC. I
> guess my question is more whether there are any assumptions in the
> code that a long in a 64-bit environment is 64-bits (e.g. pointers fit
> into long). I have not yet been able to run all the tests on Windows,
> but I guess that is one way I can find out if there are any issues.

There shouldn't be any such assumptions :)
And I think, you shouldn't have much bad surprised,
but I'm a bit less confident regarding the test-suite. It's very possible
that some tests have the assumption that sizeof(long) == sizeof(pointer).
And I'm pretty sure that this LLP64 situation have been very little tested,
very possibly never been tested at all.

Luc
