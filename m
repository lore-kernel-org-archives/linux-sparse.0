From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] Makefile: use locally built sparse in the selfcheck
 target
Date: Thu, 9 Nov 2017 18:32:07 +0000
Message-ID: <d1e128a0-93e8-657a-6f0c-a025713ec0c1@ramsayjones.plus.com>
References: <10d6a020-ebe8-6a31-e4cb-ff67c1a1009c@ramsayjones.plus.com>
 <20171109170644.vn6ktpk2newq5ps3@ltop.local>
 <628e13fc-1fbd-fbc6-d662-a5050ce59c86@ramsayjones.plus.com>
 <CAMHZB6EjHuVVchrWsST_igO+Cj+KuqL3O5ezBG8pcDpp45u1ew@mail.gmail.com>
 <aae6d72a-013d-4342-de15-28bab1ac15e4@ramsayjones.plus.com>
 <e3aaace9-77b9-7b63-ee6b-9f5069c11b92@ramsayjones.plus.com>
 <CANeU7QnBpi1J_MrWwmUCFQn=yAjap0wb1L=P9e6Jk8WMJQNikA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout04.plus.net ([212.159.14.19]:60759 "EHLO
        avasout04.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752541AbdKIScJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 13:32:09 -0500
In-Reply-To: <CANeU7QnBpi1J_MrWwmUCFQn=yAjap0wb1L=P9e6Jk8WMJQNikA@mail.gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>



On 09/11/17 18:09, Christopher Li wrote:
> On Fri, Nov 10, 2017 at 2:03 AM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>>
>> Ah, no longer puzzled. Hmm, didn't there used to be a rule like:
>>
>> sparse-llvm.o sparse-llvm.sc: BASIC_CFLAGS += $(LLVM_CFLAGS)
>>
> 
> I search the history. Nope, I miss that when I add the selfcheck.
> I did not catch this error because on FC26 missing the LLVM_CFLAGS
> does not cause compile error.

Heh, our emails crossed.

> 
> $ llvm-config --cflags
> -I/usr/include -O2 -g -pipe -Wall -Werror=format-security
> -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong
> --param=ssp-buffer-size=4 -grecord-gcc-switches
> -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -m64 -mtune=generic
> -fPIC -Wall -W -Wno-unused-parameter -Wwrite-strings
> -Wno-missing-field-initializers -pedantic -Wno-long-long -Wno-comment
> -Werror=date-time -ffunction-sections -fdata-sections -O2 -g -DNDEBUG
> -D_GNU_SOURCE -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS
> -D__STDC_LIMIT_MACROS
> 
> "llvm-config --cflags" does not introduce new header file searching directory.

Ah, OK.

So, 'llvm-config --cflags' produces different output on
whichever platform Luc is on?

ATB,
Ramsay Jones


