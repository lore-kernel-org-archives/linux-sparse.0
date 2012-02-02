From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC/PATCH 1/2] sparse, llvm: Make function declaration
 accessible to backend
Date: Wed, 1 Feb 2012 18:10:57 -0800
Message-ID: <CANeU7Q=QwsfdTu1FhqR1TdbxLGeNWN5Qf6zEqR7M3ahNJxyEZQ@mail.gmail.com>
References: <1328090152-28299-1-git-send-email-penberg@kernel.org>
	<CANeU7Q=3mA3sjaj+rV=79qZxM_bYxDBUdMV4dECHprpKzey1Lg@mail.gmail.com>
	<4F29E0E1.3000504@garzik.org>
	<1328145724.28487.95.camel@pasglop>
	<CANeU7QnDStpUovGKpLdV1zw=jJc0X1LrdmeAS2x-e8xdX+J6og@mail.gmail.com>
	<1328147419.28487.96.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:44001 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753509Ab2BBCK7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 1 Feb 2012 21:10:59 -0500
Received: by lbom4 with SMTP id m4so276661lbo.19
        for <linux-sparse@vger.kernel.org>; Wed, 01 Feb 2012 18:10:57 -0800 (PST)
In-Reply-To: <1328147419.28487.96.camel@pasglop>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jgarzik@redhat.com>

On Wed, Feb 1, 2012 at 5:50 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> But in both cases the type itself is a struct symbol isn't it ? Either a
> function def as Linus patch provides or base_type which is a struct
> symbol too....

Yes, sparse type itself is "struct symbol" pointer.
I see. You mean construct a LLVM value from a give sparse type.
Sure, that is value point. I actually did that once before, in my llvm
hack attempt. I lost that code base due to a hard drive failure.

> Sure if we have a consistent pseudo->type that covers both cases then we
> can just pass that along, I don't mind.

Yes, that is the point my counter RFC. When you look at it, the
insn->fntype is really type of the insn->func pseudo. That is a one off
thing for call instruction. Store type inside pseudo provide the same
functionality
and unify how to get type from pseudo.

Chris
