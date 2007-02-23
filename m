From: Pavel Roskin <proski@gnu.org>
Subject: Re: Fun with Linux 2.6.21-rc1
Date: Fri, 23 Feb 2007 14:59:26 -0500
Message-ID: <1172260766.14431.3.camel@dv>
References: <1172251518.6229.6.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:60623 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932641AbXBWT73 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Feb 2007 14:59:29 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HKgYH-0006HF-DF
	for linux-sparse@vger.kernel.org; Fri, 23 Feb 2007 14:57:57 -0500
In-Reply-To: <1172251518.6229.6.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

On Fri, 2007-02-23 at 12:25 -0500, Pavel Roskin wrote:
> Hello!
> 
> The current sparse reports many errors with Linux 2.6.21-rc1.  There are
> screenfuls of errors for every file.  I have reduced one of them to this
> simple file:
> 
> struct st {
> 	char c;
> } __attribute__ ((aligned(2)));
> struct st s1;
> struct st s2;

P.S. The breakage has nothing to do to Linux changes.  It was caused by
the patch called "Make the ptrlist using the sparse allocator".  Undoing
the patch fixes the problem.

-- 
Regards,
Pavel Roskin
