From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] bloody mess with __attribute__() syntax
Date: Fri, 13 Jul 2007 10:04:22 +0100
Message-ID: <20070713090422.GA23203@ftp.linux.org.uk>
References: <200707051403.16789.arnd@arndb.de> <OFC2AA6078.1DF7BE7E-ON4225730F.0044BE34-4225730F.0046B6F1@de.ibm.com> <20070705162741.GL21478@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:45792 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbXGMJE0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 13 Jul 2007 05:04:26 -0400
Content-Disposition: inline
In-Reply-To: <20070705162741.GL21478@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-sparse@vger.kernel.org, Ben Elliston <elliston@au1.ibm.com>

[l-k removed from Cc]

	FWIW, I have several problems with that TR.  All of them have the
same root cause: arrays vs. qualifiers.

1) unless 6.7.3[8] is explicitly changed, qualifiers apply to element type
of array; when you manage to apply qualifier to an array (possible via
creative use of typedef), it still applies to the element (i.e. trickles
down until it hits non-array).

2) consequently, changes to 6.2.5 are broken.  They require _any_ array
type T to be in generic address space; of course, this is a nonsense.

3) in changes to 6.7.2.1 (saying that struct or union member types should
not carry an address space qualifier) we have a variant of the same problem -
arrays escape that requirement, but they clearly should not.

4) in places where some attempt to dance around that problem is made,
results are clumsy and actually still wrong.  A typical example:

"The pointer into enclosed address space is first converted to a pointer
to the same reference type except with any address-space qualifier
removed and any address-space qualifer of the other pointer's reference
type added".

We clearly should not replace such qualifiers deep in type derivation.


Now, AFAICS a clean solution would be to leave 6.7.3[8] alone, but
* define 'type T belongs to address space A' by
	if T1 is a type and _A is an address-space qualifier, then 
the type '_A-qualified T1' belongs to corresponding address space.
	if a type T is an array of T1, T belongs to address space A
if and only if T1 belongs to address space A.
* in 6.7.2.1 change the requirement to 'the type of a member shall
not belong to non-generic address space' or equivalent.
* in places dealing with conversion of pointers between address spaces
for comparisons, etc., speak of address-space qualifiers on the outermost
non-array in derivation of reference type.  Might be worth a definition
('counterpart of type T in enclosing address space').

Note that this is very easy to get wrong; similar questions about
const and volatile lead to a subtle difference between C and C++ type
systems and in that particular case C++ one is actually saner.

In C you can assign a pointer to array of const int to object of type
pointer to void, exactly because the constraints refer to qualifiers
on reference type and do not take into account the case when qualifier
sits on array element.  C++ prohibits that - you can assign to const void *,
but not to void *.  I.e. the 'constness' is inherited by arrays there
as far as this kind of implicit conversions is concerned.

For address spaces we definitely want the same kind of semantics;
array elements obviously belong to the same address space as the
array itself.  I have not checked the C++98 (or drafts of C++0x), but
if the construction they are using to describe that part of C++
semantics of const and volatile is not too atrocious it might make
sense to borrow it...
