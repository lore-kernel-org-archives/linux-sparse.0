From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Re: Sparse just seg faulted on me!
Date: Wed, 14 Feb 2007 10:24:09 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702141022570.3604@woody.linux-foundation.org>
References: <9C17AC42-0C51-44D9-B126-1FB781DE0ECA@cam.ac.uk>
 <20070214172905.GA17959@chrisli.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:38332 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932431AbXBNSYQ (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 14 Feb 2007 13:24:16 -0500
In-Reply-To: <20070214172905.GA17959@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@freedesktop.org>



On Wed, 14 Feb 2007, Christopher Li wrote:
>
> > fs/ntfs/sysctl.c:38:15: error: undefined identifier 'CTL_UNNUMBRED'
>
> Sparse left empty ctype when error happen. Sparse should skip
> the expand_symbol() at all if error happen. 

Actually, it's often better to just explicitly make "ctype" be 
"&bad_ctype" instead.

It's nice if a NULL type means "type has not been evaluated yet", and then 
using "&bad_ctype" to mean "type evaluated to crap".

		Linus
