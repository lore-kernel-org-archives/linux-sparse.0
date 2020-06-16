From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] predefine: add a macro telling about named address spaces
Date: Tue, 16 Jun 2020 12:13:18 -0700
Message-ID: <CAHk-=whHKXbJS62Nrcsn6cy0EcHh3PrGbESBkM0MOAjFx-CVsQ@mail.gmail.com>
References: <20200616005012.66141-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729841AbgFPTNi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 16 Jun 2020 15:13:38 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC019C061573
        for <linux-sparse@vger.kernel.org>; Tue, 16 Jun 2020 12:13:37 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z9so24928184ljh.13
        for <linux-sparse@vger.kernel.org>; Tue, 16 Jun 2020 12:13:37 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 11sm4551714lju.118.2020.06.16.12.13.34
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 12:13:34 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id g2so4827701lfb.0
        for <linux-sparse@vger.kernel.org>; Tue, 16 Jun 2020 12:13:34 -0700 (PDT)
In-Reply-To: <20200616005012.66141-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, Jun 15, 2020 at 5:50 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Sparse supports named address spaces since v0.6.0-rc1.
> This gives much nicer warnings ('... __user' instead of '... <asn:1>')
> but this featres is not yet used in the kernel since it could be
> a problem for people using an older version of Sparse.

Actually, I think it's more that nobody has sent a tested patch.

I don't think it's a big burden to say "you need a newer version of
sparse" for kernel checkers, and in fact a number of the problems
people report then get answered with "update your sparse version"
anyway for other reasons.

In fact, I'd personally like to just make the kernel use _Generic()
everywhere now that we started getting our toes wet, but the fact that
we would have to require gcc-4.9 (instead of gcc-4.8 which is
currently the minimum version) is holding us back.

So I'd be perfectly happy to take a patch to do the ASN names, and to
remove the __CHECKER__ thing that holds us back from using _Generic()
with sparse. And just document that you need to have a recent enough
release..

             Linus
