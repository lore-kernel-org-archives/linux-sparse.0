From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: fun with ?:
Date: Wed, 23 May 2007 15:32:02 +0100
Message-ID: <20070523143202.GY4095@ftp.linux.org.uk>
References: <20070519025249.GZ4095@ftp.linux.org.uk> <4653633B.3000000@freedesktop.org> <20070522224619.GI4095@ftp.linux.org.uk> <46537BC1.9000808@freedesktop.org> <20070523000234.GJ4095@ftp.linux.org.uk> <20070523142544.GB2547@daikokuya.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:33761 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755048AbXEWOcF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 23 May 2007 10:32:05 -0400
Content-Disposition: inline
In-Reply-To: <20070523142544.GB2547@daikokuya.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Neil Booth <neil@daikokuya.co.uk>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, May 23, 2007 at 11:25:44PM +0900, Neil Booth wrote:
> I respect you too much Al to doubt you, but I do warn you that
> getting the rules for integer constant expressions right in C is
> harder than it looks.  GCC is not very close.  The immediate
> cast of float bit painful in recursive descent parsers.  I've managed
> to find cases where Comeau's online compiler doesn't get it right,
> and they're pretty good.
> 
> I have a test suite that tests these things to an unhealthy level of
> pedantry for my own implementation (the only one I know passes the lot,
> of course 8-); happy to run sparse when you've finished if you like.

gcc integer constant expressions handling is a bad joke.

extern int n;
struct {
	int x : 1 + n - n;
} y;

passes with -pedantic -std=c99.  Replacing that with 1 + n - n + n - n
is still OK with gcc; 1 + n + n - n - n is not.

So that's hardly an example of, well, anything.
