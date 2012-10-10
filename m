From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH 1/2] sparse, llvm: group PHI nodes at the top of each BB
Date: Wed, 10 Oct 2012 18:33:06 +0200
Message-ID: <20121010163306.GA2846@debian.debian>
References: <1349825676-1713-1-git-send-email-j.neuschaefer@gmx.net>
 <5074BD6B.2090501@pobox.com>
 <CAOJsxLF2AqK2N_R876jOOVmkHXyhe_OjyP_xfULUF5PAfKogMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:52166 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752278Ab2JJQdL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Oct 2012 12:33:11 -0400
Content-Disposition: inline
In-Reply-To: <CAOJsxLF2AqK2N_R876jOOVmkHXyhe_OjyP_xfULUF5PAfKogMw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Oct 10, 2012 at 09:31:31AM +0300, Pekka Enberg wrote:
> On Wed, Oct 10, 2012 at 3:12 AM, Jeff Garzik <jgarzik@pobox.com> wrot=
e:
> > On 10/09/2012 07:34 PM, Jonathan Neusch=C3=A4fer wrote:
> >>
> >> This is required for producing valid LLVM bitcode.
> >>
> >> Cc: Pekka Enberg <penberg@kernel.org>
> >> Cc: Christopher Li <sparse@chrisli.org>
> >> Cc: Jeff Garzik <jgarzik@redhat.com>
> >> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> >> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> >> ---
> >>   sparse-llvm.c              |   17 ++++++++++++++++-
> >>   validation/backend/loop2.c |   13 +++++++++++++
> >>   2 files changed, 29 insertions(+), 1 deletion(-)
> >>   create mode 100644 validation/backend/loop2.c
> >
> > Looks sane... but I did not verify whether or not this reordering i=
s safe
>=20
> Ditto. Jonathan, care to explain why you think it is safe? I still
> don't know Sparse's linearized IR well enough to convince myself this
> is OK.

I can't say with certainty that it's safe either, so I probably should
have marked the patch with "request for comments".

AFAICT there are three reasons an instruction cannot be moved up or dow=
n
within a basic block:
 1. If it takes previous SSA values as arguments, it can't be moved
    above the corresponding intructions.
 2. If its value is used as an argument of an instruction further down
    in the BB, it can't be moved below that instruction.
 3. Swapping two instructions that influence or are influenced by the
    "global state" (sorry for the loose wording), e.g. by doing memory
    accesses, performing I/O, or calling functions (which in turn can
    do about anything in general), is generally unsafe.

Case 1 doesn't apply because PHI nodes don't use values computed in the
same invocation of their basic block. Case 2 doesn't apply as I'm not
moving the PHI nodes down. Case 3 doesn't seem to apply either.

That's how I think this patch is safe.


HTH,
Jonathan
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
