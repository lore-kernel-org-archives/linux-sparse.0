From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: pointer arithmetics and casts
Date: Sat, 26 May 2007 04:43:55 +0100
Message-ID: <20070526034354.GP4095@ftp.linux.org.uk>
References: <20070525212300.GL4095@ftp.linux.org.uk> <118833cc0705251814h9fffa39xc4a0f3f9e61242b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:54945 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbXEZDn4 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 May 2007 23:43:56 -0400
Content-Disposition: inline
In-Reply-To: <118833cc0705251814h9fffa39xc4a0f3f9e61242b9@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Morten Welinder <mwelinder@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Fri, May 25, 2007 at 09:14:33PM -0400, Morten Welinder wrote:
> >        BINOP[+]
> >                <tree for p>
> >                BINOP[*]
> >                        IMPLICIEDT_CAST[ptrdiff_t]
> >                                <tree for i>
> >                        VAL[sizeof(*p)]
> 
> I don't think you want ptrdiff_t there.  It isn't guaranteed to
> be big enough.

Only if you are allowed to have an array object with elements too far
for their addresses to be subtracted...
 
> size_t should do, though.

size_t is an unsigned type, so by definition it won't do...
