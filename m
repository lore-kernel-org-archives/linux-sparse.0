From: Neil Booth <neil@daikokuya.co.uk>
Subject: Re: fun with ?:
Date: Wed, 23 May 2007 23:47:16 +0900
Message-ID: <20070523144716.GC2547@daikokuya.co.uk>
References: <20070519025249.GZ4095@ftp.linux.org.uk> <4653633B.3000000@freedesktop.org> <20070522224619.GI4095@ftp.linux.org.uk> <46537BC1.9000808@freedesktop.org> <20070523000234.GJ4095@ftp.linux.org.uk> <20070523142544.GB2547@daikokuya.co.uk> <20070523143202.GY4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from v035086.ppp.asahi-net.or.jp ([124.155.35.86]:7428 "HELO
	daikokuya.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1757125AbXEWOrH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 23 May 2007 10:47:07 -0400
Content-Disposition: inline
In-Reply-To: <20070523143202.GY4095@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

Al Viro wrote:-

> gcc integer constant expressions handling is a bad joke.
> 
> extern int n;
> struct {
> 	int x : 1 + n - n;
> } y;
> 
> passes with -pedantic -std=c99.  Replacing that with 1 + n - n + n - n
> is still OK with gcc; 1 + n + n - n - n is not.
> 
> So that's hardly an example of, well, anything.

Consistency?  :-)  I wasn't aware of the quirk of the second example.

Apparently these expressions are only folded if their net result
is obvious as parsed by the grammar.  Fixing this in GCC is a
horrendous amount of work; so much internal logic relies on this
early simplification, which is why it's not been done I guess.

Neil.
