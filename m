From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/3] fix loading of partially defined bitfield
Date: Sun, 6 Aug 2017 21:59:56 -0400
Message-ID: <CANeU7Q=3k4yqMuzgjQPh+Hx_Erjggzv4=_92GMXCUbLW4uwvfg@mail.gmail.com>
References: <20170807013338.46211-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34669 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751411AbdHGB75 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 21:59:57 -0400
Received: by mail-pg0-f47.google.com with SMTP id u185so27997548pgb.1
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 18:59:57 -0700 (PDT)
In-Reply-To: <20170807013338.46211-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 6, 2017 at 9:33 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The goal of this series is to fix the problem present in sparse
> when a bitfield in an uninitialized automatic variable is first
> set then read-back.
>
> In this case the bitfield itself is initialized but not the
> remaining of the structure/word and sparse was not smart
> enough to handle it.
>
> This is for testing only and the patches are not meant to
> be applied on the main tree becasue it need the new SSA
> construction to handle the undefined vars correctly.
>
> (two other simplifications is also needed to make the
> generated code a no-op as it should be but not yet
> implemented).
>
> The whole code is available in the git repository at:
>
>   git://github.com/lucvoo/sparse.git fix-loading-partialy-defined-bitfields

Is this for RC5?

Chris
