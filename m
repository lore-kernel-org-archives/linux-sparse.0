From: Christopher Li <sparse@chrisli.org>
Subject: Re: make selfcheck
Date: Mon, 17 Jul 2017 15:16:51 -0400
Message-ID: <CANeU7QmRaS8C8AyvtduDccK_w9pOjqppbMDoEDtyNH0OnN6ikw@mail.gmail.com>
References: <d5ab8af1-6a09-9985-7de1-8ad639369795@ramsayjones.plus.com> <39e3d856-fd32-8059-10bb-ad1367e7d7a9@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33927 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbdGQTQw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 17 Jul 2017 15:16:52 -0400
Received: by mail-pf0-f180.google.com with SMTP id q85so80876556pfq.1
        for <linux-sparse@vger.kernel.org>; Mon, 17 Jul 2017 12:16:52 -0700 (PDT)
In-Reply-To: <39e3d856-fd32-8059-10bb-ad1367e7d7a9@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, Jul 17, 2017 at 2:19 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> This should have been './cgcc -no-compile', of course. :(
>
Yes, of course. I discover that myself too. I am sending out a V2
version of the patches.
In the V2 version I move the checker command to be controlled by "$(CHECKER)".
For example I can change CHECKER to test-linearize and get the full
byte code output.

BTW, are you OK I merge your change with mine in the V2 patches?

Chris
