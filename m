From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse segfault on ppc64.
Date: Thu, 22 Mar 2007 00:03:54 -0700
Message-ID: <20070322070354.GA22151@chrisli.org>
References: <20070322063600.GD15364@redhat.com> <20070322073344.GU4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc15.comcast.net ([204.127.200.85]:56749 "EHLO
	sccrmhc15.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155AbXCVHmA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 22 Mar 2007 03:42:00 -0400
Content-Disposition: inline
In-Reply-To: <20070322073344.GU4095@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Dave Jones <davej@redhat.com>, linux-sparse@vger.kernel.org

On Thu, Mar 22, 2007 at 07:33:44AM +0000, Al Viro wrote:
> Segfault is new (which version?); the fscking mess in altivec is not, but
> it (a) doesn't depend on host sparse is ran on; (b) shouldn't lead to
> segfaults.  Altivec extensions are undocumented and fortunately used only
> in one place in the tree.  You should get sparse errors, but it shouldn't
> die on those.

I think the segfault is likely to cause by my recent change in the parser.

Dave, can you get a backtrace of the segfault? Even better if you can
give me a small test case which I can reproduce it on x86.

My guess it is cause by the bad_ctype related changes.

Chris
