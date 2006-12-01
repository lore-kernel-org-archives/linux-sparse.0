From: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: cast truncates bits from constant value (8000000000000000 becomes
 0)
Date: Fri, 01 Dec 2006 08:51:05 -0800
Message-ID: <45705D79.6000107@am.sony.com>
References: <4563D00D.4010704@am.sony.com>	<Pine.LNX.4.62.0612011516120.28210@pademelon.sonytel.be> <Pine.LNX.4.64.0612010723190.3695@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from outbound-blu.frontbridge.com ([65.55.251.16]:55563 "EHLO
	outbound8-blu-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1031598AbWLAQvT (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 1 Dec 2006 11:51:19 -0500
In-Reply-To: <Pine.LNX.4.64.0612010723190.3695@woody.osdl.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Linux/PPC Development <linuxppc-dev@ozlabs.org>, linux-sparse@vger.kernel.org, Andrew Pinski <Andrew_Pinski@PlayStation.Sony.Com>

Linus Torvalds wrote:
> 
> On Fri, 1 Dec 2006, Geert Uytterhoeven wrote:
>>
>> On Tue, 21 Nov 2006, Geoff Levand wrote:
>> > +enum ps3_vendor_id {
>> > +	PS3_VENDOR_ID_NONE = 0,
>> > +	PS3_VENDOR_ID_SONY = 0x8000000000000000UL,
>> > +};
>> 
>> I've just ran `make C=1' (PPC in 64-bit mode, and sparse is called with -m64),
>> and noticed that sparse (cloned from
>> git://git.kernel.org/pub/scm/devel/sparse/sparse.git a few minutes ago)
>> complains about the second value with:
>> 
>> | warning: cast truncates bits from constant value (8000000000000000 becomes 0)
>> 
>> Section 6.7.2.2.4 of C99 says:
>> 
>> | Each enumerated type shall be compatible with char, a signed integer type, or
>> | an unsigned integer type. The choice of type is implementation-defined, but
>> | shall be capable of representing the values of all the members of the
>> | enumeration.
>> 
>> The code snippet
>> 
>> | u64 x = PS3_VENDOR_ID_SONY;
>> | printk("PS3_VENDOR_ID_SONY = %lu\n", x);
>> 
>> does print the expected (i.e. non-zero) result.
>> 
>> Hence this looks like a bug in sparse.
> 
> It's really a bug in gcc, but it's documented, so it's a "feature".
> 
> Gcc allows large enums, but does so in such a strange manner that it's 
> totally hopeless to catch problems. Also, putting a value that is larger 
> than "unsigned int" into an enum is really setting yourself up for bugs 
> and not even guaranteed to work for standard C, so sparse takes a dim view 
> of it and just says that enums are limited in size to "int" or "unsigned 
> int".
> 
> You can either ignore that warning or just use a #define. 

One of the gcc maintainers (Andrew Pinski) told me to set it up that
way, so I figured it was safe.

-Geoff
