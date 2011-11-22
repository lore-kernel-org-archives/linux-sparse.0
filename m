From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] sparse, llvm: Simplify comparison op code generation
Date: Tue, 22 Nov 2011 10:26:16 -0800
Message-ID: <CA+55aFyYknesuC=fvycCOnnzy0p5fFO8W3mrHG1ETgyJC=-zmA@mail.gmail.com>
References: <1321984717-22395-1-git-send-email-penberg@kernel.org>
 <CA+55aFy9S2j2YbdwLxmYb+K4eRR61wn0Q9D3JodFL0xdYwMhgg@mail.gmail.com> <CAOJsxLFNzP0kBQwZkx3yQHLj4LL__Nkw_78i6aDpRU053J-3pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49575 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab1KVS0i (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 Nov 2011 13:26:38 -0500
Received: by fagn18 with SMTP id n18so729875fag.19
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2011 10:26:37 -0800 (PST)
In-Reply-To: <CAOJsxLFNzP0kBQwZkx3yQHLj4LL__Nkw_78i6aDpRU053J-3pA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>

On Tue, Nov 22, 2011 at 10:18 AM, Pekka Enberg <penberg@kernel.org> wrote:
>
> I think that might be a generic sparse floating point issue but I
> didn't look too closely.

No, it looks like sparse is doing fine, but because you don't generate
the FP versions of the comparison ops, LLVM is unhappy with getting an
integer comparison for a floating point value.

Enhancing the translate_op() function to generate the proper FP
comparisons for LLVM would probably make it "JustWork(tm)".

But I don't really claim to know LLVM.

                    Linus
