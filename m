From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: Pointer arithmetic error
Date: Fri, 27 Jun 2008 11:01:08 -0700
Message-ID: <70318cbf0806271101n2f9a65buc72764ee97f9ced9@mail.gmail.com>
References: <486428D7.8080603@cowlark.com>
	 <70318cbf0806261651u7a163d54m4d100012bce5db49@mail.gmail.com>
	 <48643191.307@cowlark.com> <1214560196.20755.73.camel@tara.firmix.at>
	 <4864C710.8000208@cowlark.com>
	 <1214565644.20755.80.camel@tara.firmix.at>
	 <4864F31C.3090606@cowlark.com>
	 <1214577926.20755.98.camel@tara.firmix.at>
	 <48650B35.5040505@cowlark.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:18890 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759921AbYF0SBJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 27 Jun 2008 14:01:09 -0400
Received: by yx-out-2324.google.com with SMTP id 31so210743yxl.1
        for <linux-sparse@vger.kernel.org>; Fri, 27 Jun 2008 11:01:08 -0700 (PDT)
In-Reply-To: <48650B35.5040505@cowlark.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Given <dg@cowlark.com>
Cc: linux-sparse@vger.kernel.org, Bernd Petrovitsch <bernd@firmix.at>

> In C, there is no type "byte" (unless you typedef oder #define it).
> "byte" is usually (but not necessarily) meant as "unsigned char".

In C spec, there is a concept of "byte". The union return by sizeof()
is byte. Char must fit in a byte. But char does not necessary have the
same bits as byte. Char can have more.

C99: 3.6, 3.7.1

Because char can always fit in byte, sizeof(char) == 1.

> IIRC C specifies that sizeof() returns values measured in chars, but I don't believe it specifies any mapping between the size of chars and the underlying addressing units --- it should be
> possible to use 16-bit chars, for example, on an 8-bit byte system. Using 32-bit ints, sizeof(int) would then return 2; but you wouldn't be able to access individual bytes from C.

sizeof() return value measure in _byte_.
C99: 6.5.3.4

On Fri, Jun 27, 2008 at 8:45 AM, David Given <dg@cowlark.com> wrote:
> Bernd Petrovitsch wrote:
> [...]
>>
>> That's the bug. there is no difference between "byte" and "char". Tell
>> it that a char has 32 bits too *if* it's the case.

No, there is a different between "byte" and "char". See above.


>
> Having checked the standard it turns out that we've been talking at cross
> purposes as I've been using the wrong terminology --- it actually defines
> (unhelpfully) that byte and char are the same size. Sorry for the confusion.
>
> What I was referring to when I previously said (erroneously) 'byte' was 'an
> address delta of 1', as understood by the assembler. Let's just call this a
> 'unit' for clarity. This is not necessarily the same size as a char.

In C's term, that is call a "byte" :-)

> I'm proposing adding a bits_in_unit (or something) setting and then going
> through and tracking down these places and changing them to use it. That way
> it should still work fine on exotic architectures like mine.

You are right that point out a bug (assumption) of sparse which byte is 8 bits.
Using bits_in_byte is instead of 8 is better there.
Using bits_in_char assumes char has same bits as byte. That is my read
of the C spec.

Thanks

Chris
