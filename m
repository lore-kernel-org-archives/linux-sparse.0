From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse-llvm question
Date: Thu, 26 Jan 2017 18:47:31 +0100
Message-ID: <20170126174731.jqnvuocad6hdvlky@macpro.local>
References: <CACXZuxeosx_qH3E5+gjnhx1czrSup5ZT0tm=kUqcp5u178twhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34452 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754026AbdAZRrv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 26 Jan 2017 12:47:51 -0500
Received: by mail-wm0-f65.google.com with SMTP id c85so51826670wmi.1
        for <linux-sparse@vger.kernel.org>; Thu, 26 Jan 2017 09:47:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxeosx_qH3E5+gjnhx1czrSup5ZT0tm=kUqcp5u178twhA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: linux-sparse@vger.kernel.org

On Thu, Jan 26, 2017 at 05:27:17PM +0000, Dibyendu Majumdar wrote:
> Hi
> 
> I am hoping to reuse the Sparse-llvm component as a JIT compiler for C
> in an application.
Interesting.

>I was playing around with it a bit and hit an
> immediate issue. For instance compilation of a simple program like
> this fails:
> 
> const char ident[] = "";
> 
> Is there a list of what works and what doesn't anywhere?
> 
> Thanks and Regards
> Dibyendu

I think that sparse-llvm have always been very experimental.
Here you can see that initialization of arrays is not implemented
but simple variable is, so the following seems to be fine:
	const char *ident = "";


Regards,
Luc Van Oostenryck
