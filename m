From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm array size computation issue
Date: Tue, 28 Mar 2017 23:33:01 +0200
Message-ID: <20170328213300.zfa7yecafqvalt5u@macpro.local>
References: <CACXZuxdBRB+mvRJf3VGLK2Po8w9gvSXkjTnt3=UCfoa2Wqm5Ew@mail.gmail.com>
 <CACXZuxd5cgfdE-cPZ4mkLnzy=MNn5B9EJNAYaazV3VV9o1_QKQ@mail.gmail.com>
 <CAExDi1QupTRLhPDh8PmieMQh1zr2nV59JjjQHKd4r9ab4nTu0w@mail.gmail.com>
 <CACXZuxcnxYvqM8=kDe=AkWuYB=TmU9mwd9gKc9_veZhbD0z1Xw@mail.gmail.com>
 <CACXZuxcozbUcY9Bot65eSXjSxCDTzVbGSqTqJwgRCit24zisWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37403 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932082AbdC1VdK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Mar 2017 17:33:10 -0400
Received: by mail-wm0-f49.google.com with SMTP id x124so9731625wmf.0
        for <linux-sparse@vger.kernel.org>; Tue, 28 Mar 2017 14:33:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxcozbUcY9Bot65eSXjSxCDTzVbGSqTqJwgRCit24zisWA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 28, 2017 at 10:14:43PM +0100, Dibyendu Majumdar wrote:
> >>>
> >>> Looks like the computed bit_size is being held on the SYM_NODE but
> >>> sparse-llvm looks as the bit_size field in the SYM_ARRAY node. Does
> >>> this sound like a problem - i.e. somehow the SYM_ARRAY is not getting
> >>> its size set?

I doesn't know much this area but I think it's OK.
I think the bug is that sparse-llvm doesn't use the size as it
is given: in the SYM_NODE.

I bet that if you look at the code for sizeof, you will see that
the size is taken from the SYM_NODE and not what's under it.

As far as I understand (but again, I don't know much here) it's the
purpose of SYM_NODEs to do things like that.

> I think that there is a bug in examine_node_type() in symbol.c - it
> should set the base_type's bit_size perhaps? See the line marked as
> FIX below,
> 
> /* Unsized array? The size might come from the initializer.. */
> if (bit_size < 0 && base_type->type == SYM_ARRAY) {
> struct expression *initializer = get_symbol_initializer(sym);
> if (initializer) {
> struct symbol *node_type = base_type->ctype.base_type;
> int count = count_array_initializer(S, node_type, initializer);
> 
> if (node_type && node_type->bit_size >= 0)
> bit_size = array_element_offset(S->C->target, node_type->bit_size, count);
> base_type->bit_size = bit_size;   /*** FIX set base_type->bit_size ***/
> }
> }

I'm far from sure.
Yes, here it will works but in general you have no idea who else is
using the base_type. For other users it may be legitimally still
be unsized.
 
-- Luc
