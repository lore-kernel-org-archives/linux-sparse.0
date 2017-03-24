From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v5 04/14] rewrite compare_opcode() like swap_compare_opcode()
Date: Fri, 24 Mar 2017 16:24:39 -0700
Message-ID: <CA+55aFzgt9iAKQqNzBPDFT=kTL9sP=OyjsQOJ+mxuJYQRwPQkg@mail.gmail.com>
References: <20170324231421.14869-1-luc.vanoostenryck@gmail.com> <20170324231421.14869-5-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:36124 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932803AbdCXXYl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:24:41 -0400
Received: by mail-it0-f46.google.com with SMTP id w124so23798302itb.1
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:24:40 -0700 (PDT)
In-Reply-To: <20170324231421.14869-5-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Fri, Mar 24, 2017 at 4:14 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> More precisely, use a table to get the opcdoe corresponding
> to the negated compare and use a more explicit name for the
> function.

Side note: this code should verify that it doesn't operate on a
floating point compare.

You can't negate a FP compare, because the negation doesn't
necessarily have the opposite value.

For example, "a < b" is *not* the same as "!(a >= b)" for floating
point values when one of them is a NaN. Both < and >= will compare as
false, so "negating" the op won't actually negate the resulting
logical operation.

             Linus
