From: Jeff Garzik <jeff@garzik.org>
Subject: linearize bug?
Date: Sat, 27 Aug 2011 02:29:12 -0400
Message-ID: <4E588EB8.80808@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:44060 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865Ab1H0G3P (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 02:29:15 -0400
Received: by qyk38 with SMTP id 38so833593qyk.19
        for <linux-sparse@vger.kernel.org>; Fri, 26 Aug 2011 23:29:14 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sparse Mailing-list <linux-sparse@vger.kernel.org>
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>, Linus Torvalds <torvalds@linux-foundation.org>

While trying to implement loops in LLVM, the following testcase appears 
to have some strange behavior:

int foo(int x)
{
	int i;

	for (i = 0; i < 10; i++)
		x += 42;
	
	return x;
}

when run through test-linearize produces

foo.c:1:5: warning: symbol 'foo' was not declared. Should it be static?
foo:
.L0x7f4c095ae010:
	<entry-point>
	phisrc.32   %phi2(x) <- %arg1
	phisrc.32   %phi4(x) <- %arg1
	phisrc.32   %phi7(i) <- $0
	br          .L0x7f4c095ae150

.L0x7f4c095ae150:
	phi.32      %r1(i) <- %phi7(i), %phi8(i)
	setlt.32    %r2 <- %r1(i), $10
	br          %r2, .L0x7f4c095ae060, .L0x7f4c095ae100

.L0x7f4c095ae060:
	add.32      %r5 <- %r9, $42
	phisrc.32   %phi3(x) <- %r5
	phisrc.32   %phi5(x) <- %r5
	add.32      %r8 <- %r1(i), $1
	phisrc.32   %phi8(i) <- %r8
	br          .L0x7f4c095ae150

.L0x7f4c095ae100:
	phi.32      %r9 <- %phi2(x), %phi3(x)
	ret.32      %r9

So...  WTF did %r9 come from, in the third basic block?


