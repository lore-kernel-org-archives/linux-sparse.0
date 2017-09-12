From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] build: disable sparse-llvm on non-x86
Date: Tue, 12 Sep 2017 03:04:19 -0400
Message-ID: <CANeU7Qk5HtUATD1qhQqXHAJPgmq4AQ-G4X2Y1qU=uHC5kF_mtQ@mail.gmail.com>
References: <20170909210215.2mjxhsw76ee6eeqy@taurus.defre.kleine-koenig.org>
 <20170910015622.42436-1-luc.vanoostenryck@gmail.com> <CANeU7Qn-8nLGr_JF61SGGPA=LDAs_h1C578B0RBb2u_KQn9UVA@mail.gmail.com>
 <CAExDi1SO=ztWy4hhW1FE5PzXh_DYb7RD17HqnzH8C0JP=5GUvw@mail.gmail.com>
 <CANeU7QkeWt7FcP1F3=bJx7tqo07+CkSOzucEcdLdxZ3bUOqMhQ@mail.gmail.com>
 <CAExDi1T_G=R8-H7ZgQ6xnzr+-8nDVZtmjwObKdzocr=HEFp_Cw@mail.gmail.com>
 <CANeU7QnjNiLED_-ds8tQK7_PEb8g6ywNPBCGr_5Qr8Wo98Rtpg@mail.gmail.com> <CAExDi1QezZw+ye46myEQv1r3Fo2ZQ0UBchWcW15TGbF_qJyiSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:35925 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbdILHEU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 12 Sep 2017 03:04:20 -0400
Received: by mail-yw0-f173.google.com with SMTP id v72so24237456ywa.3
        for <linux-sparse@vger.kernel.org>; Tue, 12 Sep 2017 00:04:19 -0700 (PDT)
In-Reply-To: <CAExDi1QezZw+ye46myEQv1r3Fo2ZQ0UBchWcW15TGbF_qJyiSQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Antoine Beaupre <anarcat@debian.org>

On Tue, Sep 12, 2017 at 2:48 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Hence the patch.
> I think you should take it for master.
>

Sure, I want to.

There is some minor feed back on testing of the compiling
LLVM or not. It is just which path we take to apply it.

Chris
