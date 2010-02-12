From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Warnings on global symbols accessed only from assembly code
Date: Fri, 12 Feb 2010 02:00:52 +0200
Message-ID: <20100212000052.GA6837@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-fx0-f215.google.com ([209.85.220.215]:43152 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757348Ab0BLAA4 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 11 Feb 2010 19:00:56 -0500
Received: by fxm7 with SMTP id 7so1968809fxm.28
        for <linux-sparse@vger.kernel.org>; Thu, 11 Feb 2010 16:00:55 -0800 (PST)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: linux-sparse@vger.kernel.org

Hi,

Is there a way to let sparse avoid emitting warnings like:

   symbol 'X' was not declared. Should it be static?

for global methods that are only accessed from assembly files?

The reason is that a declaration for such methods - which are usually
bootstrap ones - can given the false impression of being used by some
C code 'somewhere'.

Unfortunately the current `-Wno-decl' solution is a bit extreme: it
turns off a very useful sparse feature (by design).

Thanks,

-- 
Darwish
http://darwish.07.googlepages.com
