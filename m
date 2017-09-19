From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] build: only generate version.h when needed and remove it
 in clean target
Date: Tue, 19 Sep 2017 09:13:06 -0400
Message-ID: <CANeU7Q=DcKL2qjHvwN50UM5nQ5bcs-WuhC2Yx26FVm6NTkP5fQ@mail.gmail.com>
References: <20170914184540.26650-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35236 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751361AbdISNNH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 19 Sep 2017 09:13:07 -0400
Received: by mail-yw0-f195.google.com with SMTP id u134so1710385ywu.2
        for <linux-sparse@vger.kernel.org>; Tue, 19 Sep 2017 06:13:07 -0700 (PDT)
In-Reply-To: <20170914184540.26650-1-uwe@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Sep 14, 2017 at 2:45 PM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.o=
rg> wrote:
> This way version.h isn't generated when running $(make clean) but only
> when lib.c is about to be compiled.
>
> This simplifies packaging for Debian because the package building program=
s
> abort when there are additional files after $(make clean).

BTW, this one needs a SOB as well. I want to apply the modify 3 liner
version using the $(MAKECMDGOALS).

Thanks

Chris
