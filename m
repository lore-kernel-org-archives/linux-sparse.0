From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: intended use of "safe"?
Date: Fri, 12 Aug 2011 10:58:35 -0700
Message-ID: <20110812175835.GA1735@leaf>
References: <874o1nzx8x.fsf@blp.benpfaff.org>
 <CANeU7Qn25EWmDFuQRhr2_txEhF9hguh=SMUJnNYjLPnCR2MDNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:46940 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849Ab1HLR6u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 12 Aug 2011 13:58:50 -0400
Content-Disposition: inline
In-Reply-To: <CANeU7Qn25EWmDFuQRhr2_txEhF9hguh=SMUJnNYjLPnCR2MDNg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: blp@cs.stanford.edu, linux-sparse@vger.kernel.org

On Fri, Aug 12, 2011 at 10:47:11AM -0700, Christopher Li wrote:
> On Thu, Aug 11, 2011 at 10:14 AM, Ben Pfaff <blp@cs.stanford.edu> wro=
te:
> > What is the intended use of the sparse "safe" attribute? =A0I do
> > not see any uses of it in Linux (although there is a __safe macro
> > for it). =A0I don't see any documentation for it either.
>=20
> I don't know much about the safe attribute either. I find out the
> commit which introduce the safe attribute by "git blame".
>=20
> If a pointer is never NULL, there is not need to test the pointer.
>=20
> Chris
>=20
> commit 98f14350c26518f0f5c45632d145a218d468d8b8
> Author: Linus Torvalds <torvalds@ppc970.osdl.org>
> Date:   Fri Apr 16 18:19:30 2004 -0700
>=20
>     Introduce "safe" pointer expressions.
>=20
>     These are defined to never be NULL or nontrapping, and could
>     help code generation, but right now only cause a warning if
>     they are tested in a conditional.

That does actually seem useful.  The Linux kernel has various structure=
s
with pointers that should never be NULL, and documenting that in a
compiler-visible way seems like a feature.

- Josh Triplett
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
