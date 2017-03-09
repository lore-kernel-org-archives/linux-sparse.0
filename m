From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm incorrect definition of local variables
Date: Thu, 9 Mar 2017 15:42:36 +0100
Message-ID: <20170309144236.2bxybafobkdwczqy@macbook.local>
References: <CACXZuxdH3tryp92DVHhd8zs9bUTbrAs92Pz+knnDqDzj4eXWYQ@mail.gmail.com>
 <20170307064436.qtcscbwbjsrjoyko@macpro.local>
 <CACXZuxcC-VPjB9CD0E9zUXp6XNS8v1DdvPUZ1vc88jqwYdFUhA@mail.gmail.com>
 <20170308065337.vwrebdlo4poc4da4@macpro.local>
 <CACXZuxcbDJAeRBN_wpTRPRk7efOM2vLytke=k_0f4=C0dOQtrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33950 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754905AbdCIOml (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Mar 2017 09:42:41 -0500
Received: by mail-wm0-f53.google.com with SMTP id 196so36181214wmm.1
        for <linux-sparse@vger.kernel.org>; Thu, 09 Mar 2017 06:42:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxcbDJAeRBN_wpTRPRk7efOM2vLytke=k_0f4=C0dOQtrA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Mar 08, 2017 at 11:38:22PM +0000, Dibyendu Majumdar wrote:
> Hi Luc,
> 
> On 8 March 2017 at 06:53, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > On Tue, Mar 07, 2017 at 07:31:34AM +0000, Dibyendu Majumdar wrote:
> >> >> Here 'values' has been defined above as external global, whereas it
> >> >> should be allocated on the stack.
> >> >
> >> > Mmmh, I'll need to look a bit further at this one.
> >> >
> >>
> >> It appears that sparse-llvm only creates a local stack object for each
> >> OP_PHI instruction. What should be the general approach for
> >> identifying local stack objects in sparse linearized output?
> >
> > I've looked a bit at this and there is several issues at hand.
> > It's also not something LLVM specific.
> > So I can't answer to this for now. Hopefully, I'll be able to tell
> > you more in a few days.
> >
> 
> Thank you for looking into this. It would be good to know what issues
> you have discovered.
The issues is about which symbols are used, which ones don't need to be
allocated because all their use are via pseudos, ...
A lot of infrastructure already exist for it bit is incomplete or
wrong.

Also, I first focus to finalize the previous issues with the NULLs,
ADDs, CALLs, ...

-- Luc Van Oostenryck
