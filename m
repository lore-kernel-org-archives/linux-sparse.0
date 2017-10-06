From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/6] build: put comment about local.mk to the place where
 it is included
Date: Fri, 6 Oct 2017 12:04:36 -0700
Message-ID: <CANeU7Qn4TB-xEzQyYaT6yd2K-ge_dvoOL04A_jwUkZwWn-Dppg@mail.gmail.com>
References: <20171004132605.24734-1-uwe@kleine-koenig.org> <20171004132605.24734-3-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:49976 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751759AbdJFTEh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 6 Oct 2017 15:04:37 -0400
Received: by mail-qt0-f177.google.com with SMTP id o3so33256734qte.6
        for <linux-sparse@vger.kernel.org>; Fri, 06 Oct 2017 12:04:36 -0700 (PDT)
In-Reply-To: <20171004132605.24734-3-uwe@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Oct 4, 2017 at 6:26 AM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.or=
g> wrote:
>
>  # Allow users to override build settings without dirtying their trees
> +# For debugging, put this in local.mk:
> +#
> +#     CFLAGS +=3D -O0 -DDEBUG -g3 -gdwarf-2
> +#
>  -include local.mk

This and the first patch is fine. Subject to impact of the
debug-target-v3 branch.

Chris
