From: Jeff Garzik <jeff@garzik.org>
Subject: linearize bug?
Date: Sat, 11 Nov 2006 23:09:32 -0500
Message-ID: <45569E7C.4030706@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36542 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1754941AbWKLEJf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 11 Nov 2006 23:09:35 -0500
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1Gj6ez-0004pT-EX
	for linux-sparse@vger.kernel.org; Sun, 12 Nov 2006 04:09:33 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Given the following C code:
#include <stdlib.h>

int foo(void)
{
         int i;

         i = 42;
         i += rand();

         return i;
}

test-linearize seems to give me the following output, which indicates 
that pseudo %r1 is "dead" immediately before it is used:

foo:
.L0x2b52beecd010:
         <entry-point>
         call.32     %r1 <- rand
         dead        %r1
         add.32      %r4 <- %r1, $42
         dead        %r4
         ret.32      %r4

Am I just confused about the meaning of "dead"?   :)

	Jeff
