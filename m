From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 05/13] add get_nth1_arg()
Date: Mon, 6 Mar 2017 17:52:06 +0100
Message-ID: <20170306165205.ryo63cytkfq3lffq@macpro.local>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
 <20170305112047.3411-6-luc.vanoostenryck@gmail.com>
 <CANeU7Qma7hJQeLjc83aXR-cNGA3w7Z4cQDYFstK3PrUWUfZDaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38255 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754108AbdCFUpF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Mar 2017 15:45:05 -0500
Received: by mail-wm0-f46.google.com with SMTP id t193so75064986wmt.1
        for <linux-sparse@vger.kernel.org>; Mon, 06 Mar 2017 12:45:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qma7hJQeLjc83aXR-cNGA3w7Z4cQDYFstK3PrUWUfZDaw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Mon, Mar 06, 2017 at 10:40:17PM +0800, Christopher Li wrote:
> On Sun, Mar 5, 2017 at 7:20 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > A backend may need to know the size or the type of an
> > argument and there is no easy way to access to this info.
> 
> Actually, there is a way to do it with two list iterative. Will comment
> it on the next patch that use the get_nth1_arg().
> 
> 
> > +static inline struct symbol *get_nth1_arg(struct symbol *fn, int idx)
> > +{
> > +       struct symbol_list *args = fn->ctype.base_type->arguments;
> > +       struct symbol *arg;
> > +       int i = 0;
> > +       FOR_EACH_PTR(args, arg) {
> > +               if (++i == idx)
> > +                       return arg;
> > +       } END_FOR_EACH_PTR(arg);
> > +
> > +       return NULL;
> 
> As I said, I am not sure this is necessary in the particular case.
> However, the nth list entry is some what useful. If we add that,
> we should add it to ptrlist.c. Then every time of ptr_list can have it.
> 
> Also, there is no need to do "++i", it should use the list->nr to skip
> over the list node for the case where n is relative large. Then only do the
> counting inside the list node. If list is packed, it is every easier, we can
> just return from the index. Depend on we want to allow unpacked list
> or not.

Absolutely, this can be optimized.

But this serie is a work in progress to help Dibyendu and I won't
otherwise spend much time on sparse-llvm.

It should also be noted that, in general, counting the list entries
via the list->nr can be problematic as some part of the code store
NULL pointers to remove entries (but it's not the case here with
the arguments).

Luc Van Oostenryck
