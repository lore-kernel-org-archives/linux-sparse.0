From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/6] storage should not be inherited by pointers
Date: Mon, 28 Nov 2016 03:02:53 +0100
Message-ID: <20161128020252.GA744@macbook.local>
References: <20161124170947.14379-1-luc.vanoostenryck@gmail.com>
 <20161124170947.14379-2-luc.vanoostenryck@gmail.com>
 <CANeU7QnGdG8x+1SzKP7e8f6Gan8VZh7MNMGpZ=E3JwSQ2xYkAw@mail.gmail.com>
 <20161125033817.GA14283@macbook.local>
 <CANeU7QkyTrCLZHbeVt+VFPL__DGbhBtGpK0hPsuFsPrzKaFL-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33076 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753216AbcK1CDX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 27 Nov 2016 21:03:23 -0500
Received: by mail-wm0-f65.google.com with SMTP id u144so16547549wmu.0
        for <linux-sparse@vger.kernel.org>; Sun, 27 Nov 2016 18:02:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QkyTrCLZHbeVt+VFPL__DGbhBtGpK0hPsuFsPrzKaFL-Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Nov 28, 2016 at 09:04:56AM +0800, Christopher Li wrote:
> Sorry I jump the conclusion. If it is only concern with MOD_STATIC,
>  MOD_EXTERN & MOD_TOPLEVEL, that is not a bug issue at all.
> I thought you are going to extend that logic to other modifier bits as well.

Well ... yes and no :)
Like it can be seen in the other patches, I mostly just
wrote some tests that, I think, clearly expose soem problems.
Those problems can be considered as bugs or not, some clearly are,
I think, some much less so but trigger questions.

I think we should clearly define what is the desired behavior of
modifiers like nocast, noderef, bitwise, ... when
- taking the address of an object with such modifiers
- using typeof() on such object or pointers
- assignment with them (but this seems much better done/defined)

The case with 'safe' is similar but its working is a bit different.

And indeed, like I think you fear, any changes regarding the
address_space will create problems in existing code and
it's why I think it's better for now to first look at the situation
with the modifiers.

You certainly can see this seriemore  as the start of a reflexion
than a try to solve anything.

Luc
