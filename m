From: Christopher Li <sparse@chrisli.org>
Subject: Re: ptrlist-iterator performance on one wine source file
Date: Tue, 1 Aug 2017 19:37:15 -0400
Message-ID: <CANeU7Qmxc6GR9wReqa-K0YwKXwX1qAxy8A7MMe+G3BxD-at6ZQ@mail.gmail.com>
References: <CANeU7QnGxae2dw_vU306nc+iUR2CuGczjDjp2fUYB5yPzye22w@mail.gmail.com>
 <CAExDi1Tkws5eRO1APi6tOdhGTzvaCpuHQ8k9h+T7odD5Yx3W3Q@mail.gmail.com>
 <CANeU7QnHbCmpTmD7ckokE7XezHB6-ZAFzX-h+J8cPe=wWxx3VA@mail.gmail.com>
 <CAMHZB6FjKnPojtirh0csQMXhZC-TT=hHRPne+z7q74joDHYdbg@mail.gmail.com>
 <CANeU7QnRQG84w+e-gTjp2yOZYdwq+itgExg_UTG-zUuRT8FYLg@mail.gmail.com>
 <CAMHZB6E8PwoeofUFRB_zdVx=HqqHM72UhcqwH1QPDa_U+4V-DQ@mail.gmail.com>
 <CANeU7Qne+bdhtzrVCi-qihDt9kyJ8wN6i3XTixYJNX5yFmiBpA@mail.gmail.com>
 <20170730151254.xlnz7c4zphhnhump@ltop.local> <CANeU7Q=5SycRKw4Z1NXHPuza_UbUjSF=E9wy6Ko6UEzSHPO2ng@mail.gmail.com>
 <CAMHZB6Emib_U7AtDLZ5Wc6KGXtZzMwhbT-N+sk-B05PUVbtfNg@mail.gmail.com>
 <20170801203357.4ywboptvr6tlytab@ltop.local> <CANeU7QkShNBJ2nWh0wvTN3fTvwX710BT-g=aFf+GS1upnD_Gxw@mail.gmail.com>
 <CAExDi1R9QZJorwhMq4=nRLvMet+S0RCpeiMurko=rNYLpu8c2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35248 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdHAXhQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 1 Aug 2017 19:37:16 -0400
Received: by mail-pg0-f49.google.com with SMTP id v189so13837936pgd.2
        for <linux-sparse@vger.kernel.org>; Tue, 01 Aug 2017 16:37:16 -0700 (PDT)
In-Reply-To: <CAExDi1R9QZJorwhMq4=nRLvMet+S0RCpeiMurko=rNYLpu8c2A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Tue, Aug 1, 2017 at 5:46 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Here, both give essentially the same time.
> Which is quite normal as none of the 'additional' options
> should make any difference in how sparse is processing
> things: it's just some more flags for warnings and none of
> -fPIC -pipe -fno-strict-aliasing -gdwarf-2 -gstrict-dwarf -g
> has any effects for sparse and the only effect of -O2 is
> to define __OPTIMIZE__.

So you can't reproduce it. Let me dig deeper to see what is going on.

Chris
