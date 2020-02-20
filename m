From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 1/2] struct_union_enum_specifier: always initialize
 sym->scope
Date: Thu, 20 Feb 2020 01:56:02 +0100
Message-ID: <20200220005602.gd22zbd7c5qy4t6k@ltop.local>
References: <20200219162911.GA26790@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52584 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgBTA4G (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 19 Feb 2020 19:56:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so219740wmc.2
        for <linux-sparse@vger.kernel.org>; Wed, 19 Feb 2020 16:56:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200219162911.GA26790@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

On Wed, Feb 19, 2020 at 05:29:11PM +0100, Oleg Nesterov wrote:
> Currently it is not possible to figure out the scope of the private
> struct/union/enum type, its ->scope is NULL because bind_symbol() is
> not called.
> 
> Change struct_union_enum_specifier() to set sym->scope = block_scope
> in this case, this is what bind_symbol() does when type has a name.

Thanks.
I've just changed the comment to "used by dissect" because
elsewhere the scope or toplevel()s only relevant for symbols.

-- Luc
