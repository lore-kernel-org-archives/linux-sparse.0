From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 4/5] test-suite: Add -b option to ignore CR at eol on
 MinGW
Date: Wed, 22 May 2013 22:19:49 +0100
Message-ID: <519D3675.8060403@ramsay1.demon.co.uk>
References: <519BC87D.5080002@ramsay1.demon.co.uk> <20130521211650.GA11463@jtriplet-mobl1> <1369171620.10614.0.camel@jlt4.sipsolutions.net> <20130521214607.GB11463@jtriplet-mobl1>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:55738 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757527Ab3EVWOO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 May 2013 18:14:14 -0400
In-Reply-To: <20130521214607.GB11463@jtriplet-mobl1>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

Josh Triplett wrote:
> On Tue, May 21, 2013 at 11:27:00PM +0200, Johannes Berg wrote:
>> On Tue, 2013-05-21 at 14:16 -0700, Josh Triplett wrote:
>>> On Tue, May 21, 2013 at 08:18:21PM +0100, Ramsay Jones wrote:
>>>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>>>
>>> -b doesn't just ignore CR at end of line; it would also ignore changes
>>> in the amount of whitespace elsewhere on the line.  You might consider
>>> piping the input that has CRs through sed before storing it, to delete
>>> the CR at end of line before comparing, instead.
>>
>> Or just use --strip-trailing-cr, no? Or maybe that's not available?
> 
> Nice, I didn't know about that one.  Yes, if MinGW's diff has that, by
> all means use it.

Heh, that was the first thing I tried, but it doesn't work:

  $ diff --strip-trailing-cr sparse.c{~,}
  diff: unrecognized option `--strip-trailing-cr'
  diff: Try `diff --help' for more information.
  $ diff --version
  diff - GNU diffutils version 2.7
  $

It works just fine on cygwin and Linux, but the diff versions are
newer there, for example on cygwin:

  $ diff --version
  diff (GNU diffutils) 2.8.7
  Written by Paul Eggert, Mike Haertel, David Hayes,
  Richard Stallman, and Len Tower.

  Copyright (C) 2004 Free Software Foundation, Inc.
  This is free software; see the source for copying conditions.  There is NO
  warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  $

Hmm, does it really matter that it would miss whitespace changes
elsewhere in the line? (Ah, maybe some of the preprocessor tests?)

I think I would prefer to go back to the original _setmode() patch
than to mess with sed. ;-)

[Also, this MinGW is the one that came from the msysgit installer from
a couple of years ago. Maybe it has been updated. uname shows that the
MinGW I'm using was dated Feb 2010. dunno.]

ATB,
Ramsay Jones


