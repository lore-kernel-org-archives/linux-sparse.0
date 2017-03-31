From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Potential issue with handling of va_arg()
Date: Fri, 31 Mar 2017 20:55:44 +0200
Message-ID: <CAMHZB6GHpSktsr3V4UyQvMKWuCmpDekbd297QRcwAuq2tGkh+Q@mail.gmail.com>
References: <CACXZuxcVfKc914gx8Bj=eYsT1fS46hG8BfvBQK5Kthhk+yjeDA@mail.gmail.com>
 <CACXZuxeBMkbp3zTpsFFdMXsuW+ea2z+HKNFAMdSbiuEcF-hvfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33314 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752491AbdCaSzq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 31 Mar 2017 14:55:46 -0400
Received: by mail-qk0-f178.google.com with SMTP id d201so44907669qkc.0
        for <linux-sparse@vger.kernel.org>; Fri, 31 Mar 2017 11:55:45 -0700 (PDT)
In-Reply-To: <CACXZuxeBMkbp3zTpsFFdMXsuW+ea2z+HKNFAMdSbiuEcF-hvfg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Mar 31, 2017 at 4:06 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi,
>
> On 31 March 2017 at 14:47, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
>> I am investigating a failure in this test:
>>
>> #include <stdarg.h>
>> #include <stdlib.h>
>> #include <stdio.h>
>>
>> void error_message(const char *fmt, ...) {
>> va_list argp;
>> va_start(argp, fmt);
>
> I think this might be because the macro __builtin_va_start() is being
> defined in sparse but this doesn't match what gets defined by gcc? I
> see this in sparse:
>
> #define __builtin_va_start(a,b) ((a) = (__builtin_va_list)(&(b)))
>
> but if I run above code through gcc then preprocessed output says:
>
> __builtin_va_start(argp, fmt);
>

Current support for vaarg is more faked than anything else.
There is just the minimum needed to be able to do correct parsing
of code using it but there is nothing behind it.

-- Luc
