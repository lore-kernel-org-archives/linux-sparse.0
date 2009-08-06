From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: [PATCH] linearize.h: sanitize header
Date: Thu, 6 Aug 2009 11:51:11 +0200
Message-ID: <200908061151.11277.kdudka@redhat.com>
References: <200908061102.14935.kdudka@redhat.com> <200908061130.08387.kdudka@redhat.com> <154e089b0908060239g56261ecp916d7b937014a6fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:41467 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754637AbZHFJtq (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 6 Aug 2009 05:49:46 -0400
In-Reply-To: <154e089b0908060239g56261ecp916d7b937014a6fd@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Hannes Eder <hannes@hanneseder.net>
Cc: sparse <linux-sparse@vger.kernel.org>

On Thu August 6 2009 11:39:11 Hannes Eder wrote:
> >> I guess it is wise to change this in linearize.c as well.  Mind sending
> >> a patch?
> >
> > The question is if we need/want to :-) It's change of the working code
> > for no real benefit. I am talking only about system-wide headers which
> > can be included anywhere.
>
> Well I see at least one benefit, a small one though.  Syntax
> highlighting is somewhat confused with "true" and "false", at least
> emacs is.  They appear like the constants, where in fact they are
> variables.

I can confirm it's the same case with the vim's syntax highlighter.

> The likelyhood to break the code by renaming this two variables is
> kinda low, no?  And IHMO it was not so wise in the first place to pick
> these names. ;)

I would contend that only two variables are affected. They are if we consider 
only headers. However the situation is much worse when we concern about .c 
files. The patch would be non-trivial. Please try the following command:

$ grep --color '[^_]false[^_]' *.c

Kamil

