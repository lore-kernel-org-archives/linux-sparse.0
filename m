From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: '$' as "valid" character in identifiers
Date: Wed, 23 May 2007 15:10:57 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705231501430.3890@woody.linux-foundation.org>
References: <4654B59A.50302@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([207.189.120.13]:53909 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755293AbXEWWLI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 23 May 2007 18:11:08 -0400
In-Reply-To: <4654B59A.50302@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Michael Stefaniuc <mstefani@redhat.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>



On Wed, 23 May 2007, Michael Stefaniuc wrote:
> 
> I didn't find '$' as valid identifier character in "The C Programming
> Language (ANSI C)" nor does http://c0x.coding-guidelines.com/5.2.1.html
> allow it as valid char in the "source character set".

I think it was a common extension for some strange operating systems 
(read: VMS), where system symbols have "$" embedded in the name. So you'd 
have names like "sys$function()" for system functions.

It's possible others did it too - gcc says it's "traditional", but the 
only case I've seen it is from VMS (and thus from DEC->Compaq->HP C 
compilers).

But I certainly wouldn't object to sparse supporting it, although I would 
suggest that it at least warn by default.

		Linus
