From: David Given <dg@cowlark.com>
Subject: Re: Pointer arithmetic error
Date: Fri, 27 Jun 2008 15:03:08 +0100
Message-ID: <4864F31C.3090606@cowlark.com>
References: <486428D7.8080603@cowlark.com>	 <70318cbf0806261651u7a163d54m4d100012bce5db49@mail.gmail.com>	 <48643191.307@cowlark.com> <1214560196.20755.73.camel@tara.firmix.at>	 <4864C710.8000208@cowlark.com> <1214565644.20755.80.camel@tara.firmix.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from a.painless.aaisp.net.uk ([81.187.30.51]:51594 "EHLO
	a.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbYF0ODV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 27 Jun 2008 10:03:21 -0400
Received: from tiar.cowlark.co.uk ([81.187.191.218] helo=gate.cowlark.com)
	by a.painless.aaisp.net.uk with esmtp (Exim 4.69)
	(envelope-from <dg@cowlark.com>)
	id 1KCEYM-0007be-MF
	for linux-sparse@vger.kernel.org; Fri, 27 Jun 2008 15:03:54 +0100
Received: from [172.22.67.145] (localhost [127.0.0.1])
	by gate.cowlark.com (Postfix) with ESMTP id C01A82008D
	for <linux-sparse@vger.kernel.org>; Fri, 27 Jun 2008 15:03:16 +0100 (BST)
In-Reply-To: <1214565644.20755.80.camel@tara.firmix.at>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Bernd Petrovitsch wrote:
> It is done IMHO with the false knowledge that "sizeof(int) == 4 *
> sizeof(char)".

No, it's correctly been told that ints are 32 bits wide, but then it's 
converting this to *bytes* (not chars) by dividing by the hard-coded 
constant 8.

(By 'byte' I'm referring to the quantum of addressingness of the 
underlying machine architecture. In other words, the numbers that are 
used as parameters as offsets into load and store. This isn't something 
that's exposed to C except on architectures where sizeof(byte) == 
sizeof(char), i.e., all sensible ones.)

[...]
> ACK. Therefore "sizeof(char) == 1" must always hold.

Yes; but that is only true from C's perspective.

We're dealing with things from the machine code perspective, where 
sizeof(byte) == 1, and sizeof(char) is not necessarily the same as 
sizeof(byte).

I find it really helps with this stuff if you are capable of holding two 
completely contradictory beliefs at the same time. A certain level of 
insanity can help too...

-- 
David Given
dg@cowlark.com
