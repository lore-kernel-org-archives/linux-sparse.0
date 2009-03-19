From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Nasal demons in preprocessor use (Re: [PATCH] test-suite: new
	preprocessor test case)
Date: Thu, 19 Mar 2009 19:07:31 +0000
Message-ID: <20090319190730.GC28946@ZenIV.linux.org.uk>
References: <20090319175544.13691.42362.stgit@f10box.hanneseder.net> <20090319182628.GB28946@ZenIV.linux.org.uk> <154e089b0903191151q37ab7b20o43838845af12966f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:36184 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbZCSTHe (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 19 Mar 2009 15:07:34 -0400
Content-Disposition: inline
In-Reply-To: <154e089b0903191151q37ab7b20o43838845af12966f@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Vegard Nossum <vegard.nossum@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Hannes Eder <hannes@hanneseder.net>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>

On Thu, Mar 19, 2009 at 07:51:22PM +0100, Hannes Eder wrote:
> When currently running sparse agains the current linux-next tree, a
> lot of checks produce error messages like this:
> 
> include/linux/skbuff.h:381:9: error: expected preprocessor identifier

Cute.  If anything, this kmemcheck_define_bitfield stuff needs to be moved
inside the ifdefs.

Folks, this is not a valid C, period.  And no, there's no promise that
gcc won't change its behaviour on such constructs whenever they feel
like that.

Preprocessor directives do not belong in argument lists.  Not #ifdef,
not #define, not #include; this is undefined behaviour.
