From: Brett Nash <nash@fst.net>
Subject: Re: fun with ?:
Date: Thu, 24 May 2007 11:36:22 +1000
Message-ID: <1179970582.2498.9.camel@baboon.fluffyspider.com.au>
References: <20070519025249.GZ4095@ftp.linux.org.uk>
	 <4653633B.3000000@freedesktop.org> <20070522224619.GI4095@ftp.linux.org.uk>
	 <46537BC1.9000808@freedesktop.org> <20070523000234.GJ4095@ftp.linux.org.uk>
	 <20070523142544.GB2547@daikokuya.co.uk>
	 <20070523143202.GY4095@ftp.linux.org.uk>  <4654AF12.9040101@knosof.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from 218-214-60-232.people.net.au ([218.214.60.232]:41015 "EHLO
	sealpup.fluffyspider.com.au" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757652AbXEXCTg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 23 May 2007 22:19:36 -0400
In-Reply-To: <4654AF12.9040101@knosof.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: linux-sparse@vger.kernel.org

On Wed, 2007-05-23 at 22:16 +0100, Derek M Jones wrote:
> > extern int n;
> > struct {
> > 	int x : 1 + n - n;
> > } y;
> > 
> > passes with -pedantic -std=c99.  Replacing that with 1 + n - n + n - n
> > is still OK with gcc; 1 + n + n - n - n is not.
> > 
> > So that's hardly an example of, well, anything.
> 
> It is an example of order of evaluation mattering when overflow
> occurs.

I shudder to think of the architecture where integer overflow and
bit-field declarations are mentioned in the same sentence.

	nash
	[Going back to lurking, on his new amd2147483648]
