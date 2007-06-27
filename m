From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 16/16] fix handling of integer constant expressions
Date: Wed, 27 Jun 2007 01:41:16 +0100
Message-ID: <20070627004116.GL21478@ftp.linux.org.uk>
References: <20070624183547.GA21478@ftp.linux.org.uk> <alpine.LFD.0.98.0706241203530.3593@woody.linux-foundation.org> <1a25667a20e43a072f733a3ec2b8e79d@kernel.crashing.org> <20070624203837.GE21478@ftp.linux.org.uk> <467F531A.3030702@freedesktop.org> <20070626221040.GI21478@ftp.linux.org.uk> <20070626221134.GA21350@ftp.linux.org.uk> <20070626233226.GO7590@daikokuya.co.uk> <20070627001803.GJ21478@ftp.linux.org.uk> <4681AF87.3000301@knosof.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:38382 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbXF0AlS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 26 Jun 2007 20:41:18 -0400
Content-Disposition: inline
In-Reply-To: <4681AF87.3000301@knosof.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: Neil Booth <neil@daikokuya.co.uk>, Josh Triplett <josh@freedesktop.org>, Segher Boessenkool <segher@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org

On Wed, Jun 27, 2007 at 01:29:59AM +0100, Derek M Jones wrote:
> Al Viro wrote:
> 
> >>>Hopefully correct handling of integer constant expressions.  Please, 
> >>>review.
> >>Am I invoking sparse wrongly?  ./sparse -W -Wall doesn't diagnose
> >>the following TU, for example.
> >>
> >>extern int a;
> >>extern int as1[(a = 2)];
> >
> >sparse simply doesn't check that.  We don't have anything resembling
> >support of VLA.
> 
> If it did support VLAs it would point out that this is
> a constraint violation.  VLAs must have block or function
> prototype scope.

I know.  It's just that "let's do something about array size checks"
triggers "yeah, but the poor sod who does that will have to sort
VLAs *and* gcc extensions around VLAs out", which is not a nice thought
and so far nobody had touched that area at all.
