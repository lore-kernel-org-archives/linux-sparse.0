From: Dave Jones <davej@redhat.com>
Subject: Re: sparse segfault on ppc64.
Date: Thu, 22 Mar 2007 12:04:21 -0400
Message-ID: <20070322160421.GH15364@redhat.com>
References: <20070322063600.GD15364@redhat.com> <20070322073344.GU4095@ftp.linux.org.uk> <20070322070354.GA22151@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:45779 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933738AbXCVQEu (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 22 Mar 2007 12:04:50 -0400
Content-Disposition: inline
In-Reply-To: <20070322070354.GA22151@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

On Thu, Mar 22, 2007 at 12:03:54AM -0700, Christopher Li wrote:
 > On Thu, Mar 22, 2007 at 07:33:44AM +0000, Al Viro wrote:
 > > Segfault is new (which version?); the fscking mess in altivec is not, but
 > > it (a) doesn't depend on host sparse is ran on; (b) shouldn't lead to
 > > segfaults.  Altivec extensions are undocumented and fortunately used only
 > > in one place in the tree.  You should get sparse errors, but it shouldn't
 > > die on those.
 > 
 > I think the segfault is likely to cause by my recent change in the parser.
 > 
 > Dave, can you get a backtrace of the segfault? Even better if you can
 > give me a small test case which I can reproduce it on x86.

I did battle with our ppc64 buildhost last night to try and coax it
into giving me a coredump, no luck. And as I don't have gcc in that
chroot, I couldn't build it natively.  Given this is altivec stuff,
I didn't try building it on x86. At which point I admitted defeat
and turned in for the night ;)

I'll see if I can force it into something buildable on x86 later,
but first I'll see if I can get a useful shell on that buildhost
that I can run gcc & gdb in.

	Dave
-- 
http://www.codemonkey.org.uk
