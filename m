From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse-next and preview of 0.5.1-rc5
Date: Sun, 16 Jul 2017 21:20:38 -0400
Message-ID: <CANeU7QnL+96T_ngrcgwHREey0TF8a6ENo4ehScKtX2PfBOvnew@mail.gmail.com>
References: <CANeU7Qk-9RcNkWoEL5-0AKyd2Q30BvtjfivEG_KgD4kAH-aEdA@mail.gmail.com>
 <20170715182159.ltikqlbe6rktxfhz@ltop.local> <CANeU7Qkt4+QsgrrwUSwiiJ_V77gnJgb5YW0qSwwx1-uu9-GhLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36187 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbdGQBUj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 16 Jul 2017 21:20:39 -0400
Received: by mail-pf0-f181.google.com with SMTP id q86so68656348pfl.3
        for <linux-sparse@vger.kernel.org>; Sun, 16 Jul 2017 18:20:39 -0700 (PDT)
In-Reply-To: <CANeU7Qkt4+QsgrrwUSwiiJ_V77gnJgb5YW0qSwwx1-uu9-GhLw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>

On Sat, Jul 15, 2017 at 10:34 PM, Christopher Li <sparse@chrisli.org> wrote:

> Of course.  I will hold the RC5 for you. I haven't push the change to
> master yet. It is only in sparse-next, I can still roll back the change in we
> wants to.
>
> Can you show me some C input file that your original patch will do the
> right thing and current one will miss the opportunity to simplify?
> Even for the case it is just a suspect of producing worse code is fine.
> Just point me to some test case, I will investigate and compare the
> results.

Ping. I am still waiting for your test source to compare the two
approach of kill_unreachable_bb(). If both generate the equivalent result,
I prefer the simpler approach.

I will hold the RC5 until Wednesday if I don't have additional input.

Thanks

Chris
