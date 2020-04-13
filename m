From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 15/17] scope: give a scope for labels & gotos
Date: Mon, 13 Apr 2020 12:32:41 -0700
Message-ID: <CAHk-=wjMSeVVQHZ23=HJ3V-yYPooeuHNHmZtexUVRKg_e5VMXA@mail.gmail.com>
References: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
 <20200413161605.95900-16-luc.vanoostenryck@gmail.com> <CAHk-=wiy-BFXMpmm9-GNT_WtDKVLeR0ki4OTj83xPk=npuNSHA@mail.gmail.com>
 <20200413185452.pgj75pj5g7a42kik@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387876AbgDMTdB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Apr 2020 15:33:01 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59569C0A3BDC
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 12:33:01 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id t11so7477475lfe.4
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 12:33:01 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id q9sm9461130ljm.9.2020.04.13.12.32.57
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 12:32:58 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id j14so2114174lfg.9
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 12:32:57 -0700 (PDT)
In-Reply-To: <20200413185452.pgj75pj5g7a42kik@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, Apr 13, 2020 at 11:54 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Yes, I agree and in fact (if I understand you correctly) it was what
> I tried first, mainly because it was "conceptualy neat" and simpler.
> But then it wasn't working correctly in all situations and I
> convinced myself it couldn't. The problem was with code like:
>         void foo(void)
>         {
>                 ... = ({ ...  goto out; ... });
>
>         out:
>                 ...;
>         }
>
> In this case, when 'goto out' is parsed, the corresponding label
> symbol would be created in the inner scope and later when the label
> is defined the symbol lookup will only look in the outer scope, see
> nothing and declare another symbol for it

Oh, yeah, I see.

And that's just because of how we basically do the same thing at
"goto" time as we do at "label definition" time.

Both basically create the symbol label.

Which was simple, and worked, and meant that you never had to look
anything up, because they automatically just did the right thing - and
the use and scope is symmetric.

And the reason it does that, is that labels - unlike every other
symbol - aren't declared before use. So it's a hacky solution, and it
works.

And by "it works", I mean "doesn't really work all that well", because
clearly all the _other_ patches in your series were about the fact
that it also meant that we were horrible at the whole "label was never
defined in the first place" case.

But with the scoping change, the use and scope isn't symmetric any
more, and the "create symbol both at use and at definition" doesn't
work.

I _feel_ like the fix to that should be that the only thing that
creates the actual symbol is the label definition, and that the goto
should only ever use the 'ident' and we'd tie the two together later.

But yeah, that "tie the two together later" may not work, simply
because scoping is so tightly tied to parsing in sparse.

So maybe your approach is the best one.

It feels hacky and wrong, but maybe that just fundamentally comes from
labels having that very special "use = implicit declaration" thing.

              Linus
