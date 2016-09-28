From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse: add 'alloc_align' to the ignored attributes
Date: Wed, 28 Sep 2016 15:10:17 -0700
Message-ID: <CANeU7QmX8+Ja62vp9DPQwqPGQqkmp0o38v+A1w6Rq6CaY-BPVQ@mail.gmail.com>
References: <574EF186.5030505@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:37531 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752781AbcI1WKT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 28 Sep 2016 18:10:19 -0400
Received: by mail-it0-f50.google.com with SMTP id j69so49145802itb.0
        for <linux-sparse@vger.kernel.org>; Wed, 28 Sep 2016 15:10:18 -0700 (PDT)
In-Reply-To: <574EF186.5030505@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Wed, Jun 1, 2016 at 7:30 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> Rui's recent patch prompted me to send this patch, which I have been
> running with for a while.

Sorry for the late reply. The patch looks good.

Can you add some test case for the alloc_align()? I want to see how
your source code use the attribute. Just in case we need to parse
the attribute properly.

Chris
