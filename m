From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patchset] rewrite of initializer handling
Date: Mon, 18 Jun 2007 12:27:07 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706181223070.3593@woody.linux-foundation.org>
References: <20070618101929.GE21478@ftp.linux.org.uk> <4676CC9C.3050903@freedesktop.org>
 <20070618191653.GG21478@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38794 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761241AbXFRT2S (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 18 Jun 2007 15:28:18 -0400
In-Reply-To: <20070618191653.GG21478@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org



On Mon, 18 Jun 2007, Al Viro wrote:
> > 
> > That seems like a great approach to me; logically, an initializer should
> > expand an array of unspecified size to hold elements up to its maximum index.
> 
> That's what count_array_initializer() is trying to do, but the trouble is
> that it doesn't notice that some list elements may end up initializing
> parts of the same array member.  IOW, it tries to do the right thing,
> but to do it correctly you need to look at more than just "this has
> explicit designator, this doesn't".
> 
> I'm not sure that I understand the details of type examination in symbol.c
> enough to say whether we'd break anything by doing it that way, though.
> The question is how much of the laziness would be destroyed by that.
> Linus?

I really forget - but I do remember that arrays were a bitch from the type 
handling perspective. We need to examine their types properly early, and 
then we wanted to set their size as part of that, and there were various 
subtle ordering requirements there.

It is entirely possible that your patch fixes these things, but that whole 
type evaluation is quite easy to break by mistake..

			Linus
