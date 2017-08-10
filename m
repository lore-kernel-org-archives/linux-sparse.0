From: Christopher Li <sparse@chrisli.org>
Subject: Re: [GIT PULL] patches for -rc5
Date: Wed, 9 Aug 2017 20:48:27 -0400
Message-ID: <CANeU7Q=rxqJ3J1eH7b-QbiiV4JPg6CyDFYGhYiA1-nGEy4sk-A@mail.gmail.com>
References: <20170809004307.16663-1-luc.vanoostenryck@gmail.com>
 <20170809192015.li6dmzg3griy6uug@ltop.local> <CANeU7Q=JLy294tJiVVU=4Z0PhEQPgpgZwwcHSyCEsb1_W+k6ZQ@mail.gmail.com>
 <CAExDi1T-r4WRx_uGPGYJZ2Kk7PtN5hu4A+3+VNB9YDx1w42rHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:36023 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752219AbdHJAs2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 20:48:28 -0400
Received: by mail-yw0-f171.google.com with SMTP id u207so49930554ywc.3
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 17:48:28 -0700 (PDT)
In-Reply-To: <CAExDi1T-r4WRx_uGPGYJZ2Kk7PtN5hu4A+3+VNB9YDx1w42rHw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Aug 9, 2017 at 8:32 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> I have no problem for you to take only till the preceding ref.
> But as we agreed and so that you just have something that fast-forward to
> master *all* the changes must come from my tree first. I do the integration
> and you just pull from me.
> It's exactly what you asked and we agreed, right?
>

We agree to give this a try. I already realize this is not going to work.
Please drop that. One big consideration is that, I give up the "clean up the
history" thing on sparse-next. So no more rebase on the sparse-next.

From now on I will just do the normal git merge on master. I don't think we
need to go through your branch again, because there is no leading sparse-next
any more.

So the model will be, you give me pull request. I either give feed back or just
merge it. If there is a bug or improvement. We will do incremental fix
on master.
Just like the other git base open source project.

I will never rebase any thing on master, especially your changes.

Sorry about going back and forth. I think that is the right thing to do.
It will actually simplify things a lot. I admit the "clean up of
history" thing is
stupid. Linus was right about that. I should just do the normal merges
and take your
tree as it is.

So you can actually just send me the topic changes merge request.
If you want to send me combined merge request that is fine too.
Branch name does not matter any more.

Please give me a bit time to release RC5 before revisit your new patches.

Thanks for the great work.

Chris
