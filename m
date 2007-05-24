From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: fun with ?:
Date: Wed, 23 May 2007 17:29:38 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705231723260.3890@woody.linux-foundation.org>
References: <20070519025249.GZ4095@ftp.linux.org.uk> <4653633B.3000000@freedesktop.org>
 <20070522224619.GI4095@ftp.linux.org.uk> <46537BC1.9000808@freedesktop.org>
 <20070523000234.GJ4095@ftp.linux.org.uk> <20070523142544.GB2547@daikokuya.co.uk>
 <20070523143202.GY4095@ftp.linux.org.uk> <4654AF12.9040101@knosof.co.uk>
 <alpine.LFD.0.98.0705231456330.3890@woody.linux-foundation.org>
 <4654CE67.9070106@knosof.co.uk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463790079-140575689-1179966579=:3890"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([207.189.120.13]:52002 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756331AbXEXAaM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 23 May 2007 20:30:12 -0400
In-Reply-To: <4654CE67.9070106@knosof.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: Al Viro <viro@ftp.linux.org.uk>, Neil Booth <neil@daikokuya.co.uk>, Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463790079-140575689-1179966579=:3890
Content-Type: TEXT/PLAIN; charset=iso-2022-jp



On Thu, 24 May 2007, Derek M Jones wrote:
> 
> Saturated arithmetic kills off so many optimizations because reordering
> an expression might produce different results.

Yes. However, the FP people do have solutions to that, for all the same 
reasons.

(ie, you can add rules like:
 - parentheses have meaning outside of just precedence, and disable 
   associativity-based ordering optimizations.
 - the normal C side effect boundaries also act as ordering boundaries for 
   arithmetic.

> This is the point of the discussion that has got me confused.
> What compiler misfeature?  Perhaps I am using the 'wrong' version
> of gcc (version 4.0.2), but I get the expected wrapping behavior (ie,
> the compiler tries to behave at translate time the same way as st
> runtime).

The problem that Al was pointing to that sometimes gcc will do *constant 
folding* at parse time, and treat "1+n-n" as a compile-time constant in 
situations where that simply isn't valid C.

Try this:

	[torvalds@woody ~]$ cat t.c
	extern int n;
	int a[1 + n - n];
	[torvalds@woody ~]$ gcc -c -Wall t.c

and notice the lack of any error what-so-ever. With sparse, you get

	[torvalds@woody ~]$ sparse -Wall t.c
	t.c:2:13: error: bad constant expression

now, change the "1+n-n" into "1+n+n-n-n", and notice what gcc says:

	[torvalds@woody ~]$ gcc -c -Wall t.c
	t.c:2: error: variably modified ‘a’ at file scope

iow, gcc actually thinks that "1+n-n" is somehow different from 
"1+n+n-n-n".

Which was Al's point.

		Linus
---1463790079-140575689-1179966579=:3890--
