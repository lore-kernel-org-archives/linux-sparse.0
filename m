From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: fun with ?:
Date: Wed, 23 May 2007 22:16:02 +0100
Message-ID: <4654AF12.9040101@knosof.co.uk>
References: <20070519025249.GZ4095@ftp.linux.org.uk> <4653633B.3000000@freedesktop.org> <20070522224619.GI4095@ftp.linux.org.uk> <46537BC1.9000808@freedesktop.org> <20070523000234.GJ4095@ftp.linux.org.uk> <20070523142544.GB2547@daikokuya.co.uk> <20070523143202.GY4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:40803 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756100AbXEWVQL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 23 May 2007 17:16:11 -0400
In-Reply-To: <20070523143202.GY4095@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Neil Booth <neil@daikokuya.co.uk>, Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

Al,

>> cast of float bit painful in recursive descent parsers.  I've managed
>> to find cases where Comeau's online compiler doesn't get it right,
>> and they're pretty good.

I would be interested to know what these cases were.

> extern int n;
> struct {
> 	int x : 1 + n - n;
> } y;
> 
> passes with -pedantic -std=c99.  Replacing that with 1 + n - n + n - n
> is still OK with gcc; 1 + n + n - n - n is not.
> 
> So that's hardly an example of, well, anything.

It is an example of order of evaluation mattering when overflow
occurs.

What with game programming growing and growing in importance
I think it won't be long before saturated interger arithmetic
overflow will be encountered just as often as the 'conventional'
wrapping behavior.

-- 
Derek M. Jones                              tel: +44 (0) 1252 520 667
Knowledge Software Ltd                      mailto:derek@knosof.co.uk
Applications Standards Conformance Testing    http://www.knosof.co.uk
