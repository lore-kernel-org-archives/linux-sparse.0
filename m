From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: multiarch & base dir
Date: Sun, 5 Nov 2017 21:01:04 +0100
Message-ID: <20171105200101.hvjkrpdnf5pbycfs@ltop.local>
References: <20171105093301.adsucwshznehtdr4@ltop.local>
 <ddd46aa0-8dbb-e644-ec46-56b235727438@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56851 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbdKEUBK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 15:01:10 -0500
Received: by mail-wm0-f67.google.com with SMTP id z3so10353904wme.5
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 12:01:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <ddd46aa0-8dbb-e644-ec46-56b235727438@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: linux-sparse@vger.kernel.org

On Sun, Nov 05, 2017 at 06:50:22PM +0000, Ramsay Jones wrote:
> 
> 
> On 05/11/17 09:33, Luc Van Oostenryck wrote:
> > Hi,
> > 
> > Commit 85e2e2a25 "Add support for multiarch system header files"
> > added for GCC's multiarch directory. One of the change was :
> > +       /* add the multiarch include directories, if any */
> > +       if (multiarch_dir && *multiarch_dir) {
> > +               add_pre_buffer("#add_system \"/usr/include/%s\"\n", multiarch_dir);
> > +               add_pre_buffer("#add_system \"/usr/local/include/%s\"\n", multiarch_dir);
> > +       }
> > 
> > 
> > There, the multiarch dir is appended to /usr/include & /usr/local/include.
> > I'm wondering if using GCC_BASE should be used here instead.
> > Any thoughts?
> 
> My initial reaction is definitely not! Certainly not _instead_ of
> /usr/include and /usr/local/include. Adding GCC_BASE, which would
> look something like: '/usr/lib/gcc/x86_64-linux-gnu/5', does not
> immediately strike me as a good idea, but I haven't given it much
> thought. ;-)

OK :)
Things is that I have no real idea what is the output of
	'gcc -print-multiarch=' 

My guess is that it must be a subdirectory of the 'install dir'
which may be '/usr' but could as well be something like:
	/opt/local/lib/gcc/x86_64-linux-gnu/6.3.0/
so using an hardcoded '/usr/include' seems wrong to me.

GCC's doc says the following about -print-multiarch:
     "Print the path to OS libraries for the selected multiarch,
      relative to some 'lib' subdirectory."
and both the 'some' and the 'lib' bring questions to my mind.
My main question is "how the output of -print-multiarch is related
to include directories?"

Not that all this matters much, though.

Regards,
-- Luc
