From: Pavel Roskin <proski@gnu.org>
Subject: Re: sparse using insane amounts of memory
Date: Thu, 08 Mar 2007 12:13:30 -0500
Message-ID: <1173374010.15842.13.camel@dv>
References: <1173319356.3546.54.camel@johannes.berg>
	 <1173371608.21465.12.camel@dv>  <1173372315.3248.19.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:60430 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbXCHRNl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 8 Mar 2007 12:13:41 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HPM9g-0004zn-Ih
	for linux-sparse@vger.kernel.org; Thu, 08 Mar 2007 12:11:53 -0500
In-Reply-To: <1173372315.3248.19.camel@johannes.berg>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-sparse@vger.kernel.org

[Dropping linux-wireless, as there is nothing wireless below]

On Thu, 2007-03-08 at 17:45 +0100, Johannes Berg wrote:
>   make CC="gcc -save-temps -D__CHECKER__" KBUILD_NOCMDDEP=1 M=drivers/net/wireless/mac80211/rt2x00/
> 
> and aborted when I got lots of errors, rt2400pci.i was created and has
> about 26k lines. Running sparse on it (sparse rt2400pci.i) takes a lot
> of memory too. I put the file up at
> http://johannes.sipsolutions.net/files/rt2400pci.i

Thanks!  I see it now.  Sparse is taking about 700M on x86 and 1100M on
x86_64, which is much more than it uses for other files.

Valgrind reports something interesting, but not necessarily related to
the memory hogging:

==15775== Warning: invalid file descriptor -1 in syscall read()
==15775== Source and destination overlap in memcpy(0xBEFA84B4, 0xBEFA84D0, 48)
==15775==    at 0x4007242: memcpy (mc_replace_strmem.c:402)
==15775==    by 0x805E5CB: sort_list (sort.c:207)
==15775==    by 0x8061D7C: cleanup_and_cse (cse.c:247)
==15775==    by 0x805DE7B: linearize_symbol (linearize.c:2147)
==15775==    by 0x804AEC2: check_symbols (sparse.c:266)
==15775==    by 0x804B296: main (sparse.c:284)

If sparse is compiled without optimization, the "overlap" warning is not
reported.  I think it can be ignored.

It takes several minutes for sparse to process rt2400pci.i under
valgrind.  I haven't tried looking for leaks yet.

Reducing the file may be tricky, since there is no definite way to say
if the problem exists once the code becomes shorter.  But I'll try.

-- 
Regards,
Pavel Roskin
