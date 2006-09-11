From: Josh Triplett <josht@us.ibm.com>
Subject: Re: [PATCH RESEND] sparse_error() should not silence info() after
	sparse_error()s
Date: Mon, 11 Sep 2006 14:17:33 -0700
Message-ID: <1158009453.4373.58.camel@josh-work.beaverton.ibm.com>
References: <1158009087.4373.49.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:55976 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S965048AbWIKVRO
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 11 Sep 2006 17:17:14 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8BLHDdi003524
	for <linux-sparse@vger.kernel.org>; Mon, 11 Sep 2006 17:17:13 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8BLHDq3264024
	for <linux-sparse@vger.kernel.org>; Mon, 11 Sep 2006 15:17:13 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8BLHDsI006633
	for <linux-sparse@vger.kernel.org>; Mon, 11 Sep 2006 15:17:13 -0600
In-Reply-To: <1158009087.4373.49.camel@josh-work.beaverton.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>

On Mon, 2006-09-11 at 14:11 -0700, Josh Triplett wrote:
> sparse_error() sets max_warnings = 0 to silence subsequent sparse_warning()s
> or info()s; however, this also silences the info() after that sparse_error()
> and subsequent sparse_errors() which still get shown.  bad_expr_type runs into
> this problem: it reports an error with sparse_error() and then provides
> further information with info(), which the user never sees.  Make info()
> continue to print as long as the immediately preceeding warning or error does.

Please ignore this particular resent patch, as it already got merged;
resent by mistake as part of a larger set.

- Josh Triplett
