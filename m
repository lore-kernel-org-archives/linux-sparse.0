From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: fun with ?:
Date: Thu, 24 May 2007 01:14:31 +0100
Message-ID: <20070524001431.GD4095@ftp.linux.org.uk>
References: <20070519025249.GZ4095@ftp.linux.org.uk> <4653633B.3000000@freedesktop.org> <20070522224619.GI4095@ftp.linux.org.uk> <46537BC1.9000808@freedesktop.org> <20070523000234.GJ4095@ftp.linux.org.uk> <20070523142544.GB2547@daikokuya.co.uk> <20070523143202.GY4095@ftp.linux.org.uk> <20070523144716.GC2547@daikokuya.co.uk> <20070523153255.GA4095@ftp.linux.org.uk> <20070523230143.GG2547@daikokuya.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:46864 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755709AbXEXAOc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 23 May 2007 20:14:32 -0400
Content-Disposition: inline
In-Reply-To: <20070523230143.GG2547@daikokuya.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Neil Booth <neil@daikokuya.co.uk>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, May 24, 2007 at 08:01:43AM +0900, Neil Booth wrote:
> Al Viro wrote:-
> 
> > BTW, the fun question is whether (int)(1.1) is allowed; the same goes
> > for "is ((void *)0) a null pointer constant".  6.5.1 is sloppy ;-)
> 
> I believe that the intent is that parentheses are not viewed as
> operators, just a grouping tool, so yes to both.  All implementations
> I'm aware of take that view.

Sure - especially for the second example ;-)  And no, I don't think
anybody can be arsed to file a DR about that.
