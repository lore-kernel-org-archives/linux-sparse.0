From: Pavel Roskin <proski@gnu.org>
Subject: Re: Undetected error cases
Date: Sun, 01 Jun 2008 16:10:56 -0400
Message-ID: <1212351056.2727.7.camel@dv>
References: <19f34abd0806011142x7e56fd8gf51358bf606ede91@mail.gmail.com>
	 <1212346705.2727.6.camel@dv>
	 <19f34abd0806011246nd615793o7e09ceae8dee73e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:22226 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494AbYFAULA (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Jun 2008 16:11:00 -0400
In-Reply-To: <19f34abd0806011246nd615793o7e09ceae8dee73e6@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Vegard Nossum <vegard.nossum@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Sun, 2008-06-01 at 21:46 +0200, Vegard Nossum wrote:

> Ah, that's be true. I have now submitted the .c files that should
> produce the errors/warnings, but I can't seem to find an actual
> testsuite in which to hook them. The existing test-* files seem to
> test the API, not the files to be parsed.

It's under "validation".

-- 
Regards,
Pavel Roskin
