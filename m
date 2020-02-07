From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] dissect: introduce dissect_ctx
Date: Fri, 7 Feb 2020 12:21:08 +0100
Message-ID: <20200207112108.elchvmg3ikcu67pn@ltop.local>
References: <20200206170132.GA8908@redhat.com>
 <20200206204518.qx5qtyl52al37njy@ltop.local>
 <20200207100150.GB9260@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50970 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGLVM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Feb 2020 06:21:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so2202440wmb.0
        for <linux-sparse@vger.kernel.org>; Fri, 07 Feb 2020 03:21:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200207100150.GB9260@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

On Fri, Feb 07, 2020 at 11:01:50AM +0100, Oleg Nesterov wrote:
> On 02/06, Luc Van Oostenryck wrote:
> >
> > On Thu, Feb 06, 2020 at 06:01:32PM +0100, Oleg Nesterov wrote:
> > > Points to the current function or to the global variable in case of
> > > compound initializer.
> > >
> > > Kill the ugly test-dissect.c:storage() and change print_usage() to
> > > report dissect_ctx->ident instead.
> >
> > Having the ful ident will be good, I think, but the cost is to have
> > to maintain this context. I suppose it would be too painful to
> > propgate this context via an additional argument to all involved
> > functions?
> 
> Oh, I'd prefer to not do this. This needs to add the additional "ctx"
> arg to every do_.*() function in dissect.c, and for what? IMHO, this
> will just complicate the code for no reason.

Yes, I guessed so. No problem.

-- Luc 
