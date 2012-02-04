From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC/PATCH 1/2] sparse, llvm: Make function declaration
 accessible to backend
Date: Sat, 4 Feb 2012 04:20:46 -0800
Message-ID: <CANeU7QmdK-MJofqB8frCVJHyfce07yYBU7_3cLO_8-NkEuo4tA@mail.gmail.com>
References: <1328090152-28299-1-git-send-email-penberg@kernel.org>
	<CANeU7Q=3mA3sjaj+rV=79qZxM_bYxDBUdMV4dECHprpKzey1Lg@mail.gmail.com>
	<4F29E0E1.3000504@garzik.org>
	<1328145724.28487.95.camel@pasglop>
	<CANeU7QnDStpUovGKpLdV1zw=jJc0X1LrdmeAS2x-e8xdX+J6og@mail.gmail.com>
	<1328147419.28487.96.camel@pasglop>
	<CANeU7Q=QwsfdTu1FhqR1TdbxLGeNWN5Qf6zEqR7M3ahNJxyEZQ@mail.gmail.com>
	<CAOJsxLHku6vzYbaOf9tPOY0VwMEcJ3Te63DYqvs+S2+-W9oFdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37134 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab2BDMUr (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 4 Feb 2012 07:20:47 -0500
Received: by ghrr11 with SMTP id r11so2060716ghr.19
        for <linux-sparse@vger.kernel.org>; Sat, 04 Feb 2012 04:20:47 -0800 (PST)
In-Reply-To: <CAOJsxLHku6vzYbaOf9tPOY0VwMEcJ3Te63DYqvs+S2+-W9oFdA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jeff@garzik.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jgarzik@redhat.com>

On Fri, Feb 3, 2012 at 1:09 AM, Pekka Enberg <penberg@kernel.org> wrote:
> On Thu, Feb 2, 2012 at 4:10 AM, Christopher Li <sparse@chrisli.org> wrote:
>> Yes, that is the point my counter RFC. When you look at it, the
>> insn->fntype is really type of the insn->func pseudo. That is a one off
>> thing for call instruction. Store type inside pseudo provide the same
>> functionality and unify how to get type from pseudo.
>
> Ping? I'd really like to have this bug fixed because it affects basic
> "hello, world" on x86-64 and PPC.

Hi Pekka,

Sorry I get really spaced. Can you continue apply that into your sparse-llvm
repository? The insn->type to pseudo->ctype change is actually impact a
lot of code. I haven't able to complete it yet. On the other hand, I
don't want you
to block on it. The more I look at it, the more I believe this is the
right thing
to do. Pseudo come from expressions, the pseudo->ctype is just the expr->ctype.

We will merge the sparse-llvm again when I get this sort out. One good thing
about git is that branch and merge is really easy. I you to continue
the sparse-llvm
repository. I can submit some llvm related patch for you to review as well.
sparse-llvm.c is the biggest user of insn->type right now. I want to simplify
the usage a little bit.

Thanks

Chris
