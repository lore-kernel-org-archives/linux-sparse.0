From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v1 18/28] scope: make function_scope invalid outside functions
Date: Mon, 18 May 2020 18:38:17 -0700
Message-ID: <CAHk-=wgSBgpXKfMD=yC1B6vH-YxP+6y_KUBuDODXB_i=K7sdNg@mail.gmail.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com> <20200519005728.84594-19-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgESBig (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 21:38:36 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713A2C061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 18:38:36 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c12so6331046lfc.10
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 18:38:36 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id s8sm7899810lfd.61.2020.05.18.18.38.33
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 18:38:33 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id h188so9804141lfd.7
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 18:38:33 -0700 (PDT)
In-Reply-To: <20200519005728.84594-19-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, May 18, 2020 at 5:57 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> So, mainly in preparation for some incoming changes, let
> function_scope's parent be NULL instead of the builtin scope.

Hmm. Gcc nested functions?

Sparse doesn't _support_ them, but the symbol nesting part actually
does work, afaik. This looks like it might break it.

Yes, gcc function nesting is disgusting. But it's a thing.

Stupid test-case that almost works with sparse:

    int test(int a, int b)
    {
        inline int nested(int i)
        {
                return a*2 + i;
        }
        return nested(b);
    }

and by "almost works with sparse" I mean that it actually linearizes
correctly, even if it's mostly by mistake, and you get a warning about

    t.c:5:24: warning: unreplaced symbol 'a'

because sparse really doesn't support nested functions and it really
only works because of inlining.

            Linus
