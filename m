From: Xi Wang <xi.wang@gmail.com>
Subject: Re: [PATCH 1/2] sparse, llvm: group PHI nodes at the top of each BB
Date: Thu, 16 May 2013 01:28:56 -0400
Message-ID: <CAKU6vybB7MVaxL1uoFCR1k3kNHQBSmOfoDVxTD0i+v3hoCRE9A@mail.gmail.com>
References: <1349825676-1713-1-git-send-email-j.neuschaefer@gmx.net>
 <5074BD6B.2090501@pobox.com> <CAOJsxLF2AqK2N_R876jOOVmkHXyhe_OjyP_xfULUF5PAfKogMw@mail.gmail.com>
 <20121010163306.GA2846@debian.debian> <CAOJsxLE=UsuonXVPuDxL9jPGQj_M5xdvCUrk5u+m3U-s4Ao-hA@mail.gmail.com>
 <CAOJsxLEEBYMF4qcyBSpS7kaumzpQFm0McNexRtft3UJVwp==Xg@mail.gmail.com>
 <20121016201426.GD2932@debian.debian> <507DC95C.7010106@gmail.com> <CAOJsxLGizp=f5RziV2fKFR=wGQXWr+nvVZXLWGoeKa23gD_5Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:54714 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab3EPF3g (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 16 May 2013 01:29:36 -0400
Received: by mail-ob0-f172.google.com with SMTP id tb18so2993363obb.31
        for <linux-sparse@vger.kernel.org>; Wed, 15 May 2013 22:29:36 -0700 (PDT)
In-Reply-To: <CAOJsxLGizp=f5RziV2fKFR=wGQXWr+nvVZXLWGoeKa23gD_5Fw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: =?ISO-8859-1?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>, Jeff Garzik <jgarzik@pobox.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, May 15, 2013 at 8:05 AM, Pekka Enberg <penberg@kernel.org> wrote:
> Ping, anyone interested in turning Xi's suggestion into a patch
> against current sparse master?

I'll send a patch.
