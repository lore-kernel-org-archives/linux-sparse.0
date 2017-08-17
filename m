From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 06/29] topasm: top-level asm is special
Date: Thu, 17 Aug 2017 21:22:04 +0200
Message-ID: <CAExDi1QdaVuJdTEh_uM9tA=UE0COH8jvM5jCigrBp2HS+4r-JQ@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <20170816153455.97693-7-luc.vanoostenryck@gmail.com> <CANeU7QkxQJ7aWiduHT1anBAU+_rhgjwbfXi+wVjXE=ib9hW-0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33825 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752403AbdHQTWF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 15:22:05 -0400
Received: by mail-oi0-f49.google.com with SMTP id x3so76429819oia.1
        for <linux-sparse@vger.kernel.org>; Thu, 17 Aug 2017 12:22:05 -0700 (PDT)
In-Reply-To: <CANeU7QkxQJ7aWiduHT1anBAU+_rhgjwbfXi+wVjXE=ib9hW-0A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Aug 17, 2017 at 8:49 AM, Christopher Li <sparse@chrisli.org> wrote:
>>
>> +       if (!sym->ident) {      // top-level asm
>
> Maybe here we should check the statement is really top-level asm?
> Later on we might have more than top-level asm as with sym->ident == NULL.

Sure but it's currently how they must be detected.

In fact (like the name may suggest) this patch is part of a series
that better deal with top-level asm (they are not really statement!').
For example, top-level asm must be parsed as basic asm and not
extended asm.

So yes, I totally agree, but not now.

-- Luc
