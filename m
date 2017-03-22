From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm issue with handling of phisrc instruction
Date: Wed, 22 Mar 2017 22:38:16 +0100
Message-ID: <CAExDi1T0A-J7dqF5+qABJox2=Om3rXhOm_5T6P0yY8zUE9ymdQ@mail.gmail.com>
References: <CACXZuxdzxg_+rXu-OEUe+CwbbW+C-0CHZ=1wRrGa1ysptGDozA@mail.gmail.com>
 <CAExDi1RkSpRpSdm9i8ADSOkrQdVBMHNb=K5b+he4Gy4MMjD9wg@mail.gmail.com>
 <CACXZuxecFEoQPsUcbq8Oujvt5OYiscqcuYeMwQc5fv1ehPuAgA@mail.gmail.com>
 <CAExDi1Q_FMB+W_0-vscA6KWSPs4nZ4Dzmb42DrSrzFJ3Y5MiKw@mail.gmail.com>
 <CACXZuxfrMKckUhy9+kWGeBZt2dWiFqmXEvgJgCV7xmWej3A_Fw@mail.gmail.com>
 <CACXZuxfaQn+XApJpRY_63zf28VSeywj6R_kmy1sUHU3kEFpu-g@mail.gmail.com>
 <20170322204258.gpyewnksfccv5bta@macbook.local> <CACXZuxdTXz801Dy6QhQJ7gwKfi3B4MPWRAjmz579Qzs1JXA+Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33130 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbdCVVpe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Mar 2017 17:45:34 -0400
Received: by mail-qk0-f171.google.com with SMTP id y76so166400987qkb.0
        for <linux-sparse@vger.kernel.org>; Wed, 22 Mar 2017 14:45:33 -0700 (PDT)
In-Reply-To: <CACXZuxdTXz801Dy6QhQJ7gwKfi3B4MPWRAjmz579Qzs1JXA+Jg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Mar 22, 2017 at 9:48 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Luckily (or by design) the track_pseudo_death() is called right at the
> end after all the modifications are done. So I think it will always be
> correct as long as this is called.

It's very much by design, almost by necessity.

-- Luc
