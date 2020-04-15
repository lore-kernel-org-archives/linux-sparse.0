From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 15/17] scope: give a scope for labels & gotos
Date: Tue, 14 Apr 2020 17:59:18 -0700
Message-ID: <CAHk-=whoCQ9hiNsNS_PKJGt+dxhXng8+YLJ-CzGG0eESfv0f0g@mail.gmail.com>
References: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
 <20200413161605.95900-16-luc.vanoostenryck@gmail.com> <CAHk-=wiy-BFXMpmm9-GNT_WtDKVLeR0ki4OTj83xPk=npuNSHA@mail.gmail.com>
 <20200413185452.pgj75pj5g7a42kik@ltop.local> <CAHk-=wjMSeVVQHZ23=HJ3V-yYPooeuHNHmZtexUVRKg_e5VMXA@mail.gmail.com>
 <CAHk-=whNLSTtSsmMD5a6D3s_LtjEYwZPWOSvUdz4mCd5kFO26Q@mail.gmail.com>
 <20200413233900.t7fczyyqrees5gwr@ltop.local> <20200414074934.urvzzgpi2a36jdf2@ltop.local>
 <CAHk-=wiahqumRaQkkcQ_kFhknA9z==DCWNKK-j0GRJH7GUtPEw@mail.gmail.com> <20200414230908.kb44bx5fgu3hzq7r@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733273AbgDOA7l (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 14 Apr 2020 20:59:41 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB47C061A0C
        for <linux-sparse@vger.kernel.org>; Tue, 14 Apr 2020 17:59:38 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id w145so1293169lff.3
        for <linux-sparse@vger.kernel.org>; Tue, 14 Apr 2020 17:59:38 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id x67sm11344837lfa.76.2020.04.14.17.59.35
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 17:59:35 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id u15so1854819ljd.3
        for <linux-sparse@vger.kernel.org>; Tue, 14 Apr 2020 17:59:35 -0700 (PDT)
In-Reply-To: <20200414230908.kb44bx5fgu3hzq7r@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Tue, Apr 14, 2020 at 4:09 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> +                       if (s->scope != s->declared_scope) {
>
> This comparison can never succeed for labels declared with __label__
> because s->scope is a block scope and s->declared_scope a label one.

Hold on.. I'm sure I tested it.

Oh.

What I tested wasn't what I sent you, and I'd fixed things due to the
testing but not updated the patch file.

Oops.

The test is supposed to be

                        if (s->declared_scope != label_scope) {

which is the whole point of that 'declared_scope'.

So the concept of the patch is that the 'declared_scope' (and
'label_scope') are the same kind of scope (and comparable): it is the
applicability of the label itself (either the whole function or some
sub-expression statement).

And the the visibility of the -symbol- ends up being different, and is
the s->scope thing.

But while my testing wasn't quite as limited as my wrong-version patch
implied, it _was_ limited. So it might miss some other case.

              Linus
