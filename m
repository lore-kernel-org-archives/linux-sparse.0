From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse: update __builtin_object_size() prototype
Date: Thu, 17 Nov 2016 06:52:51 +0800
Message-ID: <CANeU7Q=hA2T+dgdi7cz_RK1Xday0g5PWszZMoT_Dw0vx0K5CBQ@mail.gmail.com>
References: <1474467238-20939-1-git-send-email-lrichard@redhat.com> <20161107100934.GB443@macbook.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:35626 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936195AbcKPWww (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Nov 2016 17:52:52 -0500
Received: by mail-it0-f67.google.com with SMTP id b123so10530034itb.2
        for <linux-sparse@vger.kernel.org>; Wed, 16 Nov 2016 14:52:52 -0800 (PST)
In-Reply-To: <20161107100934.GB443@macbook.home>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Lance Richardson <lrichard@redhat.com>, Johannes Berg <johannes@sipsolutions.net>

On Mon, Nov 7, 2016 at 6:09 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Acked-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>
>
> Chris, can you please take this patch (or Johannes' one).
> When compiling the kernel, there is more than 2000 false warnings
> only for the uaccess.h case described here above.

Applied and pushed to "chrisl" repository.

Thanks

Chris
