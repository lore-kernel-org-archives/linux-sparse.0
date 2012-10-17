From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 1/2] sparse, llvm: group PHI nodes at the top of each BB
Date: Wed, 17 Oct 2012 19:41:52 +0300
Message-ID: <CAOJsxLGWCoskGTsKefWoCYPGuR_b5_QsMTnYkzTNX14t0HkKhg@mail.gmail.com>
References: <1349825676-1713-1-git-send-email-j.neuschaefer@gmx.net>
	<5074BD6B.2090501@pobox.com>
	<CAOJsxLF2AqK2N_R876jOOVmkHXyhe_OjyP_xfULUF5PAfKogMw@mail.gmail.com>
	<20121010163306.GA2846@debian.debian>
	<CAOJsxLE=UsuonXVPuDxL9jPGQj_M5xdvCUrk5u+m3U-s4Ao-hA@mail.gmail.com>
	<CAOJsxLEEBYMF4qcyBSpS7kaumzpQFm0McNexRtft3UJVwp==Xg@mail.gmail.com>
	<20121016201426.GD2932@debian.debian>
	<507DC95C.7010106@gmail.com>
	<CAOJsxLFXaWXcR8vF_DFPAaJZPJ_BTe47Q9GSkM-2MChaRBqkdw@mail.gmail.com>
	<507E55FC.5010202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63455 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757387Ab2JQQlx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 17 Oct 2012 12:41:53 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so6477025wgb.1
        for <linux-sparse@vger.kernel.org>; Wed, 17 Oct 2012 09:41:52 -0700 (PDT)
In-Reply-To: <507E55FC.5010202@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: =?ISO-8859-1?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>, Jeff Garzik <jgarzik@pobox.com>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On 10/17/12 2:48 AM, Pekka Enberg wrote:
>> Is LLVM able to optimize away the allocas and use registers instead in
>> the emitted code?

On Wed, Oct 17, 2012 at 9:53 AM, Xi Wang <xi.wang@gmail.com> wrote:
> Yes.  See the last part of my previous email, no load/store/alloca after
> LLVM's -mem2reg pass.

Right. Jonathan, does Xi's suggestion sound reasonable to you? I'd
certainly prefer that over instruction reordering.

                                Pekka
