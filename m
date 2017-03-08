From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm incorrect definition of local variables
Date: Wed, 8 Mar 2017 07:53:38 +0100
Message-ID: <20170308065337.vwrebdlo4poc4da4@macpro.local>
References: <CACXZuxdH3tryp92DVHhd8zs9bUTbrAs92Pz+knnDqDzj4eXWYQ@mail.gmail.com>
 <20170307064436.qtcscbwbjsrjoyko@macpro.local>
 <CACXZuxcC-VPjB9CD0E9zUXp6XNS8v1DdvPUZ1vc88jqwYdFUhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37830 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751065AbdCHIdk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Mar 2017 03:33:40 -0500
Received: by mail-wm0-f45.google.com with SMTP id n11so24466052wma.0
        for <linux-sparse@vger.kernel.org>; Wed, 08 Mar 2017 00:31:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxcC-VPjB9CD0E9zUXp6XNS8v1DdvPUZ1vc88jqwYdFUhA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 07, 2017 at 07:31:34AM +0000, Dibyendu Majumdar wrote:
> >> Here 'values' has been defined above as external global, whereas it
> >> should be allocated on the stack.
> >
> > Mmmh, I'll need to look a bit further at this one.
> >
> 
> It appears that sparse-llvm only creates a local stack object for each
> OP_PHI instruction. What should be the general approach for
> identifying local stack objects in sparse linearized output?

I've looked a bit at this and there is several issues at hand.
It's also not something LLVM specific.
So I can't answer to this for now. Hopefully, I'll be able to tell
you more in a few days.

-- Luc 
