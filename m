From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 3/3] add support for -fmemcpy-max-count
Date: Fri, 2 Jun 2017 03:45:07 +0200
Message-ID: <CAMHZB6EtTDXkDLKumGnyBm9n3vbNNEGLnGqT9mndL+r77q2emA@mail.gmail.com>
References: <84e547c2-8a5b-225c-1363-361e091821f4@ramsayjones.plus.com>
 <20170601202724.77597-1-luc.vanoostenryck@gmail.com> <20170601202724.77597-4-luc.vanoostenryck@gmail.com>
 <45f3b371-2839-5353-17a7-ea82b113d4f1@ramsayjones.plus.com>
 <CAMHZB6GT8d2UUBO2po+o0QLaBh_3ZOLgA0_zYz7s1_xgDr4DQA@mail.gmail.com> <faa88d94-b243-e8be-39f0-b84ccbf92ba0@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35495 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751134AbdFBBpJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Jun 2017 21:45:09 -0400
Received: by mail-qk0-f194.google.com with SMTP id v195so8013412qka.2
        for <linux-sparse@vger.kernel.org>; Thu, 01 Jun 2017 18:45:09 -0700 (PDT)
In-Reply-To: <faa88d94-b243-e8be-39f0-b84ccbf92ba0@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Chris Li <sparse@chrisli.org>, Junio C Hamano <gitster@pobox.com>

On Fri, Jun 2, 2017 at 3:42 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:

>> Well, for now setting the limit to 0 would just warn about any
>> non-zero memcpy/memset
>> but it's something that could very easily be added, sure.
>
> Yes, as I noted in another email, I didn't read the code correctly!
> (and in my patch I had a single -Wmem-limit=n argument which _did_
> disable the check when n = 0).
>
> Naming issues aside (and I'm bad at naming, so don't listen to me
> on that), I like your -W[no-]memcpy-max-count and -fmemcpy-limit=n
> split.
>
> [You may want to remove the '=COUNT' from the commit message of
> the 2/3 patch].

Oh yes, indeed.
Thanks.

-- Luc
