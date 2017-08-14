From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Mon, 14 Aug 2017 20:51:19 +0200
Message-ID: <CAExDi1T8_fuzv6QMBCiDvrFWbhGMUJYdr2DEpdCTWEQhWJHqng@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
 <CANeU7QmkJjxr_AmBTrDhVz6VP3oZcs-8xAL3kXegrWozqkvZGA@mail.gmail.com>
 <CACXZuxfaPNCWx1+Oy08ZqfRY+eNtZ5rWpLjyHaXnK3kuvur3LQ@mail.gmail.com>
 <CAExDi1R1mQvth6OcWBZP-ur_xLfPztfaAtZWW0U8Sz=QSuW1Rw@mail.gmail.com>
 <CACXZuxfitdon6pOKxwNH2uSv2CR_-4UxzfbgsJx0TqwkP=VgPA@mail.gmail.com>
 <CAExDi1Qh_T89GkTAXtS9ZXiAk9J0Y-b7ohwCjg=K3FPX4qjQOw@mail.gmail.com>
 <CACXZuxfsJLe0uG9aXNSiKgZofYVGf_kYmFhn6Vj5bBT56xnwgw@mail.gmail.com>
 <CAExDi1Qovq8gAXw8d7cSt73Gz+y8_3cH+yc40TaPudY_QNqPVQ@mail.gmail.com>
 <CACXZuxf4T1u1=3pE52V2smtqS_61XSx6Ed7aWXPgRK+3FtDnvw@mail.gmail.com>
 <CAExDi1Qf85VY8ovn2uRoo6Qivwa0G5L529feuCzHt3FJOBEAog@mail.gmail.com> <CACXZuxfhQAUuzcZEm+eYQAuSMnouposoV0WRXsUH4hkcf2ODWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34248 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751603AbdHNSvU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Aug 2017 14:51:20 -0400
Received: by mail-oi0-f67.google.com with SMTP id v11so10109195oif.1
        for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2017 11:51:20 -0700 (PDT)
In-Reply-To: <CACXZuxfhQAUuzcZEm+eYQAuSMnouposoV0WRXsUH4hkcf2ODWA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

On Mon, Aug 14, 2017 at 6:54 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> I would rather just have the SSA construction bits first, without too
> many other changes.

I know and it's why I made the sssa-mini but it contains just that:
only the minimal changes needed for the SSA construction on top
of the current master.

But at least you know what can be done with these fixes and
where you can find them.

-- Luc
