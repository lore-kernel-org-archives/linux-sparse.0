From: Chris Li <christ.li@gmail.com>
Subject: Re: [PATCH] cgcc: teach cgcc about GNU/kFreeBSD
Date: Wed, 20 Sep 2017 00:45:51 -0400
Message-ID: <CANeU7Q=TMSjqUkVsA05NQvpyQpUwhYsFqXRCUbkn1+aMqJe=Sg@mail.gmail.com>
References: <20170914200327.15129-1-uwe@kleine-koenig.org> <CANeU7QndhpsDA5YzVzPBvoKNrYuHutJeYF9A=+Dyx=sJ_fi+OQ@mail.gmail.com>
 <a8abb58e-e95c-0d76-3b2c-8786a3325c9e@kleine-koenig.org> <CANeU7Q=S6OENzU_ogLGY0uPUT5E6SvGK1KLmKc37+7CKXV_ogw@mail.gmail.com>
 <b580c0f7-716d-17b0-7e2b-410530c4a0cf@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:55437 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751650AbdITEpw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 20 Sep 2017 00:45:52 -0400
Received: by mail-yw0-f171.google.com with SMTP id o143so1120156ywd.12
        for <linux-sparse@vger.kernel.org>; Tue, 19 Sep 2017 21:45:52 -0700 (PDT)
In-Reply-To: <b580c0f7-716d-17b0-7e2b-410530c4a0cf@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Sep 19, 2017 at 1:33 PM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.o=
rg> wrote:
>> It did in sparse Documentation/submitting-patches.md.
>
> ah, I missed that. (I wonder if it is sensible to just link to the
> respective kernel stuff instead of copying that verbatim into sparse,
> but I don't really care.)

Maybe. The kernel is GPL and sparse is MIT licensed.
If I copy the text, I need to make special case for the license of
that document under GPL. It is doable that way as well.
I just take the lazy route link to the kernel documents.

> I can resend accordingly

Send just the SOB line is good enough. You don't have to
re-create the patch.

Chris
