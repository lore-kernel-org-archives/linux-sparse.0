From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Potential issue with handling of va_arg()
Date: Sat, 1 Apr 2017 13:56:54 +0100
Message-ID: <CACXZuxfznvD82rF5nk9xu4gbFmzDy9Qw7+vpJJSCgijsBSwO4g@mail.gmail.com>
References: <CACXZuxcVfKc914gx8Bj=eYsT1fS46hG8BfvBQK5Kthhk+yjeDA@mail.gmail.com>
 <CACXZuxeBMkbp3zTpsFFdMXsuW+ea2z+HKNFAMdSbiuEcF-hvfg@mail.gmail.com> <CAMHZB6GHpSktsr3V4UyQvMKWuCmpDekbd297QRcwAuq2tGkh+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:33374 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751339AbdDAM4z (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 1 Apr 2017 08:56:55 -0400
Received: by mail-it0-f42.google.com with SMTP id 68so8682597itx.0
        for <linux-sparse@vger.kernel.org>; Sat, 01 Apr 2017 05:56:55 -0700 (PDT)
In-Reply-To: <CAMHZB6GHpSktsr3V4UyQvMKWuCmpDekbd297QRcwAuq2tGkh+Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 31 March 2017 at 19:55, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Fri, Mar 31, 2017 at 4:06 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>> On 31 March 2017 at 14:47, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
>>> I am investigating a failure in this test:
>>>
>>> #include <stdarg.h>
>>> #include <stdlib.h>
>>> #include <stdio.h>
>>>
>>> void error_message(const char *fmt, ...) {
>>> va_list argp;
>>> va_start(argp, fmt);
>>
>> I think this might be because the macro __builtin_va_start() is being
>> defined in sparse but this doesn't match what gets defined by gcc? I
>> see this in sparse:
>>
>
> Current support for vaarg is more faked than anything else.
> There is just the minimum needed to be able to do correct parsing
> of code using it but there is nothing behind it.
>

Okay, I think a workaround for sparse-llvm is to disable generation of
the macros related to var arg processing - this will cause the
compilation to fail with undefined errors, rather than silently
generating bad code. I have done this in dmr_C where the relevant
macros are not defined when llvm backend is being used. I was
experiencing crashes with minilua due to this issue - I have reworked
minilua so that the functions that rely upon var arg processing are
moved to a separate source file which cannot be compiled with
sparse-llvm.

For my use case the var arg issue is not a pressing issue to fix, what
is more important is that bad code is never generated and the cases
not handled correctly are detected early and compilation fails.

Thanks and Regards
Dibyendu
