From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Possible incorrect linearization of code (master branch)
Date: Tue, 7 Mar 2017 07:42:34 +0100
Message-ID: <20170307064233.dvo5ctrphaneubei@macpro.local>
References: <CACXZuxeNopu3Syg+TCL3TLnhwmA84qkQ1NsN4hjL-VLPi6ASYA@mail.gmail.com>
 <20170306163638.huqjg6my2qhwyyzy@macpro.local>
 <CACXZuxd_6YS7cficTeuPayyYCT-0Q==i3hje_Xd-MtoAP6bLyQ@mail.gmail.com>
 <CAExDi1RSA0qgBEbH8DH9w573-g1DrH4DhOrUo_GDdnKVh--F-w@mail.gmail.com>
 <CACXZuxexwB_krnNULmiGMCySoaVqx1Q+KiuE_tPS7P59nT7giA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33105 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752233AbdCGH5j (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Mar 2017 02:57:39 -0500
Received: by mail-wm0-f51.google.com with SMTP id v203so8514739wmg.0
        for <linux-sparse@vger.kernel.org>; Mon, 06 Mar 2017 23:56:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxexwB_krnNULmiGMCySoaVqx1Q+KiuE_tPS7P59nT7giA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Mar 06, 2017 at 10:39:42PM +0000, Dibyendu Majumdar wrote:
> On 6 March 2017 at 19:26, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > On Mon, Mar 6, 2017 at 7:47 PM, Dibyendu Majumdar
> >> Because I have a modified
> >> version of Sparse with all global state removed, merging changes is a
> >> bit painful as it has be done manually.
> >
> > I can imagine this.
> > I, of course, hve no idea why you (have to) do this but I can only very strongly
> > advice you to try to avoid this as much as possible.
> >
> 
> As I mentioned before I am using Sparse to create a JIT compiler for
> C. So this needs to be callable as a library - and I need the ability
> to call it many times. Moreover it must be possible to call several
> instances of Sparse simultaneously without conflict. To achieve all
> this, all global state is held in a set of structures. The main change
> is that the most function calls have an additional argument. The other
> changes are related to initialization of the various global structures
> used by Sparse. Generally I try to keep the code as far as possible
> identical to Sparse except for these changes. Even so merging is very
> painful.

OK, I understand better now.
Yes, I imagine it must be painful.

Do you really need to have this ability to run several instances during
development, while investigating problems?

-- Luc 
