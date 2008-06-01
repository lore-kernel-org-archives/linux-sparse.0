From: Pavel Roskin <proski@gnu.org>
Subject: Re: Undetected error cases
Date: Sun, 01 Jun 2008 14:58:25 -0400
Message-ID: <1212346705.2727.6.camel@dv>
References: <19f34abd0806011142x7e56fd8gf51358bf606ede91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:31596 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751233AbYFAS62 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Jun 2008 14:58:28 -0400
In-Reply-To: <19f34abd0806011142x7e56fd8gf51358bf606ede91@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Vegard Nossum <vegard.nossum@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Sun, 2008-06-01 at 20:42 +0200, Vegard Nossum wrote:

> None of these produce errors or even warnings when they are run
> through sparse. I probably won't get around to fixing these myself
> since I'm not that familiar with sparse internals. This is just a
> heads up :-)

Still, you may be able to create test cases for the testsuite.

-- 
Regards,
Pavel Roskin
