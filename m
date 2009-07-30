From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Detect unused header files?
Date: Thu, 30 Jul 2009 22:36:33 +0200
Message-ID: <20090730203633.GA28838@merkur.ravnborg.org>
References: <20090728181803.GA20845@merkur.ravnborg.org> <70318cbf0907281336p47b68b5cg44a3e7206646cb80@mail.gmail.com> <alpine.LFD.2.00.0907281634400.3974@localhost> <70318cbf0907281349k72a71b8fyc10d80992e4b1db9@mail.gmail.com> <20090728210404.GA21187@merkur.ravnborg.org> <70318cbf0907281438i876e21fja037aed7169aa8bf@mail.gmail.com> <70318cbf0907300355h5cb34671ha452433c4e0b5324@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from pfepa.post.tele.dk ([195.41.46.235]:40235 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014AbZG3Uge (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 30 Jul 2009 16:36:34 -0400
Content-Disposition: inline
In-Reply-To: <70318cbf0907300355h5cb34671ha452433c4e0b5324@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>, sparse <linux-sparse@vger.kernel.org>

On Thu, Jul 30, 2009 at 03:55:46AM -0700, Christopher Li wrote:
> Hi Sam,
> 
> I create a branch "unused-include-files" for some experiment patch.
> Some thing quick and dirty to find out what works and what doesn't.
> No where near submitting quality.
> 
> http://git.kernel.org/?p=devel/sparse/chrisl/sparse.git;a=shortlog;h=unused-include-files
> 
> Currently it just report all unused stream.
> 
> for your example foo.h:
> 
> #include <linux/types.h>
> #include <linux/string.h>
> 
> struct foo {
>        __u32 bar;
>        __u32 baz;
> };
> 
> 
> $ ./sparse foo.h
> unused stream preprocessor(1)
> unused stream foo.h(2)
> unused stream preprocessor(3)
> unused stream /usr/include/linux/stddef.h(6)
> unused stream /usr/include/asm/posix_types.h(7)
> unused stream /usr/include/asm/types.h(9)
> unused stream /usr/include/linux/string.h(11)
> unused stream /usr/include/string.h(12)
> unused stream /usr/include/features.h(13)
> unused stream /usr/include/sys/cdefs.h(14)
> unused stream /usr/include/bits/wordsize.h(15)
> unused stream /usr/include/gnu/stubs.h(16)
> unused stream /usr/include/bits/wordsize.h(17)
> unused stream /usr/include/gnu/stubs-32.h(18)
> unused stream /usr/lib/gcc/x86_64-redhat-linux/4.3.0//include/stddef.h(19)
> 
> Just as I expected. Lost of noise :-)
> 
> BTW, use "-vstream" to show the actual symbol usage detail.
> 
> Comments?
Thanks for hacking this up!

I will try it out during the weekend as work permits. Busy...

	Sam
