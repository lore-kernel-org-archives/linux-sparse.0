From: Pavel Roskin <proski@gnu.org>
Subject: Fixing "cast truncates bits from constant value"
Date: Mon, 17 Aug 2009 17:02:02 -0400
Message-ID: <1250542922.10511.38.camel@mj>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:32308 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991AbZHQVCD (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 17 Aug 2009 17:02:03 -0400
Received: from [192.168.0.22] (static-72-92-88-10.phlapa.fios.verizon.net [72.92.88.10])
	by smtprelay2.cesmail.net (Postfix) with ESMTPSA id 0CB2834C6A
	for <linux-sparse@vger.kernel.org>; Mon, 17 Aug 2009 17:16:27 -0400 (EDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hello!

There was a discussion in the linux-wireless mailing list about
silencing a sparse warning in the b43 driver:

http://marc.info/?t=125020183400006&r=1&w=2

It turns out the fixes for the warnings would make the code worse, not
better.  It's not what sparse should try to do.

Here's the simplest case:

static unsigned short test(void)
{
        return (unsigned short)~0x8000;
}

test.c:3:32: warning: cast truncates bits from constant value (ffff7fff
becomes 7fff)

A side note - "0x" should be used with user visible output.

0x8000 could be a constant defined in a header, so just using 0x7fff is
not an option, if the code readability is to be preserved.

In my opinion, an explicit cast should be enough to suppress the
warning.  But it's not.  Moreover, it's a "superwarning" that cannot
even be suppressed by the "force" attribute!  This source still
generates a warning:

static unsigned short test(void)
{
        return (__attribute__((force)) unsigned short)~0x8000;
}

There is also an inconsistency.  This source produces a warning:

static unsigned short test(void)
{
        return 0x0ffff000U;
}

But this source doesn't:

static unsigned short test(void)
{
        return 0xfffff000U;
}

In both cases bits are dropped and the value (a large positive number)
is changed.

I'm not currently subscribed to this list, please copy me.

-- 
Regards,
Pavel Roskin
