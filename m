From: Rob Taylor <rob.taylor@codethink.co.uk>
Subject: Re: [PATCH] c2xml
Date: Sun, 15 Jul 2007 00:54:01 +0100
Message-ID: <46996219.8030602@codethink.co.uk>
References: <46826B68.5040302@codethink.co.uk>	 <1182970187.8970.145.camel@josh-work.beaverton.ibm.com>	 <4688F05A.5010801@codethink.co.uk>  <46979F4B.9050307@codethink.co.uk> <1184349348.2616.34.camel@josh-work.beaverton.ibm.com> <46986C26.9040804@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from 208-78-103-131.slicehost.net ([208.78.103.131]:57258 "EHLO
	mail.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759858AbXGNXwI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 14 Jul 2007 19:52:08 -0400
In-Reply-To: <46986C26.9040804@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Josh Triplett <josht@linux.vnet.ibm.com>, linux-sparse@vger.kernel.org

Josh Triplett wrote:
> Josh Triplett wrote:
>> On Fri, 2007-07-13 at 16:50 +0100, Rob Taylor wrote:
>>> Any followups on this?
>> I actually committed the first three patches this morning, before you
>> sent this.  I would like to commit the fourth patch this evening.  I
>> want to think a bit about how to address one issue: I'd really love to
>> avoid constructs specific to GNU make, such as ifeq and $(shell).  I
>> managed to find a way to do that for the patch adding clean kernel-style
>> build output, by using the text substitution feature of make variable
>> expansion.  However, I haven't yet figured out a way to avoid $(shell)
>> with this patch.  The c2xml target can just always exist, so no
>> conditionals needed there.  However, without $(shell), I don't see any
>> way to handle adding c2xml to PROGRAMS and INST_PROGRAMS without
>> $(shell); backquotes will only work in the commands of a target, not the
>> prerequisites.  (Obviously, just leaving c2xml out of the all and
>> install targets would solve the problem, but that seems quite
>> suboptimal.)  I want to think about this problem for a bit, and if I
>> don't come up with anything and don't get any good suggestions, I may
>> just go ahead and require GNU make.
> 
> OK, forget it.  Anyone who wants Sparse to work with non-GNU make gets to rack
> *their* brain thinking about how to do without useful GNU make features.
> Patch applied...

Heh, I think that's a fair enough stance now-a-days :)

>> Also, you didn't update the dtd for the changes to the position
>> handling; it doesn't have end-file, and it still has start and end
>> rather than {start,end}-{line,col}.
> 
> ... and I fixed this myself.

Brilliant!

> Thanks again for some most impressive work.

Thanks for putting the time in on it yourself!

Now to go and write interesting things using c2xml :)

Thanks,
Rob
