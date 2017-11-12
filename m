From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/2] Fix illegal simplification of volatile stores
Date: Sun, 12 Nov 2017 09:14:28 +0800
Message-ID: <CANeU7QnSOro=WkH_VBoGGCPonAaw-hMGJTVG_8OQPzm19zKvaQ@mail.gmail.com>
References: <20171111162500.69476-1-luc.vanoostenryck@gmail.com>
 <CANeU7QnJgGdWtM3KkJOtWG72v_soBZfeXGkqMUmQcv-L=NM5oQ@mail.gmail.com> <20171111225218.m3cqbid6ug7r57jw@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:43942 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752276AbdKLBO3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 20:14:29 -0500
Received: by mail-yw0-f175.google.com with SMTP id y75so10965792ywg.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 17:14:29 -0800 (PST)
In-Reply-To: <20171111225218.m3cqbid6ug7r57jw@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Nov 12, 2017 at 6:59 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sun, Nov 12, 2017 at 01:29:08AM +0800, Christopher Li wrote:
>
> If you would do that:
> 1) it would be equivalent to rebasing one of my branches
> 2) it make me wonder if I have misunderstood something to the way
>    we had, some months ago, agreed to work together.

Just asking. Because you start to send patches like the build
series I don't intend to apply. I need to know it fall into the same
category.

> 3) it make me wonder why there is 67 branches in my github
>    tree waiting for you to pull them, most having been totally
>    ignored by you, a good number of them being 7 or 8 months old
>    with a few even older (not talking about the dozens of other
>    topic branches that I've never bothered to submit because they
>    don't make sense without their parent branches).

Hey, I assume you mean the llvm fix series.

We have agreement that will resume the pull again after the 5.0.1.
Which means right now. That series I just send out one important
feed back about the OP_PUSH. I thought I have send that one out
but I just find out it haven't. That is my bad.

Once we finalize a solution for that, that series is pull-able.

Please response to that email.

> 4) it make me wonder why this sudden promptitude from your part.
>

I am confused and need some clarification as well.

Chris
