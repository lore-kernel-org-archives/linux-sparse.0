From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: sparse segfault on ppc64.
Date: Thu, 22 Mar 2007 12:59:11 +0000
Message-ID: <20070322125911.GW4095@ftp.linux.org.uk>
References: <20070322063600.GD15364@redhat.com> <20070322073344.GU4095@ftp.linux.org.uk> <20070322070354.GA22151@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:49075 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbXCVM7O (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 22 Mar 2007 08:59:14 -0400
Content-Disposition: inline
In-Reply-To: <20070322070354.GA22151@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dave Jones <davej@redhat.com>, linux-sparse@vger.kernel.org

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
> 
> My guess it is cause by the bad_ctype related changes.

Humm...  I don't see ppc segfaults with the current tree.  However, after
merging the mainline sparse changes and looking for regressions on kernel
allmodconfig builds, I'm seeing a lot of noise due to expression_error() use.
What used to generate a single error now brings a cascade.  More often than
not it's utterly pointless; actually, I can't find a single instance where
additional errors would add any useful information...
