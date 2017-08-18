From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 17/29] ptrmap: core implementation
Date: Fri, 18 Aug 2017 23:35:48 +0200
Message-ID: <CAExDi1T_8uSA9FGWn-+s4e-aSxno7=W5mhxck1duBTr-1NYpXg@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <20170816153455.97693-18-luc.vanoostenryck@gmail.com> <CANeU7Q=KQOca4VAWurnkCUuRsGvVM-GDTBrdiee9h0ePqGoCKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34780 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752363AbdHRVfs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 17:35:48 -0400
Received: by mail-oi0-f48.google.com with SMTP id x3so109041010oia.1
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 14:35:48 -0700 (PDT)
In-Reply-To: <CANeU7Q=KQOca4VAWurnkCUuRsGvVM-GDTBrdiee9h0ePqGoCKw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Aug 18, 2017 at 11:02 PM, Christopher Li <sparse@chrisli.org> wrote:

>
> If you are going for simple. why not just make
> struct ptrpair as allocatable object then have
> struct ptrpair_list as normal ptrlist?

A bit less memory and one indirection less.

> The add would be normal ptrlist add.
> The lookup is just FOREACH_PTR loop.
> The update is lookup then change the value.
>
> That could safe you some code. The difference
> will be, your current ptrlist has better cache
> behavior. But if you care that much then it should
> move to hash implementation

It will be done soon.

-- Luc
