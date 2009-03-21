From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: bitfields treatment
Date: Sat, 21 Mar 2009 23:12:33 +0000
Message-ID: <20090321231233.GM28946@ZenIV.linux.org.uk>
References: <20090320213727.GJ28946@ZenIV.linux.org.uk> <49C562D5.40103@knosof.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:33226 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbZCUXMf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 21 Mar 2009 19:12:35 -0400
Content-Disposition: inline
In-Reply-To: <49C562D5.40103@knosof.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: linux-sparse@vger.kernel.org

On Sat, Mar 21, 2009 at 09:57:41PM +0000, Derek M Jones wrote:
>> to such bitfields, even if the size is smaller than int.  Arguably, that's
>> a hole in standard; in any case, both gcc and sparse *do* integer promotions
>> on those, with the same behaviour as usual (value-preserving promotion).
>
> The usual arithmetic conversions (of which integer promotion is a
> subset) are performed where the standard says they are performed,
> bit-field involving an implementation defined type or not.

The issue is whether integer promotion *do* anything for a type or happen
to be a no-op.  6.3.1.1p2 lists only the bitfields based on _Bool, int,
signed int and unsigned int, leaving the based on "some other implemention-
defined type" case mentioned in 6.7.2.1p4 not covered.  Then it proceeds
to say that everything not included in the lists is not affected by
integer promotions.

I.e. 6.3.1.1p2 as written says that e.g.
	unsigned long x : 2;
on implementations allowing unsigned long-based bitfields is not affected
by integer promotions.  All I can say is that in this case such reading
of standard can get stuffed.  The sane behaviour is close to TC proposed
in DR315, except that we should convert *all* bitfields that could be
represented by int/unsigned int resp.  If we end up with that in standard -
great, if not... I'm quite willing to go for deliberate non-compliance in
this particular case.

>> * for all bitfields we are told that they act as (signed or unsigned)
>> integer types of specified width.  That has interesting implications:
>
> See:
> http://www.open-std.org/jtc1/sc22/wg14/www/docs/dr_315.htm

Seen it...  AFAICS, the most recent part boils down to "since it's
implementation-defined per 6.7.2.1p4, it's up to implementation to
make up the rules".  Not particulary inspiring and Q2 there is a
non-issue.  The interesting part is not sizeof, it's modulo by which
the arithmetics is done...

>> unsigned long long f(unsigned long long n)
>> {
>> 	struct {
>> 		unsigned long long n:33;
>> 	} x = {n};
>> 	return x.n + x.n;
>> }
>>
>> *must* be equivalent to (n + n) & 0x1ffffffff on all implementations that
>> allow such bitfields.  I.e. these suckers are not promoted to base type;
>
> Sentence 1162 says otherwise:
> http://c0x.coding-guidelines.com/6.5.6.html

And?  Of course usual arithmetic conversions are applied.  Integer promotions
leave both arguments unaffected[1], left and right arguments have the same
type, so we get the same type as the result.

If you want to argue that type of either argument is simply unsigned long long,
you'll need more relevant references than that.  In particular, I'd like to
see how you propose to explain away 1407: "A bit-field is interpreted as a
signed or unsigned integer type consisting of the specified number of bits."
Unless you are talking about a target where the width of unsigned long long
is 33 bits, I'd say that whatever it is, it's not unsigned long long.

[1] they'd better - neither int nor unsigned int has to be wide enough to
hold the possible value.

>> they act as if we really head 33bit unsigned type, usual conversions in
>> x.n + x.n left the result with that type and addition had been done within
>> that type.
>>
>> gcc does it that way, we do not (x.n gets promoted to unsigned long long).
>
> It has been argued at WG14 that gcc gets it wrong.

What was the outcome of that argument?
