From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/3] linearize_statement: split up into helper
 functions
Date: Sat, 27 Aug 2011 14:30:32 -0700 (PDT)
Message-ID: <alpine.LFD.2.02.1108271429000.18733@i5.linux-foundation.org>
References: <alpine.LFD.2.02.1108271424400.18733@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:57562 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554Ab1H0Vbm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 17:31:42 -0400
Received: by pzk37 with SMTP id 37so6222483pzk.1
        for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 14:31:42 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1108271424400.18733@i5.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>
Cc: Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>



On Sat, 27 Aug 2011, Linus Torvalds wrote:
> 
> This is a trivial series of three patches to clean up
> linearize_statement() a bit by separating out three of the more
> complicated cases. 
> 
> No actual code changes.

The impetus for this was that it was really nasty to debug what went wrong 
when the callchain just had that "linearize_statement()". So not only do 
we avoid a level of indentation, but this actually makes things much 
easier to follow in gdb (at least as long as you don't compile with the 
default -finline-functions and -O2)

                           Linus
