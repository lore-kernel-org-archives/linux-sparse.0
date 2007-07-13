From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: [PATCH] c2xml
Date: Fri, 13 Jul 2007 10:55:48 -0700
Message-ID: <1184349348.2616.34.camel@josh-work.beaverton.ibm.com>
References: <46826B68.5040302@codethink.co.uk>
	 <1182970187.8970.145.camel@josh-work.beaverton.ibm.com>
	 <4688F05A.5010801@codethink.co.uk>  <46979F4B.9050307@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:52191 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756316AbXGMRzf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 13 Jul 2007 13:55:35 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6DHtYYb030768
	for <linux-sparse@vger.kernel.org>; Fri, 13 Jul 2007 13:55:34 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6DHtYpm208146
	for <linux-sparse@vger.kernel.org>; Fri, 13 Jul 2007 11:55:34 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6DHtY3r008752
	for <linux-sparse@vger.kernel.org>; Fri, 13 Jul 2007 11:55:34 -0600
In-Reply-To: <46979F4B.9050307@codethink.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Rob Taylor <rob.taylor@codethink.co.uk>
Cc: linux-sparse@vger.kernel.org

On Fri, 2007-07-13 at 16:50 +0100, Rob Taylor wrote:
> Any followups on this?

I actually committed the first three patches this morning, before you
sent this.  I would like to commit the fourth patch this evening.  I
want to think a bit about how to address one issue: I'd really love to
avoid constructs specific to GNU make, such as ifeq and $(shell).  I
managed to find a way to do that for the patch adding clean kernel-style
build output, by using the text substitution feature of make variable
expansion.  However, I haven't yet figured out a way to avoid $(shell)
with this patch.  The c2xml target can just always exist, so no
conditionals needed there.  However, without $(shell), I don't see any
way to handle adding c2xml to PROGRAMS and INST_PROGRAMS without
$(shell); backquotes will only work in the commands of a target, not the
prerequisites.  (Obviously, just leaving c2xml out of the all and
install targets would solve the problem, but that seems quite
suboptimal.)  I want to think about this problem for a bit, and if I
don't come up with anything and don't get any good suggestions, I may
just go ahead and require GNU make.

Also, you didn't update the dtd for the changes to the position
handling; it doesn't have end-file, and it still has start and end
rather than {start,end}-{line,col}.

- Josh Triplett
