From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse segfault on ppc64.
Date: Thu, 22 Mar 2007 15:16:12 -0700
Message-ID: <20070322221612.GD22151@chrisli.org>
References: <20070322063600.GD15364@redhat.com> <20070322073344.GU4095@ftp.linux.org.uk> <20070322070354.GA22151@chrisli.org> <20070322125911.GW4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc11.comcast.net ([63.240.77.81]:59500 "EHLO
	sccrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbXCVWy0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 22 Mar 2007 18:54:26 -0400
Content-Disposition: inline
In-Reply-To: <20070322125911.GW4095@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Dave Jones <davej@redhat.com>, linux-sparse@vger.kernel.org

On Thu, Mar 22, 2007 at 12:59:11PM +0000, Al Viro wrote:
> On Thu, Mar 22, 2007 at 12:03:54AM -0700, Christopher Li wrote:
> Humm...  I don't see ppc segfaults with the current tree.  However, after
> merging the mainline sparse changes and looking for regressions on kernel
> allmodconfig builds, I'm seeing a lot of noise due to expression_error() use.
> What used to generate a single error now brings a cascade.  More often than

Can you show me some example of the duplicate error? I can't seem to hit it
in on x86. I do notice though there is a few context imbalance report on the
inline function instead of the caller site.

> not it's utterly pointless; actually, I can't find a single instance where
> additional errors would add any useful information...

The expression_error is not intend to report more error. It is try to avoid
test expr->ctype against zero all the time. We often have error path there is
some expression has NULL in ctype then sparse segfaulted.

We can work on clean up the duplicate warnings.

Chris
