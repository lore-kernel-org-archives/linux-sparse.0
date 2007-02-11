From: Christopher Li <sparse@chrisli.org>
Subject: Re: [ANNOUNCE] sparse-0.2-cl2 is now available
Date: Sat, 10 Feb 2007 21:17:58 -0800
Message-ID: <20070211051758.GA2113@chrisli.org>
References: <20070204085329.GA6520@chrisli.org> <20070210000055.GA19968@chrisli.org> <p73hctthq8q.fsf@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc14.comcast.net ([204.127.200.84]:51769 "EHLO
	sccrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbXBKFqx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 11 Feb 2007 00:46:53 -0500
Content-Disposition: inline
In-Reply-To: <p73hctthq8q.fsf@bingen.suse.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-sparse@vger.kernel.org, linux kernel mail list <linux-kernel@vger.kernel.org>, Josh Triplett <josh@freedesktop.org>

On Sat, Feb 10, 2007 at 06:33:25PM +0100, Andi Kleen wrote:
> Interesting. Did you find any kernel bugs with this?

In short, not very useful yet.

The current run of of sparse-0.2-cl2 on git default i386 config
will find about 6 place kernel using allocated memory without NULL
check. But Linus said most of them is not worthy checking because
it is in the early stage of the kernel initializations.
It just can't fail on those small memory allocation. May be one
of them worth adding the NULL check.

For interrupt and spinlock checking, it less noisier than the current
sparse context level checking. The new checker code can identify inline
function call, so it has more information. But it is still too noisy.
I did not look at every interrupt and spinlock warning. From what I saw,
it show limit of the checker itself rather than a bug in kernel.

A lot of false positive is come from we don't have enough information
inside a single function.

e.g. sparse has not way to know some function only get called with interrupt
disabled (or some lock already hold). So it assume interrupt is still
enable and generate wrong warnings. Another example is that some helper
function will wrap the locking function. Complain about the exit with locking
hold is wrong.

I am hoping adding the cross function checking will reduce those false positive.
Any way, it need more information to reduce false positive.

I am still working on the cross function checking. May be it will become
more useful one day.

Chris
