From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 16/16] fix handling of integer constant expressions
Date: Tue, 26 Jun 2007 17:25:06 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706261721550.8675@woody.linux-foundation.org>
References: <20070624174732.GZ21478@ftp.linux.org.uk>
 <alpine.LFD.0.98.0706241102160.3593@woody.linux-foundation.org>
 <20070624183547.GA21478@ftp.linux.org.uk> <alpine.LFD.0.98.0706241203530.3593@woody.linux-foundation.org>
 <1a25667a20e43a072f733a3ec2b8e79d@kernel.crashing.org>
 <20070624203837.GE21478@ftp.linux.org.uk> <467F531A.3030702@freedesktop.org>
 <20070626221040.GI21478@ftp.linux.org.uk> <20070626221134.GA21350@ftp.linux.org.uk>
 <20070626233226.GO7590@daikokuya.co.uk>
 <20070627001803.GJ21478@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35200 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753872AbXF0AZZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 26 Jun 2007 20:25:25 -0400
In-Reply-To: <20070627001803.GJ21478@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Neil Booth <neil@daikokuya.co.uk>, Josh Triplett <josh@freedesktop.org>, Segher Boessenkool <segher@kernel.crashing.org>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org



On Wed, 27 Jun 2007, Al Viro wrote:
>
> > extern int a;
> > extern int as1[(a = 2)];
> 
> sparse simply doesn't check that.  We don't have anything resembling
> support of VLA.

Well, the above has two bugs that sparse could notice _independently_ of 
variable-sized arrays:
 - assignment outside of a function
 - variable size array that isn't an automatic variable

(strictly speaking, that's not even a variable size - it's a constant 2, 
just with a non-constant expression - maybe you misread the "=" as an 
"==")

		Linus
