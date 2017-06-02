From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/3] -Wmemcpy-max-count & friends
Date: Fri, 2 Jun 2017 02:26:16 +0200
Message-ID: <CAMHZB6Fd4Z2ofZJUHbN_52VRGcg__2rN9WEvb3MbHC9wduPjOA@mail.gmail.com>
References: <84e547c2-8a5b-225c-1363-361e091821f4@ramsayjones.plus.com>
 <20170601202724.77597-1-luc.vanoostenryck@gmail.com> <ecc76f93-d919-449d-62ff-d2f1b4bc0fae@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:35338 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751134AbdFBA0X (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Jun 2017 20:26:23 -0400
Received: by mail-qt0-f171.google.com with SMTP id w1so21938790qtg.2
        for <linux-sparse@vger.kernel.org>; Thu, 01 Jun 2017 17:26:22 -0700 (PDT)
In-Reply-To: <ecc76f93-d919-449d-62ff-d2f1b4bc0fae@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Chris Li <sparse@chrisli.org>, Junio C Hamano <gitster@pobox.com>

On Fri, Jun 2, 2017 at 2:11 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 01/06/17 21:27, Luc Van Oostenryck wrote:
>> sparse will warn if memcpy() (and some others memcpy-like
>> functions) is called with a very large static byte count.
>> But this warning cannot be disabled and the limit is arbitrary
>> fixed at 100000.
>>
>> The goal of this series is to allow to disable this warning if
>> found too unconvenient or to allow to configure its limit.
>>
>>
>> The series can also be found on the tree:
>>       git://github.com/lucvoo/sparse.git memcpy-max-count
>
> Heh, I think you know I wrote a similar patch about a decade ago ...
>
> [I tried to find it the other day but couldn't find it - I think
> it is on my old laptop, which doesn't get booted up these days!]

More or less, yes. I saw it in the email where you and Junio talked
about how this memset() warning was a bit blocking for git to use
sparse, which is the motivation of these 3 patches.

-- Luc
