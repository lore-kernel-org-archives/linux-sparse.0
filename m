From: Christopher Li <sparse@chrisli.org>
Subject: Re: Another sparse warning...
Date: Mon, 12 Feb 2007 20:21:52 -0800
Message-ID: <20070213042152.GC2922@chrisli.org>
References: <4975FCBA-D3D4-4DF2-AC20-C11A5F97DE51@cam.ac.uk> <Pine.LNX.4.64.0702120742030.8424@woody.linux-foundation.org> <20070213020054.GB2922@chrisli.org> <Pine.LNX.4.64.0702121947240.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc15.comcast.net ([204.127.200.85]:36595 "EHLO
	sccrmhc15.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030626AbXBMEv1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 12 Feb 2007 23:51:27 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702121947240.8424@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, linux-sparse@vger.kernel.org

On Mon, Feb 12, 2007 at 07:48:18PM -0800, Linus Torvalds wrote:
> > When call one of those functions, it can know that function will change
> > context.  That might be a way to solve the problem that some of the
> > spinlock function is not a inline function at all.
> 
> I thought we did that already. I'm fairly sure I had this working at some 
> point - exactly by having the calls just add up the (known) lock/unlock 
> offsets.
>

You are right. It is already there. I never see it before because my ctags
get confused about the context annotation:

void __lockfunc _spin_lock(spinlock_t *lock)		__acquires(lock); 

It generate tags for "lock" instead of "_spin_lock".

When I look up _spin_lock, it only shows the UP version. I never see
the SMP version of the _spin_lock.

Exactly why I want to have a ctags from sparse.

Chris
 
