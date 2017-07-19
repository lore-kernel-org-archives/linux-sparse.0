From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 5/5] avoid crash with sym->bb_target == NULL
Date: Thu, 20 Jul 2017 00:23:33 +0200
Message-ID: <20170719222331.uxi5he3eki3lwmrh@ltop.local>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-6-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:32849 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932154AbdGSWXg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 19 Jul 2017 18:23:36 -0400
Received: by mail-wr0-f173.google.com with SMTP id v105so33657943wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 19 Jul 2017 15:23:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170706191950.81268-6-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>

This patch fixes a reproducible crash and have been ignored
since it has been posted two weeks ago.
Is there any reasons why?

-- Luc
