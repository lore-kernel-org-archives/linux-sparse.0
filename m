From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH] bitops: simplify generic bit finding functions
Date: Sun, 27 Apr 2008 13:38:27 -0700
Message-ID: <1209328707.14173.80.camel@brick>
References: <1209327591.14173.74.camel@brick>
	 <alpine.LFD.1.10.0804271325350.3119@woody.linux-foundation.org>
	 <1209328161.14173.77.camel@brick>
	 <20080427203638.GW5882@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:29443 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbYD0UiU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 27 Apr 2008 16:38:20 -0400
Received: by wa-out-1112.google.com with SMTP id m16so7468006waf.23
        for <linux-sparse@vger.kernel.org>; Sun, 27 Apr 2008 13:38:19 -0700 (PDT)
In-Reply-To: <20080427203638.GW5882@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-sparse@vger.kernel.org

On Sun, 2008-04-27 at 21:36 +0100, Al Viro wrote:
> On Sun, Apr 27, 2008 at 01:29:21PM -0700, Harvey Harrison wrote:
> 
> > Oh, I didn't realize, I only did this because sparse started spewing out
> > lots of:
> > include/linux/bitops.h:166:32: warning: shift too big (65536) for type unsigned long
> > 
> > due to shift by size there, and again on line 202...I just wanted something
> > that sparse wouldn't warn about and was a little easier to understand to boot.
> 
> That's a sparse problem, really.  I wonder if we simply should introduce a
> new node type: EXPR_WARN.  So that expand would generate those from things
> like division by zero/overflow/bad shift *and* emitting an insn for those
> would generate a stored warning.

Well, even though it is a sparse problem, I think my revised version was
cleaner code anyway.

> 
> Objections?

None here

Harvey

