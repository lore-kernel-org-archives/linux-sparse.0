From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 06/13] llvm: fix type of literal integer passed as
 arguments
Date: Tue, 7 Mar 2017 17:21:08 +0100
Message-ID: <20170307162107.vgkloatftquqahif@macbook.local>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
 <20170305112047.3411-7-luc.vanoostenryck@gmail.com>
 <CANeU7Qnoqg-rM2MS+3BuKEvsLUBvnv+rvfYmE=XkhMicdejN=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34102 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755606AbdCGQV3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Mar 2017 11:21:29 -0500
Received: by mail-wm0-f66.google.com with SMTP id u132so1824398wmg.1
        for <linux-sparse@vger.kernel.org>; Tue, 07 Mar 2017 08:21:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qnoqg-rM2MS+3BuKEvsLUBvnv+rvfYmE=XkhMicdejN=A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Tue, Mar 07, 2017 at 11:33:19PM +0800, Christopher Li wrote:
> On Sun, Mar 5, 2017 at 7:20 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Like for all others instructions, LLVM needs the type
> > of each operands. However this information is not always
> > available via the pseudo, like here when passing a integer
> > constant as argument since for sparse constants are typeless.
> >
> > Fix this by getting the type via the function prototype.
> >
> > +               LLVMValueRef value;
> > +               if (arg->type == PSEUDO_VAL) {
> > +                       /* Value pseudos do not have type information. */
> > +                       /* Use the function prototype to get the type. */
> > +                       struct symbol *ctype = get_nth1_arg(insn->func->sym, i + 1);
> 
> I try to come up with an example to use the PREPARE_PTR_LIST() in this patch.
> I hit a bug "insn->func->sym"  assume "insn->func" is a function symbol node.
> If "insn->func" is a function pointer then access "insn->func->sym" is wrong.

Mmmm yes, indeed.
 
> Any way, my modify patch attached. It should work similar to this patch
> without using the nth argument help function. My limited test hit this
> function pointer bug.

OK. 

-- Luc
