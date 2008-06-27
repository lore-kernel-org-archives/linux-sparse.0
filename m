From: David Given <dg@cowlark.com>
Subject: Re: Pointer arithmetic error
Date: Fri, 27 Jun 2008 16:45:57 +0100
Message-ID: <48650B35.5040505@cowlark.com>
References: <486428D7.8080603@cowlark.com>	 <70318cbf0806261651u7a163d54m4d100012bce5db49@mail.gmail.com>	 <48643191.307@cowlark.com> <1214560196.20755.73.camel@tara.firmix.at>	 <4864C710.8000208@cowlark.com> <1214565644.20755.80.camel@tara.firmix.at>	 <4864F31C.3090606@cowlark.com> <1214577926.20755.98.camel@tara.firmix.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from a.painless.aaisp.net.uk ([81.187.30.51]:49691 "EHLO
	a.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbYF0PqJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 27 Jun 2008 11:46:09 -0400
Received: from tiar.cowlark.co.uk ([81.187.191.218] helo=gate.cowlark.com)
	by a.painless.aaisp.net.uk with esmtp (Exim 4.69)
	(envelope-from <dg@cowlark.com>)
	id 1KCG9q-0006P2-Ce
	for linux-sparse@vger.kernel.org; Fri, 27 Jun 2008 16:46:42 +0100
Received: from [172.22.67.145] (localhost [127.0.0.1])
	by gate.cowlark.com (Postfix) with ESMTP id 8A7BB2008D
	for <linux-sparse@vger.kernel.org>; Fri, 27 Jun 2008 16:46:04 +0100 (BST)
In-Reply-To: <1214577926.20755.98.camel@tara.firmix.at>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Bernd Petrovitsch wrote:
[...]
> That's the bug. there is no difference between "byte" and "char". Tell
> it that a char has 32 bits too *if* it's the case.

Having checked the standard it turns out that we've been talking at 
cross purposes as I've been using the wrong terminology --- it actually 
defines (unhelpfully) that byte and char are the same size. Sorry for 
the confusion.

What I was referring to when I previously said (erroneously) 'byte' was 
'an address delta of 1', as understood by the assembler. Let's just call 
this a 'unit' for clarity. This is not necessarily the same size as a char.

[...]
>>> ACK. Therefore "sizeof(char) == 1" must always hold.
>> Yes; but that is only true from C's perspective.
> 
> Is there another remotely relevant perspective (let alone more
> important) in a C parser?

The issue here is that sparse is not just a C parser. It is also a 
compiler, and needs to know how to manipulate addresses that are 
represented as units. (This is why I'm using it for my project.) It has 
to be able to express an offset into a structure in units to pass on to 
the 'assembler' (with stock sparse, this is the human who's reading the 
output of test-linearise).

Currently I believe that some parts of sparse are assuming that a unit 
is 8 bits, and other parts are assuming that a unit is CHAR_BITS bits, 
neither of which is necessarily correct. However, I need to go and check 
up on this; I'm away from the machine with my project on it right now.

I'm proposing adding a bits_in_unit (or something) setting and then 
going through and tracking down these places and changing them to use 
it. That way it should still work fine on exotic architectures like mine.

(Wikipedia has a rather interesting table of machines with interesting 
word/byte/char sizes:

http://en.wikipedia.org/wiki/Word_(computing)#Table_of_word_sizes

The last machine with a freaky word size was the Cray C-90 in 1991, 
where a unit was 64 bits but a char was 8 bits...)

-- 
David Given
dg@cowlark.com
