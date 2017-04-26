From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC] rationale for systematic elimination of OP_SYMADDR instructions
Date: Thu, 27 Apr 2017 01:04:55 +0200
Message-ID: <CAMHZB6F95R_Kx6zB3wxfogtX8vjqDWzC0EwHH85_M-xryxqVdA@mail.gmail.com>
References: <20170309142044.96408-1-luc.vanoostenryck@gmail.com>
 <CANeU7QkhQJrGifw5zvRoN27yVEfmU23B+HG5KQy3R9G3aKWUgw@mail.gmail.com>
 <CAMHZB6EE93YSm0gVUr=dhNpsTZ1vU8acJ9msyh3VSdTOTVUq-w@mail.gmail.com> <CA+55aFxY_yMJxF2rLpBVYHPwNaWnvvXH-P0Ud1tYi8rE1g7tqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:34329 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032481AbdDZXE5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 26 Apr 2017 19:04:57 -0400
Received: by mail-qt0-f177.google.com with SMTP id c45so13564177qtb.1
        for <linux-sparse@vger.kernel.org>; Wed, 26 Apr 2017 16:04:57 -0700 (PDT)
In-Reply-To: <CA+55aFxY_yMJxF2rLpBVYHPwNaWnvvXH-P0Ud1tYi8rE1g7tqg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Apr 26, 2017 at 6:15 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> Ack. I think the OP_SYMADDR elimination was wrong, and your patch is
> the right thing to do.
>
> It was done to roughly approximate the 32-bit x86 code, making the
> pseudo-asm that the linearizer outputs look more like x86 address
> generation, but you're right, it's bogus.

OK, thanks.
Now I just need to go hunt the regression I saw when I made and used
the patch. But that's another story.

-- Luc
