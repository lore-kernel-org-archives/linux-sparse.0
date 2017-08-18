From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: idea/question about sparse's context checking
Date: Fri, 18 Aug 2017 12:34:43 -0700
Message-ID: <CA+55aFxMcfPU4yVY6dNL0xiMQ8_hC7UrM0EgwggvxnhAq_ZXdA@mail.gmail.com>
References: <20170818132039.hii2siz5sjaua5qr@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36445 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbdHRTeo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 15:34:44 -0400
Received: by mail-oi0-f52.google.com with SMTP id g131so106182952oic.3
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 12:34:44 -0700 (PDT)
In-Reply-To: <20170818132039.hii2siz5sjaua5qr@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Fri, Aug 18, 2017 at 6:20 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> My idea/question is the following: this interpretation
> is already done for all 'normal' values. So couldn't we
> consider the context as a special kind of 'variable',

I think that's a great idea.  We do all the flow stuff for variables
anyway, and using a hidden variable would make it potentially a lot
more flexible. You could make the context op do much more than just a
fixed inc/dec.

                    Linus
