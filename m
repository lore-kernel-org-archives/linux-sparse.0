From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: Sparse documentation format, rST vs MD
Date: Mon, 7 Aug 2017 04:57:14 -0700
Message-ID: <20170807115713.zfu4d726kmopfym3@x>
References: <CANeU7QkbNzGVVGbvMdaN14g2nPnF3ha6+mBkLJfhCFvf90cy_w@mail.gmail.com>
 <20170807045611.aq3ofd57a7mtvdcm@x>
 <CANeU7Qm5VWBG9YzZXOjPLjve+MVeuRpY_LeyW=CHyYcxS5swLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:37493 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753092AbdHGL5V (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 07:57:21 -0400
Content-Disposition: inline
In-Reply-To: <CANeU7Qm5VWBG9YzZXOjPLjve+MVeuRpY_LeyW=CHyYcxS5swLA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Mon, Aug 07, 2017 at 07:46:25AM -0400, Christopher Li wrote:
> On Mon, Aug 7, 2017 at 12:56 AM, Josh Triplett <josh@joshtriplett.org> wrote:
> 
> > I personally find the Markdown format *much* closer to normal text
> 
> Same here. But I know I am biased.
> 
> > formatting in email, and I'd highly recommend using it.  I'm not sure
> > why the kernel picked reStructuredText, but I don't think there's likely
> > to be a huge amount of cross-pollination between the two in terms of
> > documentation.  In particular, you're unlikely to want to borrow files
> > from the kernel given the different license.
> 
> Mostly just submitting-patches.rst for the Signed-off-by part.
> For the coding style we can just point to the Linux kernel one.
> 
> I think it is fine to have a few *documents* remain GPL in sparse.
> It is not link to any source file. It is not a source file at all.
> I don't think any one will nick pick the license detail on this.

Purely procedural documentation seems fine, sure.
