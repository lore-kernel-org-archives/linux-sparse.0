From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: fun with ?:
Date: Wed, 23 May 2007 14:59:42 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705231456330.3890@woody.linux-foundation.org>
References: <20070519025249.GZ4095@ftp.linux.org.uk> <4653633B.3000000@freedesktop.org>
 <20070522224619.GI4095@ftp.linux.org.uk> <46537BC1.9000808@freedesktop.org>
 <20070523000234.GJ4095@ftp.linux.org.uk> <20070523142544.GB2547@daikokuya.co.uk>
 <20070523143202.GY4095@ftp.linux.org.uk> <4654AF12.9040101@knosof.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([207.189.120.13]:40831 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756070AbXEWWNB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 23 May 2007 18:13:01 -0400
In-Reply-To: <4654AF12.9040101@knosof.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: Al Viro <viro@ftp.linux.org.uk>, Neil Booth <neil@daikokuya.co.uk>, Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org



On Wed, 23 May 2007, Derek M Jones wrote:
> > 
> > passes with -pedantic -std=c99.  Replacing that with 1 + n - n + n - n
> > is still OK with gcc; 1 + n + n - n - n is not.
> > 
> > So that's hardly an example of, well, anything.
> 
> It is an example of order of evaluation mattering when overflow
> occurs.

No it isn't.

"1 + n - n" can overflow equally as "1 + n + n - n -n" can, and if you 
want them to do saturation or something, you cannot optimize _either_ of 
them to just "1". If "n" is MAX_INT, then with saturating arithmetic, 
neither of them results in 1.

Not that signed overflow is even specified by the C standard (and 
unsigned is specified to be well-behaved).

So it seems to be purely a compiler misfeature. No excuses.

			Linus
