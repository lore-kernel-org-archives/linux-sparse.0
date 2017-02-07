From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/3] diagnose unknown escapes after preprocessing
Date: Wed, 8 Feb 2017 02:50:55 +0800
Message-ID: <CANeU7QkGZifRpbdwtJ8eNSOmPgjBfv5G6ZX-suMFph8QZjQeyg@mail.gmail.com>
References: <20170207174507.22722-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:33006 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753893AbdBGS54 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 13:57:56 -0500
Received: by mail-io0-f196.google.com with SMTP id 101so13744614iom.0
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 10:57:56 -0800 (PST)
In-Reply-To: <20170207174507.22722-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Al Viro <viro@zeniv.linux.org.uk>

On Wed, Feb 8, 2017 at 1:45 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> This series aims to solve the wrong warning recently
> received when using sparse on Linux's kernel for arm64.
> It quite straightforwardly move the diagnostic of
> unknown escape sequence together with escape conversion,
> after preprocessing.
>
> Patch 1 is just a test case (and could be folded with patch 2)
> Patch 2 is the fix in itself
> Patch 3 remove potential cruft left by patch 2.

Looks great.

I already apply and push to sparse-next.

Chris
