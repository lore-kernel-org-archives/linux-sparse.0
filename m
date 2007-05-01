From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: sparse -Wptr-subtraction-blows: still needed?
Date: Tue, 1 May 2007 14:43:30 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705011442320.3808@woody.linux-foundation.org>
References: <4637AC3D.6000008@freedesktop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:35356 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1945943AbXEAVoR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 May 2007 17:44:17 -0400
In-Reply-To: <4637AC3D.6000008@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>



On Tue, 1 May 2007, Josh Triplett wrote:
> 
> Does this still apply?  Do current versions of GCC still have this problem?
> If not, can the option and warning go away?

Even if current versions of gcc don't triple the build time (and for the 
kernel, I suspect it doesn't, because we've tried to clean up our header 
files), the generated _code_ will invariably suck.

So I'd not want to remove the warning.

		Linus
