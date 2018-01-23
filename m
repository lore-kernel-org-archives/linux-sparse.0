From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] doc: fix manpage formatting
Date: Tue, 23 Jan 2018 03:03:01 -0800
Message-ID: <CANeU7QmhApyECXRr0mmWEOH4q+NmEDrVYNxps5uKYMN2mXkS_A@mail.gmail.com>
References: <20180121044644.90500-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:46780 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbeAWLDD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 23 Jan 2018 06:03:03 -0500
Received: by mail-qt0-f177.google.com with SMTP id o35so117295qtj.13
        for <linux-sparse@vger.kernel.org>; Tue, 23 Jan 2018 03:03:02 -0800 (PST)
In-Reply-To: <20180121044644.90500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Jan 20, 2018 at 8:46 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> A '.TP' was missing when describing '-fmem-report'.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

I get some conflict when I apply this one on master.
May be it is relate to the other document patches recently applied.

Chris
