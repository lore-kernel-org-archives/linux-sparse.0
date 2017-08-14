From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/3] assorted LLVM fixes
Date: Mon, 14 Aug 2017 22:29:26 +0200
Message-ID: <CAExDi1T6H4YA28DuPU3ic+qK1-nbP+UycQA+FqPG9XvMiQhhXQ@mail.gmail.com>
References: <20170814194152.36289-1-luc.vanoostenryck@gmail.com> <CANeU7Qmbs9FZqw1ZNRY7=ZyDjuL3OWMMyjeO_cUBRzpb-=wBbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35016 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbdHNU31 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Aug 2017 16:29:27 -0400
Received: by mail-oi0-f41.google.com with SMTP id e124so95086214oig.2
        for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2017 13:29:27 -0700 (PDT)
In-Reply-To: <CANeU7Qmbs9FZqw1ZNRY7=ZyDjuL3OWMMyjeO_cUBRzpb-=wBbA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Mon, Aug 14, 2017 at 10:21 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Mon, Aug 14, 2017 at 3:41 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> This series contains two fixes for sparse-llvm.
>> It is supposed to be applied on top of all others
>> LLVM fixes.
>
> Can you resend your other LLVM fixes (this patches are depend
> on) after the release? I can even have a temporary branch
> to merge those right now.

These patches were for Dibyendu as they are the last fixes
needed for the problmes he showed yesterday.

They make no sense to be applied alone. As written here above
they are "supposed to be applied on top of all others LLVM fixes".

-- Luc
