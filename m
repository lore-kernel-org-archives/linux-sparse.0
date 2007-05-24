From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: '$' as "valid" character in identifiers
Date: Thu, 24 May 2007 15:10:15 +0100
Message-ID: <20070524141015.GG4095@ftp.linux.org.uk>
References: <4654B59A.50302@redhat.com> <alpine.LFD.0.98.0705231501430.3890@woody.linux-foundation.org> <20070524100433.GE4095@ftp.linux.org.uk> <4655737B.7010701@knosof.co.uk> <20070524123512.GF4095@ftp.linux.org.uk> <46559093.5060908@knosof.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:45143 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbXEXOKV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 May 2007 10:10:21 -0400
Content-Disposition: inline
In-Reply-To: <46559093.5060908@knosof.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Stefaniuc <mstefani@redhat.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Thu, May 24, 2007 at 02:18:11PM +0100, Derek M Jones wrote:
> Al,
> 
> >And now for reality: of course if we set out to imitate the implementation
> >allowing $, we'd better imitate it.  The question is what to watch out
> >for and how to avoid buggering the tokenizer in process.
> 
> If sparse is going to imitate a VAX implementation then how $ is glued
> is probably the least of the implemention worries.

I suspect that the real issue is whatever stuff Windows uses (and no,
I don't have Windows boxen either).  Anybody who wants to work on
code that last compiled on VAX is not going to be happy with what
sparse will say about it, anyway.  More realistic case is a codebase
with some VMS ancestry that got moved to Windows.
