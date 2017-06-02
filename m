From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/3] memcpy()'s byte count is unsigned
Date: Fri, 2 Jun 2017 03:17:31 +0200
Message-ID: <CAExDi1Tg3p=Gv=PZBXD1Tu104z=uBWDeTEdKr3fX_fojsLZvLw@mail.gmail.com>
References: <84e547c2-8a5b-225c-1363-361e091821f4@ramsayjones.plus.com>
 <20170601202724.77597-1-luc.vanoostenryck@gmail.com> <20170601202724.77597-2-luc.vanoostenryck@gmail.com>
 <18cc66e6-a4d8-2756-a356-a507b8a4bd14@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33519 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdFBBRn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Jun 2017 21:17:43 -0400
Received: by mail-qk0-f178.google.com with SMTP id y201so49917103qka.0
        for <linux-sparse@vger.kernel.org>; Thu, 01 Jun 2017 18:17:42 -0700 (PDT)
In-Reply-To: <18cc66e6-a4d8-2756-a356-a507b8a4bd14@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Chris Li <sparse@chrisli.org>, Junio C Hamano <gitster@pobox.com>

On Fri, Jun 2, 2017 at 2:16 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> Assuming all functions take a size_t parameter, looks good.

Even if they/some don't, it will be OK because it's how sparse
interpret the constant
that matter.

-- Luc
