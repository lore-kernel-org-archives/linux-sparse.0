From: Neil Booth <neil@daikokuya.co.uk>
Subject: Re: '$' as "valid" character in identifiers
Date: Thu, 24 May 2007 23:26:08 +0900
Message-ID: <20070524142608.GJ2547@daikokuya.co.uk>
References: <4654B59A.50302@redhat.com> <alpine.LFD.0.98.0705231501430.3890@woody.linux-foundation.org> <20070524100433.GE4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from v035086.ppp.asahi-net.or.jp ([124.155.35.86]:7466 "HELO
	daikokuya.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1750709AbXEXOZx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 May 2007 10:25:53 -0400
Content-Disposition: inline
In-Reply-To: <20070524100433.GE4095@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Stefaniuc <mstefani@redhat.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

Al Viro wrote:-

> > I think it was a common extension for some strange operating systems 
> > (read: VMS), where system symbols have "$" embedded in the name. So you'd 
> > have names like "sys$function()" for system functions.
> > 
> > It's possible others did it too - gcc says it's "traditional", but the 
> > only case I've seen it is from VMS (and thus from DEC->Compaq->HP C 
> > compilers).
> > 
> > But I certainly wouldn't object to sparse supporting it, although I would 
> > suggest that it at least warn by default.
> 
> The question is how do they treat $ in preprocessor tokens.  Is it a full
> equivalent of letter?  I.e. is $x a valid identifier?  If it is, that's

Apparently yes:

http://h30097.www3.hp.com/docs/base_doc/DOCUMENTATION/V50_HTML/ARH9NATE/DOCU_026.HTM

My personal opinion is we don't want to encourage $ in identifiers,
and so I'd urge you to drop the idea :).  Too many poor mis-featured
extensions in GCC already.  At least if you do go ahead it seems the
implementation is trivial (assembler aside).

Neil.
