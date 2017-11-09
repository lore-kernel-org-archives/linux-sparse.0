From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Makefile: use locally built sparse in the selfcheck target
Date: Fri, 10 Nov 2017 02:09:11 +0800
Message-ID: <CANeU7QnBpi1J_MrWwmUCFQn=yAjap0wb1L=P9e6Jk8WMJQNikA@mail.gmail.com>
References: <10d6a020-ebe8-6a31-e4cb-ff67c1a1009c@ramsayjones.plus.com>
 <20171109170644.vn6ktpk2newq5ps3@ltop.local> <628e13fc-1fbd-fbc6-d662-a5050ce59c86@ramsayjones.plus.com>
 <CAMHZB6EjHuVVchrWsST_igO+Cj+KuqL3O5ezBG8pcDpp45u1ew@mail.gmail.com>
 <aae6d72a-013d-4342-de15-28bab1ac15e4@ramsayjones.plus.com> <e3aaace9-77b9-7b63-ee6b-9f5069c11b92@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:52831 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbdKISJM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 13:09:12 -0500
Received: by mail-yw0-f175.google.com with SMTP id w2so6043323ywa.9
        for <linux-sparse@vger.kernel.org>; Thu, 09 Nov 2017 10:09:12 -0800 (PST)
In-Reply-To: <e3aaace9-77b9-7b63-ee6b-9f5069c11b92@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Fri, Nov 10, 2017 at 2:03 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> Ah, no longer puzzled. Hmm, didn't there used to be a rule like:
>
> sparse-llvm.o sparse-llvm.sc: BASIC_CFLAGS += $(LLVM_CFLAGS)
>

I search the history. Nope, I miss that when I add the selfcheck.
I did not catch this error because on FC26 missing the LLVM_CFLAGS
does not cause compile error.

$ llvm-config --cflags
-I/usr/include -O2 -g -pipe -Wall -Werror=format-security
-Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong
--param=ssp-buffer-size=4 -grecord-gcc-switches
-specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -m64 -mtune=generic
-fPIC -Wall -W -Wno-unused-parameter -Wwrite-strings
-Wno-missing-field-initializers -pedantic -Wno-long-long -Wno-comment
-Werror=date-time -ffunction-sections -fdata-sections -O2 -g -DNDEBUG
-D_GNU_SOURCE -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS
-D__STDC_LIMIT_MACROS

"llvm-config --cflags" does not introduce new header file searching directory.

Chris
