From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Re: Sparse just seg faulted on me!
Date: Wed, 14 Feb 2007 12:36:55 -0800
Message-ID: <20070214203655.GD18753@chrisli.org>
References: <9C17AC42-0C51-44D9-B126-1FB781DE0ECA@cam.ac.uk> <20070214172905.GA17959@chrisli.org> <Pine.LNX.4.64.0702141022570.3604@woody.linux-foundation.org> <20070214195447.GA18753@chrisli.org> <Pine.LNX.4.64.0702141242460.20368@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc15.comcast.net ([63.240.77.85]:52713 "EHLO
	sccrmhc15.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932595AbXBNVGs (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 14 Feb 2007 16:06:48 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702141242460.20368@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@freedesktop.org>

On Wed, Feb 14, 2007 at 12:48:17PM -0800, Linus Torvalds wrote:
> Yeah. I started out leaving bad stuff as NULL originally, but over time, 
> as I noticed SIGSEGV's, I mostly changed the ones that I ended up having 
> trigger to &bad_ctype.
> 
> Otherwise we either need to test for NULL all the time (and especially 
> since NULL under _some_ circumstances is ok and means "not evaluated yet", 
> that can be confusing), and having to pass up errors higher and higher up.

I think I run into the exact same situations. It start out as simple
rules "&bad_ctype" means error. But then all the test against NULL need
to change to test against &bad_ctpye as well. It is getting subtle for
some place NULL means not evaluated yet.

Chris
