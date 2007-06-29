From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: [PATCH 6/6] Add a simple test script, embed expected results
	into test files
Date: Thu, 28 Jun 2007 17:29:09 -0700
Message-ID: <1183076949.2621.196.camel@josh-work.beaverton.ibm.com>
References: <20070628053954.30704.66440.stgit@dv.roinet.com>
	 <20070628054019.30704.64375.stgit@dv.roinet.com>
	 <46836129.7050407@freedesktop.org>
	 <cbf3148c0706281159x7b252776nd08fd9bd9e36b92@mail.gmail.com>
	 <1183066733.2621.127.camel@josh-work.beaverton.ibm.com>
	 <cbf3148c0706281713l793c944fp372a2f91f6f9b18c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:50845 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761952AbXF2A3J (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Jun 2007 20:29:09 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5T0T97B020179
	for <linux-sparse@vger.kernel.org>; Thu, 28 Jun 2007 20:29:09 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5T0T9Ca211986
	for <linux-sparse@vger.kernel.org>; Thu, 28 Jun 2007 18:29:09 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5T0T8E8010751
	for <linux-sparse@vger.kernel.org>; Thu, 28 Jun 2007 18:29:08 -0600
In-Reply-To: <cbf3148c0706281713l793c944fp372a2f91f6f9b18c@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Damien Lespiau <damien.lespiau@gmail.com>
Cc: Josh Triplett <josh@freedesktop.org>, Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

On Fri, 2007-06-29 at 02:13 +0200, Damien Lespiau wrote:
> > Will review in more detail later, but at first glance this looks quite
> > good, and very capable.
> 
> I rebased the series against current HEAD to make testing easier.

Thanks.

> > Two minor things that jump out at me:
> >       * The need to specify the command line as "../sparse args $file"
> >         seems somewhat inelegant.
> solved: no path in check-command now.

Excellent.

> >         Also, allowing an
> >         alternate option "check-options" that just specifies sparse
> >         flags seems useful, and the default command could do something
> >         like "sparse $options $file"; that way, you can just say
> >         "check-options: -E", or "check-options: -Wthingy".
> Humm, not sure if it's _that_ much useful to have
>          check-options: -E -Wthingy
> instead of
>          check-command: sparse -E -Wthingy $file
> for some reason I find the later less confusing, a matter of taste I guess.

I don't mind going with the latter for now and considering the former
for a later patch.

> >       * The need to prefix every line of output, rather than delimiting
> >         the start and end of the output, seems painful with large
> >         amounts of output.
> Agreed. that's why ./test-suite format helps building such tags

Yes, but I still prefer the delimited format for readability.

> However I still run into a behavior that I cannot explain:
> 
> validation$ echo $SHELL
> /bin/bash
> ----------
> validation$ ../sparse -E preprocessor/preprocessor19.c
> 
> preprocessor/preprocessor19.c:4:9: warning: preprocessor token A redefined
> preprocessor/preprocessor19.c:3:9: this was the original definition
> y
> ----------
> validation$ ../sparse -E preprocessor/preprocessor19.c 2> o 1> o && cat o
> 
> y
> processor/preprocessor19.c:4:9: warning: preprocessor token A redefined
> preprocessor/preprocessor19.c:3:9: this was the original definition
> ----------
> validation$ ../sparse -E preprocessor/preprocessor19.c &> o && cat o
> preprocessor/preprocessor19.c:4:9: warning: preprocessor token A redefined
> preprocessor/preprocessor19.c:3:9: this was the original definition
> 
> y
> 
> If you look carefully the 2> 1> redirections have eaten "pre" of the first
> "preprocessor". Using &> show a more suitable behavior but it seems
> that &> is not supported by every Bourne shell (for instance dash (the
> default /bin/sh of Ubuntu 7.04 does not support &>) Any idea ?

You can't redirect two things independently to the same file; that will
open the file twice, and the writes will conflict, giving exactly the
result you saw.  > o 2>&1 should work; it has exactly the same effect as
&> .

- Josh Triplett
