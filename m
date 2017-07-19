From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 4/5] avoid some crashes in add_dominators()
Date: Thu, 20 Jul 2017 00:22:51 +0200
Message-ID: <20170719222249.7drqmufjxcpazkx3@ltop.local>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-5-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35204 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755638AbdGSWW4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 19 Jul 2017 18:22:56 -0400
Received: by mail-wm0-f46.google.com with SMTP id w126so10226793wme.0
        for <linux-sparse@vger.kernel.org>; Wed, 19 Jul 2017 15:22:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170706191950.81268-5-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>

This patch fixes a reproducible crash and have been ignored
since it has been posted two weeks ago.
Is there any reasons why?

BTW, I had forgot the SoB. Here it is:

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
