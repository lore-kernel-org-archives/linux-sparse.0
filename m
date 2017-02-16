From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] simplify float-to-float casts that doesn't change size
Date: Thu, 16 Feb 2017 20:41:17 +0800
Message-ID: <CANeU7Qm_+QE4_RDMGEBfCqdsuEdeJGdbneeL=-HC-Dp1Hjx85Q@mail.gmail.com>
References: <20170216025831.25449-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:37793 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753285AbdBPMlT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Feb 2017 07:41:19 -0500
Received: by mail-it0-f41.google.com with SMTP id x75so22735370itb.0
        for <linux-sparse@vger.kernel.org>; Thu, 16 Feb 2017 04:41:18 -0800 (PST)
In-Reply-To: <20170216025831.25449-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Feb 16, 2017 at 10:58 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> ---
>  simplify.c                    |  2 ++
>  validation/optim/fpcast-nop.c | 15 +++++++++++++++
>  2 files changed, 17 insertions(+)
>  create mode 100644 validation/optim/fpcast-nop.c
>

Can you add a SOB line?

Thanks

Chris
