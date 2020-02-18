From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/3] struct_union_enum_specifier: set MOD_TOPLEVEL if
 toplevel(sym->scope)
Date: Tue, 18 Feb 2020 16:59:30 +0100
Message-ID: <20200218155930.ouldse3f47lna43z@ltop.local>
References: <20200214113320.GA31578@redhat.com>
 <20200217214610.uxbnfh5zooqve4yc@ltop.local>
 <20200218103837.GA3466@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40437 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgBRP7e (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 18 Feb 2020 10:59:34 -0500
Received: by mail-wm1-f68.google.com with SMTP id t14so3480817wmi.5
        for <linux-sparse@vger.kernel.org>; Tue, 18 Feb 2020 07:59:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200218103837.GA3466@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

On Tue, Feb 18, 2020 at 11:38:38AM +0100, Oleg Nesterov wrote:
> On 02/17, Luc Van Oostenryck wrote:
> >
> > On Fri, Feb 14, 2020 at 12:33:20PM +0100, Oleg Nesterov wrote:
> > > With this change dissect can know the scope of SYM_STRUCT/UNION/ENUM,
> > > see the next patch.
> > >
> > > Note that MOD_TOPLEVEL can be set even if struct/union/enum type is
> > > private and bind_symbol() is not called.
> >
> > I don't like that very much. For example: why this is needed for
> > struct/union/enum and not other types?
> 
> Do you mean builtin types like int_ctype? OK, I agree, this is slightly
> inconsistent.

I was thinking of the other constructed types: arrays & pointers.
 
> > Should it be possible to use the function toplevel() or add and
> > helper for it in scope.c?
> 
> Well, toplevel() won't work if SYM_STRUCT/etc is anonymous, in this
> case bind_symbol() is not called and thus sym->scope = NULL.
> 
> Consider
> 
> 	struct { int m; } x;
> 
> 	void func(void)
> 	{
> 		struct { int m; } x;
> 
> 	}
> 
> we want to report the 2nd struct definition as "local"
> 
>    1:8                    def   s :x
>    1:14                   def   m :x.m                             int
>    1:19                   def   v x                                struct :x
>    3:6                    def   f func                             void ( ... )
>    5:16  func             def . s :x
>    5:22  func             def . m :x.m                             int
>    5:27  func             def . v x                                struct :x
> 
> so that this spam can be filtered out, but base->scope is NULL in both
> cases.

OK, I see.
 
> > > IIUC nobody else looks at SYM_STRUCT->ctype.modifiers, "make check"
> > > doesn't show any difference.
> >
> > Yes, it's true and it shouldn't make any difference but still I
> > would prefer to not mix symbols and types more than they already are.
> 
> OK, will you agree with one-liner below? This should make toplevel() work.

This will still be inconsistent with the other types but I can live
with this. If you could just add a comment explaining why it is needed
and using an helper instead of directly using 'block_scope' (like
set_[current_]scope() or something).

-- Luc
