From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Thu, 6 Jul 2017 18:35:27 -0700
Message-ID: <CA+55aFyUN-anJrFmo25tATO2wJS8+24S8TK=PAZBEYr0LvZN8g@mail.gmail.com>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-2-luc.vanoostenryck@gmail.com> <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
 <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:34630 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753177AbdGGBf2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Jul 2017 21:35:28 -0400
Received: by mail-oi0-f53.google.com with SMTP id l130so16840275oib.1
        for <linux-sparse@vger.kernel.org>; Thu, 06 Jul 2017 18:35:28 -0700 (PDT)
In-Reply-To: <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jul 6, 2017 at 6:18 PM, Christopher Li <sparse@chrisli.org> wrote:
>
> Basiclly, the parent DO_FOR_EACH() has __nr caching the
> current ptr position. When the inner loop function delete
> one entry before the current position. The parent current
> position needs to be adjust, because the entry[] has been
> move forward.

Gaah.

I think the original idea for this was to call pack_ptr_list() only at
the end of all the list traversal that could delete things.

                 Linus
