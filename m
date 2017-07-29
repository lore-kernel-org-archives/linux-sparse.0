From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: ptrlist-iterator performance on one wine source file
Date: Sat, 29 Jul 2017 15:01:18 +0200
Message-ID: <20170729130116.b5jd4rvkiwzgsfwt@ltop.local>
References: <CANeU7QkRxYFB41o9dTMp=n=epsNTZLr1ZsjowW=DigRiVNkPjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38419 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753607AbdG2NBW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 29 Jul 2017 09:01:22 -0400
Received: by mail-wm0-f44.google.com with SMTP id m85so136017039wma.1
        for <linux-sparse@vger.kernel.org>; Sat, 29 Jul 2017 06:01:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QkRxYFB41o9dTMp=n=epsNTZLr1ZsjowW=DigRiVNkPjg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Thu, Jul 27, 2017 at 11:05:38AM -0400, Christopher Li wrote:
> Hi Luc,
> 
> Per our discussion, here is some test you are interested.
> It show some measurable difference in ptrlist-iterator vs the
> base before the patch series.

Interesting.
My measurements showed much smaller differences (around 1-2%
and smaller than the stdev). But I also saw that this difference
was significantly bigger on older/less performant machines
(which is not very surprising).

Anyway, this series in itself won't solve the issues we
currently have with deletion in nested ptrlist walking loops.

Thanks for the numbers.
-- Luc
