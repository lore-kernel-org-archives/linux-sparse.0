From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/2] fix bogus "crazy progammer"
Date: Sun, 18 Jun 2017 08:43:41 +0200
Message-ID: <20170618064340.czth3trqkb4tu5al@ltop.local>
References: <20170616191844.86256-1-luc.vanoostenryck@gmail.com>
 <8132b29c-0bfc-9294-8040-a2f7271affd6@ramsayjones.plus.com>
 <20170617034449.6clvouwqxpfiujrb@ltop.local>
 <3c71421d-eb26-5268-7701-568d59e5b4d0@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36428 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbdFRGnq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 18 Jun 2017 02:43:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id d17so11617616wme.3
        for <linux-sparse@vger.kernel.org>; Sat, 17 Jun 2017 23:43:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3c71421d-eb26-5268-7701-568d59e5b4d0@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: linux-sparse@vger.kernel.org, Chris Li <sparse@chrisli.org>

On Sat, Jun 17, 2017 at 10:20:44PM +0100, Ramsay Jones wrote:
> 
> 
> On 17/06/17 04:44, Luc Van Oostenryck wrote:
> > On Fri, Jun 16, 2017 at 09:10:57PM +0100, Ramsay Jones wrote:
> >> On 16/06/17 20:18, Luc Van Oostenryck wrote:
> >> I will do some more testing later (cygwin, 32bit linux etc.) and let
> >> you know if I find anything else.
> > 
> > Yes, please. It's very much appreciated.
> 
> Tested on Linux (64-bit and 32-bit) and cygwin (64-bit) with no
> additional issues found. Thanks!

Thank you very much!

For info, I also tested on some other platform, just for the fun
and only running the testsuite. The results are:
* sparse's makefile totally depends on gmake
* freebsd: OK
* openbsd: build failed because the two available compilers
	didn't liked __builtin_bswap{16,32,64}()
	It should be easy to workaround.
* netbsd:  I had problem to install git. I didn't spend more time.
* OSX:	   OK
