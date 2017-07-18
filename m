From: Christopher Li <sparse@chrisli.org>
Subject: Re: make selfcheck
Date: Tue, 18 Jul 2017 08:53:01 -0400
Message-ID: <CANeU7Q=7=w6WhCkg=KNfLOy5HMGizgO46zh+M_D6mK8AOASnNg@mail.gmail.com>
References: <d5ab8af1-6a09-9985-7de1-8ad639369795@ramsayjones.plus.com>
 <39e3d856-fd32-8059-10bb-ad1367e7d7a9@ramsayjones.plus.com>
 <CANeU7QmRaS8C8AyvtduDccK_w9pOjqppbMDoEDtyNH0OnN6ikw@mail.gmail.com> <ae7e6285-eb5b-9137-fab4-0ecc502aab7a@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35460 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751371AbdGRMxC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 18 Jul 2017 08:53:02 -0400
Received: by mail-pg0-f66.google.com with SMTP id d193so2739575pgc.2
        for <linux-sparse@vger.kernel.org>; Tue, 18 Jul 2017 05:53:02 -0700 (PDT)
In-Reply-To: <ae7e6285-eb5b-9137-fab4-0ecc502aab7a@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, Jul 17, 2017 at 3:28 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> I nearly have a clean 'make selfcheck' (I suspect you do too!).
> I was supposed to have gone out a while ago, ... I guess I will
> not get it finished before I go. :(

I have send out a V2 version of the patch.

BTW, I think most of the macro define part of the cgcc should be move to sparse
as well. In the end, cgcc can be merge with sparse as one. I think
even with all those
macro used by user space program, it shouldn't impact the kernel compile, right?

Chris
