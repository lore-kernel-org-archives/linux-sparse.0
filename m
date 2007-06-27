From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 16/16] fix handling of integer constant expressions
Date: Wed, 27 Jun 2007 01:18:03 +0100
Message-ID: <20070627001803.GJ21478@ftp.linux.org.uk>
References: <20070624174732.GZ21478@ftp.linux.org.uk> <alpine.LFD.0.98.0706241102160.3593@woody.linux-foundation.org> <20070624183547.GA21478@ftp.linux.org.uk> <alpine.LFD.0.98.0706241203530.3593@woody.linux-foundation.org> <1a25667a20e43a072f733a3ec2b8e79d@kernel.crashing.org> <20070624203837.GE21478@ftp.linux.org.uk> <467F531A.3030702@freedesktop.org> <20070626221040.GI21478@ftp.linux.org.uk> <20070626221134.GA21350@ftp.linux.org.uk> <20070626233226.GO7590@daikokuya.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:50069 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbXF0ASG (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 26 Jun 2007 20:18:06 -0400
Content-Disposition: inline
In-Reply-To: <20070626233226.GO7590@daikokuya.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Neil Booth <neil@daikokuya.co.uk>
Cc: Josh Triplett <josh@freedesktop.org>, Segher Boessenkool <segher@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org

On Wed, Jun 27, 2007 at 08:32:26AM +0900, Neil Booth wrote:
> Al Viro wrote:-
> 
> > Hopefully correct handling of integer constant expressions.  Please, review.
> 
> Am I invoking sparse wrongly?  ./sparse -W -Wall doesn't diagnose
> the following TU, for example.
> 
> extern int a;
> extern int as1[(a = 2)];

sparse simply doesn't check that.  We don't have anything resembling
support of VLA.  Note that check for integer constant expression
has nothing to do with that;

	int x[(int)(0.6 + 0.6)];

is valid (if stupid).  And yes, footnote in 6.6 contradicts 6.7.5.2(1);
too bad...

We certainly need to do checks on array sizes; however, that part
("if it has static storage duration, it should not be a VLA") is minor.
And then there are gccisms:
size_t foo(int n)
{
	struct {
		int a[n];
		char b;
	} x;
	return offsetof(typeof(x), b);
}

Yes, it's eaten up just fine.  And yes, such structures are silently
accepted even with -pedantic -std=c99, which is a bug.  Sigh...

We'll need to tackle VLAs at some point, but it certainly won't be fun ;-/
