From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH] sparse, llvm: Simplify comparison op code generation
Date: Tue, 22 Nov 2011 21:57:51 +0200
Message-ID: <CAOJsxLGN8bu7jyr4jxyEkE+scW9ziJ3m-Kwzp5xHTXtY32_mYA@mail.gmail.com>
References: <1321984717-22395-1-git-send-email-penberg@kernel.org>
	<CA+55aFy9S2j2YbdwLxmYb+K4eRR61wn0Q9D3JodFL0xdYwMhgg@mail.gmail.com>
	<CAOJsxLFNzP0kBQwZkx3yQHLj4LL__Nkw_78i6aDpRU053J-3pA@mail.gmail.com>
	<CA+55aFyYknesuC=fvycCOnnzy0p5fFO8W3mrHG1ETgyJC=-zmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45952 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965Ab1KVT5w (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 Nov 2011 14:57:52 -0500
Received: by vbbfc21 with SMTP id fc21so594741vbb.19
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2011 11:57:51 -0800 (PST)
In-Reply-To: <CA+55aFyYknesuC=fvycCOnnzy0p5fFO8W3mrHG1ETgyJC=-zmA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>

On Tue, Nov 22, 2011 at 10:18 AM, Pekka Enberg <penberg@kernel.org> wrote:
>> I think that might be a generic sparse floating point issue but I
>> didn't look too closely.

On Tue, Nov 22, 2011 at 8:26 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> No, it looks like sparse is doing fine, but because you don't generate
> the FP versions of the comparison ops, LLVM is unhappy with getting an
> integer comparison for a floating point value.
>
> Enhancing the translate_op() function to generate the proper FP
> comparisons for LLVM would probably make it "JustWork(tm)".

Unfortunately LLVM API requires LLVMBuildFCmp() for floats so it's not
as simple as that. I sent an incremental patch as a separate email
that adds FP support for comparison ops.
