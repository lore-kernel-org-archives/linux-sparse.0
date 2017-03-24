From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v4 03/63] canonicalize compare instructions
Date: Fri, 24 Mar 2017 09:11:57 +0100
Message-ID: <20170324081156.qhblvgndemthg7wf@macbook.local>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
 <20170321001607.75169-4-luc.vanoostenryck@gmail.com>
 <CANeU7Qkhygbv5xBHKicwJDRdDY-EJctauxvLoz33wZ_keeqXHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33390 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752672AbdCXIMB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 04:12:01 -0400
Received: by mail-wr0-f195.google.com with SMTP id 20so929582wrx.0
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 01:12:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Qkhygbv5xBHKicwJDRdDY-EJctauxvLoz33wZ_keeqXHQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

On Thu, Mar 23, 2017 at 10:12:28PM -0700, Christopher Li wrote:
> On Mon, Mar 20, 2017 at 5:15 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> 
> 
> > +static int compare_swap(int opcode)
> 
> This function can be call "swap_compare", the action part is
> swap.

Yes, indeed.
In fact, I think it need a name which explain even more
the purpose. I'll see.
 
> > +{
> > +       switch (opcode) {
> > +       case OP_SET_EQ: return OP_SET_EQ;
> > +       case OP_SET_NE: return OP_SET_NE;
> > +
> > +       case OP_SET_LT: return OP_SET_GT;
> > +       case OP_SET_LE: return OP_SET_GE;
> > +       case OP_SET_GT: return OP_SET_LT;
> > +       case OP_SET_GE: return OP_SET_LE;
> > +
> > +       case OP_SET_A:  return OP_SET_B;
> > +       case OP_SET_AE: return OP_SET_BE;
> > +       case OP_SET_B:  return OP_SET_A;
> > +       case OP_SET_BE: return OP_SET_AE;
> 
> Some very minor micro optimization note.
> I take a look at the machine code it generated. It actually generate
> a jump table and each jump table has some label entry corresponding
> to code fragment like:
> 
> movl $28, %eax #, _163
> .LVL985:
> jmp .L701 #
> 
> I think it should be better to use a static array to directly
> fetch the new opcode. There is OP_BINCMP and OP_BINCMP_END
> to mark the begin and end of the binary compare opcode. That
> way there one data table not jump table for control flow.
> 
> This comment apply to comparere_opcode() which introduce in the
> earlier patch as well.

Yes, it's kinda ugly.
OTOH, given that jumps are cheaper and cheaper on modern CPU
and memory accesses slower and slower, is what you propose
really an optimization? And even if it would, does it matter?

My preference, if performance mattered here, would be to play
with the bits of the opcode, something like:
	#define OP_SET__EQUAL	(1 << ...)
	#define OP_SET__SIGNED  (1 << ...)
	#define OP_SET__LTHAN	...
	#define OP_SET__GTHAN	...    

	...

	int swap_compare_opcode(opcode) { return opcode ^= (OP_SET__LTHAN|OP_SET__GTHAN); }

I'll look if I can get something simple and clean.

-- Luc
