From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH 1/2] V2 Give the constant pseudo value a size
Date: Sun, 24 Dec 2017 13:10:34 +0000
Message-ID: <CACXZuxdHeCqQ5x7i2a6ZTHAFSMJWHm3Myyq3TkP6Wj5Ca6bcVQ@mail.gmail.com>
References: <CANeU7Q=VPubjUkjWP20Ye8rA8d42OfVD=xM1U-quVqGK4kQb+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:35269 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751570AbdLXNKf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 24 Dec 2017 08:10:35 -0500
Received: by mail-ua0-f196.google.com with SMTP id g16so7654136uak.2
        for <linux-sparse@vger.kernel.org>; Sun, 24 Dec 2017 05:10:34 -0800 (PST)
In-Reply-To: <CANeU7Q=VPubjUkjWP20Ye8rA8d42OfVD=xM1U-quVqGK4kQb+g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

On 13 November 2017 at 15:28, Christopher Li <sparse@chrisli.org> wrote:
> Currently value pseudo does not have size.
> This create a problem pointed out by Dibyendu.
> When using LLVM, calling varidic function with
> constant value, there is no where to find the
> size.
>
> Linus give out two suggestions. One is give pseudo
> a size. The other one is the push instruction.
> This is the implementation of the first suggestion.

I tested out this change in my code base and it seems fine. I hope this helps.

Thanks and Regards
Dibyendu
