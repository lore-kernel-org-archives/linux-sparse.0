From: Neil Booth <neil@daikokuya.co.uk>
Subject: Re: fun with ?:
Date: Thu, 24 May 2007 08:01:43 +0900
Message-ID: <20070523230143.GG2547@daikokuya.co.uk>
References: <20070519025249.GZ4095@ftp.linux.org.uk> <4653633B.3000000@freedesktop.org> <20070522224619.GI4095@ftp.linux.org.uk> <46537BC1.9000808@freedesktop.org> <20070523000234.GJ4095@ftp.linux.org.uk> <20070523142544.GB2547@daikokuya.co.uk> <20070523143202.GY4095@ftp.linux.org.uk> <20070523144716.GC2547@daikokuya.co.uk> <20070523153255.GA4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from v035086.ppp.asahi-net.or.jp ([124.155.35.86]:7516 "HELO
	daikokuya.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1756647AbXEWXB3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 23 May 2007 19:01:29 -0400
Content-Disposition: inline
In-Reply-To: <20070523153255.GA4095@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

Al Viro wrote:-

> BTW, the fun question is whether (int)(1.1) is allowed; the same goes
> for "is ((void *)0) a null pointer constant".  6.5.1 is sloppy ;-)

I believe that the intent is that parentheses are not viewed as
operators, just a grouping tool, so yes to both.  All implementations
I'm aware of take that view.

Neil.
