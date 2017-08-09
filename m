From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v3 0/8] fix loading of partially defined bitfield
Date: Wed, 9 Aug 2017 01:52:25 -0400
Message-ID: <CANeU7Qk99kn3etn8yoEKKFzcW15wHjt7OYPSpZhqCDc4DE3EDQ@mail.gmail.com>
References: <20170808230634.16227-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36119 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbdHIFw0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 01:52:26 -0400
Received: by mail-pg0-f42.google.com with SMTP id v77so23871996pgb.3
        for <linux-sparse@vger.kernel.org>; Tue, 08 Aug 2017 22:52:26 -0700 (PDT)
In-Reply-To: <20170808230634.16227-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Tue, Aug 8, 2017 at 7:06 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The goal of this series is to fix the problems present in sparse
> when a bitfield in an uninitialized automatic variable is first
> set then read-back.

Haven't have a chance to take a look tonight.

Will get back to you tomorrow.

Chris
