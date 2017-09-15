From: Chris Li <christ.li@gmail.com>
Subject: Re: [PATCH] cgcc: teach cgcc about GNU/kFreeBSD
Date: Fri, 15 Sep 2017 12:56:12 -0400
Message-ID: <CANeU7QkUorcf-ADV+hKGBBkGpssL==tFtajikVDxug_Z4ffYNg@mail.gmail.com>
References: <20170914200327.15129-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:48620 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbdIOQ4O (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 12:56:14 -0400
Received: by mail-yw0-f181.google.com with SMTP id v137so1792174ywg.5
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 09:56:13 -0700 (PDT)
In-Reply-To: <20170914200327.15129-1-uwe@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Sep 14, 2017 at 4:03 PM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.o=
rg> wrote:
> +    } elsif ($spec eq 'gnu/kfreebsd') {
> +       return &add_specs ('unix') .
> +           ' -D__FreeBSD_kernel__=3D1'

This looks good. I will apply it.
I don't have FreeBSD to test it though. I assume you do
the sufficient testing on it already. It can't be any worse any way.

Thanks for the patch.

Chris
