From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [PATCH 03/15] Add type information to struct instruction.
Date: Wed, 24 Dec 2008 15:27:47 -0800
Message-ID: <70318cbf0812241527h6abf21f1hbaa2d9c4b40d566b@mail.gmail.com>
References: <20081215000849.16107.74332.stgit@zaytsev.su>
	 <20081215002610.16107.25437.stgit@zaytsev.su>
	 <70318cbf0812221921q5e53a8edhad06369537dc3a6c@mail.gmail.com>
	 <4950CA43.6090101@cowlark.com>
	 <70318cbf0812231909i812a363s353d26572c8fddd2@mail.gmail.com>
	 <4952BF51.1040302@cowlark.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:63424 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbYLXX1s (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Dec 2008 18:27:48 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3039193rvb.1
        for <linux-sparse@vger.kernel.org>; Wed, 24 Dec 2008 15:27:48 -0800 (PST)
In-Reply-To: <4952BF51.1040302@cowlark.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Given <dg@cowlark.com>
Cc: linux-sparse@vger.kernel.org

On Wed, Dec 24, 2008 at 3:01 PM, David Given <dg@cowlark.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Christopher Li wrote:
> [...]
>> OK, if it is just for OP_LOAD. Will this attached patch solve your problem?
>>
>> Instead of adding type to every instruction. It just add that for the OP_LOAD
>> instruction in insn->orig_type. If that works for you. I am very glad to reclaim
>> the space back on instruction structure.
>
> Sorry, I'm not at home right now and can't test this (and probably won't
> until New Year, though I'll have a go).

No problem. Have a nice Christmas.

>
> Also, I don't know if it *is* just of OP_LOAD. That's just the one I
> remember from looking back at old email. I think the issue is that
> OP_LOAD breaks the chain of pseudo->definer->pseudo->definer that I was
> using to determine the intrinsic type of the pseudo, but there may be
> other instructions that do this as well.

I hope that is the only one. Let me know if you find out there is
more instructions.

>
> I'd imagine that nobody else has come across this yet because most
> people are happy using the size to distinguish between different types;
> but (assuming that I've remembered this correctly) this'll bite anyone
> who needs to distinguish floats from int32s of doubles from int64s.

Right, other than the size, we need to distinguish between:
(sign/unsign) integer, floating point, pointers.
That is why we even have three type of cast instruction.
CAST, CASTFP and CASTPTR. They can generate fairly different
code.


> If space is really an issue, would it make sense therefore to replace
> the insn->size (and symbol->size etc) field with a ->type field pointing
> at the defining symbol for the type? Anyone who needs the type can get
> it from the defining symbol, plus all the other information that people
> like me need would be available, and may also simplify other code. (I
> could throw away a complete source file!)

Right, that is what I am purposing in previous email as well.
It looks have more code up front. But it can simplify the back end
who actually going to use it. It is actually much easier to do it
from front end while initializing those symbols.

Chris
