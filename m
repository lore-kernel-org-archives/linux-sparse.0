From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2 1/2] struct_union_enum_specifier: always initialize
 sym->scope
Date: Thu, 20 Feb 2020 12:57:37 +0100
Message-ID: <20200220115736.GB27143@redhat.com>
References: <20200219162911.GA26790@redhat.com>
 <20200220005602.gd22zbd7c5qy4t6k@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53378 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727393AbgBTL5q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 20 Feb 2020 06:57:46 -0500
In-Reply-To: <20200220005602.gd22zbd7c5qy4t6k@ltop.local>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

On 02/20, Luc Van Oostenryck wrote:
>
> On Wed, Feb 19, 2020 at 05:29:11PM +0100, Oleg Nesterov wrote:
> > Currently it is not possible to figure out the scope of the private
> > struct/union/enum type, its ->scope is NULL because bind_symbol() is
> > not called.
> >
> > Change struct_union_enum_specifier() to set sym->scope = block_scope
> > in this case, this is what bind_symbol() does when type has a name.
>
> Thanks.
> I've just changed the comment to "used by dissect"

Great, thanks!

> because
> elsewhere the scope or toplevel()s only relevant for symbols.

Cough... can't resist ;)

Not really, see struct_union_enum_specifier()->is_outer_scope(). But
yes sure, this is only when ->ident != NULL.

Oleg.
