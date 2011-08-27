From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH] sparse: Reduce 'test-suite' run output
Date: Sat, 27 Aug 2011 20:17:59 +0200
Message-ID: <20110827181759.GC15022@debian.debian>
References: <1314366621-29361-1-git-send-email-penberg@kernel.org>
 <CANeU7Q=xTrKKCkuB4_RcA7L=99=psZAWQiawqSLMMyOUK6E-jQ@mail.gmail.com>
 <alpine.DEB.2.00.1108271112110.2570@localhost6.localdomain6>
 <87sjomlwbj.fsf@blp.benpfaff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:48356 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752206Ab1H0SSE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 14:18:04 -0400
Content-Disposition: inline
In-Reply-To: <87sjomlwbj.fsf@blp.benpfaff.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: blp@cs.stanford.edu
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Sat, Aug 27, 2011 at 08:15:44AM -0700, Ben Pfaff wrote:
> Pekka Enberg <penberg@kernel.org> writes:
> 
> > On Fri, 26 Aug 2011, Christopher Li wrote:
> >
> >> On Fri, Aug 26, 2011 at 6:50 AM, Pekka Enberg <penberg@kernel.org> wrote:
> >>> There's more than 100 tests in the validation test suite. That makes it
> >>> cumbersome to notice test breakage in because the results don't fit on single
> >>> page.
> >>
> >> Looks good in a terminal. But if the output is piped to a file, it will be hard
> >> to read that file. We shouldn't do it for a non-terminal output.
> >
> > Right. How can I check if we're outputting to non-terminal?
> 
> test -t 1

Okay, that's way better than my approach.
