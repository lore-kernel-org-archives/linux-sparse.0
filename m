From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] sparse, llvm: Simplify comparison op code generation
Date: Tue, 22 Nov 2011 12:04:28 -0800
Message-ID: <CA+55aFzPBK8V1HZ3JAVrpTaD2ZX8qLVH5kHMskuUbov2FiHBow@mail.gmail.com>
References: <1321984717-22395-1-git-send-email-penberg@kernel.org>
 <CA+55aFy9S2j2YbdwLxmYb+K4eRR61wn0Q9D3JodFL0xdYwMhgg@mail.gmail.com>
 <CAOJsxLFNzP0kBQwZkx3yQHLj4LL__Nkw_78i6aDpRU053J-3pA@mail.gmail.com>
 <CA+55aFyYknesuC=fvycCOnnzy0p5fFO8W3mrHG1ETgyJC=-zmA@mail.gmail.com> <CAOJsxLGN8bu7jyr4jxyEkE+scW9ziJ3m-Kwzp5xHTXtY32_mYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44442 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201Ab1KVUEt (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 Nov 2011 15:04:49 -0500
Received: by wwe5 with SMTP id 5so873195wwe.1
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2011 12:04:48 -0800 (PST)
In-Reply-To: <CAOJsxLGN8bu7jyr4jxyEkE+scW9ziJ3m-Kwzp5xHTXtY32_mYA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>

On Tue, Nov 22, 2011 at 11:57 AM, Pekka Enberg <penberg@kernel.org> wrote:
>
> Unfortunately LLVM API requires LLVMBuildFCmp() for floats so it's not
> as simple as that. I sent an incremental patch as a separate email
> that adds FP support for comparison ops.

Yeah, saw that, and it looked sane to me.

                Linus
