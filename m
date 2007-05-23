From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: fun with ?:
Date: Thu, 24 May 2007 00:29:43 +0100
Message-ID: <4654CE67.9070106@knosof.co.uk>
References: <20070519025249.GZ4095@ftp.linux.org.uk> <4653633B.3000000@freedesktop.org> <20070522224619.GI4095@ftp.linux.org.uk> <46537BC1.9000808@freedesktop.org> <20070523000234.GJ4095@ftp.linux.org.uk> <20070523142544.GB2547@daikokuya.co.uk> <20070523143202.GY4095@ftp.linux.org.uk> <4654AF12.9040101@knosof.co.uk> <alpine.LFD.0.98.0705231456330.3890@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:55206 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756442AbXEWX3z (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 23 May 2007 19:29:55 -0400
In-Reply-To: <alpine.LFD.0.98.0705231456330.3890@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Neil Booth <neil@daikokuya.co.uk>, Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org

Linus,

>>> passes with -pedantic -std=c99.  Replacing that with 1 + n - n + n - n
>>> is still OK with gcc; 1 + n + n - n - n is not.
>>>
>>> So that's hardly an example of, well, anything.
>> It is an example of order of evaluation mattering when overflow
>> occurs.
> 
> No it isn't.

It was intended as a probabilit statement (ok, I did not make that
clear).  An expression containing n+n is more likely to overflow
than one containing n-n.

Anyway, getting away from nit-picking of what was intended to be a throw
away remark.

> "1 + n - n" can overflow equally as "1 + n + n - n -n" can, and if you 
> want them to do saturation or something, you cannot optimize _either_ of 
> them to just "1". If "n" is MAX_INT, then with saturating arithmetic, 
> neither of them results in 1.

Saturated arithmetic kills off so many optimizations because reordering
an expression might produce different results.

> Not that signed overflow is even specified by the C standard (and 
> unsigned is specified to be well-behaved).

Overflow for signed integer types is undefined behavior
(well technically this is an instance of
"... not in the range of representable values for its type",
sentence 490 http://c0x.coding-guidelines.com/6.5.html).

> So it seems to be purely a compiler misfeature. No excuses.

This is the point of the discussion that has got me confused.
What compiler misfeature?  Perhaps I am using the 'wrong' version
of gcc (version 4.0.2), but I get the expected wrapping behavior (ie,
the compiler tries to behave at translate time the same way as st
runtime).

-- 
Derek M. Jones                              tel: +44 (0) 1252 520 667
Knowledge Software Ltd                      mailto:derek@knosof.co.uk
Applications Standards Conformance Testing    http://www.knosof.co.uk
