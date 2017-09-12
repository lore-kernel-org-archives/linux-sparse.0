From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] build: disable sparse-llvm on non-x86
Date: Tue, 12 Sep 2017 02:02:04 -0400
Message-ID: <CANeU7Qn-8nLGr_JF61SGGPA=LDAs_h1C578B0RBb2u_KQn9UVA@mail.gmail.com>
References: <20170909210215.2mjxhsw76ee6eeqy@taurus.defre.kleine-koenig.org> <20170910015622.42436-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:35046 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbdILGCG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 12 Sep 2017 02:02:06 -0400
Received: by mail-yw0-f174.google.com with SMTP id q80so26113844ywg.2
        for <linux-sparse@vger.kernel.org>; Mon, 11 Sep 2017 23:02:05 -0700 (PDT)
In-Reply-To: <20170910015622.42436-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Antoine Beaupre <anarcat@debian.org>

On Sat, Sep 9, 2017 at 9:56 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> sparse-llvm doesn't have support for targets other than
> x86 or x86-64.
>
> Disable sparse-llvm on other archs as it create problems during
> build, selftest, ...

Thanks, will apply.

This is temporary while we looking at how to fix the other
architecture properly, right?

Chris
