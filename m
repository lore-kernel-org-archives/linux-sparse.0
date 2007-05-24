From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: '$' as "valid" character in identifiers
Date: Thu, 24 May 2007 13:35:12 +0100
Message-ID: <20070524123512.GF4095@ftp.linux.org.uk>
References: <4654B59A.50302@redhat.com> <alpine.LFD.0.98.0705231501430.3890@woody.linux-foundation.org> <20070524100433.GE4095@ftp.linux.org.uk> <4655737B.7010701@knosof.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:55141 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755195AbXEXMfY (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 May 2007 08:35:24 -0400
Content-Disposition: inline
In-Reply-To: <4655737B.7010701@knosof.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Stefaniuc <mstefani@redhat.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Thu, May 24, 2007 at 12:14:03PM +0100, Derek M Jones wrote:
> Al,
> 
> >The question is how do they treat $ in preprocessor tokens.  Is it a full
> >equivalent of letter?  I.e. is $x a valid identifier?  If it is, that's
> >easy - all we need is to add it cclass[] in tokenize.c as a letter and be
> >done with that.  If not (i.e. if it can only appear after the first
> >letter), we probably want to either classify it as digit or split the
> >"Digit" bit in two and modify the code checking for it.  In any case,
> >we need to figure out what to do with
> >
> >#define A(x,y) x##y
> >A(a,$b)
> >
> >Either $b is an identifier, or it would better be a valid pp-number; 
> >otherwise,
> >we'll get the second argument split in two tokens and get a$ b out of that
> >macro.
> 
> Item 10 of http://www.open-std.org/jtc1/sc22/wg14/www/docs/n861.htm
> gives some history and possible solutions.

Irrelevant, AFAICS.
 
> If an implementation supports $ in identifiers, then it is an extension.
> Implementation extensions are blessed in C99 provided they don't change
> the behavior of strictly conforming programs.  Since $ is not in the
> basic source character set a program that contains them is not strictly
> conforming.
>
> If sparse supports $ then it just has to do what the implementation it
> is mimicing does.  There is no C Standard behavior as such to worry about.

And now for reality: of course if we set out to imitate the implementation
allowing $, we'd better imitate it.  The question is what to watch out
for and how to avoid buggering the tokenizer in process.

The question of in n861.10 has nothing whatsobleedingever to do with that.
It makes sure that valid macro definition with extended character set will
not be misparsed in smaller character set and will generate an error instead.
We do not enforce 6.10.3p3 (we ought to; the fix is trivial, I'll send it
today), but that has nothing to do with the testcase I'd mentioned:

#define A(x,y) x##y
A(a,$b)

needs $b to be interpreted as a single token if we want existing code in
preprocess.c to do the expected thing.  Otherwise it would produce two
tokens - a$ and b.  IOW, tokenizer needs to get a single token when it
sees $b and the question is which kind of token we'll be returning.
If $ acts as a letter, it's not a problem at all (existing logics will
return ident).  If it acts as a digit (i.e. it can't be the first character
of identifier in the implementation we are imitating) the things are trickier,
since we'll need the code parsing pp-numbers to handle that stuff.  Which
might take more work since simply classifying $ as digit could change
behaviour in other parts of tokenizer.

Tokenizer implementation resembles the structure of relevant part of
standard.  That (and not worrying about interpretation of wanted behaviour
in terms of modifications of standard) is what it's all about - modifications
of tokenizer itself would better be minimally intrusive.

I don't have access to VMS boxen (thanks $DEITY); gcc implementation seems
to accept '$' as equivalent to letter.  Resulting assembler won't pass
as(1) if it's the first character in identifier, though, so we don't get
any useful information out of the experiment[1].

IOW, we need documentation of the native compilers to find out which kind
of behaviour is expected.

[1] other than "with gcc on x86 with AT&T assembler syntax an identifier
starting with $ silently lands you in nasal demon country", that is.
No idea whether the toolchain in question uses AT&T or Intel syntax, no idea
what restrictions the native compilers might have...
