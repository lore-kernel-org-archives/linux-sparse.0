From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: Adding type information to instructions
Date: Mon, 07 Jul 2008 10:42:41 -0700
Message-ID: <1215452561.3003.21.camel@josh-work.beaverton.ibm.com>
References: <486EB59C.100@cowlark.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:47580 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704AbYGGRmo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 7 Jul 2008 13:42:44 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m67HbTrG029812
	for <linux-sparse@vger.kernel.org>; Mon, 7 Jul 2008 13:37:29 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m67Hgfxu153648
	for <linux-sparse@vger.kernel.org>; Mon, 7 Jul 2008 11:42:41 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m67HgdgB012411
	for <linux-sparse@vger.kernel.org>; Mon, 7 Jul 2008 11:42:40 -0600
In-Reply-To: <486EB59C.100@cowlark.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Given <dg@cowlark.com>
Cc: linux-sparse@vger.kernel.org

On Sat, 2008-07-05 at 00:43 +0100, David Given wrote:
> I've been having trouble finding the types of pseudos; the approach I've
> been using, which is to follow the chain of pseudo's definers until I
> find an instruction with enough type information to use, turns out to
> fail utterly on OP_LOAD instructions; I can't find any way of getting
> enough information from the opcode's arguments to determine the type of
> the target.
> 
> As a result, I've had to make a minor patch to the lineariser code.
> Given that the lineariser knows the information I need at the point
> where it generates the instruction, it would seem to make sense to tag
> the instruction with the type. This is made quite easy by the way that
> the lineariser has a allocate-typed-instruction function.
> 
> Patch enclosed; it's very simple.
> 
> Does this seem like a reasonable approach? Is it something that would be
> useful to have in the base builds? Are there any ramifications I should
> be aware of?

I can't think of any fundamental reason not to do this, other than the
standard reason of data structure size.  However, I'd like to hear
something from others on the list before accepting this patch.

- Josh Triplett


