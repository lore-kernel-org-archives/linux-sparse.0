From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] compile-i386: Use SPARSE_VERSION instead of __DATE__
Date: Mon, 2 Oct 2017 21:47:20 +0200
Message-ID: <20171002194717.hfgwkgrzcf2nuefo@ltop.local>
References: <20170922081410.29162-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:47994 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdJBTrW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 2 Oct 2017 15:47:22 -0400
Received: by mail-wm0-f46.google.com with SMTP id t69so12624257wmt.2
        for <linux-sparse@vger.kernel.org>; Mon, 02 Oct 2017 12:47:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170922081410.29162-1-uwe@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc: linux-sparse@vger.kernel.org

On Fri, Sep 22, 2017 at 10:14:10AM +0200, Uwe Kleine-König wrote:
> The compile date isn't very informative for a tool, the version is what really
> matters. Additionally using __DATE__ makes the build unreprodicible.
> 

Acked-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
