From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: sparse ctags
Date: Mon, 06 Aug 2007 12:03:07 -0700
Message-ID: <1186426987.3089.27.camel@josh-work.beaverton.ibm.com>
References: <cc723f590706260145q708c4390kf5b6ccbaf84000ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:45541 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754071AbXHFTCf (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 6 Aug 2007 15:02:35 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l76J2Y7A007599
	for <linux-sparse@vger.kernel.org>; Mon, 6 Aug 2007 15:02:35 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l76J2YKL457640
	for <linux-sparse@vger.kernel.org>; Mon, 6 Aug 2007 15:02:34 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l76J2YZ5010872
	for <linux-sparse@vger.kernel.org>; Mon, 6 Aug 2007 15:02:34 -0400
In-Reply-To: <cc723f590706260145q708c4390kf5b6ccbaf84000ef@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Aneesh Kumar <aneesh.kumar@gmail.com>, dhaval@linux.vnet.ibm.com

On Tue, 2007-06-26 at 14:15 +0530, Aneesh Kumar wrote:
> Is there a document how to use this ? Does this work on multiple files
> ? Looking at the source i see it opening tags in truncate mode

No documentation, unfortunately.  The Sparse ctags doesn't take any
options.  It should work on multiple files by simply giving all the
files on one ctags command line, with something like:
ctags $(find -name '*.c')

However, it seems to have some problems at the moment running on even
*one* file:

$ ./ctags ctags.c
unknown symbol const namespace:2 type:17

$ ./ctags validation/context.c
unknown symbol const namespace:2 type:17

type 17 refers to SYM_KEYWORD, which seems consistent with "unknown
symbol const", though I don't know why ctags would look at const as a
symbol.

I've CCed Christopher Li, the author of the Sparse ctags implementation.
Chris, can you look into this problem and suggest a possible solution?

- Josh Triplett
