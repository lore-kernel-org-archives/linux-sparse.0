From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/2] fix missing evaluation when using '-include <file>'
Date: Sun, 17 Sep 2017 21:02:10 +0200
Message-ID: <CAExDi1Qwc7MSRdDNAURFZNp3SLhWHaC0PKMfgpjVxeC3ZP8S+A@mail.gmail.com>
References: <CAHmME9o02YNvfqV3RFofJE8FXwRaUACzq03TBADSYc74E02iBg@mail.gmail.com>
 <20170917100552.72288-1-luc.vanoostenryck@gmail.com> <CAHmME9ofqdqwUsjmk9TSutFMOFGqstJo1rLuO7VOiC-OCRErGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:46814 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbdIQTIH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 17 Sep 2017 15:08:07 -0400
Received: by mail-io0-f170.google.com with SMTP id d16so14286316ioj.3
        for <linux-sparse@vger.kernel.org>; Sun, 17 Sep 2017 12:08:07 -0700 (PDT)
In-Reply-To: <CAHmME9ofqdqwUsjmk9TSutFMOFGqstJo1rLuO7VOiC-OCRErGA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Sun, Sep 17, 2017 at 1:59 PM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> I can confirm this patchfix works well on my slightly more complicated
> codebase that was encountering this bug.

Good.
Thanks for the extra testing.

> By the way, I love the idea of first adding the _failing_ test with
> check-known-to-fail, and then removing that flag when the commit that
> fixes it lands. Very nice.

Yes, it certainly helps to test and to see what's happening.

-- Luc
