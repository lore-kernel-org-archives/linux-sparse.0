From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] build: disable sparse-llvm on non-x86
Date: Tue, 12 Sep 2017 02:27:18 -0400
Message-ID: <CANeU7QkeWt7FcP1F3=bJx7tqo07+CkSOzucEcdLdxZ3bUOqMhQ@mail.gmail.com>
References: <20170909210215.2mjxhsw76ee6eeqy@taurus.defre.kleine-koenig.org>
 <20170910015622.42436-1-luc.vanoostenryck@gmail.com> <CANeU7Qn-8nLGr_JF61SGGPA=LDAs_h1C578B0RBb2u_KQn9UVA@mail.gmail.com>
 <CAExDi1SO=ztWy4hhW1FE5PzXh_DYb7RD17HqnzH8C0JP=5GUvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:35270 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751238AbdILG1T (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 12 Sep 2017 02:27:19 -0400
Received: by mail-yw0-f169.google.com with SMTP id q80so26204111ywg.2
        for <linux-sparse@vger.kernel.org>; Mon, 11 Sep 2017 23:27:19 -0700 (PDT)
In-Reply-To: <CAExDi1SO=ztWy4hhW1FE5PzXh_DYb7RD17HqnzH8C0JP=5GUvw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Antoine Beaupre <anarcat@debian.org>

On Tue, Sep 12, 2017 at 2:12 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Everything is temporary, isn't it? ;)
>

Of course :-)

> In the other thread I explained the nature of the problem, it's *just* a
> question to match the options for the model/sub-architecture between
> LLVM compiler and the assembler.
> Easy to do if you choose the dumbest (generic) model, pretty annoying
> otherwise and a nightmare to test.

Yes, I saw the other email you have it pretty much figure out
already. I am tempting just pick up an used apple G5 and install
Linux on it for ppc64 testing.

Chris
