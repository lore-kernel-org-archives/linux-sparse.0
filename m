From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/3] struct_union_enum_specifier: set MOD_TOPLEVEL if
 toplevel(sym->scope)
Date: Mon, 17 Feb 2020 22:46:10 +0100
Message-ID: <20200217214610.uxbnfh5zooqve4yc@ltop.local>
References: <20200214113320.GA31578@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39286 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbgBQVqP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 17 Feb 2020 16:46:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so21492745wrt.6
        for <linux-sparse@vger.kernel.org>; Mon, 17 Feb 2020 13:46:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200214113320.GA31578@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

On Fri, Feb 14, 2020 at 12:33:20PM +0100, Oleg Nesterov wrote:
> With this change dissect can know the scope of SYM_STRUCT/UNION/ENUM,
> see the next patch.
> 
> Note that MOD_TOPLEVEL can be set even if struct/union/enum type is
> private and bind_symbol() is not called.

I don't like that very much. For example: why this is needed for
struct/union/enum and not other types?
Should it be possible to use the function toplevel() or add and
helper for it in scope.c?

> IIUC nobody else looks at SYM_STRUCT->ctype.modifiers, "make check"
> doesn't show any difference.

Yes, it's true and it shouldn't make any difference but still I
would prefer to not mix symbols and types more than they already are.
 
-- Luc
