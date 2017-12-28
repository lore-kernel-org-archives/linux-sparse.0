From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] fix implicit size of unsized arrays
Date: Thu, 28 Dec 2017 22:40:09 +0100
Message-ID: <20171228214008.o7vwji7oldjwqzfj@ltop.local>
References: <20171228150747.77209-1-luc.vanoostenryck@gmail.com>
 <CACXZuxebnX36BjVyJjSecw7Uef0PaRcgYfLCgkqYz5tLrKHLpA@mail.gmail.com>
 <20171228211911.4mkylgyk44ymtyna@ltop.local>
 <CACXZuxdphqLErKYwxwK=EDuNGO=r2UMttOLRQ7RxhS=pWMYVNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:41543 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbdL1VkM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 Dec 2017 16:40:12 -0500
Received: by mail-wm0-f68.google.com with SMTP id g75so46074270wme.0
        for <linux-sparse@vger.kernel.org>; Thu, 28 Dec 2017 13:40:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxdphqLErKYwxwK=EDuNGO=r2UMttOLRQ7RxhS=pWMYVNw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Dec 28, 2017 at 09:20:41PM +0000, Dibyendu Majumdar wrote:
> Hi Luc,
> 
> On 28 December 2017 at 21:19, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > On Thu, Dec 28, 2017 at 09:02:27PM +0000, Dibyendu Majumdar wrote:
> >> Previous thread on this issue:
> >>
> >> https://www.spinics.net/lists/linux-sparse/msg05427.html
> >
> > Ah yes, sorry, I forgot you already specifically reported this one.
> >
> > It should be fixed now.
> >
> 
> Well last time I thought the view was that a fix was not needed? What's changed?

Another case which led to a better understanding of the situation.

Note: I'm not very happy with the current fix because I think that
      array_size (which is an expression) should not be used after
      examination but thing is that currently array_size is used
      here and there.

-- Luc
