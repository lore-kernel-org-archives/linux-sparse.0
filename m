From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: Sparse documentation format, rST vs MD
Date: Sun, 6 Aug 2017 21:56:12 -0700
Message-ID: <20170807045611.aq3ofd57a7mtvdcm@x>
References: <CANeU7QkbNzGVVGbvMdaN14g2nPnF3ha6+mBkLJfhCFvf90cy_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:54531 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751433AbdHGE4Q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 00:56:16 -0400
Content-Disposition: inline
In-Reply-To: <CANeU7QkbNzGVVGbvMdaN14g2nPnF3ha6+mBkLJfhCFvf90cy_w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Sun, Aug 06, 2017 at 09:28:58PM -0400, Christopher Li wrote:
> I want to use some mark down format for the document
> of sparse.
> 
> There is two choice here:
> 
> rST (reStructuredText)
> https://en.wikipedia.org/wiki/ReStructuredText
> 
> MD (Mark Down)
> https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet
> 
> Does any one care which format to use?
> 
> So far I am weak leaning towards MD but I can be convenience
> otherwise. Mostly because MD render on github is very nicely.
> I already use MD on other projects.
> 
> Here is my run down of Pros and Cons
> rST Pros:
> 
> -  Linux kernel already using rST for documents like
>    submiting-patches.rst. I need a file for sparse version of
>    submitting-patches.
> 
> - might be more friendly to code syntax. But I am not going to use
>   those really deep extensions any way.
> 
> rST Cons (for me):
> - I don't know rST at all. I need to learn it.
> - github does not recognized rST naturally.
> 
> 
> MarkDown Pros:
> - More friendly to web.
> - Github etc can render .md properly on display.
> - I already know how the syntax. No need to learn.
> 
> MarkdDown Cons:
> - Kernel is using rST. I need to convert the format if I borrow
>   some file from the Linux Kernel.
> 
> Feed back?

I personally find the Markdown format *much* closer to normal text
formatting in email, and I'd highly recommend using it.  I'm not sure
why the kernel picked reStructuredText, but I don't think there's likely
to be a huge amount of cross-pollination between the two in terms of
documentation.  In particular, you're unlikely to want to borrow files
from the kernel given the different license.
