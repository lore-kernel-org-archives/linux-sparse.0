From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: '$' as "valid" character in identifiers
Date: Thu, 24 May 2007 12:14:03 +0100
Message-ID: <4655737B.7010701@knosof.co.uk>
References: <4654B59A.50302@redhat.com> <alpine.LFD.0.98.0705231501430.3890@woody.linux-foundation.org> <20070524100433.GE4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:4309 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754936AbXEXLOI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 May 2007 07:14:08 -0400
In-Reply-To: <20070524100433.GE4095@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Stefaniuc <mstefani@redhat.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

Al,

> The question is how do they treat $ in preprocessor tokens.  Is it a full
> equivalent of letter?  I.e. is $x a valid identifier?  If it is, that's
> easy - all we need is to add it cclass[] in tokenize.c as a letter and be
> done with that.  If not (i.e. if it can only appear after the first
> letter), we probably want to either classify it as digit or split the
> "Digit" bit in two and modify the code checking for it.  In any case,
> we need to figure out what to do with
> 
> #define A(x,y) x##y
> A(a,$b)
> 
> Either $b is an identifier, or it would better be a valid pp-number; otherwise,
> we'll get the second argument split in two tokens and get a$ b out of that
> macro.

Item 10 of http://www.open-std.org/jtc1/sc22/wg14/www/docs/n861.htm
gives some history and possible solutions.

If an implementation supports $ in identifiers, then it is an extension.
Implementation extensions are blessed in C99 provided they don't change
the behavior of strictly conforming programs.  Since $ is not in the
basic source character set a program that contains them is not strictly
conforming.

If sparse supports $ then it just has to do what the implementation it
is mimicing does.  There is no C Standard behavior as such to worry about.

-- 
Derek M. Jones                              tel: +44 (0) 1252 520 667
Knowledge Software Ltd                      mailto:derek@knosof.co.uk
Applications Standards Conformance Testing    http://www.knosof.co.uk
