From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: Booleans, what a wonderful type!
Date: Wed, 18 Jul 2007 09:33:18 -0700
Message-ID: <1184776398.2640.8.camel@josh-work.beaverton.ibm.com>
References: <1184723019.469d704b6111b@portal.student.luth.se>
	 <20070718021907.GS21668@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:36482 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932509AbXGRQdD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 18 Jul 2007 12:33:03 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6IGX153004325
	for <linux-sparse@vger.kernel.org>; Wed, 18 Jul 2007 12:33:02 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6IGX1ou026774
	for <linux-sparse@vger.kernel.org>; Wed, 18 Jul 2007 10:33:01 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6IGX15o020744
	for <linux-sparse@vger.kernel.org>; Wed, 18 Jul 2007 10:33:01 -0600
In-Reply-To: <20070718021907.GS21668@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: ricknu-0@student.ltu.se, linux-sparse@vger.kernel.org

On Wed, 2007-07-18 at 03:19 +0100, Al Viro wrote:
> On Wed, Jul 18, 2007 at 03:43:39AM +0200, ricknu-0@student.ltu.se wrote:
> 
> > * Most likly a _really_ stupid newbie question, but I have seen several of this
> > form:
> > <function>
> > {
> >         <variable> a;
> >         <doing something useful (no sign of 'a')>
> >         a = <some value/variable>;
> >         <exit>
> > }
> > How is this variable useful?
> 
> Explain, please.  If you mean moving the declaration down - it's not
> idiomatic in C and frankly, C++ style tends to make declarations harder
> to find when you read the code.

Judging by that pseudocode, I would guess that he means the function
never uses the value of a after assigning to it.  That would generally
represent a bug.

- Josh Triplett
