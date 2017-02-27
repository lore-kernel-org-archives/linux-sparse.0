From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] fix size of loaded bitfields
Date: Mon, 27 Feb 2017 10:25:46 +0100
Message-ID: <20170227092545.ymha35znxh6vzsni@macbook.local>
References: <20170217024445.16163-1-luc.vanoostenryck@gmail.com>
 <CANeU7Q=8-ohrRveh_YkF8iaVOVX9SFTgauogFBhjxLMY=XjUQA@mail.gmail.com>
 <CANeU7Q=n3WhBF4v1u-BRJMnqWmqY5xrtF=6yrPiFV5y+8GQD5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37007 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbdB0JZu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Feb 2017 04:25:50 -0500
Received: by mail-wm0-f45.google.com with SMTP id v77so57366795wmv.0
        for <linux-sparse@vger.kernel.org>; Mon, 27 Feb 2017 01:25:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=n3WhBF4v1u-BRJMnqWmqY5xrtF=6yrPiFV5y+8GQD5A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Feb 27, 2017 at 04:32:50PM +0800, Christopher Li wrote:
> On Mon, Feb 27, 2017 at 4:22 PM, Christopher Li <sparse@chrisli.org> wrote:
> > On Fri, Feb 17, 2017 at 10:44 AM, Luc Van Oostenryck
> > <luc.vanoostenryck@gmail.com> wrote:
> >> Loading a bitfield correctly take in account the offset
> >> of the bitfield inside the whole container integer.
> >> But truncating it to the width of the bitfield is not done
> >> or is done very implicitely (because the correct size is not lost).
> >
> >> Fix this by adding the missing truncating cast.
> >> This will then gives something like:
> >>         get__bfu_a:
> >>                 cast.3      %r2 <- (32) %arg1
> >>                 cast.32     %r3 <- (3) %r2
> >>                 ret.32      %r3
> >
> > The patch looks good. Applied to sparse-next.
> 
> Actually, after apply this patch. The testsuite failed
> on matching the test case of the bitfield-size.c.

Sorry for that. I changed my mind about the cast vs. and-mask
and forgot to update the test case.
Updated patch is coming.

Luc Van Oostenryck
