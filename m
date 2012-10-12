From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 1/2] sparse, llvm: group PHI nodes at the top of each BB
Date: Fri, 12 Oct 2012 21:25:42 +0300
Message-ID: <CAOJsxLE=UsuonXVPuDxL9jPGQj_M5xdvCUrk5u+m3U-s4Ao-hA@mail.gmail.com>
References: <1349825676-1713-1-git-send-email-j.neuschaefer@gmx.net>
	<5074BD6B.2090501@pobox.com>
	<CAOJsxLF2AqK2N_R876jOOVmkHXyhe_OjyP_xfULUF5PAfKogMw@mail.gmail.com>
	<20121010163306.GA2846@debian.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:41883 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105Ab2JLSZo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 12 Oct 2012 14:25:44 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so91893wib.1
        for <linux-sparse@vger.kernel.org>; Fri, 12 Oct 2012 11:25:42 -0700 (PDT)
In-Reply-To: <20121010163306.GA2846@debian.debian>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-1?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Oct 10, 2012 at 7:33 PM, Jonathan Neusch=E4fer
<j.neuschaefer@gmx.net> wrote:
> I can't say with certainty that it's safe either, so I probably shoul=
d
> have marked the patch with "request for comments".
>
> AFAICT there are three reasons an instruction cannot be moved up or d=
own
> within a basic block:
>  1. If it takes previous SSA values as arguments, it can't be moved
>     above the corresponding intructions.
>  2. If its value is used as an argument of an instruction further dow=
n
>     in the BB, it can't be moved below that instruction.
>  3. Swapping two instructions that influence or are influenced by the
>     "global state" (sorry for the loose wording), e.g. by doing memor=
y
>     accesses, performing I/O, or calling functions (which in turn can
>     do about anything in general), is generally unsafe.
>
> Case 1 doesn't apply because PHI nodes don't use values computed in t=
he
> same invocation of their basic block. Case 2 doesn't apply as I'm not
> moving the PHI nodes down. Case 3 doesn't seem to apply either.
>
> That's how I think this patch is safe.

Sounds plausible but I'm still uneasy with the idea that LLVM backend
needs to reshuffle instructions like this.

Would it be possible to solve this in the frontend?

                        Pekka
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
