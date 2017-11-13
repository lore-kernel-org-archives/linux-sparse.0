From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH 0/2] V2 llvm constant value pseudo size fix
Date: Mon, 13 Nov 2017 20:31:31 +0000
Message-ID: <CACXZuxcAp_YEVwpi=9f7n_srWM8VRauaRBfFfxrryNfjj=s30w@mail.gmail.com>
References: <CANeU7QknH=xpuButjBpVved131s8Kw4AJRZZGTBDLN+LBH_H9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:54306 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755170AbdKMUbd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Nov 2017 15:31:33 -0500
Received: by mail-ua0-f173.google.com with SMTP id j14so12315702uag.11
        for <linux-sparse@vger.kernel.org>; Mon, 13 Nov 2017 12:31:32 -0800 (PST)
In-Reply-To: <CANeU7QknH=xpuButjBpVved131s8Kw4AJRZZGTBDLN+LBH_H9A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

On 13 November 2017 at 15:27, Christopher Li <sparse@chrisli.org> wrote:
> I add the second patch to allow sparse-llvm to use
> the new size store in constant value pseudo.
>
> The whole series is very simple, only two patches.
> It directly address the problem of sparse-llvm wasn't
> able to get the integer size from constant value pseudo.
>
> Dibyendu, can you give this series some test since you report
> it?
>

I am happy to test but it might take a week or two, due to other commitments.

Regards
Dibyendu
