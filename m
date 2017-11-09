From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] Makefile: use locally built sparse in the selfcheck target
Date: Thu, 9 Nov 2017 18:43:21 +0100
Message-ID: <CAMHZB6EjHuVVchrWsST_igO+Cj+KuqL3O5ezBG8pcDpp45u1ew@mail.gmail.com>
References: <10d6a020-ebe8-6a31-e4cb-ff67c1a1009c@ramsayjones.plus.com>
 <20171109170644.vn6ktpk2newq5ps3@ltop.local> <628e13fc-1fbd-fbc6-d662-a5050ce59c86@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:53248 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbdKIRnW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 12:43:22 -0500
Received: by mail-ua0-f196.google.com with SMTP id e10so2261944uah.10
        for <linux-sparse@vger.kernel.org>; Thu, 09 Nov 2017 09:43:22 -0800 (PST)
In-Reply-To: <628e13fc-1fbd-fbc6-d662-a5050ce59c86@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Thu, Nov 9, 2017 at 6:37 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 09/11/17 17:06, Luc Van Oostenryck wrote:
>>
>> Acked-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>>
>>
>> BTW, selfcheck also fails when reaching sparse-llvm.c because of
>> the use of CFLAGS/BASIC_CFLAGS/ALL_CFLAGS/COMMON_CFLAGS/PKG_CFLAGS.
>
> Hmm, I used to have LLVM installed on Linux as well as cygwin, but
> I didn't install it the last time I did a 'nuke-n-pave' Linux
> installation. (Linux Mint is much easier to upgrade these days, which
> is to say it actually works now, but that wasn't always the case!).
>
> On cygwin, sparse-llvm.c complains for a cygwin-only reason, so it
> may be that those errors a hiding the ones you are seeing. I have been
> meaning to get around to fix the cygwin problems.
>
> What kind of errors are you seeing?

The specific error message is:
    sparse-llvm.c:6:11: error: unable to open 'llvm-c/Core.h'
but the cause is simply because the LLVM CFLAGS are used like:
    sparse-llvm.o: BASIC_CFLAGS += $(LLVM_CFLAGS)
but selfcheck/cgcc, correctly, doesn't know about BASIC_CFLAGS.

Chris should be already aware of it and is busy to cook a patch
changing the way the CFLAGS are used.

Regards,
-- Luc
