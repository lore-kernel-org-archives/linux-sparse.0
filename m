From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 4/6] build: drop -g from LDFLAGS
Date: Fri, 6 Oct 2017 12:14:38 -0700
Message-ID: <CANeU7QmRedShU-++=NORJBm+rPetnQFfeQ3-K5=dnXb4MMMkWQ@mail.gmail.com>
References: <20171004132605.24734-1-uwe@kleine-koenig.org> <20171004132605.24734-5-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:57063 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbdJFTOj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 6 Oct 2017 15:14:39 -0400
Received: by mail-qt0-f180.google.com with SMTP id 34so16201624qtb.13
        for <linux-sparse@vger.kernel.org>; Fri, 06 Oct 2017 12:14:39 -0700 (PDT)
In-Reply-To: <20171004132605.24734-5-uwe@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Oct 4, 2017 at 6:26 AM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.or=
g> wrote:
> -g is a compiler option that is ignored by the linker. So it should be
> included in CFLAGS (it already is) but not LDFLAGS.

Our linker "LD =3D gcc" so it might have impact on gcc as the finial
linking program?
I am actually not sure, I can be wrong.

Chris
