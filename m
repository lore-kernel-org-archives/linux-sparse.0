From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] fix: kill unreachable BBs after killing a child
Date: Tue, 9 May 2017 09:08:45 -0700
Message-ID: <CANeU7QnpFci3ViG9dP1g5x1wPKnR=dAXCiLwnD4buD9t1NyaeA@mail.gmail.com>
References: <20170508185710.22021-1-luc.vanoostenryck@gmail.com>
 <CANeU7Q=RU6PbRFFd7ZT4=bQh7-rHW=c9K+9bUPReSKuQmq8FqQ@mail.gmail.com> <20170509152716.weyudhvs7po23vnt@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:35645 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754123AbdEIQIr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 9 May 2017 12:08:47 -0400
Received: by mail-io0-f178.google.com with SMTP id f102so4892328ioi.2
        for <linux-sparse@vger.kernel.org>; Tue, 09 May 2017 09:08:47 -0700 (PDT)
In-Reply-To: <20170509152716.weyudhvs7po23vnt@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, May 9, 2017 at 8:27 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Like a lot of things, it depends.
> For example, the kernel use a lot inline functions or macro with
> code like:
>         ...
>         switch (sizeof(x)) {
>         case 1: ...
>         case 2: ...
>         case 4: ...
>         case 8: ...
>         default: issue a build error
>         }

Ha, that is good to know.

> Also, the simplification concerned here is 'insert_branch()'
> which, like I explained in the commit message, is used by the
> switch simplification but is also used by other branch
> simplifications.
>
>> Have two switch
>> statement in same function get simplify at the same time should be
>> even rarer.
>> Might not worth the effort to optimize for that.
>>
>> As it is, the patch is acceptable.
>
> I really also would prefer that we would not have to walk the BBs
> but I really think we don't have good others choices.

Yes, that is what I am afraid as well, it might not worth the complexity
try to optimist for it.

I have not problem walk the BBs, I just don't want to walk it more than
once if easy avoidable. Looks like there is no easy way to get it.

Let's leave it as it is.  You convinced me.  ACK.

Chris
