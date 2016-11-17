From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] add missing #include "char.h" to char.c
Date: Thu, 17 Nov 2016 16:28:59 +0800
Message-ID: <CANeU7QmDCyaQbOha-RqxYf5EUAwjFCMDzktmr_m7bmcVC4TQww@mail.gmail.com>
References: <20161102171544.17783-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:33432 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbcKQI3B (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 03:29:01 -0500
Received: by mail-it0-f68.google.com with SMTP id c20so13554659itb.0
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 00:29:00 -0800 (PST)
In-Reply-To: <20161102171544.17783-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Nov 3, 2016 at 1:15 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> And so quiets a warning from sparse about undeclared
> symbols when running on its own code.

Applied.

Chris
