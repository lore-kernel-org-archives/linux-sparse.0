From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 3/5] avoid crash in rewrite_branch()
Date: Thu, 20 Jul 2017 00:21:35 +0200
Message-ID: <20170719222132.jixz37orrmfwkobq@ltop.local>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-4-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37005 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755632AbdGSWVi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 19 Jul 2017 18:21:38 -0400
Received: by mail-wm0-f50.google.com with SMTP id g127so11219000wmd.0
        for <linux-sparse@vger.kernel.org>; Wed, 19 Jul 2017 15:21:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170706191950.81268-4-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>

This patch fixes a reproducible crash and have been ignored
since it has been posted two weeks ago.
Is there any reasons why?

-- Luc
