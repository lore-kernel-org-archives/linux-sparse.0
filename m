From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC/PATCH 1/2] sparse, llvm: Make function declaration
 accessible to backend
Date: Wed, 1 Feb 2012 17:22:47 -0800
Message-ID: <CANeU7Q=Dqtg8gyh2uoe4Md9s3_tVc1fAabmZy_fVo13ZwRYgGA@mail.gmail.com>
References: <1328090152-28299-1-git-send-email-penberg@kernel.org>
	<CANeU7Q=3mA3sjaj+rV=79qZxM_bYxDBUdMV4dECHprpKzey1Lg@mail.gmail.com>
	<4F29E0E1.3000504@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:43083 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753047Ab2BBBWt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 1 Feb 2012 20:22:49 -0500
Received: by lagu2 with SMTP id u2so1001845lag.19
        for <linux-sparse@vger.kernel.org>; Wed, 01 Feb 2012 17:22:48 -0800 (PST)
In-Reply-To: <4F29E0E1.3000504@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Pekka Enberg <penberg@kernel.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jgarzik@redhat.com>

On Wed, Feb 1, 2012 at 5:03 PM, Jeff Garzik <jeff@garzik.org> wrote:
> That is useful, yes. =A0But it does not address this specific problem=
=2E
>
> We need the function declaration remembered, rather than what we have=
 now --
> a list of arguments with full type information, specific to its calls=
ite.
>
> You cannot deduce that a function call is/not varargs presently, even=
 with a
> working pseudo->type setup.

I am not trying do deduce function call/varargs from the call. I am
trying to get
it from call_insn->func->type directly. Similar to Linus' patch,
instead of store fntype
at call_insn->fntype, store it at call_insn->func->type directly. It sh=
ould work
the similar way as Linus's patch, no?

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
