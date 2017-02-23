From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] fix expansion cost of pure functions
Date: Wed, 22 Feb 2017 17:01:03 -0800
Message-ID: <CA+55aFz_+qEteX-o-2O+=RWiNWQ-N603vFDUNTBG8W2Bn11Png@mail.gmail.com>
References: <20170216154532.9261-1-luc.vanoostenryck@gmail.com> <CANeU7QkmOAAbOJs_QYnxh4O=J7y_Vbg8rM5jmdzKvvL5q_XFxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34705 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932456AbdBWBBw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Feb 2017 20:01:52 -0500
Received: by mail-oi0-f54.google.com with SMTP id 65so10603326oig.1
        for <linux-sparse@vger.kernel.org>; Wed, 22 Feb 2017 17:01:04 -0800 (PST)
In-Reply-To: <CANeU7QkmOAAbOJs_QYnxh4O=J7y_Vbg8rM5jmdzKvvL5q_XFxg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Feb 22, 2017 at 3:57 PM, Christopher Li <sparse@chrisli.org> wrote:
>
> I think dropping to zero has some thing to do with get rid of
> the side effect cost. So it possible the cost can be dropping.

No, I think the zero is just a bug, introduced in commit 8376ab091a
("sparse: Fix __builtin_safe_p for pure and const functions").

I might be missing something, but I think Luc's patch is fine.

              Linus
