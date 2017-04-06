From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/4] fix implicit zero initializer.
Date: Thu, 6 Apr 2017 16:39:53 -0700
Message-ID: <CA+55aFzH_69Yhqa+V+j64_Q4h2V9G_QsXj5HSuNL2bfwbrxckw@mail.gmail.com>
References: <20170406230029.11384-1-luc.vanoostenryck@gmail.com> <20170406230029.11384-5-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:35324 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755403AbdDFXjy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Apr 2017 19:39:54 -0400
Received: by mail-io0-f179.google.com with SMTP id z13so40299046iof.2
        for <linux-sparse@vger.kernel.org>; Thu, 06 Apr 2017 16:39:54 -0700 (PDT)
In-Reply-To: <20170406230029.11384-5-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Thu, Apr 6, 2017 at 4:00 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The C standard requires that, when initializing an aggregate, all
> fieds not explicitly initialized shall be implicity zero-initialized

Note the "all fields".

Which is not the same as "the whole aggregate" which is what you do.
The parts that don't have fields at all are undefined.

I think your patch is fine, and you might as well clear the whole
backing store, but I think strictly speaking you're initializing more
than what the standard says.

                Linus
