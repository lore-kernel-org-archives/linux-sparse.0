From: Christopher Li <sparse@chrisli.org>
Subject: Re: SSSA and some C pointer manipulation.
Date: Sun, 20 Aug 2017 23:41:29 -0400
Message-ID: <CANeU7QmhVyO9oACn=P-EAtj73Gp_J0f2NjMKbpmNpBka4JtzVQ@mail.gmail.com>
References: <CANeU7Qm-k0xzRXwVx0bSg688+yFTa_PrC7EnKdyJY8HCWZT-uw@mail.gmail.com>
 <CAExDi1Tgs7UpXm0OCwLbLDVfZsAHQx2z-ygWEQ1fUnWVU1aNXg@mail.gmail.com> <CANeU7QmSDAAr+mgs+GC58Hb3kB=jx1p3m9Df3cmR4KfjQgoq8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:35892 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbdHUDla (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Aug 2017 23:41:30 -0400
Received: by mail-yw0-f175.google.com with SMTP id y64so133074ywf.3
        for <linux-sparse@vger.kernel.org>; Sun, 20 Aug 2017 20:41:30 -0700 (PDT)
In-Reply-To: <CANeU7QmSDAAr+mgs+GC58Hb3kB=jx1p3m9Df3cmR4KfjQgoq8g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 20, 2017 at 11:29 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Sun, Aug 20, 2017 at 12:18 PM, Luc Van Oostenryck

>     again SSSA. We can turn SSSA off and let the alternative
>     SSA conversion do all the work. And see how well it perform.
>     This option can be on by default.

Sorry I mean we can leave the SSSA method on by default.

Chris
