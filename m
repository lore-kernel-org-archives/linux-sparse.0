From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v5 0/25] Generic Red-Black Trees (still WIP)
Date: Tue, 25 Sep 2012 21:28:36 -0400
Message-ID: <1348622916.22822.44.camel@gandalf.local.home>
References: <1348615467-9850-1-git-send-email-daniel.santos@pobox.com>
	 <1348618742.22822.39.camel@gandalf.local.home> <50625436.1020501@att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <50625436.1020501@att.net>
Sender: linux-doc-owner@vger.kernel.org
To: Daniel Santos <daniel.santos@pobox.com>
Cc: linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Tue, 2012-09-25 at 20:02 -0500, Daniel Santos wrote:
> >> Q&A
> >> ===
> >> Q: Why did you add BUILD_BUG_ON_NON_CONST() and
> >>    BUILD_BUG_ON_NON_CONST42()?
> > A: Because BUILD_BUG_ON_NON_CONST42() will crash if it does not result
> > in the answer to life, the universe and everything!
> 
> By the way, I have a theory before time, God was writing code on some
> cosmic computer (beyond our understanding, of course) when he
> accidentally tried to divide by zero, resulting in a core dump that we
> now know as the universe we live in.  So thus, we are just the excrement
> of some celestial computer after it failed to properly execute its code.
> 

And that operation on which God failed on was:

ans = 42 / 0

Which totally explains the point where... "to understand the answer, you
must first understand the question".

-- Steve

