From: Christopher Li <sparse@chrisli.org>
Subject: Re: MOD_TYPEDEF unused?
Date: Tue, 13 Jun 2017 15:55:22 -0700
Message-ID: <CANeU7QnKLFhYJFZ3bfsJ=kpvMOjoQXghv6EwoPksBZAVAoHvsQ@mail.gmail.com>
References: <CACXZuxcVHQrRNtKGS8mURVuHPUDhwsyF7AFnnvCBpbHb2AwQpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:34974 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752259AbdFMWzX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Jun 2017 18:55:23 -0400
Received: by mail-it0-f53.google.com with SMTP id m62so49914809itc.0
        for <linux-sparse@vger.kernel.org>; Tue, 13 Jun 2017 15:55:23 -0700 (PDT)
In-Reply-To: <CACXZuxcVHQrRNtKGS8mURVuHPUDhwsyF7AFnnvCBpbHb2AwQpQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Jun 13, 2017 at 3:01 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi,
>
> I was looking at the output of c2xml (actually modified version used
> in dmrC project) - and saw that typedefs are not marked in any way.
> Digging deeper I found that typedef symbols do not have the
> MOD_TYPEDEF set. MOD_USERTYPE is set though.
>
> Is there any harm in setting MOD_TYPEDEF also?

I take a look, nobody is actually using MOD_TYPEDEF any more.
It was used in the old code for parsing typedef types.

Of course there is no harm setting it, it might make more sense to
remove it.

Chris
