From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] build: disable sparse-llvm on non-x86
Date: Tue, 12 Sep 2017 08:12:17 +0200
Message-ID: <CAExDi1SO=ztWy4hhW1FE5PzXh_DYb7RD17HqnzH8C0JP=5GUvw@mail.gmail.com>
References: <20170909210215.2mjxhsw76ee6eeqy@taurus.defre.kleine-koenig.org>
 <20170910015622.42436-1-luc.vanoostenryck@gmail.com> <CANeU7Qn-8nLGr_JF61SGGPA=LDAs_h1C578B0RBb2u_KQn9UVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:37837 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbdILGMT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 12 Sep 2017 02:12:19 -0400
Received: by mail-lf0-f48.google.com with SMTP id 80so23638222lfy.4
        for <linux-sparse@vger.kernel.org>; Mon, 11 Sep 2017 23:12:19 -0700 (PDT)
In-Reply-To: <CANeU7Qn-8nLGr_JF61SGGPA=LDAs_h1C578B0RBb2u_KQn9UVA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Antoine Beaupre <anarcat@debian.org>

On Tue, Sep 12, 2017 at 8:02 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Sat, Sep 9, 2017 at 9:56 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> sparse-llvm doesn't have support for targets other than
>> x86 or x86-64.
>>
>> Disable sparse-llvm on other archs as it create problems during
>> build, selftest, ...
>
> Thanks, will apply.
>
> This is temporary while we looking at how to fix the other
> architecture properly, right?

Everything is temporary, isn't it? ;)

In the other thread I explained the nature of the problem, it's *just* a
question to match the options for the model/sub-architecture between
LLVM compiler and the assembler.
Easy to do if you choose the dumbest (generic) model, pretty annoying
otherwise and a nightmare to test.

-- Luc
