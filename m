From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC/PATCH 1/2] sparse, llvm: Make function declaration
 accessible to backend
Date: Wed, 1 Feb 2012 17:33:24 -0800
Message-ID: <CANeU7QnDStpUovGKpLdV1zw=jJc0X1LrdmeAS2x-e8xdX+J6og@mail.gmail.com>
References: <1328090152-28299-1-git-send-email-penberg@kernel.org>
	<CANeU7Q=3mA3sjaj+rV=79qZxM_bYxDBUdMV4dECHprpKzey1Lg@mail.gmail.com>
	<4F29E0E1.3000504@garzik.org>
	<1328145724.28487.95.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:60856 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753888Ab2BBBdZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 1 Feb 2012 20:33:25 -0500
Received: by lagu2 with SMTP id u2so1005395lag.19
        for <linux-sparse@vger.kernel.org>; Wed, 01 Feb 2012 17:33:24 -0800 (PST)
In-Reply-To: <1328145724.28487.95.camel@pasglop>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jgarzik@redhat.com>

On Wed, Feb 1, 2012 at 5:22 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> And there could be more. For example specific attributes on the
> declaration may affect the ABI for the call (think asmlinkage or good
> old pascal calling conventions on old macos :-)
>
> Not something we absolutely need to sort out right now but another
> reason why we really need to base the LLVM side definition based on the
> declaration.

Yes, that is what I am talking about too. Notice that insn->func is a pseudo
not a symbol. Pseudo can be result from another expression. That is my
suggestion in the counter RFC, put the full symbol type into pseudo->type.
You should have access of that information.

>
> I'll try to toy a bit more this week-end see if the patches work for all
> cases I can think of. We really have two different things (represented
> by the two different hunks) which we might try to better factor:
>
> The case of a function call where we are after the declaration, and the
> case of creating an llvm type containing a function pointer (which can
> happen as part of the first one if an argument is a function pointer)
> for which we are looking at the base_type.
>
> We should at least make it a single piece of code that takes a symbol
> and shoots out a llvm ref.

Do you mean take a pseudo then shoot out a llvm ref? The pseudo is
the more general form, a pseudo can come from symbol node or
expressions (function pointers).

Chris
