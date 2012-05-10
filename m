From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Updated __nocast vs __bitwise documentation
Date: Thu, 10 May 2012 04:42:22 -0700
Message-ID: <CANeU7QnN7PLpuSQF-v_NHeh_ZaJuwpoi30K-od+WXmgaGqCt0A@mail.gmail.com>
References: <CABG-yt2XiduTbyN+tm++Fw1_s9_QvjFy60=5a--tScMwDT443A@mail.gmail.com>
	<CANeU7QkQtZ9x8xQFWDVPu2tCizWrvmF8EhZE84d6Nok58tnWCQ@mail.gmail.com>
	<CABG-yt2yVwF76vHitm-KzKLV4kQ205hEMTCeRcsJF9-doWvW6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38184 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938Ab2EJLmX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 10 May 2012 07:42:23 -0400
Received: by yenm10 with SMTP id m10so1341395yen.19
        for <linux-sparse@vger.kernel.org>; Thu, 10 May 2012 04:42:22 -0700 (PDT)
In-Reply-To: <CABG-yt2yVwF76vHitm-KzKLV4kQ205hEMTCeRcsJF9-doWvW6w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Shakthi Kannan <shakthimaan@gmail.com>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, May 10, 2012 at 4:06 AM, Shakthi Kannan <shakthimaan@gmail.com> wrote:
> Hi Chris:
>
> --- On Thu, May 10, 2012 at 4:20 PM, Christopher Li <sparse@chrisli.org> wrote:
> | Looks good. Thanks for doing that.
> |
> | Can you add some reference (in sparse.txt) to the original Linus email
> | where some
> | of this document is base on? Just to give credit where it is due. A
> link to the
> | Linus original email would be perfect.
> \--
>
> Is the following reference sufficient if added to the sparse.txt file?
>
> === sparse.txt ===
>
> Sparse
> ~~~~~
>
> Copyright (C) 2012 Linus Torvalds

CCing Linus,

Not sure about the rules of quoting other people's email.
Does it need the full copyright notice?

I would just add these two lines to the end of the sparse.txt

Reference:
 * Linus' email about __nocast vs __bitwise: https://lkml.org/lkml/2012/3/22/409

Chris
