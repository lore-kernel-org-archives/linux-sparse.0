From: Christopher Li <sparse@chrisli.org>
Subject: Re: Detect unused header files?
Date: Thu, 30 Jul 2009 03:55:46 -0700
Message-ID: <70318cbf0907300355h5cb34671ha452433c4e0b5324@mail.gmail.com>
References: <20090728181803.GA20845@merkur.ravnborg.org>
	 <70318cbf0907281336p47b68b5cg44a3e7206646cb80@mail.gmail.com>
	 <alpine.LFD.2.00.0907281634400.3974@localhost>
	 <70318cbf0907281349k72a71b8fyc10d80992e4b1db9@mail.gmail.com>
	 <20090728210404.GA21187@merkur.ravnborg.org>
	 <70318cbf0907281438i876e21fja037aed7169aa8bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:25149 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbZG3Kzq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 30 Jul 2009 06:55:46 -0400
Received: by qw-out-2122.google.com with SMTP id 8so748532qwh.37
        for <linux-sparse@vger.kernel.org>; Thu, 30 Jul 2009 03:55:46 -0700 (PDT)
In-Reply-To: <70318cbf0907281438i876e21fja037aed7169aa8bf@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>, sparse <linux-sparse@vger.kernel.org>

Hi Sam,

I create a branch "unused-include-files" for some experiment patch.
Some thing quick and dirty to find out what works and what doesn't.
No where near submitting quality.

http://git.kernel.org/?p=devel/sparse/chrisl/sparse.git;a=shortlog;h=unused-include-files

Currently it just report all unused stream.

for your example foo.h:

#include <linux/types.h>
#include <linux/string.h>

struct foo {
       __u32 bar;
       __u32 baz;
};


$ ./sparse foo.h
unused stream preprocessor(1)
unused stream foo.h(2)
unused stream preprocessor(3)
unused stream /usr/include/linux/stddef.h(6)
unused stream /usr/include/asm/posix_types.h(7)
unused stream /usr/include/asm/types.h(9)
unused stream /usr/include/linux/string.h(11)
unused stream /usr/include/string.h(12)
unused stream /usr/include/features.h(13)
unused stream /usr/include/sys/cdefs.h(14)
unused stream /usr/include/bits/wordsize.h(15)
unused stream /usr/include/gnu/stubs.h(16)
unused stream /usr/include/bits/wordsize.h(17)
unused stream /usr/include/gnu/stubs-32.h(18)
unused stream /usr/lib/gcc/x86_64-redhat-linux/4.3.0//include/stddef.h(19)

Just as I expected. Lost of noise :-)

BTW, use "-vstream" to show the actual symbol usage detail.

Comments?

Chris
