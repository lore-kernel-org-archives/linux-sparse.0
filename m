From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] Makefile: use locally built sparse in the selfcheck
 target
Date: Thu, 9 Nov 2017 17:55:02 +0000
Message-ID: <aae6d72a-013d-4342-de15-28bab1ac15e4@ramsayjones.plus.com>
References: <10d6a020-ebe8-6a31-e4cb-ff67c1a1009c@ramsayjones.plus.com>
 <20171109170644.vn6ktpk2newq5ps3@ltop.local>
 <628e13fc-1fbd-fbc6-d662-a5050ce59c86@ramsayjones.plus.com>
 <CAMHZB6EjHuVVchrWsST_igO+Cj+KuqL3O5ezBG8pcDpp45u1ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout04.plus.net ([212.159.14.19]:57768 "EHLO
        avasout04.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751012AbdKIRzE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 12:55:04 -0500
In-Reply-To: <CAMHZB6EjHuVVchrWsST_igO+Cj+KuqL3O5ezBG8pcDpp45u1ew@mail.gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>



On 09/11/17 17:43, Luc Van Oostenryck wrote:
> On Thu, Nov 9, 2017 at 6:37 PM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>>
>>
>> On 09/11/17 17:06, Luc Van Oostenryck wrote:
>>>
>>> Acked-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>>>
>>>
>>> BTW, selfcheck also fails when reaching sparse-llvm.c because of
>>> the use of CFLAGS/BASIC_CFLAGS/ALL_CFLAGS/COMMON_CFLAGS/PKG_CFLAGS.
>>
>> Hmm, I used to have LLVM installed on Linux as well as cygwin, but
>> I didn't install it the last time I did a 'nuke-n-pave' Linux
>> installation. (Linux Mint is much easier to upgrade these days, which
>> is to say it actually works now, but that wasn't always the case!).
>>
>> On cygwin, sparse-llvm.c complains for a cygwin-only reason, so it
>> may be that those errors a hiding the ones you are seeing. I have been
>> meaning to get around to fix the cygwin problems.
>>
>> What kind of errors are you seeing?
> 
> The specific error message is:
>     sparse-llvm.c:6:11: error: unable to open 'llvm-c/Core.h'
> but the cause is simply because the LLVM CFLAGS are used like:
>     sparse-llvm.o: BASIC_CFLAGS += $(LLVM_CFLAGS)
> but selfcheck/cgcc, correctly, doesn't know about BASIC_CFLAGS.

Hmm, that doesn't make much sense - the selfcheck target uses
the $(ALL_CFLAGS), just like the '%.o %.c' target. So, if the
file is compiled by gcc, then cgcc should have the same flags
(plus some sparse specific flags).

[This is the Makefile on the master branch @ c408da2].

puzzled ...

ATB,
Ramsay Jones


