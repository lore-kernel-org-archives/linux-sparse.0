From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] Makefile: use locally built sparse in the selfcheck target
Date: Sat, 11 Nov 2017 15:44:17 +0100
Message-ID: <CAExDi1QY_+bC02cFLm0+fHoVM59WL8664p8AJ=EA51Y7TSbDLQ@mail.gmail.com>
References: <10d6a020-ebe8-6a31-e4cb-ff67c1a1009c@ramsayjones.plus.com>
 <20171109170644.vn6ktpk2newq5ps3@ltop.local> <628e13fc-1fbd-fbc6-d662-a5050ce59c86@ramsayjones.plus.com>
 <CAMHZB6EjHuVVchrWsST_igO+Cj+KuqL3O5ezBG8pcDpp45u1ew@mail.gmail.com>
 <aae6d72a-013d-4342-de15-28bab1ac15e4@ramsayjones.plus.com>
 <e3aaace9-77b9-7b63-ee6b-9f5069c11b92@ramsayjones.plus.com>
 <CANeU7QnBpi1J_MrWwmUCFQn=yAjap0wb1L=P9e6Jk8WMJQNikA@mail.gmail.com> <d1e128a0-93e8-657a-6f0c-a025713ec0c1@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:38594 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbdKKOoS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:44:18 -0500
Received: by mail-it0-f49.google.com with SMTP id c3so4771822itc.3
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:44:18 -0800 (PST)
In-Reply-To: <d1e128a0-93e8-657a-6f0c-a025713ec0c1@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Thu, Nov 9, 2017 at 7:32 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>>
>> $ llvm-config --cflags
>> -I/usr/include -O2 -g -pipe -Wall -Werror=format-security
>> -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong
>> --param=ssp-buffer-size=4 -grecord-gcc-switches
>> -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -m64 -mtune=generic
>> -fPIC -Wall -W -Wno-unused-parameter -Wwrite-strings
>> -Wno-missing-field-initializers -pedantic -Wno-long-long -Wno-comment
>> -Werror=date-time -ffunction-sections -fdata-sections -O2 -g -DNDEBUG
>> -D_GNU_SOURCE -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS
>> -D__STDC_LIMIT_MACROS
>>
>> "llvm-config --cflags" does not introduce new header file searching directory.
>
> Ah, OK.
>
> So, 'llvm-config --cflags' produces different output on
> whichever platform Luc is on?

Usually, I have nothing (of interest) in /usr since most of my stuff
is installed in somewhere in $HOME or /opt.

Regards,
-- Luc
