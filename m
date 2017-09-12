From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] build: disable sparse-llvm on non-x86
Date: Tue, 12 Sep 2017 08:48:16 +0200
Message-ID: <CAExDi1QezZw+ye46myEQv1r3Fo2ZQ0UBchWcW15TGbF_qJyiSQ@mail.gmail.com>
References: <20170909210215.2mjxhsw76ee6eeqy@taurus.defre.kleine-koenig.org>
 <20170910015622.42436-1-luc.vanoostenryck@gmail.com> <CANeU7Qn-8nLGr_JF61SGGPA=LDAs_h1C578B0RBb2u_KQn9UVA@mail.gmail.com>
 <CAExDi1SO=ztWy4hhW1FE5PzXh_DYb7RD17HqnzH8C0JP=5GUvw@mail.gmail.com>
 <CANeU7QkeWt7FcP1F3=bJx7tqo07+CkSOzucEcdLdxZ3bUOqMhQ@mail.gmail.com>
 <CAExDi1T_G=R8-H7ZgQ6xnzr+-8nDVZtmjwObKdzocr=HEFp_Cw@mail.gmail.com> <CANeU7QnjNiLED_-ds8tQK7_PEb8g6ywNPBCGr_5Qr8Wo98Rtpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36031 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbdILGsS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 12 Sep 2017 02:48:18 -0400
Received: by mail-lf0-f68.google.com with SMTP id l196so4911821lfl.3
        for <linux-sparse@vger.kernel.org>; Mon, 11 Sep 2017 23:48:17 -0700 (PDT)
In-Reply-To: <CANeU7QnjNiLED_-ds8tQK7_PEb8g6ywNPBCGr_5Qr8Wo98Rtpg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Antoine Beaupre <anarcat@debian.org>

On Tue, Sep 12, 2017 at 8:44 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Tue, Sep 12, 2017 at 2:34 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> It's not the problem.
>> I tested it on a ppc64le (power8) machine while I investigated the
>> problem. So let's say that it's solved/tested for ppc64. Then what
>> about all the other models & archs?
>
> For problem like this one happen on the host side of the package,
> I don't have a magic solution either. I guess we will just fix the
> bugs that we know. Then let other people who has the access to
> those model & archs do the testing and report back.
>
> Mean while, we can make it easy to enable and disable
> llvm, similar to a config file. The user don't have to patch
> sparse in order to disable sparse-llvm compiling.

Hence the patch.
I think you should take it for master.

-- Luc
