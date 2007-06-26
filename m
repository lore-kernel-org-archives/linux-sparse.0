From: Jeff Garzik <jeff@garzik.org>
Subject: Re: support for C++ ?
Date: Tue, 26 Jun 2007 07:01:29 -0400
Message-ID: <4680F209.7070601@garzik.org>
References: <Pine.LNX.4.64.0706252219310.12395@paik.artengine.ca> <4680A013.8030707@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58376 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752357AbXFZLBc (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 26 Jun 2007 07:01:32 -0400
In-Reply-To: <4680A013.8030707@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Mathieu Bouchard <matju@artengine.ca>, linux-sparse@vger.kernel.org

Josh Triplett wrote:
> To the best of my knowledge, nobody involved in the Sparse community has any
> plans to attempt C++.  I also think that a subset of the language capable of
> handling any significant number of common programs would end up containing
> most of the language.  Even basic support for C++ would require large changes
> to the parser and to the Sparse data structures, and that doesn't even count
> the huge can of worms that would open once you start running into interactions
> between Sparse-annotated types and inheritance or overloading.


Indeed.  The gcc people even wrote their own hand-coded C++ parser for 
similar reasons, so I can't see it being an easy integration into 
sparse.  You might as well fork at that point.

	Jeff
