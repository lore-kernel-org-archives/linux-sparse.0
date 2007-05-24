From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: fun with ?:
Date: Thu, 24 May 2007 01:10:08 +0100
Message-ID: <4654D7E0.6090505@knosof.co.uk>
References: <20070519025249.GZ4095@ftp.linux.org.uk> <4653633B.3000000@freedesktop.org> <20070522224619.GI4095@ftp.linux.org.uk> <46537BC1.9000808@freedesktop.org> <20070523000234.GJ4095@ftp.linux.org.uk> <20070523142544.GB2547@daikokuya.co.uk> <20070523143202.GY4095@ftp.linux.org.uk> <20070523144716.GC2547@daikokuya.co.uk> <20070523153255.GA4095@ftp.linux.org.uk> <20070523230143.GG2547@daikokuya.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:60969 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756343AbXEXAKV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 23 May 2007 20:10:21 -0400
In-Reply-To: <20070523230143.GG2547@daikokuya.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Neil Booth <neil@daikokuya.co.uk>
Cc: Al Viro <viro@ftp.linux.org.uk>, Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

Neil,

>> BTW, the fun question is whether (int)(1.1) is allowed; the same goes
>> for "is ((void *)0) a null pointer constant".  6.5.1 is sloppy ;-)
> 
> I believe that the intent is that parentheses are not viewed as
> operators,

I suspect that many implementations simply throw them away (or rather
don't bother hanging onto them) in this case, and so work by
'accident'.

>             just a grouping tool, so yes to both.  All implementations
> I'm aware of take that view.

The word 'immediate' in sentence 1318
http://c0x.coding-guidelines.com/6.6.html
"... floating constants that are the immediate operands of casts"
could be interpreted to mean that no other tokens occur between
the cast and its operand.

I suspect that the behavior of existing implementations would be
enough to push any implementation that did not treat (int)(1.1) as
an integer constant into accepting it as such.

-- 
Derek M. Jones                              tel: +44 (0) 1252 520 667
Knowledge Software Ltd                      mailto:derek@knosof.co.uk
Applications Standards Conformance Testing    http://www.knosof.co.uk
