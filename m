From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/3] teach sparse about endianness
Date: Tue, 20 Jun 2017 21:13:02 -0700
Message-ID: <CANeU7QmUcoYB79m78Ey4K=0NUvDG=hoo9AiR1VJ6NK1kpQCdUA@mail.gmail.com>
References: <20170620201931.92864-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:37368 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbdFUENE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 21 Jun 2017 00:13:04 -0400
Received: by mail-it0-f48.google.com with SMTP id m47so24994075iti.0
        for <linux-sparse@vger.kernel.org>; Tue, 20 Jun 2017 21:13:03 -0700 (PDT)
In-Reply-To: <20170620201931.92864-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Jun 20, 2017 at 1:19 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The goal of this series is to let sparse correctly
> check macros, structures, ... endian-specific.
> This is done by:
> 1) the introduction of a pair of option flags:
>    -mbig-endian/-mlittle-endian
> 2) a set of predefined macros:
>    __{BIG,LITTLE}_ENDIAN__,
>    __ORDER_{BIG,LITTLE}_ENDIAN__ &
>    __BYTE_ORDER__

This series looks good to me.

Signed-off-By: <sparse@chrisli.org>

Chris
