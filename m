From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Re: [patchset] rewrite of initializer handling
Date: Tue, 19 Jun 2007 11:47:38 +0200
Message-ID: <4677A63A.5060101@redhat.com>
References: <20070618101929.GE21478@ftp.linux.org.uk> <4676CC9C.3050903@freedesktop.org> <20070618191653.GG21478@ftp.linux.org.uk> <4676FD25.9030504@redhat.com> <20070618224355.GK21478@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:51781 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753922AbXFSJsJ (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 19 Jun 2007 05:48:09 -0400
In-Reply-To: <20070618224355.GK21478@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org

Al Viro wrote:
> On Mon, Jun 18, 2007 at 11:46:13PM +0200, Michael Stefaniuc wrote:
> 
>>> Umm...  I don't think that it's related.  count_array_initializer() would
>>> work just fine for that one, since the straightforward list element counting
>>> would work as-is.
>> Right, it doesn't fixes this error. Actually the output of
>> make clean; CHECK='sparse -Wno-transparent-union -Wno-old-initializer
>> -Wno-non-pointer-null' make CC=cgcc > build.out 2>&1
>> is identical bit by bit with or without Al's patch series.
> 
> Eh...  count_array_initializer() is not even touched in that series anyway.
> The question had been how to fix it; Josh asked if fixing it would take
> care of your report as well and I said "no".  Patch that followed was
> unrelated to count_array_initializer() problems or problems fixed by
> patch series that went into the tree.
> 
>> Works for Wine and removes most of the "error: cannot size expression"
>> errors.
> 
> Any regressions?
Nope, just the errors removed and no additional warnings introduced.

>> The 7 remaining errors are preceded by "error: bad constant
>> expression" in the same line. Have to condense those into a test case too.
> 
> Probably genuine VLAs...
Right.

bye
	michael
-- 
Michael Stefaniuc               Tel.: +49-711-96437-199
Sr. Network Engineer            Fax.: +49-711-96437-111
Red Hat GmbH                    Email: mstefani@redhat.com
Hauptstaetterstr. 58            http://www.redhat.de/
D-70178 Stuttgart
