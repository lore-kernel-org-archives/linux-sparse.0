From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Backend projects for Sparse
Date: Wed, 28 Nov 2007 14:45:13 -0500
Message-ID: <474DC549.2030000@garzik.org>
References: <1196243580.474d3a7c9895b@mail.physics.auth.gr> <70318cbf0711281053k6dc561c5ge540ccd99a6a922e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55711 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752160AbXK1TpR (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 28 Nov 2007 14:45:17 -0500
In-Reply-To: <70318cbf0711281053k6dc561c5ge540ccd99a6a922e@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: nkavv@physics.auth.gr, linux-sparse@vger.kernel.org

Christopher Li wrote:
> There is already compile-i386.c in the project. But it is not a good
> place to start.

Agreed.  That was generating code directly from the parse tree, rather 
than from the linearized form.


> It does not use the linearized byte code at all. The compile.c written by Linus
> is a better place to start.

test-linearize.c maybe?  compile.c is part of compile-i386.


>> 5) Is there any documentation covering the API and linked tools to the sparse
>> library (something more than the man pages)?
> 
> Not that I know of. If you need that much detail to perform the back end work,
> you have to read some source code. I think you can ignore a lot of the parser
> details and focus on the linearized byte code.

Agreed.

	Jeff
