From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: Feature request - a macro defined for GCC
Date: Thu, 03 Jul 2008 14:12:26 -0700
Message-ID: <1215119546.11853.10.camel@josh-work.beaverton.ibm.com>
References: <BLU125-W17EAD8591F0443962FC5E5A09E0@phx.gbl>
	 <BLU125-W344BFBA01CF733DBD08F3FA09E0@phx.gbl>
	 <486AC5A2.4070103@tuliptree.org>
	 <BLU125-W495B0DAC339F02DDE29479A0990@phx.gbl>
	 <486AE891.4020805@tuliptree.org>
	 <BLU125-W23C2C0C257AF9E56E1B886A0990@phx.gbl>
	 <486CF7C9.60001@tuliptree.org>
	 <49C57313-8636-400D-8121-1EE7B78CAB26@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:33789 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753627AbYGCVM3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 3 Jul 2008 17:12:29 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m63LCRtT012314
	for <linux-sparse@vger.kernel.org>; Thu, 3 Jul 2008 17:12:27 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m63LCR56171060
	for <linux-sparse@vger.kernel.org>; Thu, 3 Jul 2008 15:12:27 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m63LCQ9E000973
	for <linux-sparse@vger.kernel.org>; Thu, 3 Jul 2008 15:12:27 -0600
In-Reply-To: <49C57313-8636-400D-8121-1EE7B78CAB26@apple.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Chris Lattner <clattner@apple.com>
Cc: Jim Wilson <wilson@tuliptree.org>, x z <hzmonte@hotmail.com>, gcc@gnu.org, linux-sparse@vger.kernel.org

[Adding the Sparse mailing list to CC.]

On Thu, 2008-07-03 at 09:37 -0700, Chris Lattner wrote:
> IMO, the whole notion of a compiler-specific macro has pretty limited=
 =20
> usefulness.  Why not add macros for specific *features* offered by th=
e =20
> compiler.  For example:
>=20
> #ifdef __SUPPORTS_NESTED_FUNCTIONS__
>=20
> is much better than some mismash of version checking, which isn't =20
> guaranteed to be right in the future.  One disadvantage of this is =20
> that it will put even more burden on the already overloaded =20
> preprocessor.  It would be much nicer to have a feature query system =
=20
> that doesn't rely on one macro per system.  Perhaps something like:
>=20
> #if __feature_supported(nested_functions) && =20
> __feature_supported(transparent_union) && =20
> __feature_supported(attribute_aligned)
> ...
>=20
> Taking an approach reduces startup time of the preprocessor, because =
=20
> it doesn't have to populate the identifier table with tons of =20
> predefines.

=EF=BB=BFSpeaking as the maintainer of Sparse, I would love to see GCC =
adopt
such an approach.  I don't like that Sparse currently has to define GNU=
C
and other such macros, and impersonate a GCC version that implies
support for the GCC extensions it has.  While that support probably
needs to stick around for backward compatibility, I'd much rather have
Sparse support some new feature-testing construct.

I'd suggest defining exactly one new preprocessor symbol, to advertise
the support for the feature-testing mechanism.  For instance,
__HAVE_EXTENSION_SUPPORTED__, or __FEATURE_SUPPORTED_SUPPORTED__. :)
The rest could use syntax like you suggest above.  For instance:

#ifdef __HAVE_EXTENSION_SUPPORTED__
#if __have_extension__(noreturn)
#define ATTR_NORETURN __extension__((noreturn))
#endif
=EF=BB=BF#if __have_extension__(sentinel)
#define ATTR_SENTINEL __extension__((sentinel))
#endif
#endif
#ifndef ATTR_NORETURN
#define ATTR_NORETURN
#endif
=EF=BB=BF#ifndef ATTR_SENTINEL
#define ATTR_SENTINEL
#endif

The same thing would work for Sparse extensions:

=EF=BB=BF#ifdef __HAVE_EXTENSION_SUPPORTED__
#if __have_extension__(address_space) && __have_extension__(noderef)
#define __user __extension__((address_space(1),noderef))
#endif
#endif
#ifndef __user
=EF=BB=BF#define __user
#endif

The only problem then becomes maintaining the canonical list of
extension names.  We could use the ugly approach of names like
"org.gnu.gcc.extension.sentinel" and "org.kernel.sparse.address_space",
but that seems entirely too ugly.  The other alternative seems like a
central registry of extension names; I'd happily help maintain such a
registry.

Thoughts?

- Josh Triplett


--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
