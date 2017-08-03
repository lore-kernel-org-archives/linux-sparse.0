From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: ptrlist-iterator performance on one wine source file
Date: Fri, 4 Aug 2017 00:29:45 +0200
Message-ID: <20170803222942.itqxfz2mgdpmrisl@ltop.local>
References: <CANeU7Qne+bdhtzrVCi-qihDt9kyJ8wN6i3XTixYJNX5yFmiBpA@mail.gmail.com>
 <20170730151254.xlnz7c4zphhnhump@ltop.local>
 <CANeU7Q=5SycRKw4Z1NXHPuza_UbUjSF=E9wy6Ko6UEzSHPO2ng@mail.gmail.com>
 <CAMHZB6Emib_U7AtDLZ5Wc6KGXtZzMwhbT-N+sk-B05PUVbtfNg@mail.gmail.com>
 <20170801203357.4ywboptvr6tlytab@ltop.local>
 <CANeU7QkShNBJ2nWh0wvTN3fTvwX710BT-g=aFf+GS1upnD_Gxw@mail.gmail.com>
 <CAExDi1R9QZJorwhMq4=nRLvMet+S0RCpeiMurko=rNYLpu8c2A@mail.gmail.com>
 <CANeU7QmzundH7qpdYhQqDJgBv+5pPemwft+1uH5oVQ1POnoQDw@mail.gmail.com>
 <CAMHZB6E0NYy_bNJftB5n4BFZ4-fNf___n0RN1OPb+jkV4Ry-Dw@mail.gmail.com>
 <20170803214906.dvvyibtf53j3ah6m@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38502 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751736AbdHCW3u (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 3 Aug 2017 18:29:50 -0400
Received: by mail-wm0-f53.google.com with SMTP id m85so6426175wma.1
        for <linux-sparse@vger.kernel.org>; Thu, 03 Aug 2017 15:29:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170803214906.dvvyibtf53j3ah6m@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Thu, Aug 03, 2017 at 11:49:08PM +0200, Luc Van Oostenryck wrote:
> 2) I don't think that the lack of static evaluation of strlen("wine") or
>    "wine"[0] is a problem here because where present this code is preceded
>    by a test __builtin_constant_p(winetest_platform) wich fail.
>    All this code is then quickly optimized away (but have first been
>    generated as linearized code).

There is a big problem here as __builtin_constant_p() is not expanded.

Investigating.

-- Luc
