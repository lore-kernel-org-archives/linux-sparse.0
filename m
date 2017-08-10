From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2 1/8] Remove single-store shortcut
Date: Thu, 10 Aug 2017 09:25:02 -0400
Message-ID: <CANeU7Q=vqEoE9BZ2OyFWNG+y0A59BpLM57CFTZonV0Ay3T3Y8Q@mail.gmail.com>
References: <CACXZuxd30jwczag_GHW3cmqPcBybEi7jfwfku81vW2nHzo_kyA@mail.gmail.com>
 <20170807191205.86590-1-luc.vanoostenryck@gmail.com> <20170807191205.86590-2-luc.vanoostenryck@gmail.com>
 <CANeU7QkmmQOx90sZUsn+8BGCN8Jcz40_8xWBzGZvRYk0GuX=PA@mail.gmail.com> <CAExDi1TGUP9TETWGYguiaa0yjLPhs81k7WakWSSzramJm8pRSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:36788 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752335AbdHJNZD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 09:25:03 -0400
Received: by mail-yw0-f176.google.com with SMTP id u207so4418531ywc.3
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 06:25:03 -0700 (PDT)
In-Reply-To: <CAExDi1TGUP9TETWGYguiaa0yjLPhs81k7WakWSSzramJm8pRSg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Aug 10, 2017 at 8:26 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Anyway, it's very temporary because the code still put the
> phi-nodes at wrong places.
> This simplify_one_symbol() is replaced by the new SSA construction
> branch.
>
> Believe it or not but this placement of phi-nodes is a much bigger
> issue than those undefined vars. For example, on the kernel,
> this patch has exactly zero (visible) effect. But every non-trivial
> piece of code is plainly very wrong because of those bad phi-nodes.

I can totally see that.

My way to explain to myself is that, it is all about the SSA
dominance property. Violate the properly == bad things can
happen.

I can use the property to reason about phi node placements,
Also reason this patch as well.

> Yes, I'll do later.
> (if you want just for testing, please take the ref in the cover letter
> and drop the top patches. Unless comments from you, I don't
> have the intention to change something to these two patches)

I can do more testing too.

Thanks!

Chris
