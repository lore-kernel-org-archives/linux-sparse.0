From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Re: '$' as "valid" character in identifiers
Date: Thu, 24 May 2007 16:50:15 +0200
Message-ID: <4655A627.2050403@redhat.com>
References: <4654B59A.50302@redhat.com> <alpine.LFD.0.98.0705231501430.3890@woody.linux-foundation.org> <20070524100433.GE4095@ftp.linux.org.uk> <4655737B.7010701@knosof.co.uk> <20070524123512.GF4095@ftp.linux.org.uk> <46559093.5060908@knosof.co.uk> <20070524141015.GG4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:38717 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750715AbXEXOuz (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 May 2007 10:50:55 -0400
In-Reply-To: <20070524141015.GG4095@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Derek M Jones <derek@knosof.co.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

Al Viro wrote:
> On Thu, May 24, 2007 at 02:18:11PM +0100, Derek M Jones wrote:
>>> And now for reality: of course if we set out to imitate the implementation
>>> allowing $, we'd better imitate it.  The question is what to watch out
>>> for and how to avoid buggering the tokenizer in process.
>> If sparse is going to imitate a VAX implementation then how $ is glued
>> is probably the least of the implemention worries.
> 
> I suspect that the real issue is whatever stuff Windows uses (and no,
> I don't have Windows boxen either).  Anybody who wants to work on
I do not know what VC++ is doing but the Win32 API has _no_ $ in 
identifiers whatsoever. The code over which sparse tripped was a 
variable defined in an else block in the winedump utility. And that is 
not even a Win32 application but a pure standard C one. I sent a patch 
to Wine to fix that (todays commit session didn't happen yet).

 From Wine point of view we do not need to handle the '$'.

> code that last compiled on VAX is not going to be happy with what
> sparse will say about it, anyway.  More realistic case is a codebase
> with some VMS ancestry that got moved to Windows.
Wine is not supported on VMS ;)

bye
	michael
-- 
Michael Stefaniuc               Tel.: +49-711-96437-199
Sr. Network Engineer            Fax.: +49-711-96437-111
Red Hat GmbH                    Email: mstefani@redhat.com
Hauptstaetterstr. 58            http://www.redhat.de/
D-70178 Stuttgart
