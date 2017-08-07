From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 7/8] transform (A << S) >> S into A & (-1 >> S)
Date: Tue, 8 Aug 2017 00:08:41 +0200
Message-ID: <CAExDi1TfyR7brtPvV1htcRA0fF1+xrxdsepbAOqgN+29M9SyvQ@mail.gmail.com>
References: <CACXZuxd30jwczag_GHW3cmqPcBybEi7jfwfku81vW2nHzo_kyA@mail.gmail.com>
 <20170807191205.86590-1-luc.vanoostenryck@gmail.com> <20170807191205.86590-8-luc.vanoostenryck@gmail.com>
 <CA+55aFyEJOfbmru8BMk4DUYop4HpP7HAhVr5_hGXdtNMK0CGog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35324 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751743AbdHGWIm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 18:08:42 -0400
Received: by mail-qt0-f196.google.com with SMTP id t37so1814614qtg.2
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 15:08:42 -0700 (PDT)
In-Reply-To: <CA+55aFyEJOfbmru8BMk4DUYop4HpP7HAhVr5_hGXdtNMK0CGog@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, Aug 7, 2017 at 11:54 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Aug 7, 2017 at 12:12 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> +               // replace (A << S) >> S
>> +               // by      A & (-1 >> S)
>
> Umm. This seems misleading.
>
> Don't you mean "value of all ones of the same size as A, shifted right by S"
>
>> +               insn->src2 = value_pseudo(-1ULL >> value);
>
> ..and this seems buggy. There's a lot of bits in -1ULL, but what if
> the size of 'S' is only 32-bit?
>
> So I think you should take the size of A into account?
>
> Or am I missing something?

I don't think you're missing something and this code have only been
very lightly tested (and maybe developed too fastly too).
OTOH, it shouldn't matter much since it's only used for a mask
(subsequent steps will drop the superfluous high bits) and I think
that it's done so at some other place too.
But it certainly wouldn't be bad to use the right size for the mask.

-- Luc
