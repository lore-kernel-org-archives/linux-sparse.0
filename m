From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: '$' as "valid" character in identifiers
Date: Thu, 24 May 2007 14:18:11 +0100
Message-ID: <46559093.5060908@knosof.co.uk>
References: <4654B59A.50302@redhat.com> <alpine.LFD.0.98.0705231501430.3890@woody.linux-foundation.org> <20070524100433.GE4095@ftp.linux.org.uk> <4655737B.7010701@knosof.co.uk> <20070524123512.GF4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:16914 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755588AbXEXNSQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 May 2007 09:18:16 -0400
In-Reply-To: <20070524123512.GF4095@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Stefaniuc <mstefani@redhat.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

Al,

> And now for reality: of course if we set out to imitate the implementation
> allowing $, we'd better imitate it.  The question is what to watch out
> for and how to avoid buggering the tokenizer in process.

If sparse is going to imitate a VAX implementation then how $ is glued
is probably the least of the implemention worries.

VAX C supported a whole host of extensions (eg, the ability to
glue comments, 8 & 9 in octal constants).

I have a pdf of the DEC C language reference manual for Tru64 which
people are welcome to a copy of.

> I don't have access to VMS boxen (thanks $DEITY);

Continuing in the vein of Irrelevant, AFAICS.  You can access various
Crays here: http://www.cray-cyber.org/access/index.php

Perhaps there is a similar site available for Vaxes?

> IOW, we need documentation of the native compilers to find out which kind
> of behaviour is expected.

I collect old C compiler manuals, if anybody locates a ps or pdf of
an original VAC C compiler manual, please forward me a copy.

-- 
Derek M. Jones                              tel: +44 (0) 1252 520 667
Knowledge Software Ltd                      mailto:derek@knosof.co.uk
Applications Standards Conformance Testing    http://www.knosof.co.uk
