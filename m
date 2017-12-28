From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm array size computation issue
Date: Thu, 28 Dec 2017 22:30:15 +0100
Message-ID: <20171228213014.few7ixr2gaksrt3f@ltop.local>
References: <CACXZuxdBRB+mvRJf3VGLK2Po8w9gvSXkjTnt3=UCfoa2Wqm5Ew@mail.gmail.com>
 <CACXZuxd5cgfdE-cPZ4mkLnzy=MNn5B9EJNAYaazV3VV9o1_QKQ@mail.gmail.com>
 <CAExDi1QupTRLhPDh8PmieMQh1zr2nV59JjjQHKd4r9ab4nTu0w@mail.gmail.com>
 <CACXZuxcnxYvqM8=kDe=AkWuYB=TmU9mwd9gKc9_veZhbD0z1Xw@mail.gmail.com>
 <CACXZuxcozbUcY9Bot65eSXjSxCDTzVbGSqTqJwgRCit24zisWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:41994 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbdL1VaS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 Dec 2017 16:30:18 -0500
Received: by mail-wm0-f50.google.com with SMTP id f21so2420549wmh.1
        for <linux-sparse@vger.kernel.org>; Thu, 28 Dec 2017 13:30:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxcozbUcY9Bot65eSXjSxCDTzVbGSqTqJwgRCit24zisWA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 28, 2017 at 10:14:43PM +0100, Dibyendu Majumdar wrote:
> Hi Luc,
> 
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

Yes, it's correct and will fix most aspects of the issue but it's
only part of the fix:
- array_size need also to be updated
- the SYM_ARRAY can't be directly updated because it can be
  shared between several nodes, so it need to be duplicated
  before being updated.

-- Luc
