From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 0/2] fix missing evaluation when using '-include <file>'
Date: Sun, 17 Sep 2017 13:59:19 +0200
Message-ID: <CAHmME9ofqdqwUsjmk9TSutFMOFGqstJo1rLuO7VOiC-OCRErGA@mail.gmail.com>
References: <CAHmME9o02YNvfqV3RFofJE8FXwRaUACzq03TBADSYc74E02iBg@mail.gmail.com>
 <20170917100552.72288-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from frisell.zx2c4.com ([192.95.5.64]:57475 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750803AbdIQL7V (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 17 Sep 2017 07:59:21 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id fc417de7
        for <linux-sparse@vger.kernel.org>;
        Sun, 17 Sep 2017 11:51:32 +0000 (UTC)
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bf2e818f (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-sparse@vger.kernel.org>;
        Sun, 17 Sep 2017 11:51:32 +0000 (UTC)
Received: by mail-oi0-f51.google.com with SMTP id p126so3383399oih.9
        for <linux-sparse@vger.kernel.org>; Sun, 17 Sep 2017 04:59:20 -0700 (PDT)
In-Reply-To: <20170917100552.72288-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

I can confirm this patchfix works well on my slightly more complicated
codebase that was encountering this bug.

By the way, I love the idea of first adding the _failing_ test with
check-known-to-fail, and then removing that flag when the commit that
fixes it lands. Very nice.
