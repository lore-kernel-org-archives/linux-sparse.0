From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 1/2] sparse, llvm: group PHI nodes at the top of each BB
Date: Wed, 17 Oct 2012 09:48:17 +0300
Message-ID: <CAOJsxLFXaWXcR8vF_DFPAaJZPJ_BTe47Q9GSkM-2MChaRBqkdw@mail.gmail.com>
References: <1349825676-1713-1-git-send-email-j.neuschaefer@gmx.net>
	<5074BD6B.2090501@pobox.com>
	<CAOJsxLF2AqK2N_R876jOOVmkHXyhe_OjyP_xfULUF5PAfKogMw@mail.gmail.com>
	<20121010163306.GA2846@debian.debian>
	<CAOJsxLE=UsuonXVPuDxL9jPGQj_M5xdvCUrk5u+m3U-s4Ao-hA@mail.gmail.com>
	<CAOJsxLEEBYMF4qcyBSpS7kaumzpQFm0McNexRtft3UJVwp==Xg@mail.gmail.com>
	<20121016201426.GD2932@debian.debian>
	<507DC95C.7010106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:49476 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755159Ab2JQGsS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 17 Oct 2012 02:48:18 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so4186045wey.19
        for <linux-sparse@vger.kernel.org>; Tue, 16 Oct 2012 23:48:17 -0700 (PDT)
In-Reply-To: <507DC95C.7010106@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: =?ISO-8859-1?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>, Jeff Garzik <jgarzik@pobox.com>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On 10/16/12 4:14 PM, Jonathan Neusch=E4fer wrote:
>> Actually, the situation of Phi nodes in LLVM is actually slightly mo=
re
>> complex: They require "one pair (of value and BB) for each predecess=
or
>> basic block of the current block"[1]. This mean that we'll sometimes
>> need to insert phi nodes into BBs that don't directly use a value.

On Tue, Oct 16, 2012 at 11:53 PM, Xi Wang <xi.wang@gmail.com> wrote:
> I ran into the same problem before.  I would suggest a simpler and sa=
fer
> way: don't emit LLVM phi; instead emit load/store (of some alloca).
>
> phi    =3D> load from some alloca
> phisrc =3D> store to some alloca

Is LLVM able to optimize away the allocas and use registers instead in
the emitted code? If not, that means we'll spill and reload at every
basic block boundary...
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
