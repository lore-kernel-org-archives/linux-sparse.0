From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: extra 'make check' failures on 32bit Linux
Date: Mon, 27 Mar 2017 01:56:59 +0200
Message-ID: <20170326235658.qx7hj3m5p57ktom5@macpro.local>
References: <806988fb-6e3c-872b-d7ab-282336f67f73@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35762 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751493AbdCZX5d (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 26 Mar 2017 19:57:33 -0400
Received: by mail-wr0-f195.google.com with SMTP id p52so5343029wrc.2
        for <linux-sparse@vger.kernel.org>; Sun, 26 Mar 2017 16:57:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <806988fb-6e3c-872b-d7ab-282336f67f73@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sun, Mar 26, 2017 at 11:21:44PM +0100, Ramsay Jones wrote:
> Hi Christopher, Luc,
> 
> On occasion I build sparse on 32-bit Linux and I have noticed, for some
> weeks now, unexpected test failures. I have been meaning to take a look
> at fixing these failures, but I just haven't had the time ... :(
> 
> So, as the next best thing, I thought I should at least let you know
> about the failures, viz:
> 
> ...
> 
> Note that the output file for bool-cast-implicit.c is identical to the
> above file for bool-cast-explicit.c, so I haven't included it here.
> 
> Again, I haven't had time to look properly, but it seems that some
> expected output files assume a 64-bit platform and that long and pointers
> are 64-bit rather than 32-bit. (or something like that :-) )

You're absolutely right. My bad.
I'll update all that.

Thanks for letting know.

-- Luc
