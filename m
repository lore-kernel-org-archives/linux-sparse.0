From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/5] simplify '(x / 1)' to 'x'
Date: Wed, 8 Feb 2017 02:29:09 +0800
Message-ID: <CANeU7QkOmqZH-X4C3Ma6b94jyx1LnjM=UEH2CjEt0SwgZ4Y2Kw@mail.gmail.com>
References: <20161207154655.98109-1-luc.vanoostenryck@gmail.com>
 <20161207154655.98109-3-luc.vanoostenryck@gmail.com> <CANeU7QmSHZf9p+0riTgtMFtSuopkHgmcwG_t1izjwg5sDa1B6g@mail.gmail.com>
 <20170207145226.vnxmuyk3rwbpqcse@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:36080 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754490AbdBGS3K (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 13:29:10 -0500
Received: by mail-io0-f182.google.com with SMTP id j13so96873539iod.3
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 10:29:10 -0800 (PST)
In-Reply-To: <20170207145226.vnxmuyk3rwbpqcse@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Feb 7, 2017 at 10:52 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Mmmh yes. In fact here these 4 lines are not needed at all.
> It's most probably leftover of some code restructuration.
>
> Do you want that I send a new version of this patch?

If you have a new version of this patch or series. I am happy to replace
the old version and apply the new one. I can rebase sparse-next.

Chris
