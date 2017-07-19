From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 2/5] avoid crash when ep->active is NULL
Date: Thu, 20 Jul 2017 00:20:53 +0200
Message-ID: <20170719222051.ssog4n5wd75lik5o@ltop.local>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-3-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37818 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755603AbdGSWU4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 19 Jul 2017 18:20:56 -0400
Received: by mail-wm0-f43.google.com with SMTP id g127so11208293wmd.0
        for <linux-sparse@vger.kernel.org>; Wed, 19 Jul 2017 15:20:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170706191950.81268-3-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>

This patch fixes a reproducible crash and have been ignored
since it has been posted two weeks ago.
Is there any reasons why?

-- Luc
