From: Pavel Roskin <proski@gnu.org>
Subject: Re: Sparse crash when mixing int and enum in ternary operator
Date: Tue, 09 Mar 2010 20:09:22 -0500
Message-ID: <1268183362.2615.17.camel@mj>
References: <1268097872.16227.10.camel@mj> <1268165517.23196.22.camel@mj>
	 <201003092129.16118.kdudka@redhat.com>
	 <201003100030.50165.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:33272 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791Ab0CJBJY (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 9 Mar 2010 20:09:24 -0500
In-Reply-To: <201003100030.50165.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Josh Triplett <josh@joshtriplett.org>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

On Wed, 2010-03-10 at 00:30 +0100, Kamil Dudka wrote:

> Hopefully I got it.  The promissed fix, which includes new test-cases for ?:, 
> is attached.

Looks good!  "make check" works.  Checking the whole kernel produces no
core dumps.  The warnings appear to be legitimate.

I wonder is the quirk handling could be skipped for EXPR_SELECT, but I'm
fine with it if it's harmless.

When would expr or type be NULL?  We could check type in
warn_for_enum_conversions().

-- 
Regards,
Pavel Roskin
