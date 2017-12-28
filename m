From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] fix implicit size of unsized arrays
Date: Thu, 28 Dec 2017 23:10:47 +0100
Message-ID: <20171228221046.6kdh6pwexrcy6e4g@ltop.local>
References: <20171228150747.77209-1-luc.vanoostenryck@gmail.com>
 <CACXZuxebnX36BjVyJjSecw7Uef0PaRcgYfLCgkqYz5tLrKHLpA@mail.gmail.com>
 <20171228211911.4mkylgyk44ymtyna@ltop.local>
 <CACXZuxdphqLErKYwxwK=EDuNGO=r2UMttOLRQ7RxhS=pWMYVNw@mail.gmail.com>
 <20171228214008.o7vwji7oldjwqzfj@ltop.local>
 <CACXZuxdxdAybNJr6jzj2B02TWTw3PsZbV7YjSmE1CgQ1yzSm9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36611 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbdL1WKu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 Dec 2017 17:10:50 -0500
Received: by mail-wm0-f53.google.com with SMTP id b76so45881330wmg.1
        for <linux-sparse@vger.kernel.org>; Thu, 28 Dec 2017 14:10:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxdxdAybNJr6jzj2B02TWTw3PsZbV7YjSmE1CgQ1yzSm9A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Dec 28, 2017 at 09:44:25PM +0000, Dibyendu Majumdar wrote:
> Hi Luc,
> 
> On 28 December 2017 at 21:40, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > On Thu, Dec 28, 2017 at 09:20:41PM +0000, Dibyendu Majumdar wrote:
> >> On 28 December 2017 at 21:19, Luc Van Oostenryck
> >> <luc.vanoostenryck@gmail.com> wrote:
> >> > On Thu, Dec 28, 2017 at 09:02:27PM +0000, Dibyendu Majumdar wrote:
> >> >> Previous thread on this issue:
> >> >>
> >> >> https://www.spinics.net/lists/linux-sparse/msg05427.html
> >> >
> >> > Ah yes, sorry, I forgot you already specifically reported this one.
> >> >
> >> > It should be fixed now.
> >> >
> >>
> >> Well last time I thought the view was that a fix was not needed? What's changed?
> >
> > Another case which led to a better understanding of the situation.
> >
> 
> I understood that the correct solution was for the symbol to hold the size.
> 
> https://www.spinics.net/lists/linux-sparse/msg05442.html
> https://www.spinics.net/lists/linux-sparse/msg05444.html

The situation is:
1) yes, all what's really needed is present in SYM_NODE::bit_size
2) but some part of the code use SYM_ARRAY::bit_size or
   SYM_ARRAY::array_size
3) the implicit size of unsized arrays is really a special case
   that's doesn't follow the normal handling of SYM_NODE and
   the corresponding base type
2) the SYM_ARRAY must not be updated because it can be shared
   between several nodes with different size (like in the testcase
   I joined with the fix)
So duplicating the SYM_ARRAY to unshare it then updating it
seems to be what is needed although I don't find it very clean.
Not all of this was understood in March.

Regards,
Luc
