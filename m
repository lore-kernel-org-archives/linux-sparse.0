From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] graph: do not scan removed instructions
Date: Wed, 8 Nov 2017 09:17:58 +0100
Message-ID: <20171108081756.ulvrn2q4ohjni4ks@ltop.local>
References: <20171107105430.4810-1-luc.vanoostenryck@gmail.com>
 <CANeU7QkG8NqyYWy6OmmDjaXXeS1iuZxrnbvG2CADd6qGpjL2Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:52913 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdKHISB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Nov 2017 03:18:01 -0500
Received: by mail-wr0-f169.google.com with SMTP id j23so1599109wra.9
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 00:18:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QkG8NqyYWy6OmmDjaXXeS1iuZxrnbvG2CADd6qGpjL2Ow@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>

On Wed, Nov 08, 2017 at 02:54:17AM +0800, Christopher Li wrote:
> On Tue, Nov 7, 2017 at 6:54 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > ---
> >  graph.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/graph.c b/graph.c
> > index 8cbc22027..c9af9a580 100644
> > --- a/graph.c
> > +++ b/graph.c
> > @@ -130,6 +130,8 @@ static void graph_calls(struct entrypoint *ep, int internal)
> >                         continue;
> >
> >                 FOR_EACH_PTR(bb->insns, insn) {
> > +                       if (!insn->bb)
> > +                               continue;
> 
> Looks good to me.

Thank you for the review.
Thank you for the very fast review.

-- Luc
