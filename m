From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v4 32/63] llvm: add support for OP_SETVAL with floats
Date: Fri, 24 Mar 2017 08:48:03 +0100
Message-ID: <20170324074802.nd4j7i4egpjv6sb6@macbook.local>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
 <20170321001607.75169-33-luc.vanoostenryck@gmail.com>
 <CANeU7QmUAe+K20pV_oiv0UB3RjGEatAo0TBtTSzW9jwcuuqQ8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:36151 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753459AbdCXHsH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 03:48:07 -0400
Received: by mail-wr0-f174.google.com with SMTP id u108so3841558wrb.3
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 00:48:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QmUAe+K20pV_oiv0UB3RjGEatAo0TBtTSzW9jwcuuqQ8A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

On Thu, Mar 23, 2017 at 10:53:15PM -0700, Christopher Li wrote:
> On Mon, Mar 20, 2017 at 5:15 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > --- a/sparse-llvm.c
> > +++ b/sparse-llvm.c
> > @@ -866,6 +866,23 @@ static void output_op_cast(struct function *fn, struct instruction *insn, LLVMOp
> >         insn->target->priv = target;
> >  }
> >
> > +static void output_op_setval(struct function *fn, struct instruction *insn)
> > +{
> > +       struct expression *val = insn->val;
> > +       LLVMTypeRef dtype = symbol_type(insn->type);
> > +       LLVMValueRef target;
> > +
> > +       switch (val->type) {
> > +       case EXPR_FVALUE:
> > +               target = LLVMConstReal(dtype, val->fvalue);
> > +               break;
> > +       default:
> > +               assert(0);
> 
> If there is just one case and default, maybe "if" statement is good enough?
> Switch statement is kind of over kill here.

The next patch add the case EXPR_LABEL and EXPR_STRINGs
need to be supported too.

-- Luc
