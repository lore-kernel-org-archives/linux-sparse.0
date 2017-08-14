From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/3] assorted LLVM fixes
Date: Mon, 14 Aug 2017 16:21:50 -0400
Message-ID: <CANeU7Qmbs9FZqw1ZNRY7=ZyDjuL3OWMMyjeO_cUBRzpb-=wBbA@mail.gmail.com>
References: <20170814194152.36289-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:34688 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751098AbdHNUVv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Aug 2017 16:21:51 -0400
Received: by mail-yw0-f176.google.com with SMTP id s143so61595379ywg.1
        for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2017 13:21:51 -0700 (PDT)
In-Reply-To: <20170814194152.36289-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Mon, Aug 14, 2017 at 3:41 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> This series contains two fixes for sparse-llvm.
> It is supposed to be applied on top of all others
> LLVM fixes.
>

I think we are going to have the finial release of 0.5.1 this
Wednesday if no show stoppers.

Can you resend your other LLVM fixes (this patches are depend
on) after the release? I can even have a temporary branch
to merge those right now.

We can do a quick fix up of 0.5.2 the problem we know so
far.

Make it reasonable stable and cut another release.

Chris
