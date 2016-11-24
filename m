From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] add test case for builtin bswap with constant args
Date: Thu, 24 Nov 2016 08:17:52 +0800
Message-ID: <CANeU7Qkb_MPsvqDkkUxFmUu5Yh6WiSh7U+BT59YRmhVKzT+JMw@mail.gmail.com>
References: <CANeU7QkABOFTdUCdabWL1YwHb3Qf4huVL115AHqZBNcqUytmhg@mail.gmail.com>
 <20161123203855.14957-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:35344 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933573AbcKXARx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Nov 2016 19:17:53 -0500
Received: by mail-io0-f195.google.com with SMTP id h133so3404687ioe.2
        for <linux-sparse@vger.kernel.org>; Wed, 23 Nov 2016 16:17:53 -0800 (PST)
In-Reply-To: <20161123203855.14957-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Nov 24, 2016 at 4:38 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> ---
>  validation/builtin-constant-eval.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 validation/builtin-constant-eval.c

Looks good to me. Will apply.

Thanks for the patch.

Chris
