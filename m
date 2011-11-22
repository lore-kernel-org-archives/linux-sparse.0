From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] sparse, llvm: More comparison ops code generation
Date: Tue, 22 Nov 2011 09:44:15 -0800
Message-ID: <CA+55aFwa1DWKaeKJri+Npf0O6jK3e1f5bU3WpdMZ5asfh+msog@mail.gmail.com>
References: <1321983632-8458-1-git-send-email-penberg@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57940 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758311Ab1KVRoh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 Nov 2011 12:44:37 -0500
Received: by wwe5 with SMTP id 5so676164wwe.1
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2011 09:44:36 -0800 (PST)
In-Reply-To: <1321983632-8458-1-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>

On Tue, Nov 22, 2011 at 9:40 AM, Pekka Enberg <penberg@kernel.org> wrote:
> This patch implements LLVM code generation for OP_SET_LE, OP_SET_GE, OP_SET_BE,
> and OP_SET_AE.

Ugh.

Can't you just do it with a single statement like

    target = LLVMBuildICmp(fn->builder, translate_op(op), lhs, rhs,
target_name);

instead of having that case-statement where every case does the same thing?

The translate_op() thing should be trivial too, just something like

   static int translate_op(int sparse_op)
   {
       static const int trans_tbl[] = {
           .[OP_SET_LE] = LLVMIntSLE,
       ...
        };
        return trans_tbl[sparse_op];
   }

or whatever. No?

                 Linus
