From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [SPARSE v2 00/28] detect invalid branches
Date: Mon, 18 May 2020 18:41:07 -0700
Message-ID: <CAHk-=wiaZgBKwC2-ku3UeV4Rdv=tPcKLAfjy96PbJSntcLBWHw@mail.gmail.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgESBl0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 21:41:26 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E2BC061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 18:41:26 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id h188so9808210lfd.7
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 18:41:26 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id u3sm7935131lfq.59.2020.05.18.18.41.23
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 18:41:23 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id b6so11962012ljj.1
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 18:41:23 -0700 (PDT)
In-Reply-To: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, May 18, 2020 at 5:57 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> The goals of the patches in this series are:
> *) to detect such gotos at evaluation time;
> *) issue a sensible error message;
> *) avoid the linearization of functions with invalid gotos.

Ack. Apart from that one question I had, which I didn't actually
verify whether it was a problem for the insane test-case I posted.

I only _read_ the patches, I didn't actually apply and test them in any way.

               Linus
