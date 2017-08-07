From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 7/8] transform (A << S) >> S into A & (-1 >> S)
Date: Mon, 7 Aug 2017 14:54:15 -0700
Message-ID: <CA+55aFyEJOfbmru8BMk4DUYop4HpP7HAhVr5_hGXdtNMK0CGog@mail.gmail.com>
References: <CACXZuxd30jwczag_GHW3cmqPcBybEi7jfwfku81vW2nHzo_kyA@mail.gmail.com>
 <20170807191205.86590-1-luc.vanoostenryck@gmail.com> <20170807191205.86590-8-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34336 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbdHGVyQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 17:54:16 -0400
Received: by mail-oi0-f49.google.com with SMTP id x3so16691178oia.1
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 14:54:16 -0700 (PDT)
In-Reply-To: <20170807191205.86590-8-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, Aug 7, 2017 at 12:12 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> +               // replace (A << S) >> S
> +               // by      A & (-1 >> S)

Umm. This seems misleading.

Don't you mean "value of all ones of the same size as A, shifted right by S"

> +               insn->src2 = value_pseudo(-1ULL >> value);

..and this seems buggy. There's a lot of bits in -1ULL, but what if
the size of 'S' is only 32-bit?

So I think you should take the size of A into account?

Or am I missing something?

             Linus
