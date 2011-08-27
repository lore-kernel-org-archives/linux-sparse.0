From: blp@cs.stanford.edu (Ben Pfaff)
Subject: Re: [PATCH] sparse: Reduce 'test-suite' run output
Date: Sat, 27 Aug 2011 08:15:44 -0700
Message-ID: <87sjomlwbj.fsf@blp.benpfaff.org>
References: <1314366621-29361-1-git-send-email-penberg@kernel.org>
	<CANeU7Q=xTrKKCkuB4_RcA7L=99=psZAWQiawqSLMMyOUK6E-jQ@mail.gmail.com>
	<alpine.DEB.2.00.1108271112110.2570@localhost6.localdomain6>
Reply-To: blp@cs.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from outmail148154.authsmtp.co.uk ([62.13.148.154]:56821 "EHLO
	outmail148154.authsmtp.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750971Ab1H0PfT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 11:35:19 -0400
Reply-to: blp@cs.stanford.edu
In-Reply-To: <alpine.DEB.2.00.1108271112110.2570@localhost6.localdomain6>
	(Pekka Enberg's message of "Sat, 27 Aug 2011 11:13:17 +0300 (EEST)")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

Pekka Enberg <penberg@kernel.org> writes:

> On Fri, 26 Aug 2011, Christopher Li wrote:
>
>> On Fri, Aug 26, 2011 at 6:50 AM, Pekka Enberg <penberg@kernel.org> wrote:
>>> There's more than 100 tests in the validation test suite. That makes it
>>> cumbersome to notice test breakage in because the results don't fit on single
>>> page.
>>
>> Looks good in a terminal. But if the output is piped to a file, it will be hard
>> to read that file. We shouldn't do it for a non-terminal output.
>
> Right. How can I check if we're outputting to non-terminal?

test -t 1
-- 
"To the engineer, the world is a toy box full of sub-optimized and
 feature-poor toys."
--Scott Adams
