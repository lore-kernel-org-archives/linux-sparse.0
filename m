From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 5/7] check the storage of C99 for-loop initializers
Date: Sun, 5 Mar 2017 16:24:25 +0100
Message-ID: <20170305152424.sifq45zp5qdff6fd@macpro.local>
References: <20170228094635.qbod5dwqwrw6etvt@macbook.local>
 <20170228100403.33184-1-luc.vanoostenryck@gmail.com>
 <20170228100403.33184-6-luc.vanoostenryck@gmail.com>
 <CANeU7Qn0Tk=cJdiXY4fjNkdOXnECmvZHCeoD-2dW6B0TceQQmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:34337 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbdCEPZy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 10:25:54 -0500
Received: by mail-wr0-f179.google.com with SMTP id l37so101350445wrc.1
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 07:24:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qn0Tk=cJdiXY4fjNkdOXnECmvZHCeoD-2dW6B0TceQQmQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Mar 05, 2017 at 10:26:53PM +0800, Christopher Li wrote:
> >
> > +static void process_for_loop_decl(struct symbol_list **list, struct symbol *sym)
> > +{
> > +       ...
> > +       add_symbol(list, sym);
> > +       fn_local_symbol(sym);
> 
> The more I look at it, the more I feel that the above two lines
> should kind of appear in every process_*_declar function.

I agree and it certainly does for the current two cases.
And it's why I've kept the symbol_list as type.
But I understood you thought differently in your previous
comment:
	"The default function can be adding the symbol to a list.
	So the struct symbol_list **list should turn into transparent
	argument as context for the call back."

> So may be we should just change your patch 4/7 into:
> 
>                if (!is_typedef) {
> 
> +                     if (process_decl)
> +                                process_decl(sym);
> 
>                        if (!(decl->ctype.modifiers & (MOD_EXTERN |
> MOD_INLINE))) {
>                                add_symbol(list, decl);
>                                fn_local_symbol(decl);
>                        }
>                }
> 
> Then for the default case, just pass NULL as process_decl. Might want
> to find a better name for this function callback arguments as well.
> 
> Because you are actually not interested in change the behavor of adding
> to the list at all. You just want to get an notification when the symbol does
> get added into the list. Now thing of it, I can't come up with one example
> process_xxx_decl not add the symbol nor doing the fn_local_symbol.

Yes.
I almost came with a solution with an ops struct with two operations:
- one that do some checking
- another that do the 'action' like adding to the list
But then it wasn't needed for the default & c99-for-loop cases here.

I'll see what can be done.

Luc
