From: Shakthi Kannan <shakthimaan@gmail.com>
Subject: Re: [PATCH] Updated __nocast vs __bitwise documentation
Date: Thu, 10 May 2012 16:36:28 +0530
Message-ID: <CABG-yt2yVwF76vHitm-KzKLV4kQ205hEMTCeRcsJF9-doWvW6w@mail.gmail.com>
References: <CABG-yt2XiduTbyN+tm++Fw1_s9_QvjFy60=5a--tScMwDT443A@mail.gmail.com>
	<CANeU7QkQtZ9x8xQFWDVPu2tCizWrvmF8EhZE84d6Nok58tnWCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:50689 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200Ab2EJLG3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 10 May 2012 07:06:29 -0400
Received: by wgbdr13 with SMTP id dr13so1213543wgb.1
        for <linux-sparse@vger.kernel.org>; Thu, 10 May 2012 04:06:28 -0700 (PDT)
In-Reply-To: <CANeU7QkQtZ9x8xQFWDVPu2tCizWrvmF8EhZE84d6Nok58tnWCQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

Hi Chris:

--- On Thu, May 10, 2012 at 4:20 PM, Christopher Li <sparse@chrisli.org> wrote:
| Looks good. Thanks for doing that.
|
| Can you add some reference (in sparse.txt) to the original Linus email
| where some
| of this document is base on? Just to give credit where it is due. A
link to the
| Linus original email would be perfect.
\--

Is the following reference sufficient if added to the sparse.txt file?

=== sparse.txt ===

Sparse
~~~~~

Copyright (C) 2012 Linus Torvalds

Source: https://lkml.org/lkml/2012/3/22/409

__nocast vs __bitwise:

...
...
...

=== END ===

I will re-submit the patch with the approved changes.

Thanks for your quick response!

SK

-- 
Shakthi Kannan
http://www.shakthimaan.com
