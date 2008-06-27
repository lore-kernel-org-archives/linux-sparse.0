From: David Given <dg@cowlark.com>
Subject: Re: Pointer arithmetic error
Date: Fri, 27 Jun 2008 11:55:12 +0100
Message-ID: <4864C710.8000208@cowlark.com>
References: <486428D7.8080603@cowlark.com>	 <70318cbf0806261651u7a163d54m4d100012bce5db49@mail.gmail.com>	 <48643191.307@cowlark.com> <1214560196.20755.73.camel@tara.firmix.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c.painless.aaisp.net.uk ([81.187.30.53]:43568 "EHLO
	c.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046AbYF0KzZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 27 Jun 2008 06:55:25 -0400
Received: from tiar.cowlark.co.uk ([81.187.191.218] helo=gate.cowlark.com)
	by c.painless.aaisp.net.uk with esmtp (Exim 4.69)
	(envelope-from <dg@cowlark.com>)
	id 1KCBbu-00029r-37
	for linux-sparse@vger.kernel.org; Fri, 27 Jun 2008 11:55:22 +0100
Received: from [172.22.67.145] (localhost [127.0.0.1])
	by gate.cowlark.com (Postfix) with ESMTP id 1E5B82008D
	for <linux-sparse@vger.kernel.org>; Fri, 27 Jun 2008 11:55:21 +0100 (BST)
In-Reply-To: <1214560196.20755.73.camel@tara.firmix.at>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Bernd Petrovitsch wrote:
[...]
> In C, there is no type "byte" (unless you typedef oder #define it).
> "byte" is usually (but not necessarily) meant as "unsigned char".

The issue here is that sparse is helpful and converts pointer offsets 
into byte offsets when generating code for pointer arithmetic. So:

const int* p = (const char*) 1234;
p += 10;

-->

set.32 %p0 <- 1234
add.32 %p1 <- %p0, 40
(In fact, in this example it'd collapse these together and use 1274 
instead.)

This appears to be done using hard-coded knowledge that a byte (one unit 
of addressingness) is 8 bits wide.

Chris Li wrote:
> Byte need to big enough to hold the char. Using bits_in_byte is better.
> There might be other place in sparse assume byte is 8 bits.

IIRC C specifies that sizeof() returns values measured in chars, but I 
don't believe it specifies any mapping between the size of chars and the 
underlying addressing units --- it should be possible to use 16-bit 
chars, for example, on an 8-bit byte system. Using 32-bit ints, 
sizeof(int) would then return 2; but you wouldn't be able to access 
individual bytes from C.

That's assuming I've remembered the spec correctly, of course --- this 
stuff is annoying subtle.

If you like I'll go and have a look to see if this can be easily fixed 
--- I need to do it anyway. In fact, I have vague recollections that 
load and store were actually using offsets like 0, 1, 2, etc (the 
'right' values), which means they must have been using bits_per_char to 
do their calculations; I need to check up on this.

-- 
David Given
dg@cowlark.com
