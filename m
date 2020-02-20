From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 1/2] struct_union_enum_specifier: always initialize
 sym->scope
Date: Thu, 20 Feb 2020 13:15:44 +0100
Message-ID: <20200220121544.7kwxkuytjzahk7ed@ltop.local>
References: <20200219162911.GA26790@redhat.com>
 <20200220005602.gd22zbd7c5qy4t6k@ltop.local>
 <20200220115736.GB27143@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38848 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgBTMPr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 20 Feb 2020 07:15:47 -0500
Received: by mail-wm1-f67.google.com with SMTP id a9so1804952wmj.3
        for <linux-sparse@vger.kernel.org>; Thu, 20 Feb 2020 04:15:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200220115736.GB27143@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

On Thu, Feb 20, 2020 at 12:57:37PM +0100, Oleg Nesterov wrote:
> On 02/20, Luc Van Oostenryck wrote:
> >
> > On Wed, Feb 19, 2020 at 05:29:11PM +0100, Oleg Nesterov wrote:
> > > Currently it is not possible to figure out the scope of the private
> > > struct/union/enum type, its ->scope is NULL because bind_symbol() is
> > > not called.
> > >
> > > Change struct_union_enum_specifier() to set sym->scope = block_scope
> > > in this case, this is what bind_symbol() does when type has a name.
> >
> > Thanks.
> > I've just changed the comment to "used by dissect"
> 
> Great, thanks!
> 
> > because
> > elsewhere the scope or toplevel()s only relevant for symbols.
> 
> Cough... can't resist ;)
> 
> Not really, see struct_union_enum_specifier()->is_outer_scope(). But
> yes sure, this is only when ->ident != NULL.

Ah yes, sorry, I wasn't clear enough here. By 'symbol' here, I
effectively meant: "a name (with its associated semantic)", not
a 'struct symbol'.
 
-- Luc
