From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] sparse, llvm: Fix 'void *' pointer code generation
Date: Mon, 24 Oct 2011 13:52:50 +0200
Message-ID: <CA+55aFx1=9C_QDE2CfqLp1zg_t=x+VjKUPZgj2karJsS1FAZaA@mail.gmail.com>
References: <1319456619-11546-1-git-send-email-penberg@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45754 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755628Ab1JXLxN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 24 Oct 2011 07:53:13 -0400
Received: by wyg36 with SMTP id 36so6071036wyg.19
        for <linux-sparse@vger.kernel.org>; Mon, 24 Oct 2011 04:53:12 -0700 (PDT)
In-Reply-To: <1319456619-11546-1-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>

On Mon, Oct 24, 2011 at 1:43 PM, Pekka Enberg <penberg@kernel.org> wrote:
>
> Fix the issue by switching to LLVMIntType(bits_per_pointer) in
> sym_basetype_type().

Why bits_per_pointer? Isn't this the "base type" of void *? A more
logical choice would seem to be to make it equivalent to "char *", and
just make it fall through to the "case 8" case?

       Linus
