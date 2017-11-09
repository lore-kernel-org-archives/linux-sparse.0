From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Makefile: use locally built sparse in the selfcheck target
Date: Fri, 10 Nov 2017 01:57:40 +0800
Message-ID: <CANeU7Qm8PsNKNo8VCf-AP5u2_x+OHjHSPmMFvd64BqNm-xtTbQ@mail.gmail.com>
References: <10d6a020-ebe8-6a31-e4cb-ff67c1a1009c@ramsayjones.plus.com>
 <20171109170644.vn6ktpk2newq5ps3@ltop.local> <628e13fc-1fbd-fbc6-d662-a5050ce59c86@ramsayjones.plus.com>
 <CAMHZB6EjHuVVchrWsST_igO+Cj+KuqL3O5ezBG8pcDpp45u1ew@mail.gmail.com> <aae6d72a-013d-4342-de15-28bab1ac15e4@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:49527 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752459AbdKIR5l (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 12:57:41 -0500
Received: by mail-yw0-f175.google.com with SMTP id y16so410669ywa.6
        for <linux-sparse@vger.kernel.org>; Thu, 09 Nov 2017 09:57:41 -0800 (PST)
In-Reply-To: <aae6d72a-013d-4342-de15-28bab1ac15e4@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Fri, Nov 10, 2017 at 1:55 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>> The specific error message is:
>>     sparse-llvm.c:6:11: error: unable to open 'llvm-c/Core.h'
>> but the cause is simply because the LLVM CFLAGS are used like:
>>     sparse-llvm.o: BASIC_CFLAGS += $(LLVM_CFLAGS)
>> but selfcheck/cgcc, correctly, doesn't know about BASIC_CFLAGS.
>
> Hmm, that doesn't make much sense - the selfcheck target uses
> the $(ALL_CFLAGS), just like the '%.o %.c' target. So, if the

Right. But selfcheck using *.sc target.

So the likely fix is just:
sparse-llvm.o sparse-llvm.sc: XXX_CFLAGS += $(LLVM_CFLAGS)

I am looking at this right now.

Interesting enough, on my FC 26 it is not triggering the header
file error.

Chris
