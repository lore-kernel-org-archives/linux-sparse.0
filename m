From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] Makefile: use locally built sparse in the selfcheck target
Date: Thu, 9 Nov 2017 19:32:15 +0100
Message-ID: <CAMHZB6ECi0noCDxAEaiJ4m3QUTgX=Z3eCR5JHLWZVNLv4RCSgg@mail.gmail.com>
References: <10d6a020-ebe8-6a31-e4cb-ff67c1a1009c@ramsayjones.plus.com>
 <20171109170644.vn6ktpk2newq5ps3@ltop.local> <628e13fc-1fbd-fbc6-d662-a5050ce59c86@ramsayjones.plus.com>
 <CAMHZB6EjHuVVchrWsST_igO+Cj+KuqL3O5ezBG8pcDpp45u1ew@mail.gmail.com>
 <aae6d72a-013d-4342-de15-28bab1ac15e4@ramsayjones.plus.com> <e3aaace9-77b9-7b63-ee6b-9f5069c11b92@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:56527 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752541AbdKIScQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 13:32:16 -0500
Received: by mail-vk0-f66.google.com with SMTP id g11so4575695vkd.13
        for <linux-sparse@vger.kernel.org>; Thu, 09 Nov 2017 10:32:16 -0800 (PST)
In-Reply-To: <e3aaace9-77b9-7b63-ee6b-9f5069c11b92@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Thu, Nov 9, 2017 at 7:03 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 09/11/17 17:55, Ramsay Jones wrote:
>>
>>
>> On 09/11/17 17:43, Luc Van Oostenryck wrote:
>>> On Thu, Nov 9, 2017 at 6:37 PM, Ramsay Jones
>>> <ramsay@ramsayjones.plus.com> wrote:
>>>>
>>>>
>>>> On 09/11/17 17:06, Luc Van Oostenryck wrote:
>>>>>
>>>>> Acked-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>>>>>
>>>>>
>>>>> BTW, selfcheck also fails when reaching sparse-llvm.c because of
>>>>> the use of CFLAGS/BASIC_CFLAGS/ALL_CFLAGS/COMMON_CFLAGS/PKG_CFLAGS.
>>>>
>>>> Hmm, I used to have LLVM installed on Linux as well as cygwin, but
>>>> I didn't install it the last time I did a 'nuke-n-pave' Linux
>>>> installation. (Linux Mint is much easier to upgrade these days, which
>>>> is to say it actually works now, but that wasn't always the case!).
>>>>
>>>> On cygwin, sparse-llvm.c complains for a cygwin-only reason, so it
>>>> may be that those errors a hiding the ones you are seeing. I have been
>>>> meaning to get around to fix the cygwin problems.
>>>>
>>>> What kind of errors are you seeing?
>>>
>>> The specific error message is:
>>>     sparse-llvm.c:6:11: error: unable to open 'llvm-c/Core.h'
>>> but the cause is simply because the LLVM CFLAGS are used like:
>>>     sparse-llvm.o: BASIC_CFLAGS += $(LLVM_CFLAGS)
>>> but selfcheck/cgcc, correctly, doesn't know about BASIC_CFLAGS.
>>
>> Hmm, that doesn't make much sense - the selfcheck target uses
>> the $(ALL_CFLAGS), just like the '%.o %.c' target. So, if the
>> file is compiled by gcc, then cgcc should have the same flags
>> (plus some sparse specific flags).
>>
>> [This is the Makefile on the master branch @ c408da2].
>>
>> puzzled ...
>
> Ah, no longer puzzled. Hmm, didn't there used to be a rule like:
>
> sparse-llvm.o sparse-llvm.sc: BASIC_CFLAGS += $(LLVM_CFLAGS)
>
> this?

Yes, for example.

-- Luc
