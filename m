From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse: add nocapture as an ignored attribute
Date: Thu, 9 Feb 2017 07:00:02 +0800
Message-ID: <CANeU7QnKz276LaompJ97jLggRhkPGGDN6hYuWo+HOnt5F5TQ1w@mail.gmail.com>
References: <96833.1486594318@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:32770 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752425AbdBHXaS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Feb 2017 18:30:18 -0500
Received: by mail-io0-f176.google.com with SMTP id v96so3919476ioi.0
        for <linux-sparse@vger.kernel.org>; Wed, 08 Feb 2017 15:30:13 -0800 (PST)
In-Reply-To: <96833.1486594318@turing-police.cc.vt.edu>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Feb 9, 2017 at 6:51 AM,  <valdis.kletnieks@vt.edu> wrote:
> commit 4397a428cbcd67e418b1d1fee8442c8b192994c9
> Author: Emese Revfy <re.emese@gmail.com>
> Date:   Tue Jul 26 22:40:37 2016 +0200
>
>     gcc-plugins: Add the initify gcc plugin
>
> This adds a new attribute 'nocapture'.  Tell sparse about it.
>
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

Can you add some test case how the nocapture attribute
was used in your source code?

Thanks

Chris
