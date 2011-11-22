From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] sparse, llvm: Simplify comparison op code generation
Date: Tue, 22 Nov 2011 10:05:33 -0800
Message-ID: <CA+55aFy9S2j2YbdwLxmYb+K4eRR61wn0Q9D3JodFL0xdYwMhgg@mail.gmail.com>
References: <1321984717-22395-1-git-send-email-penberg@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39847 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754694Ab1KVSFz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 Nov 2011 13:05:55 -0500
Received: by wwe5 with SMTP id 5so707973wwe.1
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2011 10:05:54 -0800 (PST)
In-Reply-To: <1321984717-22395-1-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>

On Tue, Nov 22, 2011 at 9:58 AM, Pekka Enberg <penberg@kernel.org> wrote:
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>

Hey, I obviously like it since I suggested it, but I wonder if you
shouldn't handle the FP cases too?

You have lost the

  assert(!symbol_is_fp_type(insn->type));

but I do suspect that the same code should be able to largely just
handle the FP cases (you'd obviously need to translate the sparse
OP_SET_NE things into the proper LLVM LLVMfpEQ or whatever LLVM does).

That said, if you don't handle the FP cases, I think you should
re-introduce the assert().

                      Linus
