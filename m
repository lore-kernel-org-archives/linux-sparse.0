From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: '$' as "valid" character in identifiers
Date: Thu, 24 May 2007 11:04:33 +0100
Message-ID: <20070524100433.GE4095@ftp.linux.org.uk>
References: <4654B59A.50302@redhat.com> <alpine.LFD.0.98.0705231501430.3890@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:53215 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755714AbXEXKEj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 May 2007 06:04:39 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0705231501430.3890@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Stefaniuc <mstefani@redhat.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Wed, May 23, 2007 at 03:10:57PM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 23 May 2007, Michael Stefaniuc wrote:
> > 
> > I didn't find '$' as valid identifier character in "The C Programming
> > Language (ANSI C)" nor does http://c0x.coding-guidelines.com/5.2.1.html
> > allow it as valid char in the "source character set".
> 
> I think it was a common extension for some strange operating systems 
> (read: VMS), where system symbols have "$" embedded in the name. So you'd 
> have names like "sys$function()" for system functions.
> 
> It's possible others did it too - gcc says it's "traditional", but the 
> only case I've seen it is from VMS (and thus from DEC->Compaq->HP C 
> compilers).
> 
> But I certainly wouldn't object to sparse supporting it, although I would 
> suggest that it at least warn by default.

The question is how do they treat $ in preprocessor tokens.  Is it a full
equivalent of letter?  I.e. is $x a valid identifier?  If it is, that's
easy - all we need is to add it cclass[] in tokenize.c as a letter and be
done with that.  If not (i.e. if it can only appear after the first
letter), we probably want to either classify it as digit or split the
"Digit" bit in two and modify the code checking for it.  In any case,
we need to figure out what to do with

#define A(x,y) x##y
A(a,$b)

Either $b is an identifier, or it would better be a valid pp-number; otherwise,
we'll get the second argument split in two tokens and get a$ b out of that
macro.

So far it's easy, but... generating a warning will be the nasty part.  We
certainly don't want it to be generated in tokenizer; after all,

#define A(x) #x
A($)

is legitimate, so we can't do anything until we are past preprocessor.
In any case, generating a warning on each instance of such identifier
would be an overkill.  So we'd have to do it somewhere around insertion
into symbol table.  And doing essentially strchr() in there is not
a nice thing - it's a hot path...
