From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: idea/question about sparse's context checking
Date: Fri, 18 Aug 2017 22:59:42 +0200
Message-ID: <CAExDi1Sn4q67_WcN6jSWKDSyxSSR2UPseTYm9Or9uopcQNn81w@mail.gmail.com>
References: <20170818132039.hii2siz5sjaua5qr@ltop.local> <CA+55aFxMcfPU4yVY6dNL0xiMQ8_hC7UrM0EgwggvxnhAq_ZXdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36497 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbdHRU7n (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 16:59:43 -0400
Received: by mail-oi0-f53.google.com with SMTP id g131so108090321oic.3
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 13:59:43 -0700 (PDT)
In-Reply-To: <CA+55aFxMcfPU4yVY6dNL0xiMQ8_hC7UrM0EgwggvxnhAq_ZXdA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Fri, Aug 18, 2017 at 9:34 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Aug 18, 2017 at 6:20 AM, Luc Van Oostenryck wrote:
>
> I think that's a great idea.
I confess that it's totally copied from how it's done for the return value.

> We do all the flow stuff for variables
> anyway, and using a hidden variable would make it potentially a lot
> more flexible. You could make the context op do much more than just a
> fixed inc/dec.

Yes, I see potential too, but nothing very specific. Have you something in mind?

-- Luc
