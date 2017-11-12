From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/2] Fix illegal simplification of volatile stores
Date: Sun, 12 Nov 2017 17:57:32 +0800
Message-ID: <CANeU7Q=o+90-BL9RSwONBLmVfvD-RWkDubBskksuvLah1zi8fg@mail.gmail.com>
References: <20171111162500.69476-1-luc.vanoostenryck@gmail.com>
 <CANeU7QnJgGdWtM3KkJOtWG72v_soBZfeXGkqMUmQcv-L=NM5oQ@mail.gmail.com>
 <20171111225218.m3cqbid6ug7r57jw@ltop.local> <CANeU7QnSOro=WkH_VBoGGCPonAaw-hMGJTVG_8OQPzm19zKvaQ@mail.gmail.com>
 <CAExDi1QwQFQ+dci=j5KrB6_Q65JD496J0U4w_Hv7usHwb-qj-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:50477 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbdKLJ5d (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Nov 2017 04:57:33 -0500
Received: by mail-yw0-f174.google.com with SMTP id i198so11308606ywe.7
        for <linux-sparse@vger.kernel.org>; Sun, 12 Nov 2017 01:57:33 -0800 (PST)
In-Reply-To: <CAExDi1QwQFQ+dci=j5KrB6_Q65JD496J0U4w_Hv7usHwb-qj-g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Nov 12, 2017 at 1:19 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The LLVM fixes series and the 66 others series.

I see one pull request for llvm fixes. Where is your other 66
freaking pull request?

> Chris ...
> v0.5.1 was out mid-August (and you made a very long and painful thing of it).

Well it is kind of long and painful due to the bugs we found
at the last stage. What do you expect? ship with the bugs?

> You ignored the last pull request for 7 weeks.

Yes, that is 68 patches it take some time for me to
go through. Didn't the sending patches documents
mention 15 patches at a time?

Yes, I have very limited time to hack on sparse.
But I do have the best intention for sparse.
I do give me my effort to work on sparse with the
resource on my hand. Recently I have been traveling
a lot so my time is very spotted. I haven't been the
best of maintainer and I apologize for that.
I do want to work with you to get this thing merged.

As we agree, I don't pull if I am not complete happy with
the series. Why do you keep refusing to make any change
to your pull request. I even offer I pull into topic branch
and I personally fix it for you on top your change. You have
no reply on that regard.

If you want the code get merged, you need to work with
maintainer. Smearing the maintain and refuse to make any
change does not help to get your code merge. It only
help you to advance your political agenda.

For example, if you drop the unresolved OP_PUSH patches
from the series. I can pull your llvm-fix now.
Do you want to do that? Or that is not an option for you?

>
>> That series I just send out one important
>> feed back about the OP_PUSH. I thought I have send that one out
>> but I just find out it haven't. That is my bad.
>
> Is that serious?

Well not as serious as you don't provide any solutions to resolve
the issue in hand. I am object to the OP_PUSH, that one need more
discussion. Can we have a solution to merge the rest?

> Given how you have been so good the last 2-3 years at ignoring
> patches & series, must I, once more, trust you and believe this?

Luc, being an open source developer, you need to
have an open mind. It has came to my attention you
seems have some dubious intentions of doing things.

Chris
