From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 2/3] add support for -Wmemcpy-max-count
Date: Fri, 2 Jun 2017 02:33:50 +0200
Message-ID: <CAMHZB6HSgXdXjL1kLg2Q9GYwMGdZZs=tE0d4BzyA3M99jR-MrA@mail.gmail.com>
References: <84e547c2-8a5b-225c-1363-361e091821f4@ramsayjones.plus.com>
 <20170601202724.77597-1-luc.vanoostenryck@gmail.com> <20170601202724.77597-3-luc.vanoostenryck@gmail.com>
 <d29d03a0-7e40-1427-40bd-df14c37112d1@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35778 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbdFBAdw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Jun 2017 20:33:52 -0400
Received: by mail-qt0-f193.google.com with SMTP id r58so7780373qtb.2
        for <linux-sparse@vger.kernel.org>; Thu, 01 Jun 2017 17:33:52 -0700 (PDT)
In-Reply-To: <d29d03a0-7e40-1427-40bd-df14c37112d1@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Chris Li <sparse@chrisli.org>, Junio C Hamano <gitster@pobox.com>

On Fri, Jun 2, 2017 at 2:23 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 01/06/17 21:27, Luc Van Oostenryck wrote:
>> sparse will warn if memcpy() (or memset(), copy_from_user(),
>> copy_to_user()) is called with a very large static byte-count.
>>
>> But this warning is given unconditionaly while there are projects
>> where this warning may not be not desired.
>>
>> Change this by making this warning conditional on a new warning
>> flag: -Wmemcpy-max-count=COUNT.
>
> As always, the hardest part for me is naming. I can't remember exactly
> what I called it, but I wanted something which would kinda sum up
> all the functions. So, it was something like -Wmem-move-limit=n, or
> something like that, and so the test was disabled by setting it to
> zero.

Yes, the name is far from ideal. I used 'memcpy' for the name because
I think it's the most representative but I would like to have a better name.
I considered for a while something like '-Wmem-operations' or '-Wmem-functions',
now I'm just thinking about '-Wmem-transfert-limit=...', I dunno.

> -Wmemcpy-max-count=count is probably a better name! ;-)

>> diff --git a/sparse.1 b/sparse.1
>> index c924b3a59..efbd78d01 100644
>> --- a/sparse.1
>> +++ b/sparse.1
>> @@ -210,6 +210,14 @@ trouble.
>>  Sparse does not issue these warnings by default.
>>  .
>>  .TP
>> +.B \-Wmemcpy\-max\-count
>> +Warn about call of \fBmemset()\fR, \fBmemset()\fR, \fBcopy_from_user()\fR, or
>                         ^^^^^^^         ^^^^^^^^
> memcpy() and memset()

Ah yes, good catch. Thanks.


-- Luc
