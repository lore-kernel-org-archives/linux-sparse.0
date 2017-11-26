From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [GIT PULL] llvm fixes
Date: Sun, 26 Nov 2017 20:34:47 +0100
Message-ID: <20171126193445.zc6frfjle7xq7ug2@ltop.local>
References: <20170918095135.12066-1-luc.vanoostenryck@gmail.com>
 <20171117095147.a4v4alrcr77rafut@ltop.local>
 <CANeU7QnTtcKP9ukNqGmMzfVMviYwYEfYFhgLRHHGxCqR7sPGEQ@mail.gmail.com>
 <20171117195004.s472oqlldfrgiz2t@ltop.local>
 <CANeU7Q=pZAuzju8EJACZ9HVKzM6C=L0PDY6xnid6Ub5=RkuXwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36930 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbdKZTet (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 26 Nov 2017 14:34:49 -0500
Received: by mail-wm0-f52.google.com with SMTP id v186so30846361wma.2
        for <linux-sparse@vger.kernel.org>; Sun, 26 Nov 2017 11:34:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=pZAuzju8EJACZ9HVKzM6C=L0PDY6xnid6Ub5=RkuXwg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Nov 27, 2017 at 01:42:55AM +0800, Christopher Li wrote:
> 
> If there is a size change during the implicit cast,
> it can be a good thing to make the truncate and
> size extend more obvious. I think you have some idea
> relate to that.

Yes, I have essentially finished the cast rework. However,
my tests now reveals some forgotten cases and some bugs.
It's a good thing but they must be fixed.

It also won't solve problems with pseudos silently changing
from type/size (which is more a question of IR simplification).

-- Luc
