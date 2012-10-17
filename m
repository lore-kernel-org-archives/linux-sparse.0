From: Xi Wang <xi.wang@gmail.com>
Subject: Re: [PATCH 1/2] sparse, llvm: group PHI nodes at the top of each
 BB
Date: Wed, 17 Oct 2012 02:53:48 -0400
Message-ID: <507E55FC.5010202@gmail.com>
References: <1349825676-1713-1-git-send-email-j.neuschaefer@gmx.net> <5074BD6B.2090501@pobox.com> <CAOJsxLF2AqK2N_R876jOOVmkHXyhe_OjyP_xfULUF5PAfKogMw@mail.gmail.com> <20121010163306.GA2846@debian.debian> <CAOJsxLE=UsuonXVPuDxL9jPGQj_M5xdvCUrk5u+m3U-s4Ao-hA@mail.gmail.com> <CAOJsxLEEBYMF4qcyBSpS7kaumzpQFm0McNexRtft3UJVwp==Xg@mail.gmail.com> <20121016201426.GD2932@debian.debian> <507DC95C.7010106@gmail.com> <CAOJsxLFXaWXcR8vF_DFPAaJZPJ_BTe47Q9GSkM-2MChaRBqkdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:62432 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756034Ab2JQGxp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 17 Oct 2012 02:53:45 -0400
Received: by mail-qa0-f53.google.com with SMTP id s11so202808qaa.19
        for <linux-sparse@vger.kernel.org>; Tue, 16 Oct 2012 23:53:44 -0700 (PDT)
In-Reply-To: <CAOJsxLFXaWXcR8vF_DFPAaJZPJ_BTe47Q9GSkM-2MChaRBqkdw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: =?UTF-8?B?Sm9uYXRoYW4gTmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>, Jeff Garzik <jgarzik@pobox.com>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On 10/17/12 2:48 AM, Pekka Enberg wrote:
> Is LLVM able to optimize away the allocas and use registers instead in
> the emitted code?

Yes.  See the last part of my previous email, no load/store/alloca after
LLVM's -mem2reg pass.

- xi
