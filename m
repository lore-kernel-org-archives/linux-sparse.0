From: Chris Li <christ.li@gmail.com>
Subject: Re: [PATCH] cgcc: teach cgcc about GNU/kFreeBSD
Date: Tue, 19 Sep 2017 08:25:56 -0400
Message-ID: <CANeU7QndhpsDA5YzVzPBvoKNrYuHutJeYF9A=+Dyx=sJ_fi+OQ@mail.gmail.com>
References: <20170914200327.15129-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33888 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbdISMZ5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 19 Sep 2017 08:25:57 -0400
Received: by mail-yw0-f196.google.com with SMTP id v72so1659143ywa.1
        for <linux-sparse@vger.kernel.org>; Tue, 19 Sep 2017 05:25:57 -0700 (PDT)
In-Reply-To: <20170914200327.15129-1-uwe@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Sep 14, 2017 at 4:03 PM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.o=
rg> wrote:
> ---
>  cgcc | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/cgcc b/cgcc
> index a8d7b4f217fe..0ab54f943578 100755
> --- a/cgcc
> +++ b/cgcc
> @@ -235,6 +235,9 @@ sub add_specs {
>      } elsif ($spec eq 'linux') {
>         return &add_specs ('unix') .
>             ' -D__linux__=3D1 -D__linux=3D1 -Dlinux=3Dlinux';
> +    } elsif ($spec eq 'gnu/kfreebsd') {
> +       return &add_specs ('unix') .
> +           ' -D__FreeBSD_kernel__=3D1'

Catching up my back logs. I just find out that this patch
is missing a SOB. Send you send one to the mailing list?

Thanks

Chris
