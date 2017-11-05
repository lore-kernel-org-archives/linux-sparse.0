From: Christopher Li <sparse@chrisli.org>
Subject: Re: multiarch & base dir
Date: Sun, 5 Nov 2017 17:59:04 +0800
Message-ID: <CANeU7QkaiPxUcw7g+jGdNY1JZd8=MuMa=k11kX7PKmBMzPaQGg@mail.gmail.com>
References: <20171105093301.adsucwshznehtdr4@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:45708 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752041AbdKEJ7F (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 04:59:05 -0500
Received: by mail-yw0-f193.google.com with SMTP id j4so5683171ywb.2
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 01:59:05 -0800 (PST)
In-Reply-To: <20171105093301.adsucwshznehtdr4@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Nov 5, 2017 at 5:33 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Commit 85e2e2a25 "Add support for multiarch system header files"
> added for GCC's multiarch directory. One of the change was :
> +       /* add the multiarch include directories, if any */
> +       if (multiarch_dir && *multiarch_dir) {
> +               add_pre_buffer("#add_system \"/usr/include/%s\"\n", multiarch_dir);
> +               add_pre_buffer("#add_system \"/usr/local/include/%s\"\n", multiarch_dir);
> +       }
>
>
> There, the multiarch dir is appended to /usr/include & /usr/local/include.
> I'm wondering if using GCC_BASE should be used here instead.
> Any thoughts?

I think the multiarch is for cross compile. I guess using GCC_BASE will not fit
the cross compile need. GCC_BASE has hard code to the current gcc that compile
sparse. Not necessary the same cross compile setting to run sparse.

I don't know, Ramsay might be able comment more on this.

Chris
