From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] fix expansion cost of pure functions
Date: Thu, 23 Feb 2017 07:57:00 +0800
Message-ID: <CANeU7QkmOAAbOJs_QYnxh4O=J7y_Vbg8rM5jmdzKvvL5q_XFxg@mail.gmail.com>
References: <20170216154532.9261-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:35093 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932894AbdBWA2l (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Feb 2017 19:28:41 -0500
Received: by mail-it0-f54.google.com with SMTP id 203so157045583ith.0
        for <linux-sparse@vger.kernel.org>; Wed, 22 Feb 2017 16:28:36 -0800 (PST)
In-Reply-To: <20170216154532.9261-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Feb 16, 2017 at 11:45 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Expansion cost of an expression should be a monotonically
> increasing function of its sub-expressions.
>
> Here, for the costs of calling a pure function, the costs is
> reset to zero (wich is used when the expression expand to
> a constant/to test if the expression is a constant or not).
>
> Fix this by setting the cost as the total expansion cost of
> all the arguments plus one for the function itself.

I am not sure about this one, adding CC to Linus.

Currently pure function and constant function both share MOD_PURE.
If the function has attribute "pure" or "constant", then the user is
telling the compiler this function does not have side effects.

I think dropping to zero has some thing to do with get rid of
the side effect cost. So it possible the cost can be dropping.
But maybe it shouldn't drop to zero.

Chris
