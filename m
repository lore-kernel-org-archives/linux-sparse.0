From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] introduce Wdirective_within_macro
Date: Thu, 12 Mar 2020 20:12:55 +0100
Message-ID: <20200312191255.j7ifliuaqmuq3us4@ltop.local>
References: <20200312150909.GA3403@redhat.com>
 <CAHk-=wiNPBt4wNkfgSd_utshPkjqQv-z7cg5iCji2jbFAUrLkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51202 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLTNA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 12 Mar 2020 15:13:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id a132so7354747wme.1
        for <linux-sparse@vger.kernel.org>; Thu, 12 Mar 2020 12:12:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHk-=wiNPBt4wNkfgSd_utshPkjqQv-z7cg5iCji2jbFAUrLkg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexey Gladkov <gladkov.alexey@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Thu, Mar 12, 2020 at 11:24:06AM -0700, Linus Torvalds wrote:
> On Thu, Mar 12, 2020 at 8:09 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > When used on linux kernel, sparse issues a lot of "directive in macro's
> > argument list" errors, "#if" within a macro invocation is widely used in
> > the kernel code.
> 
> Ack. Downgrading to a warning is a good thing anyway.
> 
> I'd even be ok with making the default be "don't warn", and enable
> warnings only if explicitly asked for, or perhaps with "pedantic" (not
> that I think sparse cares about pedantic right now).

*nod*
 
> Yes, it's undefined behavior. But sparse does the right thing, and
> it's the better thing to do. And it's not like we're necessarily
> always particularly pedantic about some other cases.
> 
> Now, the example where somebody _redefined_ a macro inside the macro
> expansion, that's a different thing. That's just crazy. Maybe we could
> make that "directive in macro argument list" thing be a more nuanced
> flag?

Yes, it's what I was thinking too. The #if*/#elif/#else/#endif should be
perfectly safe here. A redefine is indeed crazy, same for a self-#undef
IMO (even if its meaning is better defined and I think it would need a
small change with sym->expansion), #include could make some sense
but probably should be avoided too, like the other directives.

-- Luc
