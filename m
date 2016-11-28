From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/6] storage should not be inherited by pointers
Date: Mon, 28 Nov 2016 09:04:56 +0800
Message-ID: <CANeU7QkyTrCLZHbeVt+VFPL__DGbhBtGpK0hPsuFsPrzKaFL-Q@mail.gmail.com>
References: <20161124170947.14379-1-luc.vanoostenryck@gmail.com>
 <20161124170947.14379-2-luc.vanoostenryck@gmail.com> <CANeU7QnGdG8x+1SzKP7e8f6Gan8VZh7MNMGpZ=E3JwSQ2xYkAw@mail.gmail.com>
 <20161125033817.GA14283@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:33516 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753096AbcK1BE6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 27 Nov 2016 20:04:58 -0500
Received: by mail-io0-f194.google.com with SMTP id j92so19797663ioi.0
        for <linux-sparse@vger.kernel.org>; Sun, 27 Nov 2016 17:04:58 -0800 (PST)
In-Reply-To: <20161125033817.GA14283@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Nov 25, 2016 at 11:38 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> I'm not sure we're talking about the same thing.
> The patch doesn't touch to anything related to address space
> which have to be inherited by the '&/adressof' operator.
> The patch only concern what must be done with MOD_STATIC,
> MOD_EXTERN & MOD_TOPLEVEL when we're taking the address of an object.
> This is certainly one point where taking the address of an object
> and then later dereferencing the pointer is *not* the same as using
> directly the object, it deosn't matter anymore if the object was
> static.

Sorry I jump the conclusion. If it is only concern with MOD_STATIC,
 MOD_EXTERN & MOD_TOPLEVEL, that is not a bug issue at all.
I thought you are going to extend that logic to other modifier bits as well.

Chris
