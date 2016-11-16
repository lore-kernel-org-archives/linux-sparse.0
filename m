From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] sparse: update __builtin_object_size() prototype
Date: Thu, 17 Nov 2016 00:28:50 +0100
Message-ID: <20161116232850.GB21402@macpro.local>
References: <1474467238-20939-1-git-send-email-lrichard@redhat.com>
 <20161107100934.GB443@macbook.home>
 <CANeU7Q=hA2T+dgdi7cz_RK1Xday0g5PWszZMoT_Dw0vx0K5CBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36334 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932347AbcKPX2y (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Nov 2016 18:28:54 -0500
Received: by mail-wm0-f65.google.com with SMTP id m203so16050254wma.3
        for <linux-sparse@vger.kernel.org>; Wed, 16 Nov 2016 15:28:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=hA2T+dgdi7cz_RK1Xday0g5PWszZMoT_Dw0vx0K5CBQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Lance Richardson <lrichard@redhat.com>, Johannes Berg <johannes@sipsolutions.net>

On Thu, Nov 17, 2016 at 06:52:51AM +0800, Christopher Li wrote:
> On Mon, Nov 7, 2016 at 6:09 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > Acked-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> >
> >
> > Chris, can you please take this patch (or Johannes' one).
> > When compiling the kernel, there is more than 2000 false warnings
> > only for the uaccess.h case described here above.
> 
> Applied and pushed to "chrisl" repository.
> 
> Thanks
> 
> Chris
> --

Thanks.

BTW, how must we consider this "chrilsi" repository?
A bit like a -next repository or more like a working one?
Can we consider it as stable for git fetches & pulls?


Luc
