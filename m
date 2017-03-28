From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm array size computation issue
Date: Wed, 29 Mar 2017 00:21:25 +0200
Message-ID: <20170328222124.kjtgzrhzsnsxdtq2@macpro.local>
References: <CACXZuxdBRB+mvRJf3VGLK2Po8w9gvSXkjTnt3=UCfoa2Wqm5Ew@mail.gmail.com>
 <CACXZuxd5cgfdE-cPZ4mkLnzy=MNn5B9EJNAYaazV3VV9o1_QKQ@mail.gmail.com>
 <CAExDi1QupTRLhPDh8PmieMQh1zr2nV59JjjQHKd4r9ab4nTu0w@mail.gmail.com>
 <CACXZuxcnxYvqM8=kDe=AkWuYB=TmU9mwd9gKc9_veZhbD0z1Xw@mail.gmail.com>
 <CACXZuxcozbUcY9Bot65eSXjSxCDTzVbGSqTqJwgRCit24zisWA@mail.gmail.com>
 <20170328213300.zfa7yecafqvalt5u@macpro.local>
 <CACXZuxf3nuNV61MDoTGx7oiBGBUn+Gcw4B=BaVvRW_N-GydW4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:34920 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752679AbdC1WWI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Mar 2017 18:22:08 -0400
Received: by mail-wr0-f179.google.com with SMTP id u1so116129872wra.2
        for <linux-sparse@vger.kernel.org>; Tue, 28 Mar 2017 15:22:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxf3nuNV61MDoTGx7oiBGBUn+Gcw4B=BaVvRW_N-GydW4Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 28, 2017 at 10:43:54PM +0100, Dibyendu Majumdar wrote:
> Hi Luc,
> 
> On 28 March 2017 at 22:33, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > On Tue, Mar 28, 2017 at 10:14:43PM +0100, Dibyendu Majumdar wrote:
> >
> >> I think that there is a bug in examine_node_type() in symbol.c - it
> >> should set the base_type's bit_size perhaps? See the line marked as
> >> FIX below,
> >>
> >> /* Unsized array? The size might come from the initializer.. */
> >> if (bit_size < 0 && base_type->type == SYM_ARRAY) {
> >> struct expression *initializer = get_symbol_initializer(sym);
> >> if (initializer) {
> >> struct symbol *node_type = base_type->ctype.base_type;
> >> int count = count_array_initializer(S, node_type, initializer);
> >>
> >> if (node_type && node_type->bit_size >= 0)
> >> bit_size = array_element_offset(S->C->target, node_type->bit_size, count);
> >> base_type->bit_size = bit_size;   /*** FIX set base_type->bit_size ***/
> >> }
> >> }
> >
> > I'm far from sure.
> > Yes, here it will works but in general you have no idea who else is
> > using the base_type. For other users it may be legitimally still
> > be unsized.
> >
> 
> I saw that if I set the array size in the C code then
> base_type->bit_size gets set. So my reasoning was that this is okay,
> as only the way the size is determined is changed, but the array still
> has a size. What do you think?

Yes, that's normal.
The SYM_ARRAY has its size set if the size is given.

Otherwise the size will:
-) stay unsized. For example, extern int array[] in an include
   Most files will just see it and use it like this, and only
   a single file will define the array and give it a size.
-) will receive a size later, at the end of the initialization.
   In this case, the array is given a SYM_NODE and the size
   is set there.

Important information is stored in the SYM_NODE and it's wrong
to just jump over it.

I'm not 100% of what I'm telling here but ...

-- Luc
  
