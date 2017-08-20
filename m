From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH] fix expansion of constant bitfield dereference
Date: Sun, 20 Aug 2017 23:19:15 +0100
Message-ID: <CACXZuxdCqhukBxvtPej_Yao6JM0bEPg95JQzxab5fgk2CmiQPA@mail.gmail.com>
References: <20170820221602.27852-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:34733 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753334AbdHTWTR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Aug 2017 18:19:17 -0400
Received: by mail-ua0-f181.google.com with SMTP id i3so21004541uad.1
        for <linux-sparse@vger.kernel.org>; Sun, 20 Aug 2017 15:19:16 -0700 (PDT)
In-Reply-To: <20170820221602.27852-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 20 August 2017 at 23:16, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> During the expansion of a dereference, it's if the initializer
> which corrrespond to the offset we're interested is a constant.
> In which case this dereference can be avoided and the value
> given in the initializer can be used instead.
>
> However, it's not enough to check for the offset since for bitfields
> several are placed at the same offset.
> Currently, the first initializer matching the offset is selected.
>
> Fix this by refusing such expansion if the constant value correspond
> to a bitfield.
>

Thanks very much for the fix!

Regards
Dibyendu
