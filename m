From: Pavel Roskin <proski@gnu.org>
Subject: Bogus warning when comparing nocast short variables
Date: Wed, 21 Jul 2010 12:51:02 -0400
Message-ID: <1279731062.9003.15.camel@mj>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:56285 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986Ab0GUQvJ (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 21 Jul 2010 12:51:09 -0400
Received: from [192.168.0.22] (static-72-92-88-10.phlapa.fios.verizon.net [72.92.88.10])
	by smtprelay2.cesmail.net (Postfix) with ESMTPSA id 6D1FC34C6D
	for <linux-sparse@vger.kernel.org>; Wed, 21 Jul 2010 13:11:08 -0400 (EDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hello!

This test file causes a warning:

typedef short __attribute__((nocast)) u16;
int main(int argc, char **argv)
{
        u16 i = (u16)argc;
        u16 j = (u16)2;
        return (i == j);
}

$ sparse test1.c 
test1.c:6:17: warning: implicit cast from nocast type
test1.c:6:22: warning: implicit cast from nocast type

But this file doesn't cause any warning:

typedef short __attribute__((nocast)) u16;
int main(int argc, char **argv)
{
        u16 i = (u16)argc;
        u16 j = (u16)2;
        switch (i) {
                case j: return 1;;
                default: return 0;;
        }
}

I think the warnings are bogus.  No cast should be needed to compare
variables of the same type.

The warning was actually found in the current Linux kernel, driver
zd1121rw.  A fix was proposed, but I thing the fix belongs to the sparse
code.

-- 
Regards,
Pavel Roskin
