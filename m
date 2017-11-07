From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 2/2] builtin: make builtins more builtin
Date: Tue, 7 Nov 2017 09:22:08 +0100
Message-ID: <CAMHZB6FCx_gpEJDj3Q-kdTG8L89PsOxjYB+S7FaBQ_y9Ek41=A@mail.gmail.com>
References: <20171106201628.98470-1-luc.vanoostenryck@gmail.com>
 <20171106201628.98470-3-luc.vanoostenryck@gmail.com> <CANeU7Qn+gSxPy+RMGGTJ4rmhwZyMLkzpGQt2-G+jYNtgRCd4qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:48321 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933148AbdKGIWJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Nov 2017 03:22:09 -0500
Received: by mail-vk0-f47.google.com with SMTP id y196so3937197vkc.5
        for <linux-sparse@vger.kernel.org>; Tue, 07 Nov 2017 00:22:08 -0800 (PST)
In-Reply-To: <CANeU7Qn+gSxPy+RMGGTJ4rmhwZyMLkzpGQt2-G+jYNtgRCd4qw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Nov 7, 2017 at 2:38 AM, Christopher Li <sparse@chrisli.org> wrote:
>
> Hi Luc,
>
> I like the direction this patch is heading.
>
> I think you can change the  declare_builtin to be driven by table (C
> structure array).
> Rather than explicit function call. That will both save code do you
> don't need to deal with
> the variance part.

Using a table is certainly the usual way of doing this sort of things
but here, given that we can have between 0 & 6 arguments, it's
much less useful.
But I'm ready to change my mind if someone can give me numbers
showing a significant gain in speed or size if a table is used.

Regards,
-- Luc
