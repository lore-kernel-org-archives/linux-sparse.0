From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] add test case for builtin bswap with constant args
Date: Thu, 24 Nov 2016 14:00:09 +0100
Message-ID: <20161124130007.GA12488@macbook.local>
References: <CANeU7QkABOFTdUCdabWL1YwHb3Qf4huVL115AHqZBNcqUytmhg@mail.gmail.com>
 <20161123203855.14957-1-luc.vanoostenryck@gmail.com>
 <CANeU7QkY6Pztt3V3pEmT=BMfP_H=ckZ0o8KVZUnqK6oq2yj32g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f170.google.com ([209.85.210.170]:34384 "EHLO
        mail-wj0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756781AbcKXNAM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 24 Nov 2016 08:00:12 -0500
Received: by mail-wj0-f170.google.com with SMTP id mp19so33054280wjc.1
        for <linux-sparse@vger.kernel.org>; Thu, 24 Nov 2016 05:00:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QkY6Pztt3V3pEmT=BMfP_H=ckZ0o8KVZUnqK6oq2yj32g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Nov 24, 2016 at 01:30:14PM +0800, Christopher Li wrote:
> On Thu, Nov 24, 2016 at 4:38 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > ---
> >  validation/builtin-constant-eval.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >  create mode 100644 validation/builtin-constant-eval.c
> 
> Can you reply with a sign off line?
> 
> Thanks
> 
> Chris
> --

Oh yes, I forgot this. Sorry.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
