From: Tommy Thorn <tommy@numba-tu.com>
Subject: Re: Pointer arithmetic error
Date: Sat, 28 Jun 2008 17:13:19 -0700
Message-ID: <4866D39F.3050909@numba-tu.com>
References: <486428D7.8080603@cowlark.com>	 <70318cbf0806261651u7a163d54m4d100012bce5db49@mail.gmail.com>	 <48643191.307@cowlark.com> <1214560196.20755.73.camel@tara.firmix.at>	 <4864C710.8000208@cowlark.com>	 <1214565644.20755.80.camel@tara.firmix.at>	 <4864F31C.3090606@cowlark.com>	 <1214577926.20755.98.camel@tara.firmix.at>	 <48650B35.5040505@cowlark.com> <70318cbf0806271101n2f9a65buc72764ee97f9ced9@mail.gmail.com> <486578A9.7000900@cowlark.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from server204.webhostingpad.com ([69.65.0.218]:54319 "EHLO
	server204.webhostingpad.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755269AbYF2AN0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 28 Jun 2008 20:13:26 -0400
In-Reply-To: <486578A9.7000900@cowlark.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Given <dg@cowlark.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

[Resent for the 3rd time. I seems I can't write to the list]

David Given wrote:
 > Christopher Li wrote:
 > [...]
 >   
 >> You are right that point out a bug (assumption) of sparse which byte 
is 8 bits.
 >> Using bits_in_byte is instead of 8 is better there.
 >> Using bits_in_char assumes char has same bits as byte. That is my read
 >> of the C spec.
 >>     
 >
 > Yes, indeed, I'd managed to get my terminology muddled to the confusion
 > of everyone.
 >
 > Okay, I've gone and looked at the implementation of this stuff; it would
 > appear that modifying the code to supply the back end with units scaled
 > in something other than C chars is actually quite complicated, so I
 > haven't tried to do that. However, I'm enclosing a patch that should,
 > hopefully, fix the cases where it's assuming 8 bit bytes. Hopefully I've
 >  managed to catch all the cases, without breaking the octal parse code...
 >
 > (I haven't used git before; is this the right format?)
 >   

Yes, but it would have been better to have kept all the white space
changes for a separate change so we could just see that relevant changes.

This introduces divides all over the place for all users, replacing a
very cheap constant shift with an expensive divide. All sparse users
would be paying the cost for a feature that is useful for 1 user, I
think we should perhaps think carefully about this.

One obvious solution would be to introduce a BITS_IN_CHAR macro in
target.h defaulting to 8 and let "exotic" architectures redefine it to
bits_in_char. This is very similar to the approach GCC is using.



On a completely unrelated node, I'm excited to see your work on using
sparse for compilation. Hopefully your experience will lead to it being
easier for the next guy. I would like to see sparse target for a simple
abstract machine, but I so far haven't had time to work on it.

Tommy


