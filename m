From: Chris Li <christ.li@gmail.com>
Subject: Re: [PATCH 2/3] allow builtins to have prototype and evaluate/expand methods
Date: Mon, 13 Feb 2017 07:35:15 +0800
Message-ID: <CANeU7Q=k-0RfkYH5hHQxwpm=qCN+cG6EFLK2AtsAfVeUEycg9w@mail.gmail.com>
References: <20170123213728.89900-1-luc.vanoostenryck@gmail.com>
 <20170123213728.89900-3-luc.vanoostenryck@gmail.com> <CANeU7QkTLwcVq4Spv4CcZjpjuZybW1=39Z5hU=5Qu6jYGB8=EA@mail.gmail.com>
 <20170212150332.33xlxmzohgb7hrpp@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:35648 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdBLXfR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Feb 2017 18:35:17 -0500
Received: by mail-it0-f67.google.com with SMTP id 203so10300704ith.2
        for <linux-sparse@vger.kernel.org>; Sun, 12 Feb 2017 15:35:16 -0800 (PST)
In-Reply-To: <20170212150332.33xlxmzohgb7hrpp@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>

On Sun, Feb 12, 2017 at 11:03 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> OK, I've look at this.
> The difference between your patch and mine is that yours share/
> migrate the methods for all symbols while mine purposely did that
> for builtins only. The reasons I did this way was to avoid to share

That to me is actually not the main difference. Yes, the one line patch
is simple and apply op to all symbol has the same name.
If we need, we can make that migrate code into a function and do
some special handing for builtin etc. I just don't see the need for
that right now.

The big difference I see is the solve the problem at symbol creating
side rather than symbol usage side.

In the future, we can make migrate symbol only return symbol are
new (and has incremental difference). Totally drop the symbol which
is the exact same abstract declare as the previous one.

> methods between things that don't need to, for example if someone
> define a function that have the same name as one of the numerous
> attributes (which are not reserved keywords and aren't necessarily
> protected by leading double underscore). But having look at this now,
> I see that it should never be a problem when this happen (but is it
> a good idea?).

Even if that became a problem, we can add some code to deal with
it. E.g. conditionally migrate some symbol information.

Chris
