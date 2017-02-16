From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] simplify float-to-float casts that doesn't change size
Date: Thu, 16 Feb 2017 14:53:02 +0100
Message-ID: <20170216135215.tbhmu3tssruwuuf7@macbook.local>
References: <20170216025831.25449-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qm_+QE4_RDMGEBfCqdsuEdeJGdbneeL=-HC-Dp1Hjx85Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:35782 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754478AbdBPNxz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Feb 2017 08:53:55 -0500
Received: by mail-wr0-f175.google.com with SMTP id c4so12124520wrd.2
        for <linux-sparse@vger.kernel.org>; Thu, 16 Feb 2017 05:53:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qm_+QE4_RDMGEBfCqdsuEdeJGdbneeL=-HC-Dp1Hjx85Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Feb 16, 2017 at 08:41:17PM +0800, Christopher Li wrote:
> On Thu, Feb 16, 2017 at 10:58 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > ---
> >  simplify.c                    |  2 ++
> >  validation/optim/fpcast-nop.c | 15 +++++++++++++++
> >  2 files changed, 17 insertions(+)
> >  create mode 100644 validation/optim/fpcast-nop.c
> >
> 
> Can you add a SOB line?

Of course.
    Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
