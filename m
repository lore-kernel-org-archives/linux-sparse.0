From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 3/3] add support for -fmemcpy-max-count
Date: Fri, 2 Jun 2017 02:38:00 +0200
Message-ID: <CAMHZB6GT8d2UUBO2po+o0QLaBh_3ZOLgA0_zYz7s1_xgDr4DQA@mail.gmail.com>
References: <84e547c2-8a5b-225c-1363-361e091821f4@ramsayjones.plus.com>
 <20170601202724.77597-1-luc.vanoostenryck@gmail.com> <20170601202724.77597-4-luc.vanoostenryck@gmail.com>
 <45f3b371-2839-5353-17a7-ea82b113d4f1@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:33569 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdFBAiB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Jun 2017 20:38:01 -0400
Received: by mail-qt0-f170.google.com with SMTP id t26so49180549qtg.0
        for <linux-sparse@vger.kernel.org>; Thu, 01 Jun 2017 17:38:01 -0700 (PDT)
In-Reply-To: <45f3b371-2839-5353-17a7-ea82b113d4f1@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Chris Li <sparse@chrisli.org>, Junio C Hamano <gitster@pobox.com>

On Fri, Jun 2, 2017 at 2:30 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:

>>  .SH OTHER OPTIONS
>>  .TP
>> +.B \-fmemcpy-limit=COUNT
>> +By default, sparse will warn if \fBmemcpy()\fR (or \fBmemset()\fR,
>> +\fBcopy_from_user()\fR, copy_to_user()\fR) is called with a very large
>> +(known at compile-time) byte-count. COUNT is the value under which
>> +no such warning will be given. The default limit is 100000.
>> +.
>> +.TP
>
> So, in addition to -Wno-memcpy-max-count, you could turn the warning
> off with just -fmemcpy-limit=0. cool.
>
> Thanks!
>
> ATB,
> Ramsay Jones

Well, for now setting the limit to 0 would just warn about any
non-zero memcpy/memset
but it's something that could very easily be added, sure.

-- Luc
