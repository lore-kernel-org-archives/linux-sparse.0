From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm issue with handling of phisrc instruction
Date: Wed, 22 Mar 2017 20:33:24 +0000
Message-ID: <CACXZuxeKH+3PG8UsYREgDzRWc2JAPf2yrgVh=xsTgvJBfW14tA@mail.gmail.com>
References: <CACXZuxdzxg_+rXu-OEUe+CwbbW+C-0CHZ=1wRrGa1ysptGDozA@mail.gmail.com>
 <CAExDi1RkSpRpSdm9i8ADSOkrQdVBMHNb=K5b+he4Gy4MMjD9wg@mail.gmail.com>
 <CACXZuxecFEoQPsUcbq8Oujvt5OYiscqcuYeMwQc5fv1ehPuAgA@mail.gmail.com>
 <CAExDi1Q_FMB+W_0-vscA6KWSPs4nZ4Dzmb42DrSrzFJ3Y5MiKw@mail.gmail.com>
 <CACXZuxfrMKckUhy9+kWGeBZt2dWiFqmXEvgJgCV7xmWej3A_Fw@mail.gmail.com>
 <20170322192929.waqifaco6wtm7wue@macpro.local> <CACXZuxeo24ABdTRgm_VR1UOvbGZ8-9rCpmDtLD8yqPNLeA1suw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:36396 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753948AbdCVUd0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Mar 2017 16:33:26 -0400
Received: by mail-io0-f173.google.com with SMTP id l7so71383063ioe.3
        for <linux-sparse@vger.kernel.org>; Wed, 22 Mar 2017 13:33:25 -0700 (PDT)
In-Reply-To: <CACXZuxeo24ABdTRgm_VR1UOvbGZ8-9rCpmDtLD8yqPNLeA1suw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 22 March 2017 at 19:46, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
>
> You were right - I needed to retain following line:
>
> track_pseudo_death(C, ep);
>
> Anyway it appears that this now populates the phi_users list so that
> the code works correctly.
>

Of course now I can see the following in sparse-llvm:

/* need ->phi_users */
dbg_dead = 1;

Regards
Dibyendu
