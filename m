From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] introduce Wdirective_within_macro
Date: Thu, 12 Mar 2020 11:24:06 -0700
Message-ID: <CAHk-=wiNPBt4wNkfgSd_utshPkjqQv-z7cg5iCji2jbFAUrLkg@mail.gmail.com>
References: <20200312150909.GA3403@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40602 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgCLSYZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 12 Mar 2020 14:24:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id 19so7586139ljj.7
        for <linux-sparse@vger.kernel.org>; Thu, 12 Mar 2020 11:24:24 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id j17sm12725680ljc.0.2020.03.12.11.24.22
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 11:24:22 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id d23so7550787ljg.13
        for <linux-sparse@vger.kernel.org>; Thu, 12 Mar 2020 11:24:22 -0700 (PDT)
In-Reply-To: <20200312150909.GA3403@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Alexey Gladkov <gladkov.alexey@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Thu, Mar 12, 2020 at 8:09 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> When used on linux kernel, sparse issues a lot of "directive in macro's
> argument list" errors, "#if" within a macro invocation is widely used in
> the kernel code.

Ack. Downgrading to a warning is a good thing anyway.

I'd even be ok with making the default be "don't warn", and enable
warnings only if explicitly asked for, or perhaps with "pedantic" (not
that I think sparse cares about pedantic right now).

Yes, it's undefined behavior. But sparse does the right thing, and
it's the better thing to do. And it's not like we're necessarily
always particularly pedantic about some other cases.

Now, the example where somebody _redefined_ a macro inside the macro
expansion, that's a different thing. That's just crazy. Maybe we could
make that "directive in macro argument list" thing be a more nuanced
flag?

             Linus
