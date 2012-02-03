From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 1/2] sparse, llvm: Make function declaration
 accessible to backend
Date: Fri, 03 Feb 2012 22:31:22 +1100
Message-ID: <1328268682.30631.1.camel@pasglop>
References: <1328090152-28299-1-git-send-email-penberg@kernel.org>
	 <CANeU7Q=3mA3sjaj+rV=79qZxM_bYxDBUdMV4dECHprpKzey1Lg@mail.gmail.com>
	 <4F29E0E1.3000504@garzik.org> <1328145724.28487.95.camel@pasglop>
	 <CANeU7QnDStpUovGKpLdV1zw=jJc0X1LrdmeAS2x-e8xdX+J6og@mail.gmail.com>
	 <1328147419.28487.96.camel@pasglop>
	 <CANeU7Q=QwsfdTu1FhqR1TdbxLGeNWN5Qf6zEqR7M3ahNJxyEZQ@mail.gmail.com>
	 <CAOJsxLHku6vzYbaOf9tPOY0VwMEcJ3Te63DYqvs+S2+-W9oFdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:57175 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752196Ab2BCLbo (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 3 Feb 2012 06:31:44 -0500
In-Reply-To: <CAOJsxLHku6vzYbaOf9tPOY0VwMEcJ3Te63DYqvs+S2+-W9oFdA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Christopher Li <sparse@chrisli.org>, Jeff Garzik <jeff@garzik.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jgarzik@redhat.com>

On Fri, 2012-02-03 at 11:09 +0200, Pekka Enberg wrote:
> On Thu, Feb 2, 2012 at 4:10 AM, Christopher Li <sparse@chrisli.org> wrote:
> > Yes, that is the point my counter RFC. When you look at it, the
> > insn->fntype is really type of the insn->func pseudo. That is a one off
> > thing for call instruction. Store type inside pseudo provide the same
> > functionality and unify how to get type from pseudo.
> 
> Ping? I'd really like to have this bug fixed because it affects basic
> "hello, world" on x86-64 and PPC.

Yeah I don't know sparse well enough to have an informed preference of
one way vs. the other, so just pick one that works :-)

From there we can cache the llvm ref etc... which should fix a while
pile of problems and make things faster.

Cheers,
Ben.
 

