From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH] sparse/parse.c: ignore hotpatch attribute
Date: Thu, 30 Apr 2015 17:50:22 +0200
Message-ID: <20150430155022.GA1378@opentech.at>
References: <1430218119-58354-1-git-send-email-heiko.carstens@de.ibm.com> <CA+55aFzZtGyz3CLF5Hjyjr0GVkx3SYui8yE9JjO5tzzHZzk78g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:41283 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809AbbD3PuY (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 30 Apr 2015 11:50:24 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFzZtGyz3CLF5Hjyjr0GVkx3SYui8yE9JjO5tzzHZzk78g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Thu, 30 Apr 2015, Linus Torvalds wrote:

> On Tue, Apr 28, 2015 at 3:48 AM, Heiko Carstens
> <heiko.carstens@de.ibm.com> wrote:
> > gcc knows about a new "hotpatch" attribute which sparse can safely ignore,
> > since it modifies only which code will be generated just like the
> > "no_instrument_function" attribute.
> 
> I'm wondering if sparse should just ignore all attributes it doesn't
> recognize, so that we could just remove this ever-expanding list of
> things that don't actually matter for sparse..
> 
> The "unrecognized attribute" thing made more sense way back when -
> when I wanted to get he basic attributes handled. Now it's just
> noise...
>
The list of attributes does not really exapand quickly so explicitly
marking them to be ignored after a new "unrecognized attribute" triggers
would have the advantage that it is actually looked at and not
silently ignored.

thx!
hofrat
