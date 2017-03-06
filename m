From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] give a type to OP_PHISOURCE
Date: Mon, 6 Mar 2017 03:44:40 +0100
Message-ID: <20170306024439.gkuv7a42oqx3or23@macpro.local>
References: <20170303095421.39740-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qn-m=7F1OQKk+pYQzSNpx3e5AOnuQENbG7bz=1BjoQ3Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34250 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752558AbdCFCoo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 21:44:44 -0500
Received: by mail-wr0-f194.google.com with SMTP id u48so20038366wrc.1
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 18:44:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qn-m=7F1OQKk+pYQzSNpx3e5AOnuQENbG7bz=1BjoQ3Qw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Mon, Mar 06, 2017 at 10:27:26AM +0800, Christopher Li wrote:
> On Fri, Mar 3, 2017 at 5:54 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Currently, OP_PHISOURCEs are given a size but not a type.
> >
> > There is no good reasons fro that and it complicate the
> > further correct processing or make it impossible.
> >
> > CC: Dibyendu Majumdar <mobile@majumdar.org.uk>
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> 
> I am looking at the llvm patches right now.
> 
> These four has similar names in the 13 patches so I assume
> they can be safely dropped.
> 
> 9602773-give-a-type-to-OP_PHISOURCE.patch
> 9602515-give-a-type-to-OP_SEL-always.patch
> 9602771-llvm-add-support-for-OP_NEG.patch
> 9603553-llvm-fix-do-not-mix-pointers-and-floats-when-doing-compares.patch
> 
> I am not sure about this two. Should I skip them?
> 
> # 9599615-llvm-fix-getting-type-of-values.patch
> # 9601521-llvm-stores-does-not-create-or-modify-their-target.patch
> 
> Here is the 13 llvm patches I have in my queue.

Yes, those in the serie are the last version.
The other ones can be discarded (I keep uptodate the status of my
patches on patchwork).
 
Luc
