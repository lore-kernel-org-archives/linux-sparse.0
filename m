From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] sparse: Increase pre_buffer[] and check overflow
Date: Tue, 8 Jul 2008 22:45:47 +0200
Message-ID: <20080708204547.GA16742@uranus.ravnborg.org>
References: <20080709.002805.128619748.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from pasmtpb.tele.dk ([80.160.77.98]:37385 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752015AbYGHUo7 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 8 Jul 2008 16:44:59 -0400
Content-Disposition: inline
In-Reply-To: <20080709.002805.128619748.anemo@mba.ocn.ne.jp>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-sparse@vger.kernel.org, linux-mips@linux-mips.org

On Wed, Jul 09, 2008 at 12:28:05AM +0900, Atsushi Nemoto wrote:
> I got this error when running sparse on mips kernel with gcc 4.3:
> 
> builtin:272:1: warning: Newline in string or character constant
> 
> The linus-mips kernel uses '$(CC) -dM -E' to generates arguments for
> sparse.  With gcc 4.3, it generates lot of '-D' options and causes
> pre_buffer overflow.

Why does mips have this need when all other archs does not?
We should fix sparse so it is dynamically allocated - but
that is not an excuse for mips to use odd stuff like this.

So please someone from mips land explain why this is needed.

	Sam
