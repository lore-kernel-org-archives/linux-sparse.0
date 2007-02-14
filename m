From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Re: Sparse just seg faulted on me!
Date: Wed, 14 Feb 2007 11:54:47 -0800
Message-ID: <20070214195447.GA18753@chrisli.org>
References: <9C17AC42-0C51-44D9-B126-1FB781DE0ECA@cam.ac.uk> <20070214172905.GA17959@chrisli.org> <Pine.LNX.4.64.0702141022570.3604@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:56215 "EHLO
	rwcrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932564AbXBNUYm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 14 Feb 2007 15:24:42 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702141022570.3604@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@freedesktop.org>

On Wed, Feb 14, 2007 at 10:24:09AM -0800, Linus Torvalds wrote:
> Actually, it's often better to just explicitly make "ctype" be 
> "&bad_ctype" instead.
> 
> It's nice if a NULL type means "type has not been evaluated yet", and then 
> using "&bad_ctype" to mean "type evaluated to crap".

Good idea. Some of the code already doing that. I am making it as a separate
patch because touch a lot of code.

Chris
